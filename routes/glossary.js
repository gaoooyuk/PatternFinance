var express = require('express');
var moment = require('moment');
var assert = require('assert');
var async = require('async');

var router = express.Router();

var collectionName = 'glossary'

router.get('/', function(req, res) {
    var word = "信贷脉冲"
    searchWord(word, "zh", function(found, cache) {
        res.render('glossary',
        {
            "html_title": "信贷脉冲",
            "html_description": "Trade Smart - 面向多策略开发的自动交易系统STS。",
            "html_keywords": "STS,Trading Systems,交易系统,交易策略,策略开发,磨石金融,Python",
            "html_cache": JSON.stringify(cache)
        })
    })
});

router.get('/*', function(req, res, next) {
    var word = req.params['0']
    searchWord(word, "zh", function(found, cache) {
        if (found) {
            res.render('glossary',
            {
                "html_title": word,
                "html_description": "Trade Smart - 面向多策略开发的自动交易系统STS。",
                "html_keywords": "STS,Trading Systems,交易系统,交易策略,策略开发,磨石金融,Python",
                "html_cache": JSON.stringify(cache)
            })
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
            var cursor2 = global.mongodb.collection('glossary').find({}).sort(sort).limit(3);
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
            var word_lang = "word_" + lang
            var cursor3 = global.mongodb.collection('glossary').find({ word_lang: word }).limit(1);
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

module.exports = router;
