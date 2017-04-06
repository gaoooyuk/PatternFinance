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
var queueColumnRoot = []
var queueColumn = []
var queueArticle = []
var phantomJS = null
var phantomColumnRunning = false
var idHash = {} // PF:id <-> jrtt:id
var agents = ['Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_8; en-us) AppleWebKit/534.50 (KHTML, like Gecko) Version/5.1 Safari/534.50', 
'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-us) AppleWebKit/534.50 (KHTML, like Gecko) Version/5.1 Safari/534.50', 
'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0;', 
'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)', 
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)', 
'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1', 
'Mozilla/5.0 (Windows NT 6.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1', 
'Opera/9.80 (Macintosh; Intel Mac OS X 10.6.8; U; en) Presto/2.8.131 Version/11.11', 
'Opera/9.80 (Windows NT 6.1; U; en) Presto/2.8.131 Version/11.11', 
'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Maxthon 2.0)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; TencentTraveler 4.0)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; The World)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; SE 2.X MetaSr 1.0; SE 2.X MetaSr 1.0; .NET CLR 2.0.50727; SE 2.X MetaSr 1.0)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; 360SE)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Avant Browser)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)', 
'Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5', 
'Mozilla/5.0 (iPod; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5', 
'Mozilla/5.0 (iPad; U; CPU OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5', 
'Mozilla/5.0 (Linux; U; Android 2.3.7; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1', 
'MQQBrowser/26 Mozilla/5.0 (Linux; U; Android 2.3.7; zh-cn; MB200 Build/GRJ22; CyanogenMod-7) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1', 
'Opera/9.80 (Android 2.3.4; Linux; Opera Mobi/build-1107180945; U; en-GB) Presto/2.8.149 Version/11.10', 
'Mozilla/5.0 (Linux; U; Android 3.0; en-us; Xoom Build/HRI39) AppleWebKit/534.13 (KHTML, like Gecko) Version/4.0 Safari/534.13', 
'Mozilla/5.0 (BlackBerry; U; BlackBerry 9800; en) AppleWebKit/534.1+ (KHTML, like Gecko) Version/6.0.0.337 Mobile Safari/534.1+', 
'Mozilla/5.0 (hp-tablet; Linux; hpwOS/3.0.0; U; en-US) AppleWebKit/534.6 (KHTML, like Gecko) wOSBrowser/233.70 Safari/534.6 TouchPad/1.0', 
'Mozilla/5.0 (SymbianOS/9.4; Series60/5.0 NokiaN97-1/20.0.019; Profile/MIDP-2.1 Configuration/CLDC-1.1) AppleWebKit/525 (KHTML, like Gecko) BrowserNG/7.1.18124', 
'Mozilla/5.0 (compatible; MSIE 9.0; Windows Phone OS 7.5; Trident/5.0; IEMobile/9.0; HTC; Titan)', 
'UCWEB7.0.2.37/28/999', 
'NOKIA5700/ UCWEB7.0.2.37/28/999', 
'Openwave/ UCWEB7.0.2.37/28/999', 
'Mozilla/4.0 (compatible; MSIE 6.0; ) Opera/UCWEB7.0.2.37/28/999', 
'UCWEB7.0.2.37/28/999', 
'NOKIA5700/ UCWEB7.0.2.37/28/999', 
'Openwave/ UCWEB7.0.2.37/28/999', 
'Mozilla/4.0 (compatible; MSIE 6.0; ) Opera/UCWEB7.0.2.37/28/999',
'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36']

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
			queueColumn = queueColumnRoot
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
	sched = later.parse.recur().every(10).second();
}

var crawl = function() {
	async.parallel([
	    function(callback) {
	    	if (queueColumn.length > 0 && !phantomColumnRunning) {
	    		phantomColumnRunning = true
	    		queueColumn = queueColumn.filter(onlyUnique)
	    		crawlJrttColumn(queueColumn.shift(), callback)
	    	} else {
	    		// if we run out of column urls
				queueColumn = queueColumnRoot
	    	}
	    },
	    function(callback) {
	    	if (queueArticle.length > 0) {
	    		queueArticle = queueArticle.filter(onlyUnique)
	    		// crawlJrttArticle(queueArticle.shift(), callback)
	    	} else {
	    		// if we run out of article urls
				// wait for crawlJrttColumn to fulfill
	    	}
	    }
	],
	// async.parallel callback
	function(err, results) {
	});
}

