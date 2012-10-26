#!/bin/bash

. Load.sh

git clone git://github.com/sebhtml/ray.git
git clone git://github.com/sebhtml/RayPlatform.git

cd ray
make clean
make HAVE_LIBZ=y HAVE_LIBBZ2=y EXTRA="-march=native"
strip Ray

echo "******************* Ray is ready !"

file Ray
ls -l Ray
readelf -a Ray|head
objdump -S Ray|head
ldd Ray
cd ..
