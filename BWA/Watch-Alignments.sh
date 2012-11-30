#!/bin/bash


while true
do
	clear

	echo "Process                                     Modification                           Completed"
	for i in $(ls|grep bwa+samtools|grep File)
	do
		echo -n "$i    "
		theTime=$(stat $i|grep Modify|awk '{print $2" "$3" "$4}')
		echo -n "$theTime    "
		grep "bwa aln" $i |wc -l
	done

	sleep 10

done
