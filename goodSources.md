- [NGS Overview](https://www.thermofisher.com/de/de/home/life-science/cloning/cloning-learning-center/invitrogen-school-of-molecular-biology/next-generation-sequencing/dna-sequencing-preparation-illumina.html)

- [Bioinformatics Software List](https://en.wikipedia.org/wiki/List_of_bioinformatics_software)

Workflow Genome Assembly:
  1. Extract DNA/RNA from the species --> different RNA expression in different parts of the species
     1. RNA must be reverse transcribed to cDNA before putting it onto a flow cell
  2. Fragment the DNA and add adapters to the fragments to attach it to a flow cell. Amplification is then to happen. When the DNA has known variant callings, then a lower coverage like 30 might be enough and for cancer 80. For Hifi reads 8 to 25 as coverage
  3. Hifi reads with Pacbio or Short reads with Illumina --> Control with Fastqc, fix with trimmomatic and/or bfc
     1. Both together can be used aswell --> Short reads for easy areas and long reads for resolving complex regions, large structural variants or repeats
  4. Assembly to contigs with bwa (short reads) or canu (long reads)
  5. Compare with reference genome with annotated proteins or make another transcriptome assembly to annotate exon/intron areas, splice
     1. Use RNA sequencing on different development stages of an organism
  6. tophat for alignment of RNA seq reads to a reference genome, bowtie2 is used as a read aligner
     1. bwa aligns DNA against a reference genome