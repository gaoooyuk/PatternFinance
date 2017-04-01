/**
** BaiduPush is a bot who help us push urls to Baidu
**/
var MongoClient = require('mongodb').MongoClient;
var request = require('request');
var moment = require('moment');
var assert = require('assert');
var later = require('later');
var async = require('async');

// global variables
var iter = 0
var sched = null
var ARTICLE_COLLECTION_NAME = 'article'
var TERMS_COLLECTION_NAME = 'terms'
var STRATEGY_COLLECTION_NAME = 'strategy'
var urls = []
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
'Mozilla/4.0 (compatible; MSIE 6.0; ) Opera/UCWEB7.0.2.37/28/999']

//
//
//

var start = function() {
	// MongoDB
	var dbUrl = 'mongodb://localhost:27017/PatternFinanceDB';
	MongoClient.connect(dbUrl, function(err, db) {
		assert.equal(null, err);
		console.log("Init: mongodb connected.");
		global.mongodb = db

		getUrls(function() {
			urls.push("https://www.patternfinance.com")
			urls.push("https://www.patternfinance.com/about")
			urls.push("https://www.patternfinance.com/liqi")
			urls.push("https://www.patternfinance.com/edge")
			urls.push("https://www.patternfinance.com/mindstore")
			urls.push("https://www.patternfinance.com/research")
			urls.push("https://www.patternfinance.com/review")
			urls.push("https://www.patternfinance.com/company")
			urls.push("https://www.patternfinance.com/story")
			urls.push("https://www.patternfinance.com/sts")
			urls.push("https://www.patternfinance.com/joinus")
			urls.push("https://www.patternfinance.com/partners")
		})

		iter = 0
		if (assertPoint(sched)) {
			// Execute code
			var timer = later.setInterval(pushUrls, sched);
		} else {
			console.log("Warning: no sched found.")
		}
	});
}

var setSchedule = function(s) {
	sched = s
}

var useDefaultSchedule = function() {
	// 
	// China Time Schedule (UTC)
	// Timezone: UTC+8
	// Opening Time (UTC): 01:05-14:00 (Lunch Time: 03:30-04:30)
	// Opening Time (Local): 09:05-22:00 (Lunch Time: 11:30-12:30)
	//
	sched = later.parse.recur().every(1).minute()
			.after('01:05').time().before('03:35').time()
			.every(1).minute()
			.onWeekday()
			.and()
			.after('04:30').time().before('14:05').time()
			.every(1).minute()
			.onWeekday();

	// sched = later.parse.recur().every(1).minute();
}

//
//
//

function pushUrls() {
	decision = Math.random()
	if (decision < 0.9) {
		return
	}

	iter++
	console.log("")
	console.log("[" + iter + "] Pushing urls at: " + moment.utc().format("YYYY-MM-DD HH:mm:ss Z"));
	var pushCount = Math.floor(urls.length/2 * Math.random()) + 1
	urls2push = getRandomSubset(urls, pushCount)
	console.log("#urls to push: ", urls2push.length)

	var k1 = Math.floor(25 * Math.random())
	var k2 = Math.floor(30 * Math.random())
	var rand = (k1 + k2) * 1000 // 0 ~ 55s
	setTimeout(function() {
		for (var i = 0; i < urls2push.length; i++) {
			var agent = agents[Math.floor(agents.length * Math.random())]
			var options = {
				url: 'https://www.patternfinance.com' + urls2push[i],
				headers: {
					'User-Agent': agent
				}
			};
			// console.log('{' + i + '} ' + options.url)
			request(options, function (error, response, body) {
			});
		}
	}, rand);
}

function getUrls(cb) {
	async.parallel([
	    function(callback) {
	    	getArticleUrls(callback)
	    },
	    function(callback) {
	    	getTermsUrls(callback)
	    },
	    function(callback) {
	    	getStrategyUrls(callback)
	    }
	],
	// async.parallel callback
	function(err, results) {
		cb()
	});
}

function getArticleUrls(callback) {
	var cursor = global.mongodb.collection(ARTICLE_COLLECTION_NAME).find({ "status": "public" });
	cursor.each(function(err, doc) {
		assert.equal(err, null);
	  	if (doc != null) {
	  		var id = doc.articleId
	  		if ("" !== id) {
	  			urls.push("/article/" + id)
	  		}
	  	} else {
			callback(null, "")
	  	}
	});
}

function getTermsUrls(callback) {
	var cursor = global.mongodb.collection(TERMS_COLLECTION_NAME).find({});
	cursor.each(function(err, doc) {
		assert.equal(err, null);
	  	if (doc != null) {
	  		var id = doc.id
	  		if ("" !== id) {
	  			urls.push("/terms/" + id)
	  		}
	  	} else {
			callback(null, "")
	  	}
	});
}

function getStrategyUrls(callback) {
	var cursor = global.mongodb.collection(STRATEGY_COLLECTION_NAME).find({});
	cursor.each(function(err, doc) {
		assert.equal(err, null);
	  	if (doc != null) {
	  		var id = doc.id
	  		if ("" !== id) {
	  			urls.push("/strategy/" + id)
	  		}
	  	} else {
			callback(null, "")
	  	}
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

useDefaultSchedule()
start()
