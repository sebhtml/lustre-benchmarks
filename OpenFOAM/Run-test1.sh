#!/bin/bash

#PBS -N OpenFOAM-2012-10-10-flange
#PBS -o OpenFOAM-2012-10-10-flange.stdout
#PBS -e OpenFOAM-2012-10-10-flange.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l qos=DebugQ 
#PBS -l walltime=10:00:00
#PBS -l nodes=4:ppn=8
#PBS -l hostlist=r103-n[49-52]

cd $PBS_O_WORKDIR

source Load.sh

NSLOTS=32

echo "r103-n[49-56]" > OpenFOAM-2012-10-10-flange.hosts

cd run/tutorials/basic/laplacianFoam/flange/


./Allrun


