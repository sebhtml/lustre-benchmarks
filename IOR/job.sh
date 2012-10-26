#!/bin/bash

#PBS -N IOR-2012-10-27.2
#PBS -o IOR-2012-10-27.2.stdout
#PBS -e IOR-2012-10-27.2.stderr
#PBS -A nne-790-aa
#PBS -q debug1
#PBS -l hostlist=r105-n57+r105-n58+r105-n67+r105-n68
#####r105-n[57,58,67,68]
#PBS -l qos=DebugQ 
#PBS -l walltime=8:00:00
#PBS -l nodes=4:ppn=8

cd $PBS_O_WORKDIR

coresPerNode=8
nodes=4


NSLOTS=$(($nodes * $coresPerNode))
maximumCores=$NSLOTS

. /rap/clumeq/Seb-Boisvert/software/IOR-2.10.3/Load.sh

jobDirectory=../selected-lustre/IOR-2012-10-27.2

mkdir $jobDirectory

# -1 means all OSTs
for stripeCount in 1 2 3 4 5 6 7 8 -1
do
	# Jean-François only wants 1M for stripeSize
	for stripeSize in 1M 2M 4M
	do
		directory=$jobDirectory/stripeSize=$stripeSize,stripeCount=$stripeCount
		mkdir $directory
		lfs setstripe -s $stripeSize -i 0 -c $stripeCount $directory

		for NSLOTS in 1 $(seq $coresPerNode $coresPerNode $maximumCores)
		do
			jobWithNodes=$directory/$NSLOTS
			mkdir $jobWithNodes

			ln -s $jobWithNodes storage

			for testCase in $(ls ior-tests/*.ior)
			do
				mpiexec -n $NSLOTS IOR -f $testCase &> storage/000-$(basename $testCase).txt
			done

			rm storage
		done
	done
done


