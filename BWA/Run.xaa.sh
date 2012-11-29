#!/bin/bash

#PBS -N bwa+samtools-2012-11-28.1-xaa
#PBS -o bwa+samtools-2012-11-28.1-xaa.stdout
#PBS -e bwa+samtools-2012-11-28.1-xaa.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l hostlist=r105-n57
##########PBS -l hostlist=r105-n57+r105-n58+r105-n67+r105-n68
#####r105-n[57,58,67,68]
#PBS -l qos=DebugQ 
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=8

cd $PBS_O_WORKDIR

./Run-job.sh xaa
