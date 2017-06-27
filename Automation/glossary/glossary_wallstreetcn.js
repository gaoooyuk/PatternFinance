var MongoClient = require('mongodb').MongoClient;
var moment = require('moment-timezone');
var request = require('request');
var jieba = require("nodejieba");
var assert = require('assert');
var async = require('async');
var later = require('later');
var path = require('path');
var fs = require('fs');

// global variables
var iter = 0
var sched = null

var start = function() {
	// MongoDB
	var dbUrl = 'mongodb://localhost:27017/PatternFinanceDB';
	MongoClient.connect(dbUrl, function(err, db) {
		assert.equal(null, err);
		console.log("Init: mongodb connected.");
		global.mongodb = db

		iter = 0
		if (assertPoint(sched)) {
			// Load user dict
			jieba.load({
				userDict: 'dict.txt',
			});

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
	sched = later.parse.recur().every(60).second();
}

var crawl = function() {
	var options = {
	  url: 'https://api.xuangubao.cn/api/pc/msgs?headmark=0&limit=10&subjids=9,469,35,10',
	  headers: {
	    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'
	  }
	};

	function crawl_cb(error, response, body) {
		if (!error && response.statusCode == 200) {
			try {
				var info = JSON.parse(body)
				if (assertPoint(info) 
					&& assertPoint(info.NewMsgs)) {
					var msgs = info.NewMsgs
					processMsgs(msgs)
				}
			} catch(e) {

			}
		}
	}

	request(options, crawl_cb);
}

var processMsgs = function(msgs) {
	var minLength = 15
	var maxLength = 30
	var minWordLength = 2

	msgs.forEach(function(msg) {
		var title = msg.Title
		var tlen = String(title).length
		if (tlen >= minLength 
			&& tlen <= maxLength) {
			var words = jieba.cut(title, false)
			words = words.filter(onlyUnique)
			words.forEach(function(word) {
				var wlen = String(word).length
				if (wlen >= minWordLength) {
					var example = {}
					example.content = title
					example.source = "华尔街见闻"
					example.href = ""
					example.timestamp = (new Date).getTime()

					var feed = {}
					feed.word_zh = word
					feed.word_en = ""
					feed.description_zh = ""
					feed.description_en = ""
					feed.examples_zh = [example]
					feed.examples_en = []

					processFeed(title, feed)
				}
			})
		}
	})
}

var processFeed = function(title, feed) {
	find("glossary", "word_zh", feed.word_zh, function(db_res) {
		if (db_res.exists) {
			global.mongodb.collection('glossary').findOne({
				"word_zh": feed.word_zh,
				"examples_zh": {
					$elemMatch: {
		    			"content": title
					}
				}
			}, function(err, doc) {
				if (!doc) {
					global.mongodb.collection('glossary').update( 
						{ "word_zh": feed.word_zh },
						{ $addToSet: { "examples_zh": feed.examples_zh[0] } },
						{ upsert: false } 
					);
				}
			});
		} else {
	  		console.log("词条: ", feed.word_zh)
			console.log("收录: ", title)
			console.log("")

			// global.mongodb.collection('glossary').insertOne(
			// 	feed, 
			// 	function(err, result) {
			// 		assert.equal(err, null)
			// 	}
			// );
		}
	})
}

var find = function(collectionName, key, value, callback) {
	var result = {}
	result.exists = false
	result.obj = null

	var item = {}
	item[key] = value

	var cursor = global.mongodb.collection(collectionName).find( item );
	cursor.each(function(err, doc) {
		assert.equal(err, null);

	  	if (doc != null) {
	  		result.exists = true
	  		result.obj = doc
	  	} else {
	  		callback(result)
	  	}
	});
};

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