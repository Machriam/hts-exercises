/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex01-02-05/program.sh
#!/bin/bash

echo "Hello world!"
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-01-quality-control/010-get-fastqc.sh
#!/bin/bash

wd=$(pwd)
mkdir -p /mnt/silo/hts2024/ckappel/bin
cd /mnt/silo/hts2024/ckappel/bin
wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip
unzip fastqc_v0.12.1.zip
mv FastQC fastqc_v0.12.1
cd fastqc_v0.12.1
chmod u+x fastqc

cd $wd

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-01-quality-control/020-run-fastqc.sh
#!/bin/bash

mkdir -p rawdata

/mnt/silo/hts2024/ckappel/bin/fastqc_v0.12.1/fastqc \
    -o rawdata \
    /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata/*.fq.gz

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-02-quality-trimming/010-get-trimmomatic.sh
#!/bin/bash

wd=$(pwd)

cd /mnt/silo/hts2024/ckappel/bin

mkdir -p Trimmomatic

cd Trimmomatic

wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip

unzip Trimmomatic-0.39.zip

cd "$wd"



/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-02-quality-trimming/020-run-trimmomatic.sh
#!/bin/bash
mkdir -p trimmomatic
cat /mnt/silo/hts2024/ckappel/bin/Trimmomatic/Trimmomatic-0.39/adapters/*.fa | sed 's/>/\n>/' | sed '/^$/d' > adapters.fa

for sample in DNA1 DNA2 DNA3 DNA4; do

    java -jar \
	 /mnt/silo/hts2024/ckappel/bin/Trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar \
	 PE \
	 -threads 4 \
	 -phred64 \
	 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata/$sample\_1.fq.gz \
	 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata/$sample\_2.fq.gz \
	 trimmomatic/$sample\_1.fq.gz \
	 trimmomatic/$sample\_forward_unpaired.fq.gz \
	 trimmomatic/$sample\_2.fq.gz \
	 trimmomatic/$sample\_reverse_unpaired.fq.gz \
	 ILLUMINACLIP:adapters.fa:2:30:10 \
	 LEADING:20 \
	 TRAILING:20 \
	 SLIDINGWINDOW:20:15 \
	 MINLEN:36
    
done


/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-02-quality-trimming/030-run-fastqc.sh
#!/bin/bash

mkdir -p trimmomatic/fastqc

/mnt/silo/hts2024/ckappel/bin/fastqc_v0.12.1/fastqc \
    -o trimmomatic/fastqc \
    trimmomatic/*.fq.gz


/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-02-quality-trimming/run-trimmomatic-example-script-with-file-variable.sh
#!/bin/bash

# Combine all adapter sequences in one file (if you do not know which adapters were used for library creation)
cat /mnt/silo/hts2023/ckappel/bin/Trimmomatic/Trimmomatic-0.39/adapters/*.fa | sed 's/>/\n>/' | sed '/^$/d' > adapters.fa



# Create output directory
mkdir -p trimmomatic

# Run trimmomatic
SAMPLE_NAME=DNA1
FQ1=/mnt/silo/hts2023/data/Capsella-sequencing/DNA-seq/rawdata/DNA1_1.fq.gz
FQ2=/mnt/silo/hts2023/data/Capsella-sequencing/DNA-seq/rawdata/DNA1_2.fq.gz

java -jar \
	/mnt/silo/hts2023/ckappel/bin/Trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar \
	PE \
	$FQ1 \
	$FQ2 \
	trimmomatic/$SAMPLE_NAME-fwd.fq.gz \
	trimmomatic/$SAMPLE_NAME-fwd-unpaired.fq.gz \
	trimmomatic/$SAMPLE_NAME-rev.fq.gz \
	trimmomatic/$SAMPLE_NAME-rev-unpaired.fq.gz \
	ILLUMINACLIP:adapters.fa:2:30:10 \
	LEADING:20 \
	TRAILING:20 \
	SLIDINGWINDOW:20:15 \
	MINLEN:36





/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-02-quality-trimming/script.sh
#!/bin/bash

java -jar trimmomatic-0.35.jar \
     PE \
     -phred33 \
     input_forward.fq.gz \
     input_reverse.fq.gz \
     output_forward_paired.fq.gz \
     output_forward_unpaired.fq.gz \
     output_reverse_paired.fq.gz \
     output_reverse_unpaired.fq.gz \
     ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 \
     LEADING:3 \
     TRAILING:3 \
     SLIDINGWINDOW:4:15 \
     MINLEN:36

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-03-fastq-file-transformation/010-setup-seqtk.sh
#!/bin/bash

wd=$(pwd)

cd /mnt/silo/hts2024/ckappel/bin
mkdir -p seqtk
cd seqtk
wget https://github.com/lh3/seqtk/archive/refs/tags/v1.4.tar.gz
tar xvfz v1.4.tar.gz
cd seqtk-1.4
make

cd "$wd"



/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-03-fastq-file-transformation/020-transform-quality-encodings-using-seqtk.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/seqtk/seqtk-1.4:$PATH

# ### seqtk example for DNA1_1
# seqtk seq -Q64 -V /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata/DNA1_1.fq.gz | gzip >DNA1_1.fq.gz

### Loop over all files
mkdir -p rawdata-phred33
for f in /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata/*.fq.gz; do
    outfile=$(echo $f | sed 's/.*\//rawdata-phred33\//')
    echo $f $outfile
    seqtk seq -Q64 -V $f | gzip >$outfile
done
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-03-fastq-file-transformation/030-setup-seqkit.sh
#!/bin/bash

wd=$(pwd)

cd /mnt/silo/hts2024/ckappel/bin

mkdir seqkit
cd seqkit

wget https://github.com/shenwei356/seqkit/releases/download/v0.12.0/seqkit_linux_amd64.tar.gz
tar xfvz seqkit_linux_amd64.tar.gz

cd "$wd"
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-03-fastq-file-transformation/040-transform-using-seqkit.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/seqkit:$PATH

mkdir -p rawdata-phred33-seqkit

for f in /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata/*.fq.gz; do
    outfile=$(echo $f | sed 's/.*\//rawdata-phred33-seqkit\//')
    echo $f $outfile

    ## Transform to phred33 quality encoding
    seqkit convert $f --from Illumina-1.5+ | gzip > $outfile

done
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-03-fastq-file-transformation/050-transform-to-fasta.sh
### Transform to fasta
PATH=/mnt/silo/hts2024/ckappel/bin/seqtk/seqtk-master:$PATH

fq=
faout=
zcat $fq | head -n4000 | seqkit fq2fa -o - >$faout


/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-04-error-correction/010-setup-bfc.sh
#!/bin/bash

if [ ! -e /mnt/silo/hts2024/ckappel/bin/bfc/bfc-master ]
then
    wd=$(pwd)
    mkdir -p /mnt/silo/hts2024/ckappel/bin/bfc
    cd /mnt/silo/hts2024/ckappel/bin/bfc
    wget https://github.com/lh3/bfc/archive/master.zip
    unzip master.zip
    cd bfc-master
    make
    cd $wd
fi

    
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex03-02-04-error-correction/015-bfc-error-correction.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bfc/bfc-master:$PATH

mkdir -p rawdata-phred33-bfc-corrected

for f in /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata-phred33/*.fq.gz; do
    sample=$(echo $f | sed 's/.*\///' | sed 's/.fq.gz//')
    echo $sample $f
    bfc \
	-s 250m \
	-t 4 \
	$f \
	| gzip > rawdata-phred33-bfc-corrected/$sample.fq.gz
    
done



### Quality control
mkdir -p rawdata-phred33-bfc-corrected/fastqc
/mnt/silo/hts2024/ckappel/bin/fastqc_v0.12.1/fastqc \
    -o rawdata-phred33-bfc-corrected/fastqc \
    rawdata-phred33-bfc-corrected/*.fq.gz
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex04-01-02-subset-preprocessing/010-bfc-error-correction.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bfc/bfc-master:$PATH

outdir=subsets-phred33-bfc

mkdir -p $outdir

for f in /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/C*.fq.gz; do
    sample=$(echo $f | sed 's/.*\///' | sed 's/.fq.gz//')
    echo $sample $f
    bfc \
	-s 1m \
	-t 4 \
	$f \
	| gzip > $outdir/$sample.fq.gz
    
done



### Quality control
mkdir -p $outdir/fastqc

/mnt/silo/hts2024/ckappel/bin/fastqc_v0.12.1/fastqc \
    -o $outdir/fastqc \
    $outdir/*.fq.gz
    
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex04-01-02-subset-preprocessing/010-bfc-error-correction_simpler.sh
#!/bin/bash

### Simpler, with variables
mkdir -p output
fq=/mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cru_1.fq.gz
sample=Cru_1
bfc -s 1m -t 4 $fq | gzip >output/$sample.fq.gz

### Even simples, without varibles
bfc -s 1m -t 4 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cru_1.fq.gz | gzip >output/Cru_1.fq.gz
bfc -s 1m -t 4 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cru_2.fq.gz | gzip >output/Cru_2.fq.gz
bfc -s 1m -t 4 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cgr_1.fq.gz | gzip >output/Cgr_1.fq.gz
bfc -s 1m -t 4 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cgr_2.fq.gz | gzip >output/Cgr_2.fq.gz


/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex04-01-02-subset-preprocessing/020-trimmomatic-quality-trimming.sh
#!/bin/bash

outdir=subsets-phred33-trimmomatic

mkdir -p $outdir $outdir/unpaired

for sample in Cru Cgr; do

    java -jar \
	 /mnt/silo/hts2024/ckappel/bin/Trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar \
	 PE \
	 -threads 4 \
	 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/$sample\_1.fq.gz \
	 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/$sample\_2.fq.gz \
	 $outdir/$sample\_1.fq.gz \
	 $outdir/unpaired/$sample\_1_unpaired.fq.gz \
	 $outdir/$sample\_2.fq.gz \
	 $outdir/unpaired/$sample\_2_unpaired.fq.gz \
	 LEADING:20 \
	 TRAILING:20 \
	 SLIDINGWINDOW:20:15 \
	 MINLEN:36
    
done


/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex04-01-02-subset-preprocessing/025-bfc-error-correction-of-trimmomatic-quality-trimmed-files.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bfc/bfc-master:$PATH

outdir=subsets-phred33-trimmomatic-bfc

mkdir -p $outdir

for f in subsets-phred33-trimmomatic/C*.fq.gz; do
    sample=$(echo $f | sed 's/.*\///' | sed 's/.fq.gz//')
    echo $sample $f
    bfc \
	-s 1m \
	-t 4 \
	$f \
	| gzip > $outdir/$sample.fq.gz
    
done



### Quality control
mkdir -p $outdir/fastqc

/mnt/silo/hts2024/ckappel/bin/fastqc_v0.12.1/fastqc \
    -o $outdir/fastqc \
    $outdir/*.fq.gz
    
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex04-01-03-subset-de-novo-assembly/015-run-SOAP-denovo.sh
#!/bin/bash

PATH=/mnt/silo/hts2024/ckappel/bin/miniconda/bin:$PATH

k=51

### C. rubella rawdata
mkdir -p soapdenovo/Cru-raw/K$k

SOAPdenovo-63mer all \
  -s soapdenovo/Cru-raw.conf \
  -K $k \
  -R \
  -o soapdenovo/Cru-raw/K$k \
  1>soapdenovo/Cru-raw/K$k-assembly.log \
  2>soapdenovo/Cru-raw/K$k-assembly.err


### C. rubella bfc error corrected
mkdir -p soapdenovo/Cru-bfc/K$k

SOAPdenovo-63mer all \
  -s soapdenovo/Cru-bfc.conf \
  -K $k \
  -R \
  -o soapdenovo/Cru-bfc/K$k \
  1>soapdenovo/Cru-bfc/K$k-assembly.log \
  2>soapdenovo/Cru-bfc/K$k-assembly.err
  
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex04-01-03-subset-de-novo-assembly/020-setup-megahit.sh
#!/bin/bash

wd=$(pwd)
cd /mnt/silo/hts2024/ckappel/bin
mkdir -p megahit
cd megahit
wget https://github.com/voutcn/megahit/releases/download/v1.2.9/MEGAHIT-1.2.9-Linux-x86_64-static.tar.gz
tar xfvz MEGAHIT-1.2.9-Linux-x86_64-static.tar.gz
cd $wd

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex04-01-03-subset-de-novo-assembly/025-megahit-assembly.sh
#!/bin/bash

PATH=/mnt/silo/hts2024/ckappel/bin/megahit/MEGAHIT-1.2.9-Linux-x86_64-static/bin:$PATH

mkdir -p megahit

### Assembly with raw sequencing files
megahit \
    -1 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cru_1.fq.gz \
    -2 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cru_2.fq.gz \
    -o megahit/Cru-raw \
    -t 2
    
megahit \
    -1 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cgr_1.fq.gz \
    -2 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cgr_2.fq.gz \
    -o megahit/Cgr-raw \
    -t 8
    


### Assembly with error corrected data
megahit \
    -1 /mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-bfc/Cru_1.fq.gz \
    -2 /mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-bfc/Cru_1.fq.gz \
    -o megahit/Cru-bfc \
    -t 8
    
megahit \
    -1 /mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-bfc/Cgr_1.fq.gz \
    -2 /mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-bfc/Cgr_1.fq.gz \
    -o megahit/Cgr-bfc \
    -t 8


### Assembly with quality trimmed data
megahit \
    -1 /mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-trimmomatic/Cru_1.fq.gz \
    -2 /mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-trimmomatic/Cru_1.fq.gz \
    -o megahit/Cru-trimmed \
    -t 8

### Assembly with quality trimmed and error corrected data
megahit \
    -1 /mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-trimmomatic-bfc/Cru_1.fq.gz \
    -2 /mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-trimmomatic-bfc/Cru_1.fq.gz \
    -o megahit/Cru-trimmed-bfc \
    -t 8

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex04-01-03-subset-de-novo-assembly/040-setup-spades.sh
#!/bin/bash

wd="$(pwd)"

cd /mnt/silo/hts2024/ckappel/bin
mkdir spades
cd spades

wget https://github.com/ablab/spades/releases/download/v3.15.5/SPAdes-3.15.5.tar.gz
tar -xzf SPAdes-3.15.5.tar.gz
cd SPAdes-3.15.5

./spades_compile.sh

## binaries/executables are in subdirectory /mnt/silo/hts2024/ckappel/bin/spades/SPAdes-3.15.5/bin

cd "$wd"


/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex04-01-03-subset-de-novo-assembly/045-spades-assembly.sh
#!/bin/bash

### Add SPAdes bin directory to the PATH
PATH=/mnt/silo/hts2024/ckappel/bin/spades/SPAdes-3.15.5/bin:$PATH


/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex04-01-03-subset-de-novo-assembly/999-assembly-stats.sh
#!bin/bash

### Setup program
if [ ! -e /mnt/silo/hts2024/ckappel/bin/assembly-stats/assembly-stats-1.0.1/build ]; then
  wd=$(pwd)
  cd /mnt/silo/hts2024/ckappel/bin
  mkdir assembly-stats
  cd assembly-stats
  wget https://github.com/sanger-pathogens/assembly-stats/archive/refs/tags/v1.0.1.tar.gz
  tar xvfz v1.0.1.tar.gz
  cd assembly-stats-1.0.1/
  mkdir build
  cd build
  cmake ..
  make
  cd "$wd"
fi



### Run it
PATH=/mnt/silo/hts2024/ckappel/bin/assembly-stats/assembly-stats-1.0.1/build:$PATH

### megahit subset assembly
assembly-stats /mnt/silo/hts2024/ckappel/exercises/ex04-01-03-subset-assembly/megahit/Cru-raw/final.contigs.fa


/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex04-01-09-pacbio-assembly/010-setup-canu.sh
#!/bin/bash

wd=$(pwd)

cd /mnt/silo/hts2024/ckappel/bin
mkdir canu
cd canu
wget https://github.com/marbl/canu/releases/download/v2.2/canu-2.2.Linux-amd64.tar.xz
tar xJf canu-2.2.Linux-amd64.tar.xz

cd $wd

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex04-01-09-pacbio-assembly/020-canu-assembly.sh
#!/bin/bash

PATH=/mnt/silo/hts2024/ckappel/bin/canu/canu-2.2/bin:$PATH

canu \
    -p unknown \
    -d assembly \
    useGrid=false \
    genomeSize=1.5m \
    -pacbio /mnt/silo/hts2024/data/unknown/unknown-pacbio.fq.gz

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-04-bwa-subsets-mapping/010-bwa-setup.sh
#!/bin/bash

wd=$(pwd)

cd /mnt/silo/hts2024/ckappel/bin

mkdir -p bwa

cd bwa

git clone https://github.com/lh3/bwa.git

cd bwa

make

cd "$wd"
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-04-bwa-subsets-mapping/020-mapping.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bwa/bwa:$PATH

### Make bwa index
mkdir idx
ln -s /mnt/silo/hts2024/data/genomes/Caprub1_0/GCF_000375325.1_Caprub1_0_genomic.fna idx/ref.fa
bwa index idx/ref.fa

### Mapping
fq1=/mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cr1504_1.fq.gz
fq2=/mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cr1504_2.fq.gz
bwa mem idx/ref.fa $fq1 $fq2 >Cr1504.sam

fq1=/mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cg926_1.fq.gz
fq2=/mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cg926_2.fq.gz
bwa mem idx/ref.fa $fq1 $fq2 >Cg926.sam

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-05-samtools-bam-indexing/010-setup-samtools.sh
#!/bin/bash

wd=$(pwd)

cd /mnt/silo/hts2024/ckappel/bin

mkdir -p samtools

cd samtools

wget https://github.com/samtools/samtools/releases/download/1.19.2/samtools-1.19.2.tar.bz2

tar xvfj samtools-1.19.2.tar.bz2

cd samtools-1.19.2

make

cd "$wd"


/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-05-samtools-bam-indexing/020-transform-to-bam-format.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/samtools/samtools-1.19.2:$PATH

# samtools view -hSbo output.bam input.sam # h: include header; S: input is sam form (default, not necessary; b: output in binary binary format (bam); o: output files as parameter, standard output otherwise
# samtools view -bS input.sam >output.bam
# samtools -b -h -o output.bam input.sam
# samtools view -hbo output.bam input.sam

samtools view -b -h -o Cr1504.bam ../ex05-01-04-bwa-subsets-mapping/Cr1504.sam
samtools view -b -h -o Cg926.bam ../ex05-01-04-bwa-subsets-mapping/Cg926.sam






/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-05-samtools-bam-indexing/030-bam-sort-and-indexing.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/samtools/samtools-1.19.2:$PATH

samtools sort Cg926.bam -o Cg926.sorted.bam
samtools index Cg926.sorted.bam # only position sorted files can be indexed

samtools sort Cr1504.bam -o Cr1504.sorted.bam
samtools index Cr1504.sorted.bam







/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-08-comparing-raw-and-pre-processed-reads/010-mapping-pre-processed-reads.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bwa/bwa:$PATH
PATH=/mnt/silo/hts2024/ckappel/bin/samtools/samtools-1.19.2:$PATH

### Cru
fq1=/mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-bfc/Cru_1.fq.gz
fq2=/mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-bfc/Cru_2.fq.gz

bwa mem ../ex05-01-04-bwa-subsets-mapping/idx/ref.fa $fq1 $fq2 \
    | samtools view -b -h \
    | samtools sort -o Cru.bam
samtools index Cru.bam

# ### Cgr
# fq1=/mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-bfc/Cgr_1.fq.gz
# fq2=/mnt/silo/hts2024/ckappel/exercises/ex04-01-02-subset-preprocessing/subsets-phred33-bfc/Cgr_2.fq.gz

# bwa mem ../ex05-01-04-bwa-subsets-mapping/idx/ref.fa $fq1 $fq2 \
#     | samtools view -b -h \
#     | samtools sort -o Cgr.bam
# samtools index Cgr.bam





/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-09-mapping-assembled-scaffolds/010-mapping-scaffolds.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bwa/bwa:$PATH
PATH=/mnt/silo/hts2024/ckappel/bin/samtools/samtools-1.19.2:$PATH
PATH=/mnt/silo/hts2024/ckappel/exercises/ex05-01-12-mapping-nanopore-pacbio-miseq/minimap2-2.8_x64-linux:$PATH

### Link bwa index
ln -s /mnt/silo/hts2024/ckappel/exercises/ex05-01-04-bwa-subsets-mapping/idx .

### Mapping C. rubella scaffolds
ln -s /mnt/silo/hts2024/ckappel/exercises/ex04-01-03-subset-de-novo-assembly/megahit/Cru-bfc/final.contigs.fa Cru-bfc.fa
mkdir -p mapping
minimap2 \
    -x splice \
    -a \
    idx/ref.fa \
    Cru-bfc.fa \
    | samtools view -b -h - | samtools sort -o mapping/Cru-bfc.bam -
samtools index mapping/Cru-bfc.bam

### Mapping C. gradiflora scaffolds
ln -s /mnt/silo/hts2024/ckappel/exercises/ex04-01-03-subset-de-novo-assembly/megahit/Cgr-bfc/final.contigs.fa Cgr-bfc.fa
minimap2 \
    -x splice \
    -a \
    idx/ref.fa \
    Cgr-bfc.fa \
    | samtools view -b -h - | samtools sort -o mapping/Cgr-bfc.bam -
samtools index mapping/Cgr-bfc.bam



/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-10-mapping-subsets-with-other-mappers/010-setup-botwie2.sh
#!/bin/bash

wd=$(pwd)

cd /mnt/silo/hts2024/ckappel/bin/
mkdir -p bowtie2
cd bowtie2
wget https://github.com/BenLangmead/bowtie2/releases/download/v2.5.3/bowtie2-2.5.3-linux-x86_64.zip
unzip bowtie2-2.5.3-linux-x86_64.zip
cd bowtie2-2.5.3-linux-x86_64

cd "$wd"
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-10-mapping-subsets-with-other-mappers/020-bowtie2-mapping.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bowtie2/bowtie2-2.5.3-linux-x86_64:$PATH
PATH=/mnt/silo/hts2024/ckappel/bin/samtools/samtools-1.19.2:$PATH

### Build index
mkdir bowtie2-index
ln -s /mnt/silo/hts2024/data/genomes/Caprub1_0/GCF_000375325.1_Caprub1_0_genomic.fna bowtie2-index/ref.fa

bowtie2-build bowtie2-index/ref.fa bowtie2-index/ref


bowtie2-build /mnt/silo/hts2024/data/genomes/Caprub1_0/GCF_000375325.1_Caprub1_0_genomic.fna bowtie2-index/ref2

### Cru mapping
#bowtie2 -x example/index/lambda_virus -1 example/reads/reads_1.fq -2 example/reads/reads_2.fq
mkdir -p bowtie2
bowtie2 -x bowtie2-index/ref \
	-1 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cr1504_1.fq.gz \
	-2 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cr1504_2.fq.gz \
    | samtools sort -o bowtie2/Cr1504.bam
samtools index bowtie2/Cr1504.bam

bowtie2 -x bowtie2-index/ref \
	-1 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cg926_1.fq.gz \
	-2 /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/subsets-phred33/Cg926_2.fq.gz \
    | samtools sort -o bowtie2/Cg926.bam
samtools index bowtie2/Cg926.bam





	
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-11-whole-genome-mapping/010-bwa-mapping.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bwa/bwa:$PATH
PATH=/mnt/silo/hts2024/ckappel/bin/samtools/samtools-1.19:$PATH
PATH=/mnt/silo/hts2024/ckappel/bin/bcftools/bcftools-1.19:$PATH

### Use pre-build index
bwa_index=/mnt/silo/hts2024/ckappel/exercises/ex05-01-04-bwa-subsets-mapping/idx/ref.fa

### Combinde fastq data
mkdir -p rawdata
cat /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata-phred33/DNA1_1.fq.gz /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata-phred33/DNA3_1.fq.gz >rawdata/Cgr_1.fq.gz
cat /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata-phred33/DNA1_2.fq.gz /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata-phred33/DNA3_2.fq.gz >rawdata/Cgr_2.fq.gz

cat /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata-phred33/DNA2_1.fq.gz /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata-phred33/DNA4_1.fq.gz >rawdata/Cru_1.fq.gz
cat /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata-phred33/DNA2_2.fq.gz /mnt/silo/hts2024/data/Capsella-sequencing/DNA-seq/rawdata-phred33/DNA4_2.fq.gz >rawdata/Cru_2.fq.gz

### Mapping
mkdir -p bwa
bwa mem -t 44 $bwa_index rawdata/Cru_1.fq.gz rawdata/Cru_2.fq.gz \
    | samtools sort -o bwa/Cru.bam
samtools index bwa/Cru.bam

bwa mem -t 44 $bwa_index rawdata/Cgr_1.fq.gz rawdata/Cgr_2.fq.gz \
    | samtools sort -o bwa/Cgr.bam
samtools index bwa/Cgr.bam


/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-11-whole-genome-mapping/020-make-bam-files-for-region-of-interest.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/samtools/samtools-1.19.2:$PATH

mkdir -p bwa/region1
samtools view -b -h bwa/Cgr.bam NW_006238923.1:1,000,000-2,000,000 >bwa/region1/Cgr.bam
samtools index bwa/region1/Cgr.bam

samtools view -b -h bwa/Cru.bam NW_006238923.1:1,000,000-2,000,000 >bwa/region1/Cru.bam
samtools index bwa/region1/Cru.bam

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-12-mapping-nanopore-pacbio-miseq/010-mapping-against-Ath-genome.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bwa/bwa:$PATH
PATH=/mnt/silo/hts2024/ckappel/bin/samtools/samtools-1.19.2:$PATH

mkdir -p mapping

### Index
ref=/mnt/silo/hts2024/data/genomes/TAIR10/TAIR10_chr.fa

if [ ! -e $ref.bwt ]; then
    bwa index $ref

fi


### Setup minimap2
if [ ! -e minimap2-2.8_x64-linux ]; then
    curl -L https://github.com/lh3/minimap2/releases/download/v2.8/minimap2-2.8_x64-linux.tar.bz2 \
	| tar -jxvf -

fi




### Mapping raw Oxford Nanopore data
f=/mnt/silo/hts2023/data/public-data/PRJEB21270/ERR2173373.fastq.gz

time ./minimap2-2.8_x64-linux/minimap2 \
    -x map-ont \
    -a \
    $ref \
    $f \
    | samtools view -b -h - | samtools sort -o mapping/ERR2173373-minimap.bam -

samtools index mapping/ERR2173373-minimap.bam



### Mapping raw PacBio data
f=/mnt/silo/hts2023/data/public-data/PRJEB21270/ERR2173371_1.fastq.gz

./minimap2-2.8_x64-linux/minimap2 \
    -x map-pb \
    -a \
    $ref \
    $f \
    | samtools view -b -h - | samtools sort -o mapping/ERR2173371-minimap.bam -

samtools index mapping/ERR2173371-minimap.bam



### MiSeq data
f1=/mnt/silo/hts2023/data/public-data/PRJEB21270/ERR2173372_1.fastq.gz
f2=/mnt/silo/hts2023/data/public-data/PRJEB21270/ERR2173372_2.fastq.gz

bwa mem \
    $ref \
    $f1 \
    $f2 \
    | samtools view -b -h - | samtools sort -o mapping/ERR2173372.bam -

samtools index mapping/ERR2173372.bam

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-01-12-mapping-nanopore-pacbio-miseq/020-extract-regions.sh
#!/bin/bash
PATH=/mnt/silo/hts2023/ckappel/bin/samtools/samtools-1.17:$PATH

mkdir -p mapping-Chr1-1-to-1000000

for bam in mapping/*.bam; do
    sample=$(echo $bam | sed 's/.*\///' | sed 's/\.bam//')
    echo $sample
    samtools view -b -h $bam Chr1:1-1000000 > mapping-Chr1-1-to-1000000/$sample.bam
    samtools index mapping-Chr1-1-to-1000000/$sample.bam

done

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-02-01-subsets-variant-calling/010-setup-bcftools.sh
#!/bin/bash

wd=$(pwd)

cd /mnt/silo/hts2024/ckappel/bin
mkdir bcftools
cd bcftools
wget https://github.com/samtools/bcftools/releases/download/1.19/bcftools-1.19.tar.bz2
tar xjf bcftools-1.19.tar.bz2
cd bcftools-1.19
make

cd "$wd"

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-02-01-subsets-variant-calling/020-variant-calling.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/samtools/samtools-1.19:$PATH
PATH=/mnt/silo/hts2024/ckappel/bin/bcftools/bcftools-1.19:$PATH

###  Link reference fasta and generate samtools index
mkdir -p idx
ln -s /mnt/silo/hts2024/data/genomes/Caprub1_0/GCF_000375325.1_Caprub1_0_genomic.fna idx/ref.fa
samtools faidx idx/ref.fa

### Variant calling using samtools
bcftools mpileup -Ou \
	 -f idx/ref.fa \
	 /mnt/silo/hts2024/ckappel/exercises/ex05-01-05-samtools-bam-indexing/Cr1504.sorted.bam \
	 /mnt/silo/hts2024/ckappel/exercises/ex05-01-05-samtools-bam-indexing/Cg926.sorted.bam \
    | bcftools call -v -m -Ov -o subsets-raw.vcf

## -v: output variant sites only
## -m: alternative model for multiallelic and rare-variant calling
## -O v: output uncompressed vcf format
## -o file: output file
 

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-02-01-subsets-variant-calling/030-filter-homozygous-differences.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bcftools/bcftools-1.19:$PATH

### Using grep
cat subsets-raw.vcf | grep "0/0.*1/1" | wc -l 

### filter1: homozygous reference for Cru and homozygous alternative for Cgr
bcftools view -i 'GT="0/0" && GT="1/1"' subsets-raw.vcf >subsets-raw.filter1.vcf



### [not working] filter2: homozygous reference for Cru and homozygous alternative for Cgr; reheader and filter by sample name
bcftools query -l subsets-raw.vcf
bcftools reheader -s samples.txt -o subsets-raw.renamed.vcf subsets-raw.vcf
bcftools query -l subsets-raw.renamed.vcf

##bcftools view -i 'FMT/Cr1504="0/0" & FMT/Cg926="1/1"' subsets-raw.renamed.vcf >subsets-raw.renamed.filter2.vcf
 
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-02-03-snpEff-variant-effect-prediction/010-setup-snpEff.sh
#!/bin/bash

wd=$(pwd)

cd /mnt/silo/hts2024/ckappel/bin
mkdir snpEff
cd snpEff
wget https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip
unzip snpEff_latest_core.zip

cd "$wd"

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-02-03-snpEff-variant-effect-prediction/020-build-snpEff-database.sh
#!/bin/bash

### Go to snpEff installation directory and create genome data directory
mkdir -p /mnt/silo/hts2024/ckappel/bin/snpEff/snpEff/data/Caprub1_0


### Copy genome fasta, rename to sequences.fa.gz
gzip -c /mnt/silo/hts2024/data/genomes/Caprub1_0/GCF_000375325.1_Caprub1_0_genomic.fna >/mnt/silo/hts2024/ckappel/bin/snpEff/snpEff/data/Caprub1_0/sequences.fa.gz


### Copy gene annotations (gff), rename to genes.gff.gz
gzip -c /mnt/silo/hts2024/data/genomes/Caprub1_0/genomic.gff >/mnt/silo/hts2024/ckappel/bin/snpEff/snpEff/data/Caprub1_0/genes.gff.gz


### Add entry to snpEff.config
echo "Caprub1_0.genome : Capsella rubella genome version 1.0" >>/mnt/silo/hts2024/ckappel/bin/snpEff/snpEff/snpEff.config


### Build snpEff genome database
java -jar /mnt/silo/hts2024/ckappel/bin/snpEff/snpEff/snpEff.jar \
     build -gff3 -v Caprub1_0 -noCheckCds -noCheckProtein



/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-02-03-snpEff-variant-effect-prediction/030-run-snpEff.sh
#!/bin/bash

java -jar /mnt/silo/hts2024/ckappel/bin/snpEff/snpEff/snpEff.jar \
     -v Caprub1_0 \
     /mnt/silo/hts2024/ckappel/exercises/ex05-02-01-subsets-variant-calling/subsets-raw.vcf \
     >subsets-raw.snpEff.vcf

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-02-04-whole-genome-variant-calling-and-effect-prediction/010-variant-calling-by-window.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/samtools/samtools-1.19:$PATH
PATH=/mnt/silo/hts2024/ckappel/bin/bcftools/bcftools-1.19:$PATH

mkdir -p tables tmp

### Link pre-build index
ln -s /mnt/silo/hts2024/ckappel/exercises/ex05-01-04-bwa-subsets-mapping/idx .

### Link mappings
ln -s /mnt/silo/hts2024/ckappel/exercises/ex05-01-11-whole-genome-mapping/bwa .

### Make 0.5 Mb windows for parallel variant calling
PATH=/home/ckappel/Science/bin/bedtools/bedtools-v2.29.1/bin:$PATH
bedtools makewindows -g <(cat idx/ref.fa.fai | head -n 8) -w 500000 \
    | awk -F"\t" 'BEGIN {OFS=FS} {$2=$2+1}; {print($0)};' \
    | split -l 1 - tmp/region

### Variant calling
>cmds.parallel
for f in tmp/region*; do
    echo "bcftools mpileup -f idx/ref.fa -a \"AD\" -Ou -R $f bwa/*.bam | bcftools call -mv -Ob -o tables/calling.$(echo $f | sed 's/.*\///').bcf" >>cmds.parallel
    
done

parallel -j 44 <cmds.parallel
##rm cmds.parallel

bcftools concat tables/calling.*.bcf | bcftools view -O z - > tables/calling.bcf
rm tables/calling.*.bcf

## Biallelic calls only: -m2 (minimum 2 alleles) -M2 (maximum 2 alleles)
bcftools view -h tables/calling.bcf | tail -n1 | sed 's/^#//' | sed 's/bwa\///g' | sed 's/\.bam//g' | sed 's/.*FORMAT\t//' >tables/samples.txt
bcftools view --exclude-uncalled -m2 -M2 tables/calling.bcf | bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%QUAL\n' - | bgzip -c > tables/calling.coords.txt.bgz
bcftools view --exclude-uncalled -m2 -M2 tables/calling.bcf | bcftools query -f '[%AD\t]\n' - | sed 's/,/\t/g' | sed s'/\t$//' | bgzip -c > tables/calling.AD.txt.bgz
bcftools view --exclude-uncalled -m2 -M2 tables/calling.bcf | bcftools query -f '[%GT\t]\n' - | sed 's/\t$//' | bgzip -c > tables/calling.GT.txt.bgz

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-02-04-whole-genome-variant-calling-and-effect-prediction/020-run-snpEff.sh
#!/bin/bash

### Transform bcf to vcf format for use with snpEff
PATH=/mnt/silo/hts2024/ckappel/bin/bcftools/bcftools-1.19:$PATH

bcftools view tables/calling.bcf >tables/calling.vcf

### Run snpEff
java -jar /mnt/silo/hts2024/ckappel/bin/snpEff/snpEff/snpEff.jar \
     -v Caprub1_0 \
     tables/calling.vcf \
     >tables/calling.snpEff.vcf



/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex05-02-04-whole-genome-variant-calling-and-effect-prediction/030-filter-homozygous-differences.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bcftools/bcftools-1.19:$PATH

### Homozygous reference for Cru and homozygous alternative for Cgr (Ggr column comes first in tables/calling.bcf)
bcftools view -i 'GT="1/1" && GT="0/0"' tables/calling.bcf >tables/calling-fixed-differences.vcf

### Count fixed variants (lines), -H removes header
bcftools view -H | wc -l
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex06-01-01-RNA-seq-data/010-fastqc.sh
#!/bin/bash
mkdir -p rawdata-phred33/fastqc

/mnt/silo/hts2024/ckappel/bin/fastqc/FastQC/fastqc \
    -o rawdata-phred33/fastqc \
    /mnt/silo/hts2024/data/Capsella-sequencing/RNA-seq/rawdata-phred33/*.fq.gz
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex06-01-01-RNA-seq-data/020-adapter-removal-using-trimmomatir.sh
#!/bin/bash

mkdir -p adapter-removed

cat /mnt/silo/hts2024/ckappel/bin/Trimmomatic/Trimmomatic-0.39/adapters/*.fa | sed 's/>/\n>/' | sed '/^$/d' >adapters.fa
echo "" >>adapters.fa

for f in /mnt/silo/hts2024/data/Capsella-sequencing/RNA-seq/rawdata-phred33/*.fq.gz
do
    sample=$(echo $f | sed 's/.*\///' | sed 's/\.fq\.gz//')
    echo $sample $f

    java -jar \
	 /mnt/silo/hts2024/ckappel/bin/Trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar \
	 SE \
	 -threads 4 \
	 $f \
	 adapter-removed/$sample.fq.gz \
	 ILLUMINACLIP:adapters.fa:2:30:10 \
	 MINLEN:36
    
done


### Check with fastqc
mkdir -p adapter-removed/fastqc

/mnt/silo/hts2024/ckappel/bin/fastqc/FastQC/fastqc \
    -o adapter-removed/fastqc \
    adapter-removed/*.fq.gz
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex06-01-04-tophat-mapping-subsets/010-adapter-removal-using-trimmomatic.sh
#!/bin/bash

mkdir -p fastq/adapter-removed

cat /mnt/silo/hts2024/ckappel/bin/Trimmomatic/Trimmomatic-0.39/adapters/*.fa | sed 's/>/\n>/' | sed '/^$/d' >adapters.fa
echo "" >>adapters.fa

for f in /mnt/silo/hts2024/data/Capsella-sequencing/RNA-seq/subsets-phred33/*.fq.gz
do
    sample=$(echo $f | sed 's/.*\///' | sed 's/\.fq\.gz//')
    echo $sample $f

    java -jar \
	 /mnt/silo/hts2024/ckappel/bin/Trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar \
	 SE \
	 -threads 4 \
	 $f \
	 fastq/adapter-removed/$sample.fq.gz \
	 ILLUMINACLIP:adapters.fa:2:30:10 \
	 MINLEN:36
    
done


### Check with fastqc
mkdir -p fastq/adapter-removed/fastqc

/mnt/silo/hts2024/ckappel/bin/fastqc/FastQC/fastqc \
    -o fastq/adapter-removed/fastqc \
    fastq/adapter-removed/*.fq.gz
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex06-01-04-tophat-mapping-subsets/020-setup-tophat.sh
#!/bin/bash

wd=$(pwd)

### Setup bowtie
if [ ! -e /mnt/silo/hts2024/ckappel/bin/bowtie2 ]
then
    
    cd /mnt/silo/hts2024/ckappel/bin
    mkdir bowtie2
    cd bowtie2
    wget https://github.com/BenLangmead/bowtie2/releases/download/v2.5.3/bowtie2-2.5.3-linux-x86_64.zip
    unzip https://github.com/BenLangmead/bowtie2/releases/download/v2.5.3/bowtie2-2.5.3-linux-x86_64.zip
    
    cd "$wd"
    
fi

### Setup TopHat2
## Change "#!/usr/bin/env python" to "#!/usr/bin/env python2" in tophat executable

if [ ! -e /mnt/silo/hts2024/ckappel/bin/tophat2 ]
then
    
    cd /mnt/silo/hts2024/ckappel/bin
    mkdir tophat2
    cd tophat2
    wget https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.1.Linux_x86_64.tar.gz
    tar xvfz tophat-2.1.1.Linux_x86_64.tar.gz
    
    cd "$wd"
    
fi







/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex06-01-04-tophat-mapping-subsets/030-tophat-mapping-of-raw-fastq-without-script.sh
/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex06-01-04-tophat-mapping-subsets/030-tophat-mapping.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bowtie2/bowtie2-2.5.3-linux-x86_64:$PATH
PATH=/mnt/silo/hts2024/ckappel/bin/tophat2/tophat-2.1.1.Linux_x86_64:$PATH
PATH=/mnt/silo/hts2024/ckappel/bin/samtools/samtools-1.19:$PATH


### Build bowtie2 genome index
mkdir -p bowtie2-index
ln -s /mnt/silo/hts2024/data/genomes/Caprub1_0/GCF_000375325.1_Caprub1_0_genomic.fna bowtie2-index/ref.fa
bowtie2-build bowtie2-index/ref.fa bowtie2-index/ref



### Build tophat2 transcriptome index
mkdir -p tophat2-index
cat /mnt/silo/hts2024/data/genomes/Caprub1_0/genomic.gff >tophat2-index/genomic.gff
tophat2 \
    -G tophat2-index/genomic.gff \
    --transcriptome-index tophat2-index/Caprub1_0_transcriptome \
    bowtie2-index/ref



### Link rawdata in fastq directory
ln -s /mnt/silo/hts2024/data/Capsella-sequencing/RNA-seq/subsets-phred33 fastq/rawdata

### tophat2 mapping
for f in fastq/*/*.fq.gz; do
    outdir=$(echo $f | sed 's/fastq/tophat/' | sed 's/\.fq\.gz//')
    mkdir -p $outdir
    sample=$(echo $f | sed 's/.*\///' | sed 's/\.fq\.gz//')
    echo $sample $f $outdir
    tophat2 -o $outdir --transcriptome-index tophat2-index/Caprub1_0_transcriptome bowtie2-index/ref $f

