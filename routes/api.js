var express = require('express');
var deasync = require('deasync');
var moment = require('moment');
var assert = require('assert');

var router = express.Router();

var collectionName = 'article'

router.get('/retrieveBlogs', function(req, res, next) {
	var articles = []
	var cursor = global.mongodb.collection(collectionName).find({});
	cursor.each(function(err, doc) {
		assert.equal(err, null);

	  	if (doc != null) {
	  		articles.push(doc)
	  	} else {
	  		res.send(articles)
	  	}
	});
});

router.post('/getRandomArticles', function(req, res, next) {
	// Number of articles to retrieve
	var num = req.body.num
	var exceptId = req.body.exceptArticleId

	var articles = []
	var cursor = global.mongodb.collection(collectionName).find().limit(20)
	cursor.toArray(function(err, docs) {
		articles = getRandomSubset(docs, num)
		res.send(articles)
	});
});

router.post('/getArticleInfo', function(req, res, next) {
	var numOfShares = 0
	var cursor = global.mongodb.collection(collectionName).find({ "articleId": req.body.articleId });
	cursor.each(function(err, doc) {
		assert.equal(err, null);

	  	if (doc != null) {
	  		numOfShares = doc.sharedTimes
	  	} else {
	  		res.send(String(numOfShares))
	  	}
	});
});

router.post('/addSharesCount4Article', function(req, res, next) {
	global.mongodb.collection('article').update( 
	{ "articleId": req.body.articleId },
	{ $inc : { "sharedTimes" : 1 } },
	{ upsert: false } );
});

router.get('/addArticles', function(req, res, next) {
	global.mongodb.collection('article').update( 
	{ "articleId": "touzigushi_2" },
	{ 
		$set: { 
			"viewedTimes": 0,
			"likedTimes": 0,
			"sharedTimes": 0,
			"title": "股民舒立: 22年投资路。走过股灾，“在股市赚钱太难了”",
			"cover": "../articledata/covers/guminshuli.jpg",
			"lede": "“挣扎在悬浮状态”的他们有着怎么样的焦虑与彷徨。我们在这里记录他们为梦想和更好明天的不懈奋斗与期盼。",
			"type": "文章",
			"category": "投资故事"
		}
	},
	{ upsert: true } );

	global.mongodb.collection('article').update( 
	{ "articleId": "touzigushi_3" },
	{ 
		$set: { 
			"viewedTimes": 0,
			"likedTimes": 0,
			"sharedTimes": 0,
			"title": "一枚硬币走天下，十二年的酸甜苦辣",
			"cover": "../articledata/covers/yimeiyingbi.png",
			"lede": "买别墅、送孩子留学、开豪车。看“一枚硬币走天下”12年股市浮沉。",
			"type": "文章",
			"category": "投资故事"
		}
	},
	{ upsert: true } );

	res.send('Success')
});

var find = function(key, value, callback) {
	var result = {}
	result.exists = false
	result.obj = null

	var item = {}
	item[key] = value

	var cursor = global.mongodb.collection(collectionName).find(item);
	var done = false
	cursor.each(function(err, doc) {
		assert.equal(err, null);

	  	if (doc != null) {
	  		result.exists = true
	  		result.obj = doc
	  	}

	  	done = true
	});
	deasync.loopWhile(function(){return !done;});

	callback(result)
};

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

module.exports = router;
