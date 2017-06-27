var MongoClient = require('mongodb').MongoClient;
var moment = require('moment-timezone');
var JPush = require("jpush-sdk");
var assert = require('assert');
var async = require('async');
var later = require('later');
var path = require('path');
var fs = require('fs');

// global variables
var jpushClient = JPush.buildClient("0795f0cdd7ee316169000467", 
									"5fc5eedc25d4538574c1d0a3", 
									null, 
									false)
var iter = 0
var whitelist = []
var blacklist = []
var queue = []
var lastTS = 0

var start = function() {
	// MongoDB
	var dbUrl = 'mongodb://localhost:27017/ValueDB';
	MongoClient.connect(dbUrl, function(err, db) {
		assert.equal(null, err);
		console.log("Init: mongodb connected.");
		global.mongodb = db

		iter = 0
		sched1 = later.parse.recur().every(10).second();
		sched2 = later.parse.recur().every(5).second();

		var timer1 = later.setInterval(queueNews, sched1);
		var timer2 = later.setInterval(pushNews, sched2);
	});
}

var queueNews = function() {
	var sort = { 'timestamp': -1 }
	var cursor = global.mongodb.collection('live_news').find({}).sort(sort).limit(1)
	cursor.toArray(function(err, docs) {
		if (1 === docs.length) {
			var news = docs[0]

			// 筛选符合条件的News放入queue中
			if (isValid(news)) {
				lastTS = news.timestamp
				queue.push({
					"title": news.title,
					"timestamp": news.timestamp
				})

				console.log("title: ", news.title)
				console.log("source: ", news.source)
				console.log("timestamp: ", moment(news.timestamp).tz('America/New_York').format('YYYY-MM-DD hh:mm:ss'))
			}
		}
	});
}

var pushNews = function() {
	var news = queue.shift()
	if (assertPoint(news)) {
		var min2 = 1000 * 60 * 2
		console.log("news timestamp: ", news.timestamp)
		console.log("now timestamp: ", (new Date).getTime())
		var diff = Math.abs(news.timestamp - (new Date).getTime())
		console.log("diff: ", diff)
		console.log("")
		if (diff < min2) {
			tellBoss(news.title)
		}
	}
}

var isValid = function(news) {
	if (news.timestamp <= lastTS) {
		return false
	}

	return true 
}

var correctHtmlContent = function(content) {
	return content.replace(/&lt;/g, "<")
				  .replace(/&gt;/g, ">")
				  .replace(/&ld/g, "“")
				  .replace(/&gd/g, "”")
				  .replace(/&amp;/g, "&")
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

function tellBoss(msg) {
	var t = String(msg)
	if (jpushClient) {
		jpushClient.push()
			.setPlatform('ios')
		    .setAudience(JPush.registration_id('141fe1da9ea2287bac3'))
		    .setNotification(t, JPush.ios(t), JPush.android(t, null, 1))
		    .setMessage(t)
		    .send(function(err, res) {
				if (err) {
					if (err instanceof JPush.APIConnectionError) {
						console.log(err.message)
						// Response Timeout means your request to the server may have already received,
						// please check whether or not to push
						console.log(err.isResponseTimeout)
					} else if (err instanceof JPush.APIRequestError) {
						console.log(err.message)
					}
				}
		    });
	}
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

start()