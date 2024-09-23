#! /bin/bash

# Get CSV file paths and iterate over them:
# 1. Extract the index from the .csv file name
# 2. Set the qmd file name using the index from step 1
# 3. Copy the template (render.qmd). All subsequent actions are done on this copy.
# 4. use sed to inject the correct csv path into the .qmd file
# 5. render the .qmd file using Quarto

# List all CSV files in the directory
csv_dir="../data/processed-responses"
# breaks if there are spaces in the filename
csv_files=$(ls $csv_dir)

n_files=${#csv_files[@]}

# Iterate over each CSV file 
for csv_file in $csv_files; do

  # get the filename
  csv_name=$(basename $csv_file)
  echo "$csv_name"
  # get index from that file name
  index=$(echo "$csv_name" | grep -o '[0-9]\+')
  echo "$index"
  # qmd file's name, based on index of current proposal CSV
  qmd_name="proposal-${index}.qmd"
  # create a copy of QMD template
  cp render.qmd "$qmd_name"
  # set qmd file to render using the current CSV (on the 18th line)
  # Google search "sed" to learn more
  sed -i "" "18s/.*/target <- \"${csv_name}\"/g" "$qmd_name"
  # render to pdf using Quarto
  quarto render "proposal-${index}.qmd"

done
