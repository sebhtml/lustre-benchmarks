#!/bin/bash

# the fasta reference sequence
reference=$1

# a file with a list of fastq files
group=$2

# the root directory where to begin operations
jail=$3

function LogMessage(){

	message=$1

	echo "[$(date)] $message"
}

if test ! -d $jail
then
	LogMessage "Creating directory."
	mkdir $jail
fi

indexer="bwa index"
aligner="bwa aln"
decompressor="bzcat"

localReference=$jail/Reference-$group.fasta

LogMessage "Creating reference link"
ln -s $(pwd)/Reference.fasta $localReference

LogMessage "Indexing reference"

# We will include this only when the whole thing works
#$indexer $localReference

for file in $(cat $group)
do
	target=$jail/$(basename $file).fastq

	$decompressor $file > $target

	output=$jail/$(basename $file).sai

	LogMessage "Aligning "

	$aligner $localReference $target > $output

	# create the sorted sam file if this is the _2 and not the _1

	if test $(echo $file|grep _2|wc -l) = 1
	then
		LogMessage "Creating sorted bam from 2 sai files"

		# join the 2 sai files into 1 sorted bam
		bwa sampe $localReference $(echo $output|sed 's/_2/_1/g') $output $(echo $file|sed 's/_2/_1/g') $file \
		|samtools view -bS - > $target.bam

		samtools sort $target.bam $target.sorted

		# remove fastq files
		rm $target $(echo $target|sed 's/_2/_1/g')

		# remove sai files
		rm $output $(echo $output|sed 's/_2/_1/g')

		# remove unsorted bam
		rm $target.bam
	fi
done

LogMessage "Removing reference"
#rm -rf $reference
