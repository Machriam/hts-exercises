#!/bin/bash 

###  Link reference fasta and generate samtools index
mkdir -p variantCallingIndex
ln -s /mnt/silo/hts2024/data/genomes/Caprub1_0/GCF_000375325.1_Caprub1_0_genomic.fna variantCallingIndex/ref.fa
samtools faidx variantCallingIndex/ref.fa

### Variant calling using samtools
 ~/libs/bcftools/bcftools/bcftools  mpileup -Ou \
	 -f variantCallingIndex/ref.fa \
	 ./output/RNA5-s1M1M2_bfc.sorted.bam \
    |  ~/libs/bcftools/bcftools/bcftools  call -v -m -Ov -o ./output/subsets-raw.vcf
