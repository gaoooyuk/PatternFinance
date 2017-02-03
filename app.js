'use strict';

var MongoClient = require('mongodb').MongoClient;
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var favicon = require('serve-favicon');
var express = require('express');
var logger = require('morgan');
var assert = require('assert');
var path = require('path');

// Routes
var routes = require('./routes/index');
var api = require('./routes/api');

var app = express();

// Global variables
global.dirRoot = __dirname

// MongoDB
var url = 'mongodb://localhost:27017/PatternFinanceDB';
MongoClient.connect(url, function(err, db) {
  assert.equal(null, err);
  console.log("mongodb connected.");
  global.mongodb = db

  global.mongodb.collection('article').update( 
  { "articleId": "mean_reversion_part_1" },
  { $set: { 
            "viewedTimes": 0, 
            "likedTimes": 0, 
            "title": "一周学会如何在股票交易中运用Mean-Reversion策略获利 - 1", 
            "cover": "http://legends.io/wp-content/uploads/2016/05/cover2.jpg", 
            "lede:": "和你一起探讨均值回归策略在股票交易中的运用" 
          } 
  },
  { upsert: true } );
});

// express behind proxy
app.set('trust proxy', true);
app.set('trust proxy', 'loopback');

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use('/public', express.static(path.join(__dirname, 'public/')));
app.use('/article', express.static(path.join(__dirname, 'qml/')));
app.use('/', express.static(path.join(__dirname, 'qml/')));
app.use('/', routes);
app.use('/api', api);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var home_dir = path.join(global.dirRoot, 'public/')
  res.status(404).sendFile(path.join(home_dir + '/404.html'));
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});

module.exports = app;
