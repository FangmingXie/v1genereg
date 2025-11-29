#!/bin/bash

module load anaconda3
conda activate chrombpnet_v101

datadir="/u/home/f/f7xiesnm/project-zipursky/v1-bb/v1/data/v1_multiome_ai/chrombpnet_tutorial/data/downloads"
outdir="/u/home/f/f7xiesnm/project-zipursky/v1-bb/v1/data/v1_multiome_ai/chrombpnet_tutorial/data"

## ATAC reads (mappied and cleaned)
# merge, sort, index bam files
# filtering (done before)
# samtools merge -f $datadir/merged_unsorted.bam $datadir/rep1.bam $datadir/rep2.bam $datadir/rep3.bam
# samtools sort -@4 $datadir/merged_unsorted.bam -o $outdir/merged.bam
# samtools index $outdir/merged.bam


## peak regions
# peak calling (done before)
# removed overlap from blacklist
bedtools slop -i $datadir/blacklist.bed.gz -g $datadir/hg38.chrom.sizes -b 1057 > $datadir/temp.bed
bedtools intersect -v -a $datadir/overlap.bed.gz -b $datadir/temp.bed  > $outdir/peaks_no_blacklist.bed

## define folds (train, val, test) 
head -n 24 $datadir/hg38.chrom.sizes > $datadir/hg38.chrom.subset.sizes
mkdir $outdir/splits
chrombpnet prep splits \
    -c  $datadir/hg38.chrom.subset.sizes \
    -tcr chr1 chr3 chr6 \
    -vcr chr8 chr20 \
    -op $outdir/splits/fold_0

## define nonpeak regions
chrombpnet prep nonpeaks \
    -g  $datadir/hg38.fa \
    -c  $datadir/hg38.chrom.sizes \
    -br $datadir/blacklist.bed.gz \
    -p  $outdir/peaks_no_blacklist.bed \
    -fl $outdir/splits/fold_0.json \
    -o  $outdir/output
