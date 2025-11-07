## --------------------------------------------- ##
# Precip - Download
## --------------------------------------------- ##
# Purpose:
## Provide an explantion on how to download preip data

# Load libraries
librarian::shelf(tidyverse)

# Get set up
source(file = file.path("00_setup.r"))

# Clear environment
rm(list = ls()); gc()

## --------------------------------- ##
# Load Data ----
## --------------------------------- ##

# Downloaded data has the date downloaded as part of the file name
## So just list all the files in the right folder
(local_prec <- dir(path = file.path("data", "precip"), pattern = "SXWC1"))

# Read in just the last file (if more than one exists, it's probably earlier/later downloads)
prec_v01 <- read.csv(file = file.path("data", "precip", local_prec[length(local_prec)]), row.names = NULL)

# Check structure
dplyr::glimpse(prec_v01)

# End ----
