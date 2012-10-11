#!/bin/bash

reference=$1
group=$2
jail=$3

if test ! -d $jail
then
	mkdir $jail
fi

indexer="bwa index"
aligner="bwa aln"
decompressor="bunzip2"

fifoFile=$jail/fifoFile-$group.fastq

reference=$jail/Reference-$group.fasta

ln -s ../Reference.fasta $reference

$indexer $reference

for file in $(cat $group)
do
	mkfifo $fifoFile

	$decompressor $file > $fifoFile &

	output=$fail/$(basename $file).sai

	$aligner $reference $fifoFile > $output

	rm fifoFile
done

rm -rf $reference
