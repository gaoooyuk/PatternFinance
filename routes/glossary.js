var express = require('express');
var moment = require('moment');
var assert = require('assert');
var async = require('async');

var router = express.Router();

var collectionName = 'glossary'

router.get('/', function(req, res) {
    var word = "信贷脉冲"
    searchWord(word, "zh", function(found, cache) {
        renderWord(res, word, cache)
    })
});

router.get('/*', function(req, res, next) {
    var word = req.params['0']
    searchWord(word, "zh", function(found, cache) {
        if (found) {
            renderWord(res, word, cache)
        } else {
            res.redirect("https://www.patternfinance.com")
        }
    })
});

router.post('/addWords', function(req, res, next) {
    var words = req.body
    async.each(words, function(word, callback) {
        addWord(word, callback)
    }, function(err) {
        if (err) {
            // TODO
        }
        res.send("Done.")
    });
});

router.post('/updateWords', function(req, res, next) {
    var words = req.body
    async.each(words, function(word, callback) {
        updateWord(word, callback)
    }, function(err) {
        if (err) {
            // TODO
        }
        res.send("Done.")
    });
});

router.post('/searchWord', function(req, res, next) {
    var word = req.body.word
    var lang = req.body.lang
    var result = {}
    searchWord(word, lang, function(found, cache) {
        if (found) {
            result.found = true
            result.data = cache
        } else {
            result.found = false
        }
        res.send(result)
    })
});

var searchWord = function(word, lang, callback) {
    var found = false
    var total = 0
    var zxsl = []
    var cx = {}
    async.parallel([
        function(cb) {
            var cursor1 = global.mongodb.collection('glossary').find({});
            cursor1.count(function(err, count) {
                total = count
                cb(null, '');
            })
        },
        function(cb) {
            var sort = { '_id': -1 }

            // find items where array.size > 1
            // https://stackoverflow.com/questions/7811163/query-for-documents-where-array-size-is-greater-than-1/15224544#15224544
            var cursor2 = null
            if ("en" === lang) {
                cursor2 = global.mongodb.collection('glossary').find({ 'examples_en.0': {$exists:true} }).sort(sort).limit(3);
            } else {
                cursor2 = global.mongodb.collection('glossary').find({ 'examples_zh.0': {$exists:true} }).sort(sort).limit(3);
            }
            cursor2.toArray(function(err, docs) {
                docs.forEach(function(doc) {
                    var word_zh = doc.word_zh
                    var examples = doc.examples_zh
                    if (examples.length > 0) {
                        var zx = examples[examples.length - 1].content
                        zx = String(zx).replace(word_zh, "<font color=#38E4BD>" + word_zh + "</font>")
                        zxsl.push({
                            "zx": zx,
                            "word": word_zh
                        })
                    }
                })
                cb(null, '');
            });
        },
        function(cb) {
            var cursor3 = null
            if ("en" === lang) {
                cursor3 = global.mongodb.collection('glossary').find({ "word_en": word }).limit(1);
            } else {
                cursor3 = global.mongodb.collection('glossary').find({ "word_zh": word }).limit(1);
            }
            
            cursor3.toArray(function(err, docs) {
                docs.forEach(function(doc) {
                    found = true

                    cx.word_zh = doc.word_zh
                    cx.word_en = doc.word_en
                    cx.description_zh = doc.description_zh
                    cx.description_en = doc.description_en

                    var arr = []
                    var len = doc.examples_zh.length
                    var idx = Math.min(3, len)
                    for (var i = len - 1; i >= len - idx; i--) {
                        arr.push(doc.examples_zh[i])
                    }

                    cx.examples_zh = arr
                })
                cb(null, '');
            });            
        }
    ],
    function(err, results) {
        var cache = {}
        cache.total = total
        cache.zxsl = zxsl
        cache.cx = cx
        callback(found, cache)
    });
}

var addWord = function(word, callback) {
    global.mongodb.collection('glossary').findOne({
        "word_zh": word.word_zh
    }, function(err, doc) {
        if (!doc) {
            global.mongodb.collection('glossary').insert(word)
        }
        callback()
    });
}

var updateWord = function(word, callback) {
    global.mongodb.collection('glossary').updateOne(
    { 
        word_zh: word.word_zh 
    }, 
    { 
        $set: { 
            "description_zh": word.description_zh,
            "description_en": word.description_en,
            "word_en": word.word_en
        }
    },
    { upsert: true }, function(err) {
        callback()
    });
}

var renderWord = function(res, word, cache) {
    var cx = cache.cx
    var w_zh = cx.word_zh
    var d_zh = cx.description_zh

    var html_d = ""
    if ("" !== d_zh) {
        html_d = d_zh
    } else {
        html_d = "一群酷到爆的人做的金融新媒体。磨石金融给你看最简明扼要的" + "「" + w_zh + "」" + "解释和实时新闻摘录。"
    }

    var html_kw = "APP,微信,微博,咨询,AI,智能,科技,利器,金融,新媒体,磨石金融,新闻,解释,翻译," + w_zh

    res.render('glossary',
    {
        "html_title": word,
        "html_description": html_d,
        "html_keywords": html_kw,
        "html_cache": JSON.stringify(cache)
    })
}

module.exports = router;
