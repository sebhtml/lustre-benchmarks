#!/bin/bash

for i in $(seq 0 3)
do
	msub Run$i.sh
done
