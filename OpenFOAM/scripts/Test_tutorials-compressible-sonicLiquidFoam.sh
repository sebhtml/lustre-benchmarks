#!/bin/bash

#PBS -N OpenFOAM-2012-12-13.1-Xyratex-tutorials-compressible-sonicLiquidFoam_
#PBS -o OpenFOAM-2012-12-13.1-Xyratex-tutorials-compressible-sonicLiquidFoam.stdout
#PBS -e OpenFOAM-2012-12-13.1-Xyratex-tutorials-compressible-sonicLiquidFoam.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l qos=DebugQ 
#PBS -l walltime=48:00:00
#PBS -l nodes=4:ppn=8
#PBS -l hostlist=r102-n30+r105-n58+r110-n5+r105-n67

cd $PBS_O_WORKDIR

source Load.sh

NSLOTS=32

cd ../selected-lustre/OpenFOAM-2012-12-13.1-Xyratex-all/

cd tutorials/compressible/sonicLiquidFoam

time ./Allrun &> OpenFOAM-2012-12-13.1-Xyratex-tutorials-compressible-sonicLiquidFoam.txt
