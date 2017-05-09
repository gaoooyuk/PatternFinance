var MongoClient = require('mongodb').MongoClient;
var moment = require('moment-timezone');
var FeedParser = require('feedparser');
var request = require('request');
var assert = require('assert');
var async = require('async');
var later = require('later');
var path = require('path');
var fs = require('fs');

// global variables
var iter = 0
var sched = null
var feedparser = new FeedParser()
feedparser.on('error', function (error) {
	// always handle errors
	console.log("[DEBUG] FeedParser error")
});
feedparser.on('readable', function () {
	// This is where the action is!
	var stream = this
	var meta = this.meta

	var item
	while (item = stream.read()) {
		var duration = moment.duration(moment().diff(moment(item.pubDate)))
		var secs = duration.asSeconds()
		if (secs < 60) { // only process news within 60s
			var feed = {}
			feed.url = item.link
			feed.title = correctHtmlContent(item.title)
			feed.timestamp = moment.tz(item.pubDate, "MM/DD/YYYY hh:mm:ss A", "America/New_York").valueOf()
			feed.source = "CNBC"
			// console.log(feed)
			global.mongodb.collection('live_news').update( { "url": feed.url }, feed, { upsert: true } );
		}
	}
});

var start = function() {
	// MongoDB
	var dbUrl = 'mongodb://localhost:27017/ValueDB';
	MongoClient.connect(dbUrl, function(err, db) {
		assert.equal(null, err);
		console.log("Init: mongodb connected.");
		global.mongodb = db

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
	sched = later.parse.recur().every(30).second();
}

var crawl = function() {
	var url = "http://www.cnbc.com/id/15839135/device/rss/rss.html"
	var req = request(url)
  	// Some feeds do not respond without user-agent and accept headers.
  	req.setHeader('user-agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36');
  	req.setHeader('accept', 'text/html,application/xhtml+xml');

	// Define our handlers
	req.on('error', function (error) {
	  // handle any request errors
	  console.log("[DEBUG] request error")
	});
	req.on('response', function (res) {
		var stream = this; // `this` is `req`, which is a stream

		if (res.statusCode !== 200) {
			this.emit('error', new Error('Bad status code'));
		} else {
			stream.pipe(feedparser);
		}
	});
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