#!/bin/bash


pdir="/home/qlyu/mydata/data/v1_multiome_ai/chrombpnet_tutorial"
idir="$pdir/data/downloads"
odir="$pdir/data"

# ATAC reads (mappied and cleaned)
# merge, sort, index bam files
# filtering (done before)
echo "prep bam"
samtools merge -f $idir/merged_unsorted.bam $idir/rep1.bam $idir/rep2.bam $idir/rep3.bam
samtools sort -@4 $idir/merged_unsorted.bam -o $odir/merged.bam
samtools index $odir/merged.bam


# ## peak regions
# # peak calling (done before)
# # removed overlap from blacklist
echo "prep peaks"
bedtools slop -i $idir/blacklist.bed.gz -g $idir/hg38.chrom.sizes -b 1057 > $idir/temp.bed
bedtools intersect -v -a $idir/overlap.bed.gz -b $idir/temp.bed  > $odir/peaks_no_blacklist.bed

# ## define folds (train, val, test) 
echo "define folds"
head -n 24 $idir/hg38.chrom.sizes > $idir/hg38.chrom.subset.sizes
mkdir $odir/splits
chrombpnet prep splits \
    -c  $idir/hg38.chrom.subset.sizes \
    -tcr chr1 chr3 chr6 \
    -vcr chr8 chr20 \
    -op $odir/splits/fold_0

# ## define nonpeak regions
echo "prep nonpeaks"
chrombpnet prep nonpeaks \
    -g  $idir/hg38.fa \
    -c  $idir/hg38.chrom.sizes \
    -br $idir/blacklist.bed.gz \
    -p  $odir/peaks_no_blacklist.bed \
    -fl $odir/splits/fold_0.json \
    -o  $odir/output