done


# ### Single fastq example
# fq=/mnt/silo/hts2024/ckappel/exercises/ex06-01-04-tophat-mapping-subsets/fastq/adapter-removed/RNA5-s1M1M2.fq.gz
# mkdir -p mapping/RNA5-adapter-removed
# tophat2 \
#     -o mapping/RNA5-adapter-removed \
#     --transcriptome-index tophat2-index/Caprub1_0_transcriptome \
#     bowtie2-index/ref \
#     $fq


### Index bam files for visualization in IGV and other follow-up analyses
for bam in tophat/*/*/accepted_hits.bam
do
    samtools index $bam
done

    

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex06-01-05-gene-counts/010-setup-bedtools.sh
### Setup bedtools
wd=$(pwd)
cd /mnt/silo/hts2024/ckappel/bin
mkdir bedtools
cd bedtools
wget https://github.com/arq5x/bedtools2/releases/download/v2.31.0/bedtools-2.31.0.tar.gz
tar xfvz bedtools-2.31.0.tar.gz
cd bedtools2
make

cd "$wd"

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex06-01-05-gene-counts/020-bedtools-counting.sh
#!/bin/bash
PATH=/mnt/silo/hts2024/ckappel/bin/bedtools/bedtools2/bin:$PATH

cat /mnt/silo/hts2024/data/genomes/Caprub1_0/genomic.gff | awk '{if($3=="gene") print($0)}' >genes.gff

