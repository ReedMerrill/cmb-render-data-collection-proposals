# Takes a path to project proposals and outputs an R object containing a list
# of single row dataframes that each represent a single proposal. Original
# data files can have more than one proposal per CSV table, and there can be
# more than one CSV file. The R object will also contain a dataframe that maps
# variable names to their descriptions.

################################################################################
# load necessary R packages and data

library(tibble)
library(dplyr)
# remove everything in R's environment
rm(list = ls())
# get the file path to where the raw proposal data is (put it there manually)
proposals_loc <- "data/raw/"
# add the full file path (not the one relative to this project)
# getwd() returns a string that gives the full file path.
# paste0 combines the working directory and proposals_loc strings together
path <- paste0(getwd(), "/", proposals_loc)
# put all the files at the provided path that match the pattern into a list
files <- list.files(path, pattern = "\\.csv$", full.names = TRUE)
# load the list of unique IDs for proposals
load("ids.RData")
# load the proposal counter, which creates internal proposal ID codes in
# "render-proposal.qmd
load("id-num-counter.RData")
# read in all the files that were listed above. Now they're "in" R
data_list <- lapply(files, readr::read_csv)

################################################################################
# data processing

# data_list is a list of tables. Here we take each item from that list and
# remove its first two rows (which have metadata we don't need).
# Then, the rows from 3 onwards are all combined into a single table (bind_rows)
data <- tibble()
for (i in seq_along(data_list)) {
  table <- data_list[[i]][3:nrow(data_list[[i]]), ]
  data <- bind_rows(data, table)
}

# get the column names and store them as a tibble (a format that is nice later)
colnames <- c("id", colnames(data))
colnames_tibble <- as_tibble(colnames)

# iterate over the rows of "data"
for (i in 1:nrow(data)) {
  # if the ID code from row i of "data" is already in "ids", skip the rest of
  # the loop
  print(i)
  if (!(data$ResponseId[i] %in% ids)) {
    # increment the proposal counter
    counter <- counter + 1
    # process row i of "data"
    # get row i from data and put it in a new, single row table
    data_row <- data[i, ]
    # add row i's id code to "ids"
    ids <- c(ids, data_row$ResponseId[1])
    # add a counter column and make its value be current value of "counter"
    data_row <- bind_cols(tibble(counter), data_row)
    # transpose and convert back to being a tibble
    data_row <- as_tibble(t(data_row[i, ]))
    # add the column of old colnames (it is essentially *very* "long data now)
    data_row <- bind_cols(colnames_tibble, data_row)
    # make nice new column names
    data_row <- data_row |> rename(var = "value", resp = "V1")
    # output the files
    save(data_row,
         file = paste0("data/rdata/proposal-", counter, ".RData"))
  }
}
# Save new values for the counter and ids to be used next time this is run.
save(counter, file =  "id-num-counter.RData")
save(ids, file =  "ids.RData")
