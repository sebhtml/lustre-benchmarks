#!/usr/bin/env python

import sys
arguments=sys.argv

if len(arguments)==1:
	print "Not available"
	sys.exit()

# 26m26.498s

value=arguments[1]

seconds=value.replace("s","")

tokens=value.split("m")

if len(tokens)==2:
	seconds=int(tokens[0])*60+float(tokens[1].replace("s",""))

print (str(seconds))
