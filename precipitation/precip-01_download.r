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

# In order to download precipitation data for the LKC, do the following:
## 1. Go here: https://mesowest.utah.edu/cgi-bin/droman/mesomap.cgi?state=CA&rawsflag=3
## 2. Double check that "Region/Zone" (in top left corner) is set to "CALIFORNIA"
## 3. Set "Network" to "RAWS"
## 4. Click "Refresh Map" button
## 5. Zoom in on Santa Barbara
## 6. Click on station "SXWC1"
### Station is east of Lompoc, north of Santa Barbara (in Santa Ynez region)
## 7. Select "Precip" button in "View" options
## 8. Click "Download Data" (beneath the scatterplot)

# End ----
