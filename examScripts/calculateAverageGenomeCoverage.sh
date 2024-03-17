#!/bin/bash

samtools depth -r "$1" "$2" | awk '{sum+=$3} END {print sum/NR}'