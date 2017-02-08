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

router.get('/article/*', function(req, res, next) {
	var home_dir = path.join(global.dirRoot, 'qml/')
	var fn = req.params['0']

	var find = false
	var done = false
	var cursor = global.mongodb.collection('article').find({ "articleId": fn });
	cursor.each(function(err, doc) {
		assert.equal(err, null);

	  	if (doc != null) {
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

		var articlehtml_dir = path.join(global.dirRoot, 'qml/articlehtml/')
		res.sendFile(path.join(articlehtml_dir + '/article_' + fn + '.html'));
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
