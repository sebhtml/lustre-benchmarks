#!/bin/bash

root=../selected-lustre/IOR-2012-11-08-Oracle.1/

ls $root > List

software="IOR-2.10.3"
storage="/scratch"

for testName in $(cat List)
do
	for cores in $(ls $root/$testName)
	do
		for iorTest in $(ls $root/$testName/$cores)
		do
			fullTestName=$testName/$(echo $iorTest|sed 's/000-//g'|sed 's/.txt//g')

			resultFile=$root/$testName/$cores/$iorTest

			#echo "--> $resultFile"

			readDataRate=$(tail -n6 $resultFile|head -n1|awk '{print $4}')
			iopsRead=$(tail -n6 $resultFile|head -n1|awk '{print $8}')
			writeDataRate=$(tail -n7 $resultFile|head -n1|awk '{print $4}')
			iopsWrite=$(tail -n7 $resultFile|head -n1|awk '{print $8}')

			echo "<test>"
			echo "<storage>$storage</storage>"
			echo "<cores>$cores</cores>"
			echo "<software>$software</software>"
			echo "<testName>$fullTestName</testName>"
			echo "<metricName>meanReadDataRate (MiB/s)</metricName>"
			echo "<metricValue>$readDataRate</metricValue>"
			echo "</test>"

			echo "<test>"
			echo "<storage>$storage</storage>"
			echo "<cores>$cores</cores>"
			echo "<software>$software</software>"
			echo "<testName>$fullTestName</testName>"
			echo "<metricName>meanReadInputOutputOperationsPerSecond (IOPS)</metricName>"
			echo "<metricValue>$iopsRead</metricValue>"
			echo "</test>"

			echo "<test>"
			echo "<storage>$storage</storage>"
			echo "<cores>$cores</cores>"
			echo "<software>$software</software>"
			echo "<testName>$fullTestName</testName>"
			echo "<metricName>meanWriteDataRate (MiB/s)</metricName>"
			echo "<metricValue>$writeDataRate</metricValue>"
			echo "</test>"

			echo "<test>"
			echo "<storage>$storage</storage>"
			echo "<cores>$cores</cores>"
			echo "<software>$software</software>"
			echo "<testName>$fullTestName</testName>"
			echo "<metricName>meanWriteInputOutputOperationsPerSecond (IOPS)</metricName>"
			echo "<metricValue>$iopsWrite</metricValue>"
			echo "</test>"

		done
	done
done
