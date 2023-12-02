library(dplyr)
library(readr)

tmp_CODE <- commandArgs(trailingOnly = TRUE)[1]
number <- commandArgs(trailingOnly = TRUE)[2]
tmp_type <- commandArgs(trailingOnly = TRUE)[3]

# read in matrix
mtx <- read.table(paste0("input/merged_", tmp_CODE, "_", tmp_type, "_samples.txt"))

# Counting Column Pairs for Row Combinations
combinations <- combn(rownames(mtx), 2, simplify = TRUE)
counts <- numeric(ncol(combinations))

# Permutation loop
permutation_matrix <- matrix(0, nrow = ncol(combinations), ncol = 5000)

for (k in 1:5000){
  shuffled_mtx <- t(apply(mtx, 1, sample))
  
  for (i in 1:ncol(combinations)) {
    row1 <- combinations[1, i]
    row2 <- combinations[2, i]
    counts[i] <- sum(shuffled_mtx[row1,] == 1 & shuffled_mtx[row2,] == 1)
  }

    permutation_matrix[,k] <- counts
}

rownames(permutation_matrix) <- paste(combinations[1,], combinations[2,], sep = "-")

# read in original df
original_df <- read_tsv(paste0("output/", tmp_CODE, "/merged_", tmp_CODE, "_", tmp_type, "_samples_original_count.txt"))
original_count <- original_df$Counts

output_matrix <- matrix(nrow = nrow(original_df), ncol = 3)
colnames(output_matrix) <- c("higher_than_counts_p", "same_as_counts_p", "lower_than_counts_p")

for (i in 1:nrow(output_matrix)){
  output_matrix[i, 1] <- sum(permutation_matrix[i, ] > original_count[i])
  output_matrix[i, 2] <- sum(permutation_matrix[i, ] == original_count[i])
  output_matrix[i, 3] <- sum(permutation_matrix[i, ] < original_count[i])
}

# Save
write.table(output_matrix, paste0("output/", tmp_CODE, "/", tmp_type, "/merged_", tmp_CODE, "_permutation", number, "_", tmp_type, "_samples_sample_label.txt"))
