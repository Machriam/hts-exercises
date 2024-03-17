#!/bin/bash

PATH=/mnt/silo/hts2024/ckappel/bin/bedtools/bedtools2/bin:$PATH

# cat /mnt/silo/hts2024/data/genomes/Caprub1_0/genomic.gff | awk '{if($3=="gene") print($0)}' >genes.gff

# bedtools multicov -bams \
# 	 /mnt/silo/hts2024/ckappel/exercises/ex06-01-04-tophat-mapping-subsets/tophat/adapter-removed/RNA5-s1M1M2/accepted_hits.bam \
# 	 /mnt/silo/hts2024/ckappel/exercises/ex06-01-04-tophat-mapping-subsets/tophat/adapter-removed/RNA6-s1M1M2/accepted_hits.bam \
# 	 /mnt/silo/hts2024/ckappel/exercises/ex06-01-04-tophat-mapping-subsets/tophat/adapter-removed/RNA7-s1M1M2/accepted_hits.bam \
# 	 /mnt/silo/hts2024/ckappel/exercises/ex06-01-04-tophat-mapping-subsets/tophat/adapter-removed/RNA8-s1M1M2/accepted_hits.bam \
# 	 -bed /mnt/silo/hts2024/data/genomes/Caprub1_0/genomic.gff \
# 	 >counts-bedtools.txt

gtf=/mnt/silo/hts2024/data/genomes/Caprub1_0/genomic.gtf

mkdir ./htseqCount

for f in /mnt/silo/hts2024/ckappel/exercises/ex06-01-04-tophat-mapping-subsets/tophat/adapter-removed/*/accepted_hits.bam
do
    sample=$(echo "$f" | sed 's/\/accepted_hits.bam//' | sed 's/.*\///')
    echo "$sample" "$f"

    htseq-count -t exon -i gene_id -s no "$f" "$gtf" > ~/hts-exercises/examScripts/htseqCount/"$sample"-htseq-count.txt
    
done
