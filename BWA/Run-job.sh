#!/bin/bash

function LogMessage(){

	message=$1

	echo "[$(date)] $message"
}

part=$1

. Load.sh

# we make only 1 reference index
indexer="bwa index"
jail=../selected-lustre/bwa+samtools-2012-11.22.4-$part
localReference=$jail/Reference.fasta

mkdir $jail

LogMessage "Creating reference link"
ln -s $(pwd)/Reference.fasta $localReference
LogMessage "Indexing reference"

(time $indexer $localReference ) &> bwa+samtools-2012-11.22.4-$part-index

# align the reads
for group in $(cat Groups.$part)
do
	(
	time ./RunGroup.sh Reference.fasta $group ../selected-lustre bwa+samtools-2012-11.22.4-$part
	) &> bwa+samtools-2012-11.22.4-$part-$group &

done


# wait for the stuff to complete
wait

