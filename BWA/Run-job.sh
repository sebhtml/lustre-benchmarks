#!/bin/bash

function LogMessage(){

	message=$1

	echo "[$(date)] $message"
}

part=$1

. Load.sh

# we make only 1 reference index
indexer="bwa index"
jail=../selected-lustre/bwa+samtools-2012-11-29-1-$part
localReference=$jail/Reference.fasta

mkdir $jail

LogMessage "Creating reference link"
ln -s $(pwd)/Reference.fasta $localReference
LogMessage "Indexing reference"

(time $indexer $localReference ) &> bwa+samtools-2012-11-29-1-$part-index

# align the reads
for line in $(seq 1 4)
do

	# simulate a pseudo larger file
	group=File-$part-$line
	last=$(($line*2))
	cat $(head -n $last Groups.$part | tail -n 2) > $group

	(
	time ./RunGroup.sh Reference.fasta $group ../selected-lustre bwa+samtools-2012-11-29-1-$part
	) &> bwa+samtools-2012-11-29-1-$part-$group &

done


# wait for the stuff to complete
wait

