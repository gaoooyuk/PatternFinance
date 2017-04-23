var MongoClient = require('mongodb').MongoClient;
var htmlparser = require("htmlparser2");
var phantom = require("phantom");
var moment = require('moment');
var assert = require('assert');
var async = require('async');
var later = require('later');
var jsdom = require("jsdom");
var path = require('path');
var fs = require('fs');

// global variables
var iter = 0
var sched = null
var phantomJS = null
var phantomColumnRunning = false
var agents = ['Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_8; en-us) AppleWebKit/534.50 (KHTML, like Gecko) Version/5.1 Safari/534.50', 
'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-us) AppleWebKit/534.50 (KHTML, like Gecko) Version/5.1 Safari/534.50', 
'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0;', 
'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)', 
'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)', 
'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1', 
'Mozilla/5.0 (Windows NT 6.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1', 
'Opera/9.80 (Macintosh; Intel Mac OS X 10.6.8; U; en) Presto/2.8.131 Version/11.11', 
'Opera/9.80 (Windows NT 6.1; U; en) Presto/2.8.131 Version/11.11', 
'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Maxthon 2.0)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; TencentTraveler 4.0)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; The World)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; SE 2.X MetaSr 1.0; SE 2.X MetaSr 1.0; .NET CLR 2.0.50727; SE 2.X MetaSr 1.0)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; 360SE)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Avant Browser)', 
'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)', 
'Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5', 
'Mozilla/5.0 (iPod; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5', 
'Mozilla/5.0 (iPad; U; CPU OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5', 
'Mozilla/5.0 (Linux; U; Android 2.3.7; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1', 
'MQQBrowser/26 Mozilla/5.0 (Linux; U; Android 2.3.7; zh-cn; MB200 Build/GRJ22; CyanogenMod-7) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1', 
'Opera/9.80 (Android 2.3.4; Linux; Opera Mobi/build-1107180945; U; en-GB) Presto/2.8.149 Version/11.10', 
'Mozilla/5.0 (Linux; U; Android 3.0; en-us; Xoom Build/HRI39) AppleWebKit/534.13 (KHTML, like Gecko) Version/4.0 Safari/534.13', 
'Mozilla/5.0 (BlackBerry; U; BlackBerry 9800; en) AppleWebKit/534.1+ (KHTML, like Gecko) Version/6.0.0.337 Mobile Safari/534.1+', 
'Mozilla/5.0 (hp-tablet; Linux; hpwOS/3.0.0; U; en-US) AppleWebKit/534.6 (KHTML, like Gecko) wOSBrowser/233.70 Safari/534.6 TouchPad/1.0', 
'Mozilla/5.0 (SymbianOS/9.4; Series60/5.0 NokiaN97-1/20.0.019; Profile/MIDP-2.1 Configuration/CLDC-1.1) AppleWebKit/525 (KHTML, like Gecko) BrowserNG/7.1.18124', 
'Mozilla/5.0 (compatible; MSIE 9.0; Windows Phone OS 7.5; Trident/5.0; IEMobile/9.0; HTC; Titan)', 
'UCWEB7.0.2.37/28/999', 
'NOKIA5700/ UCWEB7.0.2.37/28/999', 
'Openwave/ UCWEB7.0.2.37/28/999', 
'Mozilla/4.0 (compatible; MSIE 6.0; ) Opera/UCWEB7.0.2.37/28/999', 
'UCWEB7.0.2.37/28/999', 
'NOKIA5700/ UCWEB7.0.2.37/28/999', 
'Openwave/ UCWEB7.0.2.37/28/999', 
'Mozilla/4.0 (compatible; MSIE 6.0; ) Opera/UCWEB7.0.2.37/28/999',
'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36']

var start = function() {
	// Create and init PhantomJS
	phantom.create().then(ph => {
	    phantomJS = ph;
	})

	// MongoDB
	var dbUrl = 'mongodb://localhost:27017/ValueDB';
	MongoClient.connect(dbUrl, function(err, db) {
		assert.equal(null, err);
		console.log("Init: mongodb connected.");
		global.mongodb = db

		iter = 0
		if (assertPoint(sched)) {
			// Execute code
			var timer = later.setInterval(crawl, sched);
		} else {
			console.log("Warning: no sched found.")
		}
	});
}

var setSchedule = function(s) {
	sched = s
}

var useDefaultSchedule = function() {
	sched = later.parse.recur().every(2).hour();
}

var crawl = function() {
	var url = "https://www.instituteforsupplymanagement.org/ismreport/mfgrob.cfm?SSO=1"
	console.log("crawl: ", url)

	if (phantomColumnRunning) {
		return
	}
	phantomColumnRunning = true

	phantomJS.createPage().then(page => {
		page.property('customHeaders', {
			"Referer" : "https://www.patternfinance.com"
		})
		// page.property('viewportSize', { width: 1024, height: 600 });
		var agent = agents[Math.floor(agents.length * Math.random())]
		page.setting('userAgent', agent)
	    page.open(url).then(status => {
	    	return page.property('content')
	    }).then(content => {
	    	// console.log(content)
	    	var ism = {}
	    	ism.id = "ism_us"
	    	var document = jsdom.jsdom(content);

	    	var forr = document.querySelector(".mfgROB > p > strong")
	    	if (forr) {
	    		ism.forRelease = forr.innerHTML.replace("FOR RELEASE: ", "")
	    	}

	    	var asOf = document.querySelector(".mfgROB > h3")
	    	if (asOf) {
	    		var asOfStr = asOf.innerHTML
	    		ism.asOf = asOfStr.slice(0, asOfStr.indexOf("Manufacturing") - 1)
	    	}

	    	var tbodys = document.querySelectorAll(".mfgROB > table > tbody")
	    	if (tbodys) {
	    		var tbody = tbodys[1]
	    		var trs = tbody.children
	    		ism.pmi = parseFloat(trs[2].children[1].innerHTML)

	    		var msector = trs[trs.length - 1]
	    		var tds = msector.children
	    		if (tds && tds.length > 3) {
	    			ism.direction = tds[1].innerHTML
	    			ism.rateOfChange = tds[2].innerHTML
	    			ism.trendMonths = parseInt(tds[3].innerHTML)

	    			updateISM(ism)
	    		}
	    	}
	        page.close()
	        phantomColumnRunning = false
	    }).catch(e => {
	    	console.log(e)
	    	page.close()
	    	phantomColumnRunning = false
	    });
	}).catch(e => {
		console.log(e)
		phantomColumnRunning = false
	});
}

var updateISM = function(ism) {
	if (isValid(ism)) {
		global.mongodb.collection('economics').update( { "id": ism.id }, ism, { upsert: true } );
	}
}

var isValid = function(ism) {
	if (ism.forRelease && "" !== ism.forRelease
		&& ism.asOf && "" !== ism.asOf
		&& assertPoint(ism.pmi)
		&& ism.direction && "" !== ism.direction
		&& ism.rateOfChange && "" !== ism.rateOfChange
		&& assertPoint(ism.trendMonths)) {
		return true
	}

	return false
}

var correctHtmlContent = function(content) {
	return content.replace(/&lt;/g, "<")
				  .replace(/&gt;/g, ">")
				  .replace(/&ld/g, "“")
				  .replace(/&gd/g, "”")
}

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

function assertPoint(p) {
	if (undefined == p || null == p) {
		return false
	}

	return true
}

function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}

useDefaultSchedule()
start()