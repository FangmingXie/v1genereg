#!/bin/bash

# use current wd
#$ -cwd
# error = Merged with joblog
#$ -o joblog.$JOB_ID
#$ -j y
## Edit the line below as needed:
#$ -l h_rt=20:00:00,h_data=20G
#$ -pe shared 2 
# Email address to notify
#$ -M $USER@mail
# Notify when
#$ -m bea

# load the job environment:
. /u/local/Modules/default/init/modules.sh


module load anaconda3
conda activate chrombpnet_v101

pdir="/u/home/f/f7xiesnm/project-zipursky/v1-bb/v1/data/v1_multiome_ai/chrombpnet_tutorial"

outdir="$pdir/chrombpnet_model/"

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

# $ -l gpu,L40S,cuda=1