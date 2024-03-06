#!/bin/bash
outfolder="/mnt/silo/hts2024/alehmann/hts-exercises/5-2/mappingGem"
mkdir "$outfolder"
crubellaData="/mnt/silo/hts2024/alehmann/hts-exercises/5-1/crubellaData/ncbi_dataset/data"
gemFolder="/mnt/silo/hts2024/alehmann/libs/gem/gem3-mapper/bin/"

"$gemFolder/gem-indexer" -i "$crubellaData/idx/ref" -o "$crubellaData/idx/refGem"

dir="/mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/"
dest=$(basename "$dir")
outfile="$outfolder/$dest"
"$gemFolder/gem-mapper" -I "$crubellaData/idx/refGem.gem" -1 "$dir"/Cgr_1.fq.gz -2 "$dir"/Cgr_2.fq.gz -o "$outfile".sam
samtools view -hSbo "$outfile".bam "$outfile".sam
samtools sort "$outfile".bam -o "$outfile".sorted.bam
samtools index "$outfile".sorted.bam
bcftools2 mpileup -f "$outfile".sorted.bam | bcftools2 call -mv -Ob > "$outfile".bcf
bcftools2 view "$outfile".bcf > "$outfile".vcf