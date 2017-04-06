var MongoClient = require('mongodb').MongoClient;
var htmlparser = require("htmlparser2");
var express = require('express');
var phantom = require("phantom");
var moment = require('moment');
var assert = require('assert');
var async = require('async');
var later = require('later');
var jsdom = require("jsdom");
var path = require('path');
var fs = require('fs');

// global variables
var iter = 0
var sched = null
var queueInit = []
var queue = []
var phantomJS = null
var phantomRunning = false
var idHash = {} // PF:id <-> zhihu:id

var start = function() {
	// Create and init PhantomJS
	phantom.create().then(ph => {
	    phantomJS = ph;
	})

	// MongoDB
	var dbUrl = 'mongodb://localhost:27017/PatternFinanceDB';
	MongoClient.connect(dbUrl, function(err, db) {
		assert.equal(null, err);
		console.log("Init: mongodb connected.");
		global.mongodb = db

		getUrls(function() {
			queue = queueInit
		})

		iter = 0
		if (assertPoint(sched)) {
			// Execute code
			var timer = later.setInterval(crawl, sched);
		} else {
			console.log("Warning: no sched found.")
		}
	});
}

var setSchedule = function(s) {
	sched = s
}

var useDefaultSchedule = function() {
	sched = later.parse.recur().every(20).second();
}

var crawl = function() {
	async.parallel([
	    function(callback) {
	    	if (queue.length > 0) {
	    		queue = queue.filter(onlyUnique)
	    		crawlZhihu(queue.shift(), callback)
	    	} else {
	    		// if we run out of urls
	    		queue = queueInit
	    	}
	    }
	],
	// async.parallel callback
	function(err, results) {
	});
}

var crawlZhihu = function(url, cb) {
	var currentPageNum = 1
	var idx = url.indexOf("?page=")
	if (idx >= 0) {
		var pn = parseInt(url.slice(idx + 6))
		if (pn) {
			currentPageNum = pn
		}
	}	
	currentUrl = url.slice(0, url.indexOf("posts") + 5) + "?page=" + currentPageNum
	console.log("crawl: ", currentUrl)

    phantomJS.createPage().then(page => {
		// page.property('customHeaders', {
		// 	"Referer" : ""
		// })
    	// page.property('viewportSize', { width: 1024, height: 600 });
    	// page.setting('userAgent', agent)
        page.open(currentUrl).then(status => {
        	return page.property('content')
        }).then(content => {
        	var document = jsdom.jsdom(content);
        	var writerId = null
        	var user = document.querySelector(".UserLink-link")
        	if (user) {
        		var userId = user.href.replace("/people/", "")
        		writerId = idHash[userId]
        	}

        	var nodelist = document.querySelectorAll("div#Profile-posts .List-item")
        	var posts = Array.prototype.slice.call(nodelist)        	
        	var articles = []
			for (p in posts) {
				var e = posts[p]
				var item = e.querySelector("div[data-za-module-info]")
				if (assertPoint(item)) {
					var rawInfo = item.getAttribute("data-za-module-info")
					var info = JSON.parse(rawInfo)["card"]["content"]
					if ("Post" === info["type"]) {
						var article = {}
						var link = e.querySelector('.ContentItem-title a')
						article.url = "https:" + link.href
						article.title = link.innerHTML
						article.viewedTimes = null
						article.commentedTimes = info["comment_num"]
						article.likedTimes = info["upvote_num"]
						article.originId = info["token"]
						article.timestamp = info["publish_timestamp"]
						articles.push(article)
					}
				}
			}

			if (articles.length > 0 && writerId) {
				updateWriterArticles(writerId, articles)
			}

			// handle pagination
			// check if user has pagination
			var pagination = document.querySelector("div#Profile-posts .Pagination")
			if (pagination) {
				var pageList = pagination.children
				var pages = Array.prototype.slice.call(pageList)
				for (pg in pages) {
					var pe = pages[pg]
					// append url to the end of queue
					// if next page is found
					var num = parseInt(pe.innerHTML)
					if (!isNaN(num)) {
						if (num > currentPageNum) {
							var nextUrl = currentUrl.replace(/\?page=\d+/g, "?page=" + num)
							console.log("next: ", nextUrl)
							queue.push(nextUrl)
						}
					}
				}
			}
            page.close()
        }).catch(e => {
	    	console.log(e)
	    	page.close()
	    });
    }).catch(e => {
    	console.log(e)
    });
}

