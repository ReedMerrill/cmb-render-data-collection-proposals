rm(list = ls())
# get the file path to where the raw proposal data is (put it there manually)
proposals_loc <- "data/processed/"
# add the full file path (not the one relative to this project)
# getwd() returns a string that gives the full file path.
# paste0 combines the working directory and proposals_loc strings together
path <- paste0(getwd(), "/", proposals_loc)
# put all the files at the provided path that match the pattern into a list
files <- list.files(path, pattern = "\\.csv$", full.names = TRUE)
#read in all the files that were listed above. Now they're "in" R
data_list <- lapply(files, readr::read_csv)
