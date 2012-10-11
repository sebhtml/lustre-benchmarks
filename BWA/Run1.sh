#!/bin/bash

#PBS -N bwa-2012-10-11.5-xab
#PBS -o bwa-2012-10-11.5-xab.stdout
#PBS -e bwa-2012-10-11.5-xab.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l qos=DebugQ 
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=8
#PBS -l hostlist=r103-n54

cd $PBS_O_WORKDIR

source Load.sh

for group in $(cat Groups.xab)
do
	./RunGroup.sh Reference.fasta $group Storage/bwa-2012-10-11.5-xab &
done

wait

