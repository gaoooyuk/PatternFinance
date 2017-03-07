var pyShell = require('python-shell');
var medium = require('medium-sdk');
var express = require('express');
var deasync = require('deasync');
var moment = require('moment');
var assert = require('assert');
var path = require('path');
var fs = require('fs');

var router = express.Router();

var mediumClient = new medium.MediumClient({
	clientId: 'fdac4fe68d72',
	clientSecret: '4a7084a9823822aa1cd180007c720d601791f668'
})

var collectionName = 'account'

router.post('/login', function(req, res, next) {
	var method = req.body.login_method
	var token = req.body.token

	if ("code" === method) {
		res.send({ success: true })
	} else if ("email" === method) {
		res.send({ success: true })
	} else {
		res.send({ success: false, errcode: 1, errstr: "Login method is not supported: " + method })
	}
});

router.post('/addArticle', function(req, res, next) {
	var id = req.body.id
	var title = req.body.title
	var authorName = req.body.author
	var cover = req.body.cover
	var lede = req.body.lede
	var type = "文章"
	var category = req.body.category
	if ("物是评测" === category) {
		type = "评测"
	}

	var result = {}

	// save to db
	global.mongodb.collection('article').update( 
	{ "articleId": id },
	{ 
		$set: { 
			"viewedTimes": 0,
			"likedTimes": 0,
			"sharedTimes": 0,
			"title": title,
			"cover": "../articledata/covers/" + cover,
			"lede": lede,
			"type": type,
			"category": category
		}
	},
	{ upsert: true } );

	// generate QR code
	var api_dir = path.join(global.dirRoot, 'tools/qrcode')
	var out_dir = path.join(global.dirRoot, 'qml/articledata/qrcodes')
	var articleUrl = "https://www.patternfinance.com/article/" + id
	var qrFn = id + ".png"
    var options = {
        mode: 'text',
        pythonPath: '/usr/bin/python2.7',
        scriptPath: api_dir,
        args: [articleUrl, "-n", qrFn, "-d", out_dir]
    };

    pyShell.run('myqr.py', options, function(err, results) {
    });

    var now = moment()
    var fmt = "YYYY-MM-DD hh:mm"
	var from = now.format(fmt)
	var qmlData = buildArticle(id, title, type, category, authorName, lede, from, cover, req.body.rawData)

    var data_dir = path.join(global.dirRoot, 'qml/qml/')
    var file_path = data_dir + 'article_' + id + '.qml'
    fs.writeFile(file_path, qmlData, function(err) {
        if (err) {
            console.log(err);
            result.success = false
        } else {
        	result.success = true
        }

		result.actionTimeInMs = (new Date).getTime()
		res.send(result)
    });
});

router.post('/publishArticle2Medium', function(req, res, next) {
	console.log("publishArticle2Medium")
	// article id on Pattern Finance
	var id = req.body.id
	id = "kmrg8gea"

	var result = {}

	var cursor = global.mongodb.collection("article").find({ "articleId": id });
	cursor.each(function(err, doc) {
		assert.equal(err, null);

	  	if (doc != null) {
	  		var title = doc.title

	  		console.log("Start publishing article to Medium.")

	  		mediumClient.setAccessToken("2b883721714b12cf328d0cea259b684bf49492f171164b4ddd812d2b6a877dad8")
			mediumClient.getUser(function(err, user) {
				console.log("err: ", err)
				console.log("user: ", user)

				if (null === user) {
					result.success = false
					result.errcode = -1 // server error
					res.send(result)
					return
				}

				mediumClient.createPost({
					userId: user.id,
					title: 'A new post',
					contentFormat: medium.PostContentFormat.HTML,
					content: '<h1>A New Post</h1><p>This is my new post from 磨石金融.</p>',
					publishStatus: medium.PostPublishStatus.DRAFT
				}, function(err, post) {
					console.log(token, user, post)
					result.success = true
					res.send(result)
				})
			})
	  	}
	});
});

function buildArticle(id, title, type, category, authorName, lede, from, cover, rawData) {
	var article = "import QtQuick 2.5"
	article += "\n"
	article += "ArticleBase {"
	article += "\n"
	article += "    id: mainWindow"
	article += "\n"
	article += "    totalNumberOfChars: getTotalNumberOfChars()"
	article += "\n"
	article += "    estimatedReadingMins: totalNumberOfChars/700"
	article += "\n"
	article += "    totalNumberOfShares: 0"
	article += "\n"
	article += ("    articleId: " + "\"" + id + "\"")
	article += "\n"
	article += ("    articleTitle: " + "\"" + title + "\"")
	article += "\n"
	article += ("    articleType: " + "\"" + type + "\"")
	article += "\n"
	article += ("    articleCategory: " + "\"" + category + "\"")
	article += "\n"
	article += ("    authorName: " + "\"" + authorName + "\"")
	article += "\n"
	article += ("    summary: " + "\"" + lede + "\"")
	article += "\n"
	article += ("    from: " + "\"" + from + "\"")
	article += "\n"
	article += ("    coverImage: " + "\"" + cover + "\"")
	article += "\n"
	article += "	contentModel: content"
	article += "\n"
	article += "	tocModel: toc"
	article += "\n"
	article += buildArticleModel(rawData)
	article += "\n"
	article += "	ListModel { id: toc }"
	article += "\n"
	article += "}"

	return article
}

function buildArticleModel(rawData) {
    var d = "	ListModel { "
    d += "\n"
    d += "        id: content"
    var model = JSON.parse(rawData)
    for (var i = 0; i < model.length; i++) {
        d += buildArticleModelElement(model[i])
    }
    d += "\n"
    d += "	}"

    return d
}

function buildArticleModelElement(e) {
    var d = "\n"
    d += "        ListElement { "
    d += "\n"
    d += ("            type: \"" + e.type + "\"")
    d += "\n"
    d += ("            ratio: " + e.ratio)
    d += "\n"
    d += ("            content: \"" + e.content + "\"")
    d += "\n"
    d += "        }"

    return d
}

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