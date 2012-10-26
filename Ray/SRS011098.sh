#!/bin/bash

#PBS -N SRS011098.ray-2012-10-27.1
#PBS -o SRS011098.ray-2012-10-27.1.stdout
#PBS -e SRS011098.ray-2012-10-27.1.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l hostlist=r105-n57+r105-n58+r105-n67+r105-n68
#####r105-n[57,58,67,68]
#PBS -l qos=DebugQ 
#PBS -l walltime=8:00:00
#PBS -l nodes=4:ppn=8

cd $PBS_O_WORKDIR

. Load.sh

#root=/mnt/scratch_mp2/corbeil/corbeil_group/genomes/
root=../selected-lustre/genomes

mpiexec \
-n 32 \
Ray \
-k 21 \
-o ../selected-lustre/SRS011098.ray-2012-10-27.1 \
-s SRS011098/SRR055676.fastq.gz \
-s SRS011098/SRR055756.fastq.gz \
-s SRS011098/SRR056894.fastq.gz \
-s SRS011098/SRR056977.fastq.gz \
-s SRS011098/SRR059326.fastq.gz \
-s SRS011098/SRR059327.fastq.gz \
-p SRS011098/SRR062051_1.fastq.gz \
SRS011098/SRR062051_2.fastq.gz \
-p SRS011098/SRR062052_1.fastq.gz \
SRS011098/SRR062052_2.fastq.gz \
  -search \
 $root/EMBL_CDS+GO/EMBL_CDS_Sequences \
 -gene-ontology \
 $root/EMBL_CDS+GO/000-Ontologies.txt \
 $root/EMBL_CDS+GO/000-Annotations.txt \
 -search \
 $root/RayKmerSearchStuff/last-build/ARDB \
 -search \
 $root/RayKmerSearchStuff/last-build/Bacteria-Genomes \
 -search \
 $root/RayKmerSearchStuff/last-build/HumanChromosomes \
 -search \
 $root/RayKmerSearchStuff/last-build/NCBI-Bacteria_DRAFT \
 -search \
 $root/RayKmerSearchStuff/last-build/Viruses-Genomes \
 -with-taxonomy \
 $root/taxonomy/last-build/Genome-to-Taxon.tsv \
 $root/taxonomy/last-build/TreeOfLife-Edges.tsv \
 $root/taxonomy/last-build/Taxon-Names.tsv \



