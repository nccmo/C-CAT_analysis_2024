#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -e log/
#$ -o log/

CODE=$1

# all samples ------------------------------------------

## original
qsub -sync y lib/run_original.sh ${CODE} "all"

## permutation (sample label)
qsub -sync y -t 1-200:1 lib/run_permutation_sample_label.sh ${CODE} "all"
qsub -sync y -t 1-200:1 lib/run_permutation_sample_label.sh ${CODE} "all"
qsub -sync y -t 1-200:1 lib/run_permutation_sample_label.sh ${CODE} "all"
qsub -sync y -t 1-200:1 lib/run_permutation_sample_label.sh ${CODE} "all"

# ## merge
qsub -sync y lib/merge_sample_label.sh ${CODE} "all"


# # non-NCC samples ------------------------------------------

## original
qsub -sync y lib/run_original.sh ${CODE} "nonNCC"

# permutation (sample label)
qsub -sync y -t 1-200:1 lib/run_permutation_sample_label.sh ${CODE} "nonNCC"
qsub -sync y -t 1-200:1 lib/run_permutation_sample_label.sh ${CODE} "nonNCC" 
qsub -sync y -t 1-200:1 lib/run_permutation_sample_label.sh ${CODE} "nonNCC" 
qsub -sync y -t 1-200:1 lib/run_permutation_sample_label.sh ${CODE} "nonNCC"

## merge
qsub -sync y lib/merge_sample_label.sh ${CODE} "nonNCC"
