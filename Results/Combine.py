#!/usr/bin/env python

from xml.dom.minidom import parse, parseString

dataStore=[
"IOR-Oracle.xml",
"IOR-Xyratex.xml",
"OpenFOAM-Oracle.xml",
"OpenFOAM-Xyratex.xml"
]

output="Report.html"

for document in dataStore:
	print "Opening document "+document
	dom=parse(document)
	for test in dom.getElementsByTagName("test"):
		#print(test)
		storage=test.getElementsByTagName("storage")[0].childNodes[0].nodeValue
		cores=test.getElementsByTagName("cores")[0].childNodes[0].nodeValue
		software=test.getElementsByTagName("software")[0].childNodes[0].nodeValue
		testName=test.getElementsByTagName("testName")[0].childNodes[0].nodeValue
		metricName=test.getElementsByTagName("metricName")[0].childNodes[0].nodeValue
		metricValueNode=test.getElementsByTagName("metricValue")[0]
		metricValue=0
	
		if len(metricValueNode.childNodes)>=1:
			metricValue=metricValueNode.childNodes[0].nodeValue


