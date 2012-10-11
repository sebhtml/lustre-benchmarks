#!/bin/bash

#PBS -N bwa-2012-10-10.1-xab
#PBS -o bwa-2012-10-10.1-xab.stdout
#PBS -e bwa-2012-10-10.1-xab.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l qos=DebugQ 
#PBS -l walltime=1:00:00
#PBS -l nodes=1:ppn=8
#PBS -l hostlist=r103-n53

cd $PBS_O_WORKDIR

source Load.sh

for group in $(cat Groups.xad)
do
	./RunGroup.sh Reference.fasta $group &
done

wait

