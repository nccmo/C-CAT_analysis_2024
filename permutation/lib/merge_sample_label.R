library(dplyr)
library(tidyr)
library(readr)

tmp_CODE <- commandArgs(trailingOnly = TRUE)[1]
tmp_type <- commandArgs(trailingOnly = TRUE)[2]

# read in original df
original_df <- read_tsv(paste0("output/", tmp_CODE, "/merged_", tmp_CODE, "_", tmp_type, "_samples_original_count.txt"))

# output
output_mtx <- read.table(paste0("output/", tmp_CODE, "/", tmp_type, "/merged_", tmp_CODE, "_permutation1_", tmp_type, "_samples_sample_label.txt")) %>% 
    as.matrix()
for (i in 2:200){
  tmp_mtx <- read.table(paste0("output/", tmp_CODE, "/", tmp_type, "/merged_", tmp_CODE, "_permutation", i, "_", tmp_type, "_samples_sample_label.txt")) %>% 
    as.matrix()
  output_mtx <- output_mtx + tmp_mtx
}

output_df <- output_mtx %>%
  as_tibble()

cbind(original_df, output_df) %>%
  write_tsv(paste0("output/", tmp_CODE, "/merged_", tmp_CODE, "_permutation_output_", tmp_type, "_samples.txt"))
