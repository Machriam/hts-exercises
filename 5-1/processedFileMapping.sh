#!/bin/bash
outfolder="/mnt/silo/hts2024/alehmann/hts-exercises/5-1/mapping"
mkdir "$outfolder"
crubellaData="/mnt/silo/hts2024/alehmann/hts-exercises/5-1/crubellaData/ncbi_dataset/data"

for file in /mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/**/Cru_1.fq.gz
do
	dir="$(dirname "$file" )"
	dest=$(basename "$dir")
	outfile="$outfolder/$dest"
	bwa mem "$crubellaData/idx/ref" "$dir"/Cru_*.fq.gz> "$outfile".sam
	samtools view -hSbo "$outfile".bam "$outfile".sam
	samtools sort "$outfile".bam -o "$outfile".sorted.bam
	samtools index "$outfile".sorted.bam
done