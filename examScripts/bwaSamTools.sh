#!/bin/bash

# BWA is a short read aligner to a reference genome
#~/../data/Capsella-sequencing/DNA-seq/subsets-phred33/Cgr_*.fq.gz
filename="$(basename "$1" ".fq.gz")"
outfile="./output/$filename"

bwa mem ./bwaIndex/ref "$1" > "$outfile".sam
samtools view -hSbo "$outfile".bam "$outfile".sam
samtools sort "$outfile".bam -o "$outfile".sorted.bam
samtools index "$outfile".sorted.bam
samtools flagstat "$outfile".sorted.bam > "$outfile".flagstat.txt
samtools idxstats "$outfile".sorted.bam > "$outfile".idxstats.txt