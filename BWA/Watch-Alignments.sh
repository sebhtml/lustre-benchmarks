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
			echo -n " COMPLETED"
		fi
		
		echo ""
	done

	echo ""

	echo "Alignment"
	echo ""

	echo "Task		LastModification		Progress"
	for i in $(ls|grep bwa+samtools|grep Bin_)
	do
		echo -n "$i  "

		printDate $i

		progress=$(grep "bwa aln" $i |grep CMD|wc -l)

# reconstruct the file name
# Entries.Bin_1.txt
		content=Entries$(echo $i|sed 's/Entries/ /g'|awk '{print $2}')

		total=$(cat $content|wc -l)

		printf "[%2s/%2s] " $progress $total

		printProgressBar $progress

		if test $progress -eq $total
		then
			echo -n " COMPLETED"
		fi

		echo ""
	done

	sleep 10

done
