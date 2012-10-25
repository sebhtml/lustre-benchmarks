#!/bin/bash

storage=../selected-lustre/sort-2012-10-25.1

mkdir $storage
cd $storage
mkdir workingDrive
export TMPDIR=workingDrive

echo "Creating data file."

time \
(
for i in $(seq 1 1000000000)
do
	echo $RANDOM 
done > Sink.txt
)

echo "Calling sort with something for TMPDIR"

time \
sort -n Sink.txt


