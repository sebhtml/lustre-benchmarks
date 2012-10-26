#!/bin/bash

#PBS -N SRA001125.ray-2012-10-27.1
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l hostlist=r105-n57+r105-n58+r105-n67+r105-n68
#####r105-n[57,58,67,68]
#PBS -l qos=DebugQ 
#PBS -l walltime=8:00:00
#PBS -l nodes=4:ppn=8

cd $PBS_O_WORKDIR

. Load.sh

mpiexec \
-n 32 \
Ray \
-k 21 \
-o ../selected-lustre/SRA001125.ray-2012-10-27.1 \
-p \
    SRA001125/SRR001665_1.fastq.gz \
    SRA001125/SRR001665_2.fastq.gz \
-p \
    SRA001125/SRR001666_1.fastq.gz \
    SRA001125/SRR001666_2.fastq.gz \


