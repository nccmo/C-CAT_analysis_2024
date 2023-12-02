#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -e log/
#$ -o log/

module load R/4.1

CODE=${1}
type=${2}

mkdir -p "output/${CODE}/${type}/"

if [ -e "output/${CODE}/${type}/merged_${CODE}_permutation${SGE_TASK_ID}_${type}_samples_sample_label.txt" ]; then
  exit
fi

Rscript lib/run_permutation_sample_label.R \
${CODE} \
${SGE_TASK_ID} \
${type}
