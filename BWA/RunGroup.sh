#!/bin/bash

reference=$1
group=$2
jail=$3

function LogMessage{

	echo "[$(date)] $i"
}

if test ! -d $jail
then
	LogMessage "Creating directory."
	mkdir $jail
fi

indexer="bwa index"
aligner="bwa aln"
decompressor="bunzip2"

fifoFile=$jail/fifoFile-$group.fastq

reference=$jail/Reference-$group.fasta

LogMessage "Creating reference link"
ln -s ../Reference.fasta $reference

LogMessage "Indexing reference"

$indexer $reference

for file in $(cat $group)
do
	mkfifo $fifoFile

	$decompressor $file > $fifoFile &

	output=$jail/$(basename $file).sai

	LogMessage "Aligning "
	$aligner $reference $fifoFile > $output

	rm $fifoFile
done

LogMessage "Removing reference"
rm -rf $reference
