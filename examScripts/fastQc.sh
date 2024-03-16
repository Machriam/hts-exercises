#!/bin/bash
trimmomaticPath="/mnt/silo/hts2024/alehmann/libs/trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar"
adapterLookup="/mnt/silo/hts2024/alehmann/libs/trimmomatic/Trimmomatic-0.39/adapters/adapters.fa"

output="/mnt/silo/hts2024/alehmann/hts-exercises/examScripts/output"

filename="$(basename "$1" ".fq.gz")"
java -jar "$trimmomaticPath" SE -phred33 -threads 8 "$1" "$output/$filename"_trimmomatic.fq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 ILLUMINACLIP:$adapterLookup:2:30:10
bfc -s 1g -t16 "$output/$filename"_trimmomatic.fq.gz | gzip > "$output/$filename"_bfc.fq.gz
fastqc "$output/$filename"_bfc.fq.gz -o "$output"