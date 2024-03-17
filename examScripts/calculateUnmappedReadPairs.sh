#!/bin/bash

# 1: read paired (0x1)
# 2: read mapped in proper pair (0x2)
# 4: read unmapped (0x4)
# 8: mate unmapped (0x8)
# 16: read reverse strand (0x10)
# 32: mate reverse strand (0x20)
# 64: first in pair (0x40)
# 128: second in pair (0x80)
# 256: not primary alignment (0x100)
# 512: read fails platform/vendor quality checks (0x200)
# 1024: read is PCR or optical duplicate (0x400)
# 2048: supplementary alignment (0x800)

# -f: Only include reads with all of the FLAGs in INT present [0].
# -F: Do not include reads with any of the FLAGs in INT present [0].
# -q: Skip alignments with MAPQ smaller than INT [0].

samtools view -f 8 -c "$2" "$1"