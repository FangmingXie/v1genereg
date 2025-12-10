#!/bin/bash


pdir="/home/qlyu/mydata/data/v1_multiome_ai/v1l23"
idir="$pdir/data/downloads"
odir="$pdir/data"

# ## peak regions
# # peak calling (done before)
# # removed overlap from blacklist
echo "prep peaks"
bedtools slop -i $idir/mm10.blacklist.bed -g $idir/mm10.chrom.sizes -b 1057 > $idir/temp.bed
bedtools intersect -v -a $idir/consensus_peaks_L23.bed -b $idir/temp.bed  > $odir/peaks_no_blacklist.bed

awk 'BEGIN {OFS="\t"} {print $1, $2, $3, $4, ".", ".", ".", ".", ".", 250}' \
    $odir/peaks_no_blacklist.bed \
    > $odir/peaks_no_blacklist_10col.bed

# ## define folds (train, val, test) 
echo "define folds"
head -n 21 $idir/mm10.chrom.sizes > $idir/mm10.chrom.subset.sizes
mkdir $odir/splits
chrombpnet prep splits \
    -c  $idir/mm10.chrom.subset.sizes \
    -tcr chr1 chr3 chr6 \
    -vcr chr8 chr19 \
    -op $odir/splits/fold_0

# ## define nonpeak regions
echo "prep nonpeaks"
chrombpnet prep nonpeaks \
    -g  $idir/mm10.fa \
    -c  $idir/mm10.chrom.sizes \
    -br $idir/mm10.blacklist.bed \
    -p  $odir/peaks_no_blacklist_10col.bed \
    -fl $odir/splits/fold_0.json \
    -o  $odir/output
