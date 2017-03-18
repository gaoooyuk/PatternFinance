# -*- coding: utf-8 -*-
import jieba
import jieba.analyse

from os import listdir
from os.path import isfile, join
import sys

if __name__ == '__main__':
	print '[*]开始提取磨石金融所有文章中的关键词'
	print '[*]初始化Keywords提取器'
	print '[*]载入自定义词典'
	jieba.load_userdict('keyworddict.txt')

	print '[*]开始提取关键词...'
	articlePath='../origins/'
	onlyfiles = [f for f in listdir(articlePath) if isfile(join(articlePath, f))]

	content = ''
	for fl in onlyfiles:
		content = content + open('../origins/'+fl, 'rb').read()

	tags = jieba.analyse.extract_tags(content, topK=100, allowPOS=('ns', 'n', 'vn', 'v'))
	print(', '.join(tags))

	print '[*]关键词提取完毕'