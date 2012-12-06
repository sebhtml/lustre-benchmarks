#!/bin/bash

#PBS -N bwa+samtools-Xyratex-2012-12-06-2-Job05
#PBS -o bwa+samtools-Xyratex-2012-12-06-2-Job05.stdout
#PBS -e bwa+samtools-Xyratex-2012-12-06-2-Job05.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l hostlist=r105-n87
#PBS -l qos=DebugQ 
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=8

cd $PBS_O_WORKDIR

./Run-job.sh ../selected-lustre bwa+samtools-Xyratex-2012-12-06-2 Job05
