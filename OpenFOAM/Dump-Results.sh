#!/bin/bash

key=$1

ls *.stderr|grep $key |grep tutorials > List

# OpenFOAM-2012-11-08.1-Oracle-tutorials-multiphase-multiphaseEulerFoam-damBreak4phase.stderr

software="apps/openfoam/2.1.0"
storage=$2

function printNode(){
	local name=$1
	local value=$2
	echo "<$name>$value</$name>"
}

echo "<root>"

for i in $(cat List)
do
	name=$(echo $i|sed "s/$key//g"|sed 's/.stderr//g')
	metric="runningTime (s)"
	value=$(grep real $i|awk '{print $2}')

	#echo "INPUT $value"

	seconds=$(./convert-to-seconds.py $value)
	echo "<test>"
	printNode "storage" $storage
	printNode "cores" 32
	printNode "software" $software
	printNode "testName" $name
	printNode "metricName" "$metric"
	printNode "metricValue" $seconds
	echo "</test>"
done


echo "</root>"

