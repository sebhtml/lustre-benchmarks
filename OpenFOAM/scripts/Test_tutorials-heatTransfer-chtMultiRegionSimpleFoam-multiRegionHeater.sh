#!/bin/bash

#PBS -N OpenFOAM-2012-11-08.1-Oracle-tutorials-heatTransfer-chtMultiRegionSimpleFoam-multiRegionHeater_
#PBS -o OpenFOAM-2012-11-08.1-Oracle-tutorials-heatTransfer-chtMultiRegionSimpleFoam-multiRegionHeater.stdout
#PBS -e OpenFOAM-2012-11-08.1-Oracle-tutorials-heatTransfer-chtMultiRegionSimpleFoam-multiRegionHeater.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l qos=DebugQ 
#PBS -l walltime=48:00:00
#PBS -l nodes=4:ppn=8
#PBS -l hostlist=r105-n57+r105-n58+r105-n67+r105-n68
################PBS -l hostlist=r103-n[49-52]

cd $PBS_O_WORKDIR

source Load.sh

NSLOTS=32

cd ../selected-lustre/OpenFOAM-2012-11-08.1-Oracle-all/

cd tutorials/heatTransfer/chtMultiRegionSimpleFoam/multiRegionHeater

time ./Allrun &> OpenFOAM-2012-11-08.1-Oracle-tutorials-heatTransfer-chtMultiRegionSimpleFoam-multiRegionHeater.txt
