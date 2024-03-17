#!/bin/bash

# Example: ./bowtieIndex.sh ~/hts-exercises/5-1/crubellaData/ncbi_dataset/data/GCF_000375325.1/GCF_000375325.1_Caprub1_0_genomic.fna

indexFolder="$HOME/hts-exercises/examScripts/bowtieIndex"

mkdir "$indexFolder"
ln -s "$1" "$indexFolder/ref"

~/libs/bowtie2-2.5.3-linux-x86_64/bowtie2-build "$indexFolder"/ref "$indexFolder"/ref_bowtie.bt2