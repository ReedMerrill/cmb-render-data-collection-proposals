library(lubridate)
library(dplyr)
library(readr)
library(stringr)
library(readtext)
library(here)
path <- here("data/processed-responses/")
target <- "proposal-13.csv"
data <- read_csv(paste0(path, target))


# replace newlines with double newlines, unless they're part of a markdown list
  # block #nolint
replace_newlines_non_list <- function(text) {
  # Split the text by newline characters
  lines <- strsplit(text, "\n", fixed = TRUE)[[1]]

  # Initialize a variable to store the result
  result <- c()

  # Loop through each line and check if it's part of a list block
  for (i in seq_along(lines)) {
    # replace common list block characters (*, -, o) with "- ", matching on
      # trailing whitespace #nolint
    lines[i] <- gsub("^\\s*[\\*-o]\\s*", "- ", lines[i])
    if (grepl("^\\s*-\\s+", lines[i])) {
      # If the line starts with a dash (list item), leave it as is
      result <- c(result, lines[i])
    } else {
      # If it's not a list item, add a double newline
      result <- c(result, lines[i], "")
    }
  }

  # Combine the lines back into a single string with single newlines
  result_text <- paste(result, collapse = "\n")

  return(result_text)
}

test_string <- data$resp[33]
cat(test_string)

# THIS IS THE TICKET
cat(gsub("\\\n", "\\\n\\\n", test_string))

data_clean <- sapply(data, replace_newlines_non_list(x))
