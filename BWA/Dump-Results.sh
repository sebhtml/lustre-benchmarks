#!/bin/bash

name=$1
storage=$2

echo "<root>"

for i in $(seq 0 7)
do
	key=Job0$i
	indexJob=$key-index

	echo "<test>"
	echo "<storage>$storage</storage>"
	echo "<cores>1</cores>"
	echo "<software>bwa 0.6.2, samtools 0.1.18</software>"
	echo "<testName>$indexJob</testName>"
	echo "<metricName>runningTime (s)</metricName>"
	
	indexFile=$(ls|grep $indexJob)

	theTime=$(tail -n3 $indexFile|head -n1|awk '{print $2}')

	goodTime=$(./convert-to-seconds.py $theTime)

	echo "<metricValue>$goodTime</metricValue>"

	echo "</test>"

	for alignmentJob in $(ls|grep $key|grep Bin)
	do
		echo "<test>"
		echo "<storage>$storage</storage>"
		echo "<cores>2</cores>"
		echo "<software>bwa 0.6.2, samtools 0.1.18</software>"

		expression="s/$key/ /g"
		testName=$key-$(echo $alignmentJob|sed "$expression"|awk '{print $2}')
		echo "<testName>$testName</testName>"
		echo "<metricName>runningTime (s)</metricName>"
	
		theTime=$(tail -n3 $alignmentJob|head -n1|awk '{print $2}')

		goodTime=$(./convert-to-seconds.py $theTime)

		echo "<metricValue>$goodTime</metricValue>"

		echo "</test>"
	done
done


echo "</root>"
