#!/bin/bash

#PBS -N bwa-2012-10-11.3-xaa
#PBS -o bwa-2012-10-11.3-xaa.stdout
#PBS -e bwa-2012-10-11.3-xaa.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l qos=DebugQ 
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=8
#PBS -l hostlist=r103-n56

cd $PBS_O_WORKDIR

source Load.sh

for group in $(cat Groups.xaa)
do
	./RunGroup.sh Reference.fasta $group &
done

wait

