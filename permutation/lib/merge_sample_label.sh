#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -e log/
#$ -o log/

module load R/4.1

CODE=${1}
type=${2}

Rscript lib/merge_sample_label.R \
${CODE} \
${type}
