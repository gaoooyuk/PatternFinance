var express = require('express');
var moment = require('moment');
var assert = require('assert');
var async = require('async');

var router = express.Router();

var collectionName = 'glossary'

router.get('/', function(req, res) {
    var word = "信贷脉冲"
    searchWord(word, function(found, cache) {
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
    searchWord(word, function(found, cache) {
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

var searchWord = function(word, callback) {
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
            var cursor3 = global.mongodb.collection('glossary').find({ "word_zh": word }).limit(1);
            cursor3.toArray(function(err, docs) {
                docs.forEach(function(doc) {
                    found = true

                    cx.word_zh = doc.word_zh
                    cx.description_zh = doc.description_zh

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

module.exports = router;
