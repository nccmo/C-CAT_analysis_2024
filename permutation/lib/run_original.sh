#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -e log/
#$ -o log/

module load R/4.1

CODE=$1
type=$2

mkdir -p "output/${CODE}/"

Rscript lib/count_original.R \
"input/merged_${CODE}_${type}_samples.txt" \
"output/${CODE}/merged_${CODE}_${type}_samples_original_count.txt"

