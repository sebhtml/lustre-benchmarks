#!/bin/bash
# provided by Maxime Boissonneault
# this chains the objects

lastjob=$(showq -w class=debug1 | grep Running | awk '{print $1}')

for job in $(showq -w class=debug1 | grep Idle | awk '{print $1}')
do 
	mjobctl -m depend=$lastjob $job
	lastjob=$job
done
