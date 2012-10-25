

mpiexec \
-n 32 \
-k 21 \
-o SRA001125.ray-2012-10-25.1 \
-p \
    SRA001125/SRR001665_1.fastq.gz \
    SRA001125/SRR001665_2.fastq.gz \
-p \
    SRA001125/SRR001666_1.fastq.gz \
    SRA001125/SRR001666_2.fastq.gz \
&> SRA001125.ray-2012-10-25.1.txt \