bedtools multicov -bams \
	 /mnt/silo/hts2024/ckappel/exercises/ex06-01-04-tophat-mapping-subsets/tophat/adapter-removed/RNA5-s1M1M2/accepted_hits.bam \
	 /mnt/silo/hts2024/ckappel/exercises/ex06-01-04-tophat-mapping-subsets/tophat/adapter-removed/RNA6-s1M1M2/accepted_hits.bam \
	 /mnt/silo/hts2024/ckappel/exercises/ex06-01-04-tophat-mapping-subsets/tophat/adapter-removed/RNA7-s1M1M2/accepted_hits.bam \
	 /mnt/silo/hts2024/ckappel/exercises/ex06-01-04-tophat-mapping-subsets/tophat/adapter-removed/RNA8-s1M1M2/accepted_hits.bam \
	 -bed /mnt/silo/hts2024/data/genomes/Caprub1_0/genomic.gff \
	 >counts-bedtools.txt

/mnt/silo/hts2024/alehmann/../ckappel/exercises/ex06-01-05-gene-counts/030-htseq-counting.sh
#!/bin/bash

### Setup for htseq-count
##pip3 install --user HTseq

gtf=/mnt/silo/hts2024/data/genomes/Caprub1_0/genomic.gtf

mkdir -p htseq-count

# htseq-count \
#     -t exon -i gene \
#     -s no \
#     /mnt/silo/hts2024/ckappel/exercises/ex06-01-04-tophat-mapping-subsets/tophat/adapter-removed/RNA5-s1M1M2/accepted_hits.bam \
#     $gtf \
#     >htseq-count/RNA5-htseq-count.txt

for f in /mnt/silo/hts2024/ckappel/exercises/ex06-01-04-tophat-mapping-subsets/tophat/adapter-removed/*/accepted_hits.bam
do
    sample=$(echo $f | sed 's/\/accepted_hits.bam//' | sed 's/.*\///')
    echo $sample $f

    htseq-count \
	-t exon -i gene_id \
	-s no \
	$f \
	$gtf \
	>htseq-count/$sample-htseq-count.txt
    
done

   





