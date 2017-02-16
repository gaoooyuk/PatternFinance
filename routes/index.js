var express = require('express');
var deasync = require('deasync');
var assert = require('assert');
var router = express.Router();
var path = require('path');
var fs = require('fs');

router.get('/', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')
	res.sendFile(path.join(home_dir + '/main.html'));
});

router.get('/partners', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('partners', 
	{ 
		"html_description": "",
		"html_keywords": "合作伙伴"
	})
});

router.get('/about', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('about', 
	{ 
		"html_description": "",
		"html_keywords": "关于我们,磨石金融,新媒体"
	})
});

router.get('/research', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('channel', 
	{ 
		"channel": "磨石研究",
		"channel_qml": "website_research",
		"html_description": "",
		"html_keywords": "磨石研究,投资模式,磨石金融"
	})
});

router.get('/review', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('channel', 
	{ 
		"channel": "物是评测",
		"channel_qml": "website_review",
		"html_description": "",
		"html_keywords": "物是评测,磨石金融"
	})
});

router.get('/story', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('channel', 
	{ 
		"channel": "投资故事",
		"channel_qml": "website_story",
		"html_description": "",
		"html_keywords": "投资故事,磨石金融,新媒体"
	})
});

router.get('/company', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('channel', 
	{ 
		"channel": "金融帝国",
		"channel_qml": "website_company",
		"html_description": "",
		"html_keywords": "金融帝国,磨石金融,新媒体"
	})
});

router.get('/dashboard', function(req, res, next) {
	res.render('dashboard', {})
});

router.get('/article/*', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')
	var fn = req.params['0']

	var article = {}
	var find = false
	var done = false
	var cursor = global.mongodb.collection('article').find({ "articleId": fn });
	cursor.each(function(err, doc) {
		assert.equal(err, null);

	  	if (doc != null) {
	  		article = doc
	  		find = true
	  	}

	  	done = true
	});

	deasync.loopWhile(function(){return !done;});

  	if (find) {
		global.mongodb.collection('article').update( 
			{ "articleId": fn },
			{ $inc : { "viewedTimes" : 1 } },
			{ upsert: false } );

		res.render('article', 
			{ 
				"title": article.title, 
				"articleId": article.articleId,
				"html_description": article.lede,
				"html_keywords": article.keywords
			})
	} else {
		res.status(404).sendFile(path.join(home_dir + '/404.html'));
	}
});

router.get('/sitemap.xml', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')
	res.sendFile(path.join(home_dir + '/sitemap.xml'));
});

router.get('/apple-app-site-association', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')
	var aasa = fs.readFileSync(path.join(home_dir + '/apple-app-site-association'));
	res.set('Content-Type', 'application/json');
    res.status(200).send(aasa);
});

module.exports = router;
