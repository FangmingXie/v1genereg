#!/bin/bash

pdir="/home/qlyu/mydata/data/v1_multiome_ai/chrombpnet_tutorial"
outdir="$pdir/bias_model_denovo/"
fp="k562"

# train new bias model 
chrombpnet bias pipeline \
        -ibam $pdir/data/merged.bam \
        -d "ATAC" \
        -g  $pdir/data/downloads/hg38.fa \
        -c  $pdir/data/downloads/hg38.chrom.sizes \
        -p  $pdir/data/peaks_no_blacklist.bed \
        -n  $pdir/data/output_negatives.bed \
        -fl $pdir/data/splits/fold_0.json \
        -b 0.5 \
        -o $outdir \
        -fp $fp \