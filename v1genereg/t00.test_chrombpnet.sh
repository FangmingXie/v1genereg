#!/bin/bash

# module load anaconda3
# conda activate chrombpnet_v101
datadir="/u/home/f/f7xiesnm/project-zipursky/v1-bb/v1/data"
outdir="$datadir/v1_multiome_ai/test0"

ffrag="$datadir/v1_multiome/atac_fragments/raw/P21a/atac_fragments.tsv.gz"
fpeaks="$datadir/v1_multiome/atac_fragments/frag_bed_v2/processed_peaks/consensus_peaks_L23.bed"
fnonpeaks="$datadir/genome/mm10/mm10-blacklist.v2.sorted.bed"

ffold0="$datadir/genome/mm10/folds/fold_0.json"
fgenome="$datadir/genome/mm10/mm10.fna"
fgenomesize="$datadir/genome/mm10/mm10.sorted.chrom.sizes"


chrombpnet bias pipeline \
  -ifrag $ffrag \
  -d "ATAC" \
  -g $fgenome \
  -c $fgenomesize \
  -p $fpeaks \
  -n $fnonpeaks \
  -fl $ffold0 \
  -b 0.5 \
  -o $outdir \


  