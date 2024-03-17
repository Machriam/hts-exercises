#!/bin/bash

PATH=/mnt/silo/hts2024/ckappel/bin/canu/canu-2.2/bin:$PATH

canu \
    -p unknown \
    -d assembly \
    useGrid=false \
    genomeSize=1.5m \
    -pacbio /mnt/silo/hts2024/data/unknown/unknown-pacbio.fq.gz