#!/usr/bin/env python

from xml.dom.minidom import parse, parseString

dataStore=[
"IOR-Oracle.xml",
"IOR-Xyratex.xml",
"OpenFOAM-Oracle.xml",
"OpenFOAM-Xyratex.xml"
]

storages=["/scratch","/lustre3"]

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

# this is likely a false positive
		if metricValue=="0.002":
			continue

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
stream.write("<caption>Summary</caption><tbody>")
stream.write("<tr><th>Software</th><th>Tests</th><th>Completed for "+storages[0]+"</th><th>Completed for "+storages[1]+"</th>")
stream.write("<th>Completed for both</th></tr>\n")

for entry in softwareList:
	software=entry
	localTests=softwareList[software]
	numberOfTests=len(localTests)
	done0=0
	done1=0
	doneBoth=0

	for testKey in localTests:
		has0=0
		has1=0
		if storages[0] in tests[testKey][OFFSET_STORAGE_RESULTS]:
			has0=1
			done0+=1
		if storages[1] in tests[testKey][OFFSET_STORAGE_RESULTS]:
			has1=1
			done1+=1
		if has0 and has1:
			doneBoth+=1
		

	stream.write("<tr><th>"+software+"</th><th>"+str(numberOfTests)+"</th>")
	stream.write("<th>"+str(done0)+"</th><th>"+str(done1)+"</th><th>"+str(doneBoth)+"</th></tr>\n")

stream.write("</tbody></table>")

stream.write("<br /><br />")

stream.write("<table border=\"1\" cellpadding=\"10\" cellspacing=\"10\">")
stream.write("<caption>Tests</caption><tbody>")
stream.write("<tr><th>Test</th><th>"+storages[0]+"</th><th>"+storages[1]+"</th></tr>\n")

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
			

stream.write("</tbody></table>")

stream.write("</body></html>")

stream.close()

