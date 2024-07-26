# take the Qualtrics output, transpose it and output data with the variable
# name, question/description. Headings were entered manually using Excel.

rm(list = ls())
data <- readr::read_csv("data/mcgregor_7jun2024/data.csv")
desc <- tidyr::as_tibble(t(data[1, ]))
colnames <- as_tibble(colnames(data))
final <- bind_cols(colnames, desc)
readr::write_csv(final, "data/headings-and-descs.csv")
