# -*- coding: utf-8 -*-

import time
import json
import sys

def save_data(fn, data):
	with open((fn+'.lm'), 'w') as data_file:
		data_file.write(data)

def load_data(fn):
	with open(fn) as data_file:    
		data = data_file.readlines()

	return data

if __name__ == '__main__':
	fn = sys.argv[1]

	lm = 'ListModel {'
	lm=lm+'\n'
	lm=lm+('id: content')
	lm=lm+'\n'

	lines = load_data(fn)
	for line in lines:
		if ''==line.strip():
			continue

		lm=lm+('ListElement {')
		lm=lm+'\n'
		lm=lm+('type: "txt"')
		lm=lm+'\n'
		lm=lm+('ratio: 1')
		lm=lm+'\n'
		lm=lm+('content: "'+line.strip()+'"')
		lm=lm+'\n'
		lm=lm+'}'
		lm=lm+'\n'

	lm = lm+'}'

	save_data(fn, lm)