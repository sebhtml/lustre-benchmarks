#!/bin/bash

function printProgressBar(){
	progress=$1
	for j in $(seq 1 $progress)
	do
		echo -n "*"
	done
}

function printDate(){

	theFile=$1

	theTime=$(stat $theFile|grep Modify|awk '{print $3}'|sed 's/\./ /g'|awk '{print $1}')
	echo -n "$theTime  "

}

while true
do
	clear

	echo "Indexing"
	echo ""

	echo "Task		LastModification		Progress"
	for i in $(ls|grep bwa+samtools|grep index)
	do
		progress=$(cat $i|grep iterations|wc -l)
		total="?"
		echo -n "$i "

		printDate $i

		printf "[%2s/%2s] " $progress $total
		printProgressBar $progress

		if test $(grep Finished $i|wc -l) -eq 1
		then
			echo -n " [X]" &> /dev/null
		else
			echo -n " [ ]" &> /dev/null
		fi
		
		echo ""
	done

	echo ""

	echo "Alignment"
	echo ""

	echo "Task		LastModification		Progress"
	for i in $(ls|grep bwa+samtools|grep File)
	do
		echo -n "$i  "

		printDate $i

		progress=$(grep "bwa aln" $i |wc -l)

		content=File$(echo $i|sed 's/File/ /g'|awk '{print $2}')

		total=$(cat $content|wc -l)

		printf "[%2s/%2s] " $progress $total

		printProgressBar $progress

		echo ""
	done

	sleep 10

done
