# -*- coding: utf-8 -*-
import jieba
import jieba.analyse

from os import listdir
from os.path import isfile, join
import sys, json
import logging

reload(sys)
sys.setdefaultencoding( "utf-8" )

if __name__ == '__main__':
	logging.disable(logging.DEBUG)
	fn = sys.argv[1]
	content = open('/Users/chuck/PatternFinance/origins/'+fn, 'rb').read()
	tags = jieba.analyse.extract_tags(content, topK=20, allowPOS=('ns', 'n', 'vn', 'v'))
	logging.disable(logging.NOTSET)
	print u','.join(tags)