#!/bin/bash
trimmomaticPath="/mnt/silo/hts2024/alehmann/libs/trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar"
adapterLookup="/mnt/silo/hts2024/alehmann/libs/trimmomatic/Trimmomatic-0.39/adapters/TruSeq3-SE.fa"
files="/mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/C*.fq.gz"
quast="/mnt/silo/hts2024/alehmann/libs/quast-5.2.0/quast.py"
spade="/mnt/silo/hts2024/alehmann/libs/spades/assembler/spades.py"

fastQcOutput="/mnt/silo/hts2024/alehmann/hts-exercises/4-1/fastqcResult"
bfcOutput1G="/mnt/silo/hts2024/alehmann/hts-exercises/4-1/bfcOutput-1G"
bfcOutput1M="/mnt/silo/hts2024/alehmann/hts-exercises/4-1/bfcOutput-1M"
trimmomaticOutputDefault="/mnt/silo/hts2024/alehmann/hts-exercises/4-1/trimmomaticDefault"
trimmomaticOutputCrop="/mnt/silo/hts2024/alehmann/hts-exercises/4-1/trimmomaticCrop"
trimmomaticOutputDefaultBfc1G="/mnt/silo/hts2024/alehmann/hts-exercises/4-1/trimmomaticDefaultBfc1G"
trimmomaticOutputDefaultBfc1M="/mnt/silo/hts2024/alehmann/hts-exercises/4-1/trimmomaticDefaultBfc1M"

for folder in $fastQcOutput $bfcOutput1G $bfcOutput1M $trimmomaticOutputCrop $trimmomaticOutputDefault\
              $trimmomaticOutputDefaultBfc1M $trimmomaticOutputDefaultBfc1G
do
    mkdir "$folder"
done

for file in $files
do
    filename="$(basename "$file")"
    java -jar "$trimmomaticPath" SE -phred33 -threads 8 "$file" "$trimmomaticOutputDefault/$filename" LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 ILLUMINACLIP:$adapterLookup:2:30:10
    java -jar "$trimmomaticPath" SE -phred33 -threads 8 "$file" "$trimmomaticOutputCrop/$filename" CROP:80
    bfc -s 1m -t16 "$file" | gzip > "$bfcOutput1M/$filename"
    bfc -s 1g -t16 "$file" | gzip > "$bfcOutput1G/$filename"
    fastqc "$file" -o "$fastQcOutput"
done

for file in "$bfcOutput1G"/*
do
    filename="$(basename "$file")"
    java -jar "$trimmomaticPath" SE -phred33 -threads 8 "$file" "$trimmomaticOutputDefaultBfc1G/$filename" LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 ILLUMINACLIP:$adapterLookup:2:30:10
done

for file in "$bfcOutput1M"/*
do
    filename="$(basename "$file")"
    java -jar "$trimmomaticPath" SE -phred33 -threads 8 "$file" "$trimmomaticOutputDefaultBfc1M/$filename" LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 ILLUMINACLIP:$adapterLookup:2:30:10
done

for file in "$bfcOutput1G"/*.fq.gz "$bfcOutput1M"/*.fq.gz "$trimmomaticOutputDefault"/*.fq.gz "$trimmomaticOutputCrop"/*.fq.gz\
              "$trimmomaticOutputDefaultBfc1G"/*.fq.gz "$trimmomaticOutputDefaultBfc1M"/*.fq.gz
do
    DIR="$(dirname "$file")"
    filename="$(basename "$file" .fq.gz)"
    fastqc "$file" -o "$DIR"
    python3 "$spade" -s "$file" -o "$DIR/spade"
    mv "$DIR/spade/contigs.fasta" "$DIR/$filename-contigs.fasta"
    mv "$DIR/spade/scaffolds.fasta" "$DIR/$filename-scaffolds.fasta"
    rm -rf "$DIR/spade"
    python3 "$quast" "$DIR/$filename-contigs.fasta" -o "$DIR/quast"
    mv "$DIR/quast/report.html" "$DIR/$filename-contigs.html"
    python3 "$quast" "$DIR/$filename-scaffolds.fasta" -o "$DIR/quast"
    mv "$DIR/quast/report.html" "$DIR/$filename-scaffolds.html"
    rm -rf "$DIR/quast"
done

for file in $files
do
    DIR="$fastQcOutput"
    filename="$(basename "$file" .fq.gz)"
    python3 "$spade" -s "$file" -o "$DIR/spade"
    mv "$DIR/spade/contigs.fasta" "$DIR/$filename-contigs.fasta"
    mv "$DIR/spade/scaffolds.fasta" "$DIR/$filename-scaffolds.fasta"
    rm -rf "$DIR/spade"
    python3 "$quast" "$DIR/$filename-contigs.fasta" -o "$DIR/quast"
    mv "$DIR/quast/report.html" "$DIR/$filename-contigs.html"
    python3 "$quast" "$DIR/$filename-scaffolds.fasta" -o "$DIR/quast"
    mv "$DIR/quast/report.html" "$DIR/$filename-scaffolds.html"
    rm -rf "$DIR/quast"
done