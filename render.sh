#! /bin/bash

# List all CSV files in the directory
csv_files=$(find data/processed -type f -name "*.csv")

n_files="${#csv_files[@]}"

echo "$n_files"

# Iterate over each CSV file and perform actions (e.g., print filename, process data)
for csv_file in $csv_files; do
    echo "Processing: $csv_file"

    # Example: Print the first line of each CSV
    head -n 1 "$csv_file"

    # You can replace this with your desired actions, such as using tools like awk, sed, or Python
    # to process the CSV data
done
