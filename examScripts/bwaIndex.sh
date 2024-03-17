#!/bin/bash

#Example: ./bwaIndex.sh ~/hts-exercises/5-1/crubellaData/ncbi_dataset/data/GCF_000375325.1/GCF_000375325.1_Caprub1_0_genomic.fna

indexFolder="$HOME/hts-exercises/examScripts/bwaIndex"

mkdir "$indexFolder"
ln -s "$1" "$indexFolder/ref"
bwa index "$indexFolder/ref"