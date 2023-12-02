library(dplyr)
library(readr)
library(utils)

input <- commandArgs(trailingOnly = TRUE)[1]
output <- commandArgs(trailingOnly = TRUE)[2]

# read in matrix
mtx <- read.table(input)
mtx <- as.matrix(mtx)

# Counting Column Pairs for Row Combinations
combinations <- combn(rownames(mtx), 2, simplify = TRUE)
counts <- numeric(ncol(combinations))

for (i in 1:ncol(combinations)) {
  row1 <- combinations[1, i]
  row2 <- combinations[2, i]
  counts[i] <- sum(mtx[row1,] == 1 & mtx[row2,] == 1)
}
  
result_df <- tibble(Combinations1 = combinations[1,], 
                    Combinations2 = combinations[2,], 
                    Permutation_num = "original",
                    Counts = counts)

# Save
result_df %>% 
  write_tsv(output)
