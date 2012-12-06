#!/bin/bash

list=$1

for i in $(cat $list ); do echo "$i -> $(grep $(echo $i|sed 's/\.bz2//g'|sed 's=SRA000271-AfricanGenome/==g') Lines )"; done
