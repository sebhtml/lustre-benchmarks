#!/bin/bash

reference=$1
group=$2

indexer="bwa index"
aligner="bwa aln"
decompressor="bunzip2"

fifoFile=Storage/fifoFile-$group.fastq

mkfifo $fifoFile

reference=Storage/Reference-$group.fasta

ln -s Reference.fasta $reference

$indexer $reference

for file in $(cat $group)
do
	$decompressor $file > $fifoFile &

	output=Storage/$(basename $file).sai

	$aligner $reference $fifoFile > $output
done

rm fifoFile

rm -rf $reference*
