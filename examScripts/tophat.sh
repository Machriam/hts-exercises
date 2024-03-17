#!/bin/bash

crubellaData="/mnt/silo/hts2024/alehmann/hts-exercises/5-1/crubellaData/ncbi_dataset/data"
genomeFile=$crubellaData/GCF_000375325.1/genomic.gff

# Only one, else it considers it as paired reads --> no wildcards for RNA
tophat -G "$genomeFile" ./bowtieIndex/ref_bowtie.bt2 "$1"  
samtools view ./tophat_out/accepted_hits.bam > tophat_out/accepted_hits.sam
samtools sort ./tophat_out/accepted_hits.bam -o tophat_out/accepted_hits.sorted.bam
samtools index ./tophat_out/accepted_hits.sorted.bam
samtools flagstat ./tophat_out/accepted_hits.sorted.bam > tophat_out/flagstats
samtools idxstats ./tophat_out/accepted_hits.sorted.bam > tophat_out/idxstats
bedtools multicov -bams ./tophat_out/accepted_hits.sorted.bam -bed "$genomeFile" > tophat_out/multicov