## ------------------------------------------------ ##
# Upload Data (to Google Drive)
## ------------------------------------------------ ##
# Purpose:
## Upload code outputs to various parts of the LKC Shared Drive

# For the code to talk to Drive, you need to tell R who you are (in Google)
## Work through the following tutorial to do so
### https://lter.github.io/scicomp/tutorial_googledrive-pkg.html
## Alternatively, see the help file for the following function:
### `?googledrive::drive_auth`

# Load libraries
# install.packages("librarian")
librarian::shelf(tidyverse, googledrive)

# Get set up
source("00_setup.r")

# Clear environment
rm(list = ls()); gc()

## ----------------------------- ##
# Download LFM Data ----
## ----------------------------- ##

# Identify the relevant local files
(precip_data <- dir(path = file.path("data", "precip"), pattern = "precipitation"))

# Identify link to destination Drive folder
precip_drive <- googledrive::as_id("https://drive.google.com/drive/folders/1NlMRJSE5KQUdkUE_Nl4wcFansQsI_tT3")

# Upload data to that folder
purrr::walk(.x = precip_data, 
  .f = ~ googledrive::drive_upload(media = file.path("data", "precip", .x),
  overwrite = T, path = precip_drive))
 
# End ----