var updateWriterArticles = function(writerId, articles) {
	global.mongodb.collection('writer').update( 
	{ 
		"id": writerId,
		"medias": { "$elemMatch": { "channel": "zhihu" } } 
	},
	{ 
		$addToSet: {
			"medias.$.articles": { $each: articles } 
		}
	},
	{ upsert: false } );
}

var correctHtmlContent = function(content) {
	return content.replace(/&lt;/g, "<")
				  .replace(/&gt;/g, ">")
				  .replace(/&ld/g, "“")
				  .replace(/&gd/g, "”")
}

var getRandomSubset = function(arr, size) {
    var shuffled = arr.slice(0), i = arr.length, temp, index;
    while (i--) {
        index = Math.floor((i + 1) * Math.random());
        temp = shuffled[index];
        shuffled[index] = shuffled[i];
        shuffled[i] = temp;
    }
    return shuffled.slice(0, size);
}

var shortUUID = function() {
    var ALPHABET = '23456789abdegjkmnpqrvwxyz';
    var ALPHABET_LENGTH = ALPHABET.length;

    var ID_LENGTH = 8
    var rtn = ''
    for (var i = 0; i < ID_LENGTH; i++) {
        rtn += ALPHABET.charAt(Math.floor(Math.random() * ALPHABET_LENGTH));
    }
    return rtn;
}

var getHostName = function(url) {
	var match = url.match(/:\/\/(www[0-9]?\.)?(.[^/:]+)/i);
	if (match != null 
		&& match.length > 2 
		&& typeof match[2] === 'string' 
		&& match[2].length > 0) {
		return match[2];
	} else {
		return null;
	}
}

var getDomain = function(url) {
    var hostName = getHostName(url);
    var domain = hostName;
    
    if (hostName != null) {
        var parts = hostName.split('.').reverse();
        
        if (parts != null && parts.length > 1) {
            domain = parts[1] + '.' + parts[0];
                
            if (hostName.toLowerCase().indexOf('.co.uk') != -1 && parts.length > 2) {
              domain = parts[2] + '.' + domain;
            }
        }
    }
    
    return domain;
}

function getUrls(cb) {
	async.parallel([
	    function(callback) {
	    	var cursor = global.mongodb.collection('writer').find({
	    		"medias": {
	    			$elemMatch: {
		    			"channel": "zhihu",
		    			"id": { $ne: "" }
	    			}
	    		}
	    	});

			cursor.each(function(err, doc) {
				assert.equal(err, null);

			  	if (doc != null) {
			  		for (var i = 0; i < doc.medias.length; i++) {
			  			var mt = doc.medias[i]
			  			if ("zhihu" === mt.channel) {
			  				idHash[mt.id] = doc.id
			  				queueInit.push("https://www.zhihu.com/people/" + mt.id + "/pins/posts")
			  				break
			  			}
			  		}
			  	} else {
			  		callback(null, "")
			  	}
			});
	    }

    	// queueInit.push("https://www.zhihu.com/people/mosssssssaic/pins/posts")
    	// queueInit.push("https://www.zhihu.com/people/dwill/pins/posts")
    	// queueInit.push("https://www.zhihu.com/people/alpha-59/pins/posts")
    	// queueInit.push("https://www.zhihu.com/people/liu-da-19-49/pins/posts")
    	// queueInit.push("https://www.zhihu.com/people/yan-yi-kai/pins/posts")
    	// queueInit.push("https://www.zhihu.com/people/hong-guan-jing-ji-suan-ming-shi/pins/posts")
    	// queueInit.push("https://www.zhihu.com/people/yangboli/pins/posts")
    	// queueInit.push("https://www.zhihu.com/people/chunxiao311/pins/posts")
	],
	// async.parallel callback
	function(err, results) {
		cb()
	});
}

function assertPoint(p) {
	if (undefined == p || null == p) {
		return false
	}

	return true
}

function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}

useDefaultSchedule()
start()