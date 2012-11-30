#!/bin/bash

while true; do clear; for i in $(ls|grep bwa+samtools|grep File); do echo -n "$i "; grep "bwa aln" $i |wc -l; done; sleep 10; done
