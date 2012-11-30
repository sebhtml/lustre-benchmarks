#!/bin/bash

#PBS -N bwa+samtools-Oracle-2012-11-30-1-xac
#PBS -o bwa+samtools-Oracle-2012-11-30-1-xac.stdout
#PBS -e bwa+samtools-Oracle-2012-11-30-1-xac.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l hostlist=r110-n5
#PBS -l qos=DebugQ 
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=8

cd $PBS_O_WORKDIR

./Run-job.sh ../selected-lustre bwa+samtools-Oracle-2012-11-30-1 xac
