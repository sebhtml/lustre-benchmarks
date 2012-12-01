#!/bin/bash

function LogMessage(){

	message=$1

	echo "[$(date)] $message"
}

storage=$1
jobToken=$2
part=$3

. Load.sh

# we make only 1 reference index
indexer="bwa index"
jail=$storage/$jobToken-$part
localReference=$jail/Reference.fasta

mkdir $jail

LogMessage "Creating reference link"
ln -s $(pwd)/Reference.fasta $localReference
LogMessage "Indexing reference"

(time $indexer $localReference ) &> $jobToken-$part-index

# align the reads
for group in $(cat Groups.$part)
do
	(
	time ./RunGroup.sh Reference.fasta $group $storage $jobToken-$part
	) &> $jobToken-$part-$group &

done

# wait for the stuff to complete
wait

