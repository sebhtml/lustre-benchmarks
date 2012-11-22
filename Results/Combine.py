#!/usr/bin/env python

from xml.dom.minidom import parse, parseString

dataStore=[
"IOR-Oracle.xml",
"IOR-Xyratex.xml",
"OpenFOAM-Oracle.xml",
"OpenFOAM-Xyratex.xml"
]

output="Report.html"

storageData={}

softwareList={}

tests={}

OFFSET_NAME=0
OFFSET_SOFTWARE=1
OFFSET_CORES=2
OFFSET_STORAGE_RESULTS=3

# create a data store
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

		testKey=software+"-"+cores+"-"+testName

		if testKey not in tests:
			tests[testKey]=[testName,software,cores,{}]

		if storage not in tests[testKey][OFFSET_STORAGE_RESULTS]:
			#print("Adding "+storage)
			storageData[storage]=True
			tests[testKey][OFFSET_STORAGE_RESULTS][storage]={}

		tests[testKey][OFFSET_STORAGE_RESULTS][storage][metricName]=metricValue

		if software not in softwareList:
			softwareList[software]={}

		softwareList[software][testKey]=True

storages=["/scratch","/lustre3"]

# dump HTML

stream=open(output,"w")

stream.write("<html><head><title>File system tests</title>")
stream.write("<style>")
stream.write(".software{font-weight: bold; background-color: #CC0000; color: #ffffff; }")
stream.write(".test{font-style: italic; background-color: #FFFF66; color: #000000; }")
stream.write(".metric{ background-color: #CCFF66; color: #000000; }")
stream.write("</style>")
stream.write("</head><body>")

stream.write("<table border=\"1\" cellpadding=\"10\" cellspacing=\"10\">")
stream.write("<caption>Tests</caption><tbody>")
stream.write("<tr><th>Test</th><th>/scratch (Oracle)</th><th>/lustre3 (Xyratex)</th></tr>")

for entry in softwareList:
	software=entry
	localTests=softwareList[software]

	stream.write("<tr><td class=\"software\">"+software+"</td><td></td><td></td></tr>\n")

	for testKey in localTests:
		testName=tests[testKey][OFFSET_NAME]
		cores=tests[testKey][OFFSET_CORES]
		stream.write("<tr><td class=\"test\">&nbsp;&nbsp;&nbsp;&nbsp;"+testName+" ("+str(cores)+")</td><td></td><td></td></tr>\n")

		theMainKey=storages[0]

		if theMainKey not in tests[testKey][OFFSET_STORAGE_RESULTS]:
			theMainKey=storages[1]

		for metric in tests[testKey][OFFSET_STORAGE_RESULTS][theMainKey]:
			stream.write("<tr><td class=\"metric\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+metric+"</td>")

			dataObject=tests[testKey][OFFSET_STORAGE_RESULTS]

			index=0

			while index<len(storages):
				metricValue="Not available"

				if storages[index] in dataObject and metric in dataObject[storages[index]]:
					metricValue=dataObject[storages[index]][metric]

				stream.write("<td>"+str(metricValue)+"</td>")

				index+=1

			stream.write("</tr>\n")
			

stream.write("</table>")

stream.write("</body></html>")

stream.close()

