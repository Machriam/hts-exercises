#!/bin/bash

for file in ~/hts-exercises/4-1/scaffolds/**/Cru_1-scaffolds.fasta
do
	dir="$(dirname "$file" )"
	dest=$(basename "$dir")
	echo "$dir $dest"
	outfile="mapping/$dest"
	bwa mem ./crubellaData/ncbi_dataset/data/idx/ref "$dir/Cru_*-scaffolds.fasta"> "$outfile".sam
	samtools view -hSbo "$outfile".bam "$outfile".sam
	samtools sort "$outfile".bam -o "$outfile".sorted.bam
	samtools index "$outfile".sorted.bam
done