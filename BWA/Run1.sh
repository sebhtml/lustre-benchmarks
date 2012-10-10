#!/bin/bash

#PBS -N bwa-2012-10-10.1-xad
#PBS -o bwa-2012-10-10.1-xad.stdout
#PBS -e bwa-2012-10-10.1-xad.stderr
#PBS -A clumeq
#PBS -q debug1
#PBS -l qos=DebugQ 
#PBS -l walltime=1:00:00
#PBS -l nodes=1:ppn=8

cd $PBS_O_WORKDIR

source Load.sh

for group in $(cat Groups.xab)
do
	./RunGroup.sh Reference.fasta $group &
done

wait

