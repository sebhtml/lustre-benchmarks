#!/bin/bash

wget http://downloads.sourceforge.net/project/samtools/samtools/0.1.18/samtools-0.1.18.tar.bz2

tar -xjf samtools-0.1.18.tar.bz2

cd samtools-0.1.18

source Load.sh

make
cd ..
