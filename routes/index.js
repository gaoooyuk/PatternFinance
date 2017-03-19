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

router.get('/about', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('about', 
	{ 
		"html_description": "",
		"html_keywords": "关于我们,磨石金融,新媒体,财经,内容平台"
	})
});

router.get('/books', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('books', 
	{ 
		"html_description": "",
		"html_keywords": "Books,磨石金融,宽客"
	})
});

router.get('/company', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('channel', 
	{ 
		"channel": "金融帝国",
		"channel_qml": "website_company",
		"html_description": "",
		"html_keywords": "金融帝国,磨石金融,新媒体,金融巨鳄"
	})
});

router.get('/dashboard', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')
	res.sendFile(path.join(home_dir + '/dashboard.html'));
});

router.get('/edge', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('edge', 
	{ 
		"html_description": "磨石金融Edge频道为您收录世界上最前沿的量化交易研究和金融科技创新。",
		"html_keywords": "前沿,Edge,磨石金融,宽客,量化交易,学术研究,量化对冲基金,Quant,Quatitative,Hedge Fund,Strategy"
	})
});

router.get('/joinus', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('joinus', 
	{ 
		"html_description": "",
		"html_keywords": "加入我们,加入磨石,磨石金融,新媒体,内容平台,磨石工具"
	})
});

router.get('/login', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')
	res.sendFile(path.join(home_dir + '/login.html'));
});

router.get('/liqi', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('liqi', 
	{ 
		"html_description": "",
		"html_keywords": "利器,磨石金融,Python,TALib,scikit-learn"
	})
});

router.get('/mindstore', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('mindstore', 
	{ 
		"html_description": "在Mindstore频道发现最近都有哪些不容错过的讲座和会议。",
		"html_keywords": "Mindstore,讲座,会议,磨石金融,学术会议,Workshop,Conference,Seminar,Talk,Pitch"
	})
});

router.get('/my', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')
	res.render('my', 
	{ 
		"html_description": "",
		"html_keywords": "磨石金融"
	})
});

router.get('/partners', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('partners', 
	{ 
		"html_description": "",
		"html_keywords": "合作伙伴,Gimletech,技术联盟,媒体联盟"
	})
});

router.get('/research', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('channel', 
	{ 
		"channel": "磨石研究",
		"channel_qml": "website_research",
		"html_description": "",
		"html_keywords": "磨石研究,投资模式,磨石金融,量化交易,算法交易,程序化交易,交易系统"
	})
});

router.get('/review', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('channel', 
	{ 
		"channel": "物是评测",
		"channel_qml": "website_review",
		"html_description": "",
		"html_keywords": "物是评测,磨石金融,产品,App"
	})
});

router.get('/story', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')

	res.render('channel', 
	{ 
		"channel": "投资故事",
		"channel_qml": "website_story",
		"html_description": "",
		"html_keywords": "投资故事,磨石金融,新媒体,交易人生,纪实,财经"
	})
});

// 
// 
// 
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
	  		// only list public and draft articles
	  		// list draft articles if user got an id
	  		if ("private" !== doc.status) {
		  		article = doc
		  		find = true
	  		}
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

router.get('/sogousiteverification.txt', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')
	res.sendFile(path.join(home_dir + '/sogousiteverification.txt'));
});

router.get('/shenma-site-verification.txt', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')
	res.sendFile(path.join(home_dir + '/shenma-site-verification.txt'));
});

module.exports = router;
