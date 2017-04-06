var toMarkdown = require('to-markdown');
var htmlparser = require("htmlparser2");
var pyShell = require('python-shell');
var medium = require('medium-sdk');
var express = require('express');
var deasync = require('deasync');
var moment = require('moment');
var assert = require('assert');
var async = require('async');
var jsdom = require("jsdom");
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

router.post('/getSpreadSummary', function(req, res, next) {
	var userId = req.body.userId
	var token = req.body.token
});

router.post('/getSpreadReport', function(req, res, next) {
	var userId = req.body.userId
	var token = req.body.token
});

router.post('/addArticle', function(req, res, next) {
	var id = req.body.id
	var title = req.body.title
	var author = req.body.author
	var cover = req.body.cover
	var lede = req.body.lede
	var type = "文章"
	var category = req.body.category
	if ("物是评测" === category) {
		type = "评测"
	}
	var status = "public" // draft, public, private
	if (req.body.status) {
		status = req.body.status
	}
	var rawData = req.body.rawData
	var tocs = req.body.tocs // table of content array
	var platforms = req.body.platforms
	// now we get all platforms writer want to publish to

	async.parallel([
	    function(callback) {
	    	// 磨石金融
	    	if (platforms.indexOf("patternfinance") >= 0) {
	    		publish2PatternFinance(id, title, cover, lede, type, category, author, rawData, tocs, status, callback)
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

router.post('/importArticleFromUrl', function(req, res, next) {
	var url = req.body.url
	var hostName = getHostName(url)
	// console.log("hostName: ", hostName)

	// create article meta
	var meta = {}
	meta.id = shortUUID()
	meta.title = ""
	meta.cover = ""
	meta.lede = ""
	meta.type = ""
	meta.category = ""
	meta.author = ""
	meta.rawData = "[]"
	meta.status = "draft"

	async.series([
	    function(callback) {
	    	if ("zhuanlan.zhihu.com" === hostName) {
	    		importFromZhihu(url, function(success, resObj) {
					if (success) {
						for (k in resObj) {
							meta[k] = resObj[k]
						}
						callback(null, "import-zhihu:success")
					} else {
						callback(null, "import-zhihu:fail")
					}
	    		})
	    	} else if ("xueqiu.com" === hostName) {
	    		importFromXueqiu(url, function(success, resObj) {
					if (success) {
						for (k in resObj) {
							meta[k] = resObj[k]
						}
						callback(null, "import-xueqiu:success")
					} else {
						callback(null, "import-xueqiu:fail")
					}
	    		})
	    	} else if ("mp.weixin.qq.com" === hostName) {
	    		importFromWxMP(url, function(success, resObj) {
					if (success) {
						for (k in resObj) {
							meta[k] = resObj[k]
						}
						callback(null, "import-wxmp:success")
					} else {
						callback(null, "import-wxmp:fail")
					}
	    		})
	    	} else if (hostName.indexOf("baijia.baidu.com") >= 0) {
	    		importFromBdBj(url, function(success, resObj) {
					if (success) {
						for (k in resObj) {
							meta[k] = resObj[k]
						}
						callback(null, "import-bdbj:success")
					} else {
						callback(null, "import-bdbj:fail")
					}
	    		})
	    	} else if (hostName.indexOf("ifeng.com") >= 0) {
	    		importFromFhh(url, function(success, resObj) {
					if (success) {
						for (k in resObj) {
							meta[k] = resObj[k]
						}
						callback(null, "import-fhh:success")
					} else {
						callback(null, "import-fhh:fail")
					}
	    		})
	    	} else if ("finance.sina.com.cn" === hostName) {
	    		importFromSinacj(url, function(success, resObj) {
					if (success) {
						for (k in resObj) {
							meta[k] = resObj[k]
						}
						callback(null, "import-sinacj:success")
					} else {
						callback(null, "import-sinacj:fail")
					}
	    		})
	    	} else {
	    		callback(null, "import:fail")
	    	}
	    },
	    function(callback) {
	    	callback(null, "qmlfile:fail")
	        // publish2PatternFinance(meta.id, meta.title, meta.cover, meta.lede, meta.type, meta.category, meta.author, meta.rawData, meta.status, callback)
	    }
	],
	// optional callback
	function(err, results) {
		// console.log("article: ", meta)
		var atMs = (new Date).getTime()
		res.send({ success: "true", article: meta, actionTimeInMs: atMs })
	});
});

router.post('/updateArticle', function(req, res, next) {
	var meta = req.body.meta
	global.mongodb.collection('article').update( 
	{ "articleId": req.body.articleId },
	{ 
		$set: meta
	},
	{ upsert: false } );
	meta.articleId = req.body.articleId
	res.send(meta)
});

function publish2PatternFinance(id, title, cover, lede, type, category, author, rawData, tocs, status, cb) {
	async.parallel([
	    function(callback) {
		    var now = moment()
		    var fmt = "YYYY-MM-DD hh:mm"
			var from = now.format(fmt)
			var qmlData = buildArticle(id, title, type, category, author, lede, from, cover, rawData, tocs)

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
					"status": status,
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

function importFromZhihu(url, cb) {
	var meta = {}
	meta.title = ""
	meta.cover = ""
	meta.lede = ""
	meta.type = "文章"
	meta.category = "投资故事"
	meta.author = ""
	meta.rawData = ""

	jsdom.env(url, [], function (err, window) {
		if (err) {
			cb(false, err);
		} else {
			var document = window.document
			var raw = document.querySelector("#preloadedState").innerHTML;
			var article = JSON.parse(raw)
			// console.log(article)

			var rawContent = ""
			for (p in article.database.Post) {
				var post = article.database.Post[p]
				meta.title = post.title
				rawContent = correctHtmlContent(post.content)
				// console.log(rawContent)
				meta.cover = post.titleImage
			}

			for (u in article.database.User) {
				var user = article.database.User[u]
				meta.author = user.name
			}

			var contentArray = []
			var currentTag = ""
			var parser = new htmlparser.Parser({
				onopentag: function(tag, attribs) {
					if ("h2" === currentTag && "b" === tag) {
						currentTag = "sectionHeader"
					} else {
						currentTag = tag
						if ("img" === tag) {
							contentArray.push({
								"type": "img",
								"ratio": attribs["data-rawheight"]/attribs["data-rawwidth"],
								"content": attribs.src
							})
						}
					}
				},
				ontext: function(text) {
					// console.log(currentTag)
					if ("p" === currentTag || "i" === currentTag) {
						contentArray.push({
							"type": "txt",
							"ratio": 1,
							"content": text
						})
					} else if ("sectionHeader" === currentTag) {
						contentArray.push({
							"type": "sectionHeader",
							"ratio": 1,
							"content": String(text).trim()
						})
					}
				},
				onclosetag: function(tag) {
				},
				onend: function() {
					meta.rawData = JSON.stringify(contentArray)
					// free memory associated with the window
					window.close();
					cb(true, meta);
				}
			}, {decodeEntities: true});
			parser.write(rawContent);
			parser.end();
		}
	});
}

function importFromXueqiu(url, cb) {
	var meta = {}
	meta.title = ""
	meta.cover = ""
	meta.lede = ""
	meta.type = "文章"
	meta.category = "投资故事"
	meta.author = ""
	meta.rawData = ""

	jsdom.env(url, [], function (err, window) {
		if (err) {
			cb(false, err);
		} else {
			var document = window.document

			meta.author = document.querySelector(".avatar").attributes[2].nodeValue
			meta.title = document.querySelector(".status-title").innerHTML

			var raw = document.querySelector(".detail").innerHTML;
			var rawContent = correctHtmlContent(raw)

			var contentArray = []
			var in_paragraph = false
			var pContent = ""
			var currentTag = ""
			var currentAttribPair = ""
			var parser = new htmlparser.Parser({
				onopentag: function(tag, attribs) {
					currentTag = tag
					if ("p" === tag) {
						in_paragraph = true
					}
				},
				ontext: function(text) {
					// console.log(text)
					if (in_paragraph) {
						if ("b" === currentTag) {
							pContent += ("<strong>" + text + "</strong>")
						} else {
							pContent += text
						}
					}
				},
				onattribute: function(name, value) {
					if ("class:ke_img" === currentAttribPair) {
						if ("src" === name) {
							imgUrl = "http:" + value
							contentArray.push({
								"type": "img",
								"ratio": 1,
								"content": imgUrl
							})
						}
					}
					currentAttribPair = name + ":" + value
				},
				onclosetag: function(tag) {
					if ("b" === tag) {
						currentTag = ""
					} else if ("p" === tag) {
						in_paragraph = false
						contentArray.push({
							"type": "txt",
							"ratio": 1,
							"content": pContent
						})
						pContent = ""
					}
				},
				onend: function() {
					meta.rawData = JSON.stringify(contentArray)
					// free memory associated with the window
					window.close();
					cb(true, meta);
				}
			}, {decodeEntities: true});
			parser.write(rawContent);
			parser.end();
		}
	});
}

function importFromWxMP(url, cb) {
	var meta = {}
	meta.title = ""
	meta.cover = ""
	meta.lede = ""
	meta.type = "文章"
	meta.category = "投资故事"
	meta.author = ""
	meta.rawData = ""

	jsdom.env({
		url: url, 
		headers: { 
			// to fix the decompress bug caused by gzip
			// we have to set accept-encoding other than "gzip"
			"accept-encoding": "compress"
		}, 
		done: function (err, window) {
			if (err) {
				// console.log(err)
				cb(false, err);
			} else {
				var document = window.document

				meta.author = document.querySelector("span.rich_media_meta_nickname").innerHTML
				meta.title = document.querySelector("title").innerHTML

				// console.log("meta.author: ", meta.author)
				// console.log("meta.title: ", meta.title)

				var raw = document.querySelector("div.rich_media_content").innerHTML
				var rawContent = correctHtmlContent(raw)

				var contentArray = []
				var currentTag = ""
				var parser = new htmlparser.Parser({
					onopentag: function(tag, attribs) {
						currentTag = tag
						// console.log("tag: ", tag)
						// console.log("attribs: ", attribs)
						if ("img" === tag && {} !== attribs) {
							var ratio = ratio = attribs["data-ratio"]
							if (null !== attribs["data-s"]) {
								var wh = attribs["data-s"].split(",")
								if (null !== attribs["data-w"] 
									&& wh[1] === attribs["data-w"]) {
									ratio = wh[0]/wh[1]
								}
							}
							contentArray.push({
								"type": "img",
								"ratio": ratio,
								"content": attribs["data-src"]
							})
						}
					},
					ontext: function(text) {
						if ("" !== String(text).trim()) {
							if ("p" === currentTag || "span" === currentTag) {
								contentArray.push({
									"type": "txt",
									"ratio": 1,
									"content": text
								})
							}
							// console.log("text: ", text)
						}
					},
					onattribute: function(name, value) {
						// console.log(name + ":" + value)
					},
					onclosetag: function(tag) {
					},
					onend: function() {
						meta.rawData = JSON.stringify(contentArray)
						// free memory associated with the window
						window.close();
						cb(true, meta);
					}
				}, {decodeEntities: true});
				parser.write(rawContent);
				parser.end();
			}
		}
	});
}

function importFromBdBj(url, cb) {
	var meta = {}
	meta.title = ""
	meta.cover = ""
	meta.lede = ""
	meta.type = "文章"
	meta.category = "投资故事"
	meta.author = ""
	meta.rawData = ""

	jsdom.env(url, [], function (err, window) {
		if (err) {
			cb(false, err);
		} else {
			var document = window.document

			meta.title = String(document.querySelector("title").innerHTML).replace("--百度百家", "")
			meta.author = document.querySelector("div.article-info>a.name").innerHTML
			meta.lede = String(document.querySelector('blockquote').innerHTML)
						.replace("<i class=\"i iquote\"></i>", "")

			var raw = document.querySelector("div.article-detail").innerHTML
			var rawContent = correctHtmlContent(raw)

			var contentArray = []
			var in_paragraph = false
			var pContent = ""
			var currentTag = ""
			var currentAttribPair = ""
			var parser = new htmlparser.Parser({
				onopentag: function(tag, attribs) {
					currentTag = tag
					if ("p" === tag) {
						in_paragraph = true
					} else if ("img" === tag) {
						contentArray.push({
							"type": "img",
							"ratio": 1,
							"content": attribs["src"]
						})
					}
				},
				ontext: function(text) {
					// console.log(text)
					if (in_paragraph) {
						if ("b" === currentTag || "strong" === currentTag) {
							pContent += ("<strong>" + text + "</strong>")
						} else {
							pContent += text
						}
					}
				},
				onclosetag: function(tag) {
					if ("p" === tag) {
						in_paragraph = false
						contentArray.push({
							"type": "txt",
							"ratio": 1,
							"content": pContent
						})
						pContent = ""
					} else {
						currentTag = ""
					}
				},
				onend: function() {
					meta.rawData = JSON.stringify(contentArray)
					// free memory associated with the window
					window.close();
					cb(true, meta);
				}
			}, {decodeEntities: true});
			parser.write(rawContent);
			parser.end();
		}
	});
}

function importFromFhh(url, cb) {
	var meta = {}
	meta.title = ""
	meta.cover = ""
	meta.lede = ""
	meta.type = "文章"
	meta.category = "投资故事"
	meta.author = ""
	meta.rawData = ""

	jsdom.env(url, [], function (err, window) {
		if (err) {
			cb(false, err);
		} else {
			var document = window.document

			meta.title = document.querySelector('meta[property="og:title"]').content
			meta.lede = correctHtmlContent(document.querySelector('meta[property="og:description"]').content)
			meta.author = document.querySelector("span.ss03").textContent
			
			var raw = document.querySelector("div#main_content").innerHTML
			var rawContent = correctHtmlContent(raw)

			var contentArray = []
			var in_paragraph = false
			var pContent = ""
			var currentTag = ""
			var currentAttribPair = ""
			var parser = new htmlparser.Parser({
				onopentag: function(tag, attribs) {
					currentTag = tag
					if ("p" === tag) {
						in_paragraph = true
					} else if ("img" === tag) {
						if ("class:detailPic" === currentAttribPair) {
							currentAttribPair = ""
							contentArray.push({
								"type": "img",
								"ratio": attribs["height"]/attribs["width"],
								"content": attribs["src"]
							})
						}
					}
				},
				ontext: function(text) {
					// console.log(text)
					if (in_paragraph) {
						if ("b" === currentTag || "strong" === currentTag) {
							pContent += ("<strong>" + text + "</strong>")
						} else {
							pContent += text
						}
					}
				},
				onattribute: function(name, value) {
					pair = name + ":" + value
					if ("class:detailPic" === pair) {
						currentAttribPair = pair
					}
				},
				onclosetag: function(tag) {
					if ("p" === tag) {
						in_paragraph = false
						contentArray.push({
							"type": "txt",
							"ratio": 1,
							"content": pContent
						})
						pContent = ""
					} else {
						currentTag = ""
					}
				},
				onend: function() {
					meta.rawData = JSON.stringify(contentArray)
					// free memory associated with the window
					window.close();
					cb(true, meta);
				}
			}, {decodeEntities: true});
			parser.write(rawContent);
			parser.end();
		}
	});
}

function importFromSinacj(url, cb) {
	var meta = {}
	meta.title = ""
	meta.cover = ""
	meta.lede = ""
	meta.type = "文章"
	meta.category = "投资故事"
	meta.author = ""
	meta.rawData = ""

	jsdom.env(url, [], function (err, window) {
		if (err) {
			cb(false, err);
		} else {
			var document = window.document

			meta.title = document.querySelector('meta[property="og:title"]').content
			meta.lede = correctHtmlContent(document.querySelector('meta[name="description"]').content)
			meta.author = document.querySelector('meta[name="mediaid"]').content
			
			var raw = document.querySelector("div#artibody").innerHTML
			var rawContent = correctHtmlContent(raw)

			var contentArray = []
			var in_paragraph = false
			var pContent = ""
			var currentTag = ""
			var currentAttribPair = ""
			var parser = new htmlparser.Parser({
				onopentag: function(tag, attribs) {
					console.log(tag)
					currentTag = tag
					if ("p" === tag) {
						in_paragraph = true
					} else if ("img" === tag) {
						if ("class:detailPic" === currentAttribPair) {
							currentAttribPair = ""
							contentArray.push({
								"type": "img",
								"ratio": attribs["height"]/attribs["width"],
								"content": attribs["src"]
							})
						}
					}
				},
				ontext: function(text) {
					console.log(text)
					if (in_paragraph) {
						if ("b" === currentTag || "strong" === currentTag) {
							pContent += ("<strong>" + text + "</strong>")
						} else {
							pContent += text
						}
					}
				},
				onattribute: function(name, value) {
					pair = name + ":" + value
					console.log(pair)
					if ("class:detailPic" === pair) {
						currentAttribPair = pair
					}
				},
				onclosetag: function(tag) {
					if ("p" === tag) {
						in_paragraph = false
						contentArray.push({
							"type": "txt",
							"ratio": 1,
							"content": pContent
						})
						pContent = ""
					} else {
						currentTag = ""
					}
				},
				onend: function() {
					meta.rawData = JSON.stringify(contentArray)
					// free memory associated with the window
					window.close();
					cb(true, meta);
				}
			}, {decodeEntities: true});
			parser.write(rawContent);
			parser.end();
		}
	});
}

function buildArticle(id, title, type, category, author, lede, from, cover, rawData, tocs) {
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
	article += ("    authorName: " + "\"" + author + "\"")
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
	article += buildTableOfContentModel(tocs)
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

function buildTableOfContentModel(tocs) {
    var d = "	ListModel { "
    d += "\n"
    d += "        id: toc"
    var model = JSON.parse(tocs)
    for (var i = 0; i < model.length; i++) {
        d += buildTableOfContentModelElement(model[i])
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

function buildTableOfContentModelElement(e) {
    var d = "\n"
    d += "        ListElement { "
    d += "\n"
    d += ("            title: \"" + e + "\"")
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
				  .replace(/&ld/g, "“")
				  .replace(/&gd/g, "”")
}

function translateHtml2Markdown(content) {
	content = correctHtmlContent(content)
	return toMarkdown(content)
}

function handleCodeLogin(token, res) {
	var writer = {}
	var find = false
	async.series([
	    function(callback) {
			global.mongodb.collection('writer').findOne({ "id": token }, function(err, doc) {
				if (doc) {
					find = true
			  		writer.id = doc.id
			  		writer.email = doc.c_email
			  		writer.name = doc.name
			  		writer.medias = doc.medias

  			  		if ("" === doc.c_email) {
			  			if (!doc.s_activated) {
							global.mongodb.collection('writer').update( 
								{ "id": doc.id },
								{ "s_activated": true },
								{ upsert: false } 
							);
			  			}
			  		}
				}

				callback(null, "")
			});
	    }
	],
	// optional callback
	function(err, results) {
		var resp = {}
	  	if (find) {
	  		resp.success = true
	  		resp.user = writer
		} else {
			resp.success = false
		}
		res.send(resp)
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

module.exports = router;
