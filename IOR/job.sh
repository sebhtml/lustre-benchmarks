#!/bin/bash

#PBS -N IOR-2012-12-19-Oracle-4
#PBS -o IOR-2012-12-19-Oracle-4.stdout
#PBS -e IOR-2012-12-19-Oracle-4.stderr
#PBS -A six-213-ad
#PBS -q debug1
#PBS -l qos=DebugQ 
#PBS -l walltime=48:00:00
#PBS -l nodes=4:ppn=8

cd $PBS_O_WORKDIR

coresPerNode=8
nodes=4


NSLOTS=$(($nodes * $coresPerNode))
maximumCores=$NSLOTS

. /rap/clumeq/Seb-Boisvert/software/IOR-2.10.3/Load.sh

jobDirectory=../selected-lustre/IOR-2012-12-19-Oracle-4

mkdir $jobDirectory

# -1 means all OSTs
for stripeCount in $(cat stripeCountValues.txt)
do
	# Jean-François only wants 1M for stripeSize
	for stripeSize in $(cat stripeSizeValues.txt)
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
				echo "[$(date)] Starting test"
				echo "stripeCount= $stripeCount"
				echo "stripeSize= $stripeSize"
				echo "NSLOTS= $NSLOTS"
				echo "testCase= $testCase"

				mpiexec -n $NSLOTS IOR -f $testCase &> storage/000-$(basename $testCase).txt
			done

			rm storage
		done
	done
done


