
### 3.1.1

1. DNA sequences with random chain terminations with fluorescently labeled bases at the end. The output is a base sequence read out by human or machine
2. As a file, e.g. fastq, fasta
3. fastq, fasta, sam for alignment

### 3.1.2

1. `ls ~/../data` 
2. `gzip -dc data/public-data/PRJEB21270/ERR2173372_1.fastq.gz | head` or `zcat`
3. First comes an @ with sequence name, sequence number and other information of the measurement device, which took the sequence. Then the sequence itself, seperated by a newline. Then a +. Then the quality of sequence, indicated with one letter per base. The quality is indicated with ascii digits from 0x21 to 0x7e. N means, there is no clue what aminoacid is there
4. see above, 4 lines per entry
5. see above
6. Read pairs are identified by the same genome description and a trailing 1/2. Only the ends of a dna strand can be read, so from both ends can be read and fastq files are created. Roughly the length between the ends is known, because the overall length of the dna sequence is roughly known

### 3.1.3

1. `gzip -dc data/Capsella-sequencing/DNA-seq/rawdata/DNA2_1.fq.gz | head -n2 | tail -n1 | wc -c` --> 120
2. `gzip -dc data/Capsella-sequencing/DNA-seq/rawdata/DNA2_1.fq.gz  | wc -l | awk "{print $1/4}"` --> 37.6 million
3. 37.6 million*120
4. (150415688/4*120)/250000000 about 18 times for one read in one direction. We have 2 measurements in 2 read read directions each, so 4 times the result
5. Align reads based on well known core genes and then estimate. Aligning can be wrong, may have deletions and insertions based upon the quality of the input data
   1. [K-mer estimation](https://bioinformatics.uconn.edu/genome-size-estimation-tutorial/) Reads are splitted into predefined length k