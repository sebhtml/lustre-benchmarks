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
for line in $(seq 1 4)
do

	# simulate a pseudo larger file
	group=File-$part-$line
	last=$(($line*2))
	cat $(head -n $last Groups.$part | tail -n 2) > $group

	(
	time ./RunGroup.sh Reference.fasta $group $storage $jobToken-$part
	) &> $jobToken-$part-$group &

done

# wait for the stuff to complete
wait

