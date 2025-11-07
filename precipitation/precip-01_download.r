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
# MesoWest Instructions ----
## --------------------------------- ##

# Link: https://mesowest.utah.edu/cgi-bin/droman/mesomap.cgi?state=CA&rawsflag=3

# End ----
