#!/bin/bash


wget http://downloads.sourceforge.net/project/bio-bwa/bwa-0.6.2.tar.bz2

tar -xjf bwa-0.6.2.tar.bz2

cd bwa-0.6.2

source Load.sh

make
cd ..
