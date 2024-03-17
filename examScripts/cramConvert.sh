#!/bin/bash
filename="$(basename "$1" ".fq.gz")"

samtools view -C -T ./bwaIndex/ref -o ./output/"$filename".cram "$1"