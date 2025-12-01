#!/bin/bash

pdir="/home/qlyu/mydata/data/v1_multiome_ai/chrombpnet_tutorial"
outdir="$pdir/chrombpnet_model_r2/"

# use pretrained bias model to train the actual data
chrombpnet pipeline \
        -ibam $pdir/data/merged.bam \
        -d "ATAC" \
        -g  $pdir/data/downloads/hg38.fa \
        -c  $pdir/data/downloads/hg38.chrom.sizes \
        -p  $pdir/data/peaks_no_blacklist.bed \
        -n  $pdir/data/output_negatives.bed \
        -fl $pdir/data/splits/fold_0.json \
        -b  $pdir/bias_model/ENCSR868FGK_bias_fold_0.h5 \
        -o  $outdir