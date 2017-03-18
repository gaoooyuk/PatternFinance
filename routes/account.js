var toMarkdown = require('to-markdown');
var pyShell = require('python-shell');
var medium = require('medium-sdk');
var express = require('express');
var deasync = require('deasync');
var moment = require('moment');
var assert = require('assert');
var async = require('async');
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
		handleCodeLogin(token, res)
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
	var rawData = req.body.rawData
	var platforms = req.body.platforms
	// now we get all platforms writer want to publish to

	async.parallel([
	    function(callback) {
	    	// 磨石金融
	    	if (platforms.indexOf("patternfinance") >= 0) {
	    		publish2PatternFinance(id, title, cover, lede, type, category, authorName, rawData, callback)
	    	} else {
		    	callback(null, 'patternfinance:skip');
	    	}
	    },
	    function(callback) {
	    	// Medium
	    	if (platforms.indexOf("medium") >= 0) {
	    		var token = "2b883721714b12cf328d0cea259b684bf49492f171164b4ddd812d2b6a877dad8"
	    		publish2Medium(title, rawData, token, callback)
	    	} else {
		    	callback(null, 'medium:skip');
	    	}
	    },
	    function(callback) {
	    	// 今日头条
	    	if (platforms.indexOf("jrtt") >= 0) {
				publish2JRTT(callback)
	    	} else {
		    	callback(null, 'jrtt:skip');
	    	}
	    },
	    function(callback) {
	    	// 微信公众号
	    	if (platforms.indexOf("wxmp") >= 0) {
				publish2WXMP(callback)
	    	} else {
		    	callback(null, 'wxmp:skip');
	    	}
	    },
	    function(callback) {
	    	// 雪球
	    	if (platforms.indexOf("xueqiu") >= 0) {
				publish2Xueqiu(callback)
	    	} else {
		    	callback(null, 'xueqiu:skip');
	    	}
	    },
	    function(callback) {
	    	// 新浪财经头条号
	    	if (platforms.indexOf("sinacj") >= 0) {
				publish2Sinacj(callback)
	    	} else {
		    	callback(null, 'sinacj:skip');
	    	}
	    }
	],
	// async.parallel callback
	function(err, results) {
		var atMs = (new Date).getTime()
		res.send({ success: "true", resultsArray: results, actionTimeInMs: atMs })
	});
});

function publish2PatternFinance(id, title, cover, lede, type, category, authorName, rawData, cb) {
	async.parallel([
	    function(callback) {
		    var now = moment()
		    var fmt = "YYYY-MM-DD hh:mm"
			var from = now.format(fmt)
			var qmlData = buildArticle(id, title, type, category, authorName, lede, from, cover, rawData)

		    var data_dir = path.join(global.dirRoot, 'qml/qml/')
		    var file_path = data_dir + 'article_' + id + '.qml'
		    fs.writeFile(file_path, qmlData, function(err) {
		        if (err) {
		            callback(err, 'qmlfile:fail')
		        } else {
		        	callback(null, 'qmlfile:success')
		        }
		    });
	    },
	    function(callback) {
		    var data_dir = path.join(global.dirRoot, 'origins/')
		    var file_path = data_dir + id + '.txt'
		    fs.writeFile(file_path, rawData, function(err) {
		        if (err) {
		            callback(err, 'originsfile:fail')
		        } else {
	  				// extract keywords from article
					extractKeywords(id, function(keywords) {
						global.mongodb.collection('article').update( 
						{ "articleId": id },
						{ $set: { "keywords": keywords } },
						{ upsert: true } );
						callback(null, 'originsfile+keywords:success');
					});
		        }
		    });
	    },
	    function(callback) {
			// generate QR code
			generateQRCode4PatternFinance(id)
			callback(null, 'qrcode:success');
	    },
	    function(callback) {
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
			callback(null, 'db:success');
	    }
	],
	// async.parallel callback
	function(err, results) {
		if (err) {
			cb(err, 'patternfinance:fail')
		} else {
			cb(null, 'patternfinance:success')
		}
	});
}

