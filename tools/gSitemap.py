# -*- coding: utf-8 -*-

# Generate sitemap from *.html entries

from os import listdir
from os.path import isfile, join

import time
import json
import sys

def save_data(data):
	with open(('sitemap.xml'), 'w') as data_file:
		data_file.write(data)

def load_data(fn):
	with open(fn) as data_file:    
		data = data_file.readlines()

	return data

def addItem(loc, lastmod, changefreq, priority):
	return '<url><loc>%s</loc><lastmod>%s</lastmod><changefreq>%s</changefreq><priority>%.2f</priority></url>'%(loc,lastmod,changefreq,priority)

if __name__ == '__main__':
	d='<?xml version="1.0" encoding="UTF-8"?>'
	d=d+'\n'
	d=d+'<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">'
	d=d+'\n'
	d=d+addItem('http://www.patternfinance.com/', '2017-02-04T03:18:08+00:00', 'weekly', 1.00)
	d=d+'\n'

	articlePath='../qml'
	onlyfiles = [f for f in listdir(articlePath) if isfile(join(articlePath, f))]

	for fl in onlyfiles:
		if fl.startswith('article_'):
			loc='http://www.patternfinance.com/article/%s'%(fl.replace('.html', '').replace('article_', ''))
			lastmod='2017-02-04T03:18:08+00:00'
			changefreq='weekly'
			p=0.8
			d=d+addItem(loc,lastmod,changefreq,p)
			d=d+'\n'

	d=d+'</urlset>'

	save_data(d)
