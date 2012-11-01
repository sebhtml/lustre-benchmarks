#!/bin/bash

. Load.sh

wget http://www.bcgsc.ca/downloads/abyss/abyss-1.3.4.tar.gz

cat abyss-1.3.4.tar.gz|gunzip|tar -x

ln -s abyss-1.3.4 abyss

cd abyss-1.3.4

wget http://downloads.sourceforge.net/project/boost/boost/1.49.0/boost_1_49_0.tar.bz2
tar jxf boost_1_49_0.tar.bz2
ln -s boost_1_49_0/boost boost

wget http://sparsehash.googlecode.com/files/sparsehash-2.0.2.tar.gz

cat sparsehash-2.0.2.tar.gz|gunzip|tar -x

ln -s sparsehash-2.0.2 sparsehash

./configure
