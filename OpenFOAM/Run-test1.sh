#!/bin/bash

#PBS -N OpenFOAM-2012-10-10-flange
#PBS -o OpenFOAM-2012-10-10-flange.stdout
#PBS -e OpenFOAM-2012-10-10-flange.stderr
#PBS -A clumeq
#PBS -q debug1
#PBS -l hostlist=r109-n[3-6]
#PBS -l qos=DebugQ 
#PBS -l walltime=10:00:00
#PBS -l nodes=4:ppn=8

cd $PBS_O_WORKDIR

source Load.sh

NSLOTS=32

cd run/tutorials/basic/laplacianFoam/flange/

./Allrun


