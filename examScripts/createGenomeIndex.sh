#!/bin/bash

# Example: ./createGenomeIndex.sh ~/hts-exercises/5-1/crubellaData/ncbi_dataset/data/GCF_000375325.1/genomic.gff  

indexFolder="$HOME/hts-exercises/examScripts/genomeIndex"

mkdir "$indexFolder"
ln -sf "$1" "$indexFolder/genome"

tophat -G "$indexFolder/genome" \
    --transcriptome-index "$indexFolder"/transcriptome \
    bowtieIndex/ref_bowtie.bt2