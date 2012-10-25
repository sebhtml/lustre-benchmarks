#!/bin/bash

#PBS -N OpenFOAM-2012-10-25-all
#PBS -o OpenFOAM-2012-10-25-all.stdout
#PBS -e OpenFOAM-2012-10-25-all.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l qos=DebugQ 
#PBS -l walltime=48:00:00
#PBS -l nodes=4:ppn=8
#PBS -l hostlist=r103-n[49-52]

cd $PBS_O_WORKDIR

source Load.sh

NSLOTS=32

echo "r103-n[49-52]" > OpenFOAM-2012-10-25-all.hosts

mkdir Storage/OpenFOAM-2012-10-25-all

cp -r $FOAM_TUTORIALS Storage/OpenFOAM-2012-10-25-all

cd Storage/OpenFOAM-2012-10-25-all/tutorials/

./Allrun