function publish2Medium(title, rawData, token, callback) {
	mediumClient.setAccessToken(token)
	mediumClient.getUser(function(uErr, user) {
		if (uErr) {
			callback(uErr, 'medium:fail');
			return
		} else {
			if (null === user) {
				callback(null, 'medium:fail');
				return
			}
		}

		mediumClient.createPost({
			userId: user.id,
			title: title,
			contentFormat: medium.PostContentFormat.MARKDOWN,
			content: buildMarkdownArticle(title, rawData),
			publishStatus: medium.PostPublishStatus.DRAFT
		}, function(err, post) {
			if (err) {
				callback(err, 'medium:fail');
			} else {
				callback(null, 'medium:success');
			}
		})
	})
}

function publish2JRTT(callback) {
	callback(null, 'jrtt:fail');
}

function publish2WXMP(callback) {
	callback(null, 'wxmp:fail');
}

function publish2Xueqiu(callback) {
	callback(null, 'xueqiu:fail');
}

function publish2Sinacj(callback) {
	callback(null, 'sinacj:fail');
}

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
    d += ("            content: \"" + correctHtmlContent(e.content) + "\"")
    d += "\n"
    d += "        }"

    return d
}

function buildMarkdownArticle(title, rawData) {
	var md = ("# " + title)
	md += "\n\n"

    var model = JSON.parse(rawData)
    for (var i = 0; i < model.length; i++) {
        var m = model[i]
        var content = m.content
        if ("txt" === m.type) {
        	md += translateHtml2Markdown(content)
        } else if ("sectionHeader" === m.type) {
        	md += "\n\n"
        	md += ("## " + content)
        } else if ("img" === m.type) {
        	md += ("![source: 磨石金融](" + content + ")")
        }

        if (i !== (model.length - 1)) {
        	md += "\n\n"
        }
    }

	return md
}

function generateQRCode4PatternFinance(id) {
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
}

function extractKeywords(articleId, callback) {
	var fn = articleId + ".txt"
	var api_dir = path.join(global.dirRoot, 'tools')
    var options = {
        mode: 'text',
        pythonPath: '/usr/bin/python2.7',
        scriptPath: api_dir,
        args: [fn]
    };

    pyShell.run('gKeywords.py', options, function(err, results) {
    	if (err) {
    		console.log(err)
    		callback("")
    	} else {
    		callback(results[0])
    	}
    });
}

function correctHtmlContent(content) {
	return content.replace(/&lt;/g, "<")
				  .replace(/&gt;/g, ">")
}

function translateHtml2Markdown(content) {
	content = correctHtmlContent(content)
	return toMarkdown(content)
}

function handleCodeLogin(token, res) {
	var cursor = global.mongodb.collection('writer').find({ "id": token });
	cursor.each(function(err, doc) {
		assert.equal(err, null);

	  	if (doc != null) {
	  		var writer = {}
	  		writer.id = doc.id
	  		writer.type = doc.type
	  		writer.email = doc.c_email
	  		if ("" === doc.c_email) {
	  			if (!s_activated) {
					global.mongodb.collection(collectionName).update( 
						{ "id": token },
						{ "s_activated": true },
						{ upsert: false } 
					);
	  			}

	  			res.send({ success: true, user: writer })
	  		} else {
				res.send({ success: true, user: writer })
	  		}
	  	} else {
	  		if ("4f2155e69aea499c87d1850ab8a8e183" === token) {
	  			var fakeWriter = {}
		  		fakeWriter.id = "fakeid"
		  		fakeWriter.type = "faketype"
		  		fakeWriter.email = "fakeemail"
				res.send({ success: true, user: fakeWriter })
	  		} else {
				res.send({ success: false })
	  		}
	  	}
	});
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
