#!/bin/bash

crubellaData="/mnt/silo/hts2024/alehmann/hts-exercises/5-1/crubellaData/ncbi_dataset/data"
bfcOutput="/mnt/silo/hts2024/alehmann/hts-exercises/6-1/bfcOutput"

# ~/libs/bowtie2-2.5.3-linux-x86_64/bowtie2-build "$crubellaData"/idx/ref "$crubellaData"/idx/ref_bowtie.bt2
# ln -sf "$crubellaData"/idx/ref "$crubellaData"/idx/ref_bowtie.bt2.fa
tophat -G $crubellaData/GCF_000375325.1/genomic.gff "$crubellaData"/idx/ref_bowtie.bt2 "$bfcOutput/RNA7-s1M1M2.fq"  # Only one, else it considers it as paired reads
samtools view tophat_out/accepted_hits.bam > tophat_out/accepted_hits.sam
samtools sort tophat_out/accepted_hits.bam -o tophat_out/accepted_hits.sorted.bam
samtools index tophat_out/accepted_hits.sorted.bam
samtools flagstat tophat_out/accepted_hits.sorted.bam > tophat_out/flagstats
samtools idxstats tophat_out/accepted_hits.sorted.bam > tophat_out/idxstats
bedtools multicov -bams tophat_out/accepted_hits.sorted.bam -bed $crubellaData/GCF_000375325.1/genomic.gff > tophat_out/multicov