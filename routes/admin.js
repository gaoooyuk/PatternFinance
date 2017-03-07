var express = require('express');
var deasync = require('deasync');
var moment = require('moment');
var assert = require('assert');

var router = express.Router();

var collectionName = 'writer'

router.post('/addWriter', function(req, res, next) {
	var writer = gEmptyWriter()
	writer.id = gInviteCode(req.body.type)
	writer.type = req.body.type

    global.mongodb.collection(collectionName).update(writer, {}, { upsert: true });

	res.send({ "success": true, "id": writer.id })
});

var gEmptyWriter = function() {
	var writer = {}
	writer.id = ""
	writer.name = ""
	writer.identity = ""
	writer.type = ""
	writer.password = ""

	// n_: nick name
	writer.n_wxmp = ""
	writer.n_xueqiu = ""
	writer.n_jrtt = ""
	writer.n_medium = ""
	writer.n_sinacj = ""

	// c_: contact method
	writer.c_mobile = ""
	writer.c_email = ""
	writer.c_qq = ""
	writer.c_wx = ""

	// s_: status
	writer.s_activated = false

	// avgvt: avg viewed times
	writer.avgvt_wxmp = 0
	writer.avgvt_xueqiu = 0
	writer.avgvt_jrtt = 0

	return writer
};

var gInviteCode = function(type) {
	return String(type).toUpperCase() + shortUUID(6)
};

var shortUUID = function(len) {
	var ALPHABET = '23456789abdegjkmnpqrvwxyz';
	var ALPHABET_LENGTH = ALPHABET.length;
    var ID_LENGTH = len
    var rtn = ''
    for (var i = 0; i < ID_LENGTH; i++) {
        rtn += ALPHABET.charAt(Math.floor(Math.random() * ALPHABET_LENGTH));
    }
    return rtn;
};

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
