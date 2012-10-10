#!/bin/bash

#PBS -N IOR-2012-10-01
#PBS -o IOR-2012-10-01.stdout
#PBS -e IOR-2012-10-01.stderr
#PBS -A nne-790-aa
#PBS -q debug1
#PBS -l hostlist=r109-n[3-6]
#PBS -l qos=DebugQ 
#PBS -l walltime=1:00:00
#PBS -l nodes=4:ppn=8

cd $PBS_O_WORKDIR

NSLOTS=32

. /rap/clumeq/Seb-Boisvert/software/IOR-2.10.3/Load.sh

rm StorageAppliance

for storage in xyratex-lustre # default-lustre
do
	ln -s $storage StorageAppliance
	mpiexec -n $NSLOTS IOR -f tests.ior &> $storage.txt
	rm StorageAppliance
done

