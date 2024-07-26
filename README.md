Code for processing and rendering raw CSV files containing responses to the Qualtrics survey called "CMB Data Collection Proposals".

# Workflow

1. Download data
   1. Go to "Data and Analysis" > "Export & Import" > "Export Data..." > "CSV" and select "Use numeric values"
2. Move the downloaded CSV file into the "data/raw/" folder of this repository.
3. Run "pre-processing.R"

Now there will be new files in "data/rdata".

4. Run "render-proposals.R", which iterates through the files in "data/rdata/", using the individual proposal data that each RData file contains to populate a rendered PDF file using "render.qmd" to specify the actual contents and formatting of the PDFs.

# Please note:

- This repo ignores all data files, so rendered PDFs should be permanently stored elsewhere and if historical proposal data is required it must be downloaded from Qualtrics.
- The scripts have a general description of their purpose commented at the beginning of each file, and comments throughout to assist with any debugging or modifications that may be required.