var crawlJrttColumn = function(url, cb) {
	console.log("crawl: ", url)
    phantomJS.createPage().then(page => {
		page.property('customHeaders', {
			"Referer" : url
		})
    	// page.property('viewportSize', { width: 1024, height: 600 });
    	var agent = agents[Math.floor(agents.length * Math.random())]
    	page.setting('userAgent', agent)
        page.open(url).then(status => {
        	return page.property('content')
        }).then(content => {
        	// console.log(content)
        	var document = jsdom.jsdom(content);
        	var writerId = null
        	var ds = url.split("=")
			if (ds) {
				var userId = ds[ds.length - 1]
				writerId = idHash[userId]
			}

			// handle pagination
			// TODO: load all artiles before parsing
        	// only if no article urls left in queue
        	var fulfill = 0 === queueArticle.length ? true : false
        	var articles = []

			var nodeList = document.querySelectorAll(".relatedFeed ul > li")
			var posts = Array.prototype.slice.call(nodeList)
			// var totalNumArticles = posts.length
			// console.log("totalNumArticles: ", totalNumArticles)

			for (p in posts) {
				var article = {}
				var e = posts[p]
				var meta = e.querySelector(".rbox-inner")
				if (meta) {
					var link = meta.querySelector(".title-box a")
					article.title = link.innerHTML
					article.url = "http://toutiao.com" + link.href
					if (fulfill) {
						queueArticle.push(article.url)
					}
					// schema: /item/6402022561999225345/
					var ls = link.href.split("/")
				    article.originId = ls[ls.length - 2]

					var rc = meta.querySelector(".footer a[ga_event=article_read_count]")
					if (rc) {
						article.viewedTimes = parseInt(rc.innerHTML)
					}
					var cc = meta.querySelector(".footer a[ga_event=article_comment_click]")
					if (cc) {
						article.commentedTimes = parseInt(String(cc.innerHTML).replace(/&nbsp;/g, ""))
					}
					var ts = meta.querySelector(".footer span")
					if (ts) {
						var tStr = String(ts.innerHTML).replace("&nbsp;", "")
						// TODO
						article.timestamp = tStr
					}

					articles.push(article)
				}
			}

			console.log("articles.length: ", articles.length)
			console.log("writerId: ", writerId)
			if (articles.length > 0 && writerId) {
				updateWriterArticles(writerId, articles)
			}

            page.close()
            phantomColumnRunning = false
        }).catch(e => {
	    	console.log(e)
	    	page.close()
	    	phantomColumnRunning = false
	    });
    }).catch(e => {
    	console.log(e)
    	phantomColumnRunning = false
    });
}

var crawlJrttArticle = function(url, cb) {
	console.log("crawl: ", url)
	var article = {}
    var ls = url.split("/")
    article.originId = ls[ls.length - 1]

	phantomJS.createPage().then(page => {
		page.property('customHeaders', {
			"Referer" : url
		})
    	// page.property('viewportSize', { width: 1024, height: 600 });
    	var agent = agents[Math.floor(agents.length * Math.random())]
    	page.setting('userAgent', agent)
        page.open(url).then(status => {
        	return page.property('content')
        }).then(content => {
        	var document = jsdom.jsdom(content);
            page.close()
        	console.log(article)
        }).catch(e => {
	    	console.log(e)
	    	page.close()
	    });
    }).catch(e => {
    	console.log(e)
    });
}

var updateWriterArticles = function(writerId, articles) {
	var docArticles = []
	var doc = global.mongodb.collection('writer').findOne({
		"id": writerId,
		"medias": {
			$elemMatch: {
    			"channel": "jrtt"
			}
		}
	}, function(err, doc) {
		if (doc) {
			for (var m = 0; m < doc.medias.length; m++) {
				var mt = doc.medias[m]
				if ("jrtt" === mt.channel) {
					docArticles = mt.articles
					break
				}
			}

			// if we found existing articles, update them
			// and then push new articles
			var as = articles
			while (as.length > 0) {
				var article = as.shift()
				var newArticle = article
				var found = false

				for (var i = 0; i < docArticles.length; i++) {
					if (docArticles[i].originId === article.originId) {
						found = true
						for (var key in article) {
							if (article[key]) {
								docArticles[i][key] = article[key]
							}
						}
						break
					}
				}

				if (!found) {
					docArticles.push(newArticle)
				}
			}

			global.mongodb.collection('writer').update( 
			{ 
				"id": writerId,
				"medias": { "$elemMatch": { "channel": "jrtt" } } 
			},
			{ 
				$set: {
					"medias.$.articles": docArticles
				}
			},
			{ upsert: false } );
		}
	});
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
		    			"channel": "jrtt",
		    			"id": { $ne: "" }
	    			}
	    		}
	    	});

			cursor.each(function(err, doc) {
				assert.equal(err, null);

			  	if (doc != null) {
			  		for (var i = 0; i < doc.medias.length; i++) {
			  			var mt = doc.medias[i]
			  			if ("jrtt" === mt.channel) {
			  				idHash[mt.id] = doc.id
			  				var url = "http://www.toutiao.com/c/user/" 
			  					+ mt.id 
			  					+ "/#mid="
			  					+ mt.id 
			  				queueColumnRoot.push(url)
			  				break
			  			}
			  		}
			  	} else {
			  		callback(null, "")
			  	}
			});
	    }
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