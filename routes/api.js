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
	{ "articleId": "touzigushi_1" },
	{ 
		$set: { 
			"viewedTimes": 0,
			"likedTimes": 0,
			"sharedTimes": 0,
			"title": "不一样的第一桶金",
			"cover": "../articledata/covers/baymax_sketchies_by_snookievonpink123-d8691o0.jpg",
			"lede": "看飞泥死党“死胖子”是如何在嬉笑怒骂间赚到人生中第一桶金的",
			"type": "文章",
			"category": "投资故事"
		}
	},
	{ upsert: true } );

	global.mongodb.collection('article').update( 
	{ "articleId": "renquan_starvc" },
	{ 
		$set: { 
			"viewedTimes": 0,
			"likedTimes": 0,
			"sharedTimes": 0,
			"title": "任泉和StarVC的投资故事",
			"cover": "../articledata/covers/159c0bdb2b2674f3feed092a.jpg",
			"lede": "在李冰冰家里我决定退出演艺圈 她流着泪说支持我",
			"type": "文章",
			"category": "投资故事"
		}
	},
	{ upsert: true } );

	global.mongodb.collection('article').update( 
	{ "articleId": "blackstone_story" },
	{ 
		$set: { 
			"viewedTimes": 0,
			"likedTimes": 0,
			"sharedTimes": 0,
			"title": "黑石帝国的崛起: 华尔街赚钱大王",
			"cover": "../articledata/covers/BLKX_06_1000.jpg",
			"lede": "为人熟知的商业与金融世界潜规则",
			"type": "文章",
			"category": "金融帝国"
		}
	},
	{ upsert: true } );

	global.mongodb.collection('article').update( 
	{ "articleId": "tencent_weihuangjin" },
	{ 
		$set: { 
			"viewedTimes": 0,
			"likedTimes": 0,
			"sharedTimes": 0,
			"title": "黄金红包来袭, 大头评测腾讯微黄金“互联网+现货黄金”到底适不适合理财?",
			"cover": "../articledata/covers/BLKX_06_1000.jpg",
			"lede": "",
			"type": "评测",
			"category": "产品评测"
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
