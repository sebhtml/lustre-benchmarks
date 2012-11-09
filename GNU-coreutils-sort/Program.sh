#!/bin/bash

#PBS -N sort-2012-11-08.1
#PBS -o sort-2012-11-08.1.stdout
#PBS -e sort-2012-11-08.1.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l hostlist=r105-n57+r105-n58+r105-n67+r105-n68
#####r105-n[57,58,67,68]
#PBS -l qos=DebugQ 
#PBS -l walltime=48:00:00
#PBS -l nodes=4:ppn=8


storage=../selected-lustre/sort-2012-11-08.1

mkdir $storage -p
cd $storage
mkdir workingDrive -p
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


