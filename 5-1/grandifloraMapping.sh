#!/bin/bash

dest="grandiflora"
outfile="$dest/readmappingGrandiflora"

mkdir "$dest"
bwa mem ./crubellaData/ncbi_dataset/data/idx/ref ~/../data/Capsella-sequencing/DNA-seq/subsets-phred33/Cgr_*.fq.gz > "$outfile".sam
samtools view -hSbo "$outfile".bam "$outfile".sam
samtools sort "$outfile".bam -o "$outfile".sorted.bam
samtools index "$outfile".sorted.bam