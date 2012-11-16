#!/bin/bash

ls *.stderr|grep OpenFOAM-2012-11-08.1 > List

# OpenFOAM-2012-11-08.1-Oracle-tutorials-multiphase-multiphaseEulerFoam-damBreak4phase.stderr

software="apps/openfoam/2.1.0"
storage="/scratch"

function printNode(){
	local name=$1
	local value=$2
	echo "<$name>$value</$name>"
}

for i in $(cat List)
do
	name=$(echo $i|sed 's/OpenFOAM-2012-11-08.1-Oracle-//g'|sed 's/.stderr//g')
	metric="runningTime"
	value=$(grep real $i|awk '{print $2}')

	echo "<test>"
	printNode "storage" $storage
	printNode "cores" 32
	printNode "software" $software
	printNode "testName" $name
	printNode "metricName" $metric
	printNode "metricValue" $value
	echo "</test>"
done

