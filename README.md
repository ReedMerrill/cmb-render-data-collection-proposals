Code for processing and rendering raw CSV files containing responses to the Qualtrics survey called "CMB Data Collection Proposals".

# Workflow

1. Download data
   1. Go to "Data and Analysis" > "Export & Import" > "Export Data..." > "CSV" and select "Use numeric values"
2. Move the downloaded CSV file into the "data/raw/" folder of this repository.
3. Run "pre-processing.R"

Now there will be new files in "data/rdata".

4. Run "render-proposals.R", which iterates through the files in "data/rdata/", using the individual proposal data that each RData file contains to populate a rendered PDF file using "render.qmd" to specify the actual contents and formatting of the PDFs.

# Please note:

- "get-descriptions.R" is a one-time-use script that was used to generate "headings-and-descs.csv", which was then also manually editted in Excel. If the Qualtrics survey questions every change, then it will need to be re-run and "headings-and-descs.csv" re-edited to have a "heading" column again. "Heading" is just nicely formatted short names for each question of the survey.
- If the Qualtrics survey ever changes: refer to the above note, and ensure that render.qmd has new code to account for any changes in the order or amount of questions in the survey.
- This repo ignores all the files under "data/", so rendered PDFs should be permanently stored elsewhere and if historical proposal data is required it must be downloaded from Qualtrics.
  - all ".git-keep" files should stay, but don't do anything except ensure that the repo's full file structure is pushed to Github.
- It's best not to delete "ids.txt" or "id-num-counter.txt" :)
- The scripts have a general description of their purpose commented at the beginning of each file, and comments throughout to assist with any debugging or modifications that may be required.
