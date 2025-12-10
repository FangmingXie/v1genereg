#!/bin/bash


sample="P21a"
dir="/home/qlyu/mydata/data/v1_multiome_ai/common_data/v1multiome"

# get all samples
mapfile -d '' allsamples < \
    <(find $dir/raw -mindepth 1 -maxdepth 1 -type d -printf "%f\0" | sort -z)
echo ${allsamples[@]}

# loop over all samples
i=0
for sample in "${allsamples[@]}"; do
    echo $i, $sample
    i=$((i+1))

    # one sample
    fragments="$dir/raw/${sample}/atac_fragments.tsv.gz"
    barcodes="$dir/barcodes_l23/barcodes_l23_${sample}.txt"
    outfragments="$dir/frag_l23/atac_fragments_l23_${sample}.tsv.gz"

    zcat $fragments | \
        awk 'FNR==NR {array[$1]=1; next} array[$4]' $barcodes - | \
        grep "^chr" | \
        gzip > $outfragments

    # break
done
