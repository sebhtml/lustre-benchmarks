#!/bin/bash

#PBS -N Bcereus.Illumina.ray-2012-11-08-Oracle.1
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l hostlist=r105-n57+r105-n58+r105-n67+r105-n68
#####r105-n[57,58,67,68]
#PBS -l qos=DebugQ 
#PBS -l walltime=8:00:00
#PBS -l nodes=4:ppn=8

cd $PBS_O_WORKDIR

. Load.sh

time \
mpiexec \
-n 32 \
Ray
-k 21 \
-o ../selected-lustre/Bcereus.Illumina.ray-2012-11-08-Oracle.1 \
-p \
    Bcereus.Illumina/Bcereus-10_S10_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-10_S10_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-11_S11_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-11_S11_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-12_S12_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-12_S12_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-13_S13_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-13_S13_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-14_S14_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-14_S14_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-15_S15_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-15_S15_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-16_S16_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-16_S16_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-17_S17_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-17_S17_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-18_S18_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-18_S18_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-19_S19_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-19_S19_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-1_S1_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-1_S1_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-20_S20_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-20_S20_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-21_S21_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-21_S21_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-22_S22_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-22_S22_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-23_S23_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-23_S23_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-24_S24_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-24_S24_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-2_S2_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-2_S2_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-3_S3_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-3_S3_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-4_S4_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-4_S4_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-5_S5_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-5_S5_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-6_S6_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-6_S6_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-7_S7_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-7_S7_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-8_S8_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-8_S8_L001_R2_001.fastq.gz \
-p \
    Bcereus.Illumina/Bcereus-9_S9_L001_R1_001.fastq.gz \
    Bcereus.Illumina/Bcereus-9_S9_L001_R2_001.fastq.gz \


