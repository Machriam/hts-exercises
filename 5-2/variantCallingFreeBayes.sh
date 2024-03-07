#!/bin/bash
outfolder="/mnt/silo/hts2024/alehmann/hts-exercises/5-2/variantCallingFreebayes"
mkdir "$outfolder"
crubellaData="/mnt/silo/hts2024/alehmann/hts-exercises/5-1/crubellaData/ncbi_dataset/data"
gemFolder="/mnt/silo/hts2024/alehmann/libs/gem/gem3-mapper/bin/"

"$gemFolder/gem-indexer" -i "$crubellaData/idx/ref" -o "$crubellaData/idx/refGem"

dir="/mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-bfc"
dest=$(basename "$dir")
outfile="$outfolder/$dest"
"$gemFolder/gem-mapper" -I "$crubellaData/idx/refGem.gem" -1 "$dir"/Cru_1.fq.gz -2 "$dir"/Cru_2.fq.gz -o "$outfile".sam
samtools view -hSbo "$outfile".bam "$outfile".sam
samtools sort "$outfile".bam -o "$outfile".sorted.bam
samtools index "$outfile".sorted.bam
freebayes -f "$crubellaData/idx/ref" "$outfile".sorted.bam > "$outfile.vcf"