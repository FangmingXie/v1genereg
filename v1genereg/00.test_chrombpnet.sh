#!/bin/bash

# module load anaconda3
# conda activate chrombpnet_v101

foutdir=""
ffrag=""
fpeakas=""
fnonpeaks=""
ffold0=""

fgenome=""
fgenomesize=""

chrombpnet bias pipeline \
  -ifrag /path/to/input.tsv \ # only one of ibam, ifrag or itag is accepted
  -d "ATAC" \
  -g /path/to/hg38.fa \
  -c /path/to/hg38.chrom.sizes \ 
  -p /path/to/peaks.bed \
  -n /path/to/nonpeaks.bed \
  -fl /path/to/fold_0.json \
  -b 0.5 \ 
  -o path/to/output/dir/ \


  