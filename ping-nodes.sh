#!/bin/bash

#PBS -N ping-hosts
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l hostlist=r105-n57+r105-n58+r105-n67+r105-n68
#####r105-n[57,58,67,68]
#PBS -l qos=DebugQ 
#PBS -l walltime=0:01:00
#PBS -l nodes=4:ppn=8

cd $PBS_O_WORKDIR

module load compilers/gcc/4.4.2
module load mpi/openmpi/1.4.5_gcc

mpiexec -n 4 -bynode hostname
