#!/bin/bash
# author: Sébastien Boisvert

#---------------------------------------------------

# => the reference is the fasta file on which reads will
# be aligned
# => the group is a file containing a list of fastq files
# => storage is where every event will occur
# => jobName is the name of the directory

#---------------------------------------------------

# the fasta reference sequence
reference=$1

# a file with a list of fastq files
group=$2

# the root directory where to begin operations
storage=$3

jobName=$4

function LogMessage(){

	message=$1

	echo "[$(date)] $message"
}

function RunCommand(){
	command=$1

	echo "Command: $command"

	eval $command
}

jail=$storage/$jobName

aligner="bwa aln -t 2 "
decompressor="bzcat"

localReference=$jail/Reference.fasta


for file in $(cat $group)
do
	target=$jail/$(basename $file).fastq

	RunCommand "$decompressor $file > $target"

	output=$jail/$(basename $file).sai

	RunCommand "LogMessage "Aligning $target""

	$aligner $localReference $target > $output

	# create the sorted sam file if this is the _2 and not the _1

	if test $(echo $file|grep _2|wc -l) = 1
	then
		LogMessage "Creating sorted bam from 2 sai files"

		output1=$(echo $output|sed 's/_2/_1/g')
		output2=$output

		target1=$(echo $target|sed 's/_2/_1/g')
		target2=$target

		combinedTarget=$(echo $target|sed 's/_2//g')

		# join the 2 sai files into 1 sorted bam
		RunCommand "bwa sampe $localReference $output1 $output2 $target1 $target2 | samtools view -bS - > $combinedTarget.bam"

		samtools sort $combinedTarget.bam $combinedTarget.sorted

		# remove fastq files
		rm $target $(echo $target|sed 's/_2/_1/g')

		# remove sai files
		rm $output $(echo $output|sed 's/_2/_1/g')

		# remove unsorted bam
		rm $combinedTarget.bam
	fi
done

LogMessage "Removing reference"
#rm -rf $reference
