#!/bin/bash

fragments="fragments.tsv.gz"
barcodes="whitelist_barcodes.txt"
subsetfragments="out.tsv.gz"

zcat $fi | head | \
    awk 'FNR==NR {array[$1]=1; next} array[$4]' $barcodes - | \
    gzip > $subsetfragments 
