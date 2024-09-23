# One-time script to fix newlines in the Fall 2024 proposals.

library(dplyr)
rm(list = ls())
path <- paste0(getwd(), "/data/processed-responses")
files <- list.files(path, pattern = "\\.csv$", full.names = TRUE)
data_list <- lapply(files, readr::read_csv)

str_ <- data_list[[1]][[33,2]]
str_
cat(str_)
gsub("\\\n", "\\\n\\\n", str_) |> cat()

add_newlines <- function(data) {
  for (i in seq_len(nrow(data))) {
    # everything in the resp column
    data[[i, 2]] <- gsub("\\\n", "\\\n\\\n", data[[i, 2]])
  }
  return(data)
}

seq_along(data_list)

for (i in seq_along(data_list)) {
  data <- data_list[[i]]
  data <- add_newlines(data)
  readr::write_csv(data, paste0(getwd(), "/data/tmp-processed-responses/proposal-", i, ".csv"))
}
