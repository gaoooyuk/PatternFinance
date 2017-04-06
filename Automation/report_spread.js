var MongoClient = require('mongodb').MongoClient;
var moment = require('moment');
var assert = require('assert');
var async = require('async');
var later = require('later');
var path = require('path');
var fs = require('fs');

var start = function() {
	// MongoDB
	var dbUrl = 'mongodb://localhost:27017/PatternFinanceDB';
	MongoClient.connect(dbUrl, function(err, db) {
		assert.equal(null, err);
		console.log("Init: mongodb connected.");
		global.mongodb = db

		// var sched = later.parse.recur().every(10).second();
		// var timer = later.setInterval(buildSummary, sched);
		buildSummary()
	});
}

var buildSummary = function() {
	var cursor = global.mongodb.collection('writer').find({})
	cursor.each(function(err, doc) {
		assert.equal(err, null);

	  	if (doc != null) {
	  		var totalNumArticles = 0
	  		var totalViewedTimes = 0
	  		var totalCommentedTimes = 0
	  		var totalLikedTimes = 0
	  		var avgViewedTimes = 0

	  		if (!assertPoint(doc.medias)) {
	  			return
	  		}

	  		for (var i = 0; i < doc.medias.length; i++) {
	  			var mt = doc.medias[i]

		  		var mt_totalNumArticles = mt.articles.length
		  		var mt_totalViewedTimes = 0
		  		var mt_totalCommentedTimes = 0
		  		var mt_totalLikedTimes = 0
		  		var mt_avgViewedTimes = 0

	  			for (var j = 0; j < mt.articles.length; j++) {
	  				var article = mt.articles[j]

	  				var vt = article.viewedTimes
	  				if (vt) {
						mt_totalViewedTimes += vt
	  				}

	  				var ct = article.commentedTimes
	  				if (ct) {
	  					mt_totalCommentedTimes += ct
	  				}

	  				var lt = article.likedTimes
	  				if (lt) {
	  					mt_totalLikedTimes += lt
	  				}
	  			}

	  			mt_avgViewedTimes = parseInt(mt_totalNumArticles > 0 ? mt_totalViewedTimes/mt_totalNumArticles : 0)

				global.mongodb.collection('writer').update( 
				{ 
					"id": doc.id,
					"medias": { "$elemMatch": { "channel": mt.channel } } 
				},
				{ 
					$set: {
						"medias.$.totalNumArticles": mt_totalNumArticles,
						"medias.$.totalViewedTimes": mt_totalViewedTimes,
						"medias.$.totalCommentedTimes": mt_totalCommentedTimes,
						"medias.$.totalLikedTimes": mt_totalLikedTimes,
						"medias.$.avgViewedTimes": mt_avgViewedTimes
					}
				},
				{ upsert: false } );

	  			totalNumArticles += mt_totalNumArticles
	  			totalViewedTimes += mt_totalViewedTimes
	  			totalCommentedTimes += mt_totalCommentedTimes
	  			totalLikedTimes += mt_totalLikedTimes
	  		}

		  	avgViewedTimes = parseInt(totalNumArticles > 0 ? totalViewedTimes/totalNumArticles : 0)

			global.mongodb.collection('writer').update({ "id": doc.id },
			{ 
				$set: {
					"totalNumArticles": totalNumArticles,
					"totalViewedTimes": totalViewedTimes,
					"totalCommentedTimes": totalCommentedTimes,
					"totalLikedTimes": totalLikedTimes,
					"avgViewedTimes": avgViewedTimes
				}
			},
			{ upsert: false } );
	  	}
	});
}

function assertPoint(p) {
	if (undefined == p || null == p) {
		return false
	}

	return true
}

start()