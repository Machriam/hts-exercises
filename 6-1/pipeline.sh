#!/bin/bash
trimmomaticPath="/mnt/silo/hts2024/alehmann/libs/trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar"
adapterLookup="/mnt/silo/hts2024/alehmann/libs/trimmomatic/Trimmomatic-0.39/adapters/adapters.fa"
files="/mnt/silo/hts2024/data/Capsella-sequencing/RNA-seq/subsets-phred33/RNA*.fq.gz"
quast="/mnt/silo/hts2024/alehmann/libs/quast-5.2.0/quast.py"

fastQcOutput="/mnt/silo/hts2024/alehmann/hts-exercises/6-1/fastqcResult"
trimmomaticOutput="/mnt/silo/hts2024/alehmann/hts-exercises/6-1/trimmomaticOutput"
bfcOutput="/mnt/silo/hts2024/alehmann/hts-exercises/6-1/bfcOutput"

for folder in $fastQcOutput $trimmomaticOutput $bfcOutput
do
    mkdir "$folder"
done
mkdir $fastQcOutput/normal
mkdir $fastQcOutput/trimmomatic
mkdir $fastQcOutput/bfc


for file in $files
do
    filename="$(basename "$file")"
    java -jar "$trimmomaticPath" SE -phred33 -threads 8 "$file" "$trimmomaticOutput/$filename" LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 ILLUMINACLIP:$adapterLookup:2:30:10
    bfc -s 1g -t16 "$trimmomaticOutput/$filename" | gzip > "$bfcOutput/$filename"
    fastqc "$file" -o "$fastQcOutput/normal"
    fastqc "$trimmomaticOutput/$filename" -o "$fastQcOutput/trimmomatic"
    fastqc "$bfcOutput/$filename" -o "$fastQcOutput/bfc"
done
