#!/bin/bash

pdir="/home/qlyu/mydata/data/v1_multiome_ai/v1l23"
outdir="$pdir/chrombpnet_model_l23/"

# use pretrained bias model to train the actual data
chrombpnet pipeline \
        -ifrag $pdir/data/downloads/atac_fragments_l23_P21a.tsv.gz \
        -d "ATAC" \
        -g  $pdir/data/downloads/mm10.fa \
        -c  $pdir/data/downloads/mm10.chrom.sizes \
        -p  $pdir/data/peaks_no_blacklist_10col.bed \
        -n  $pdir/data/output_negatives.bed \
        -fl $pdir/data/splits/fold_0.json \
        -b  $pdir/bias_model_l23/models/l23_bias.h5 \
        -o  $outdir
