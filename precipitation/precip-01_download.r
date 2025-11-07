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
# Data Download Instructions ----
## --------------------------------- ##

# In order to download precipitation data for the LKC, do the following:
## 1. Go to Synoptic Data (https://synopticdata.com/)
## 2. Click "Login" (top right corner)
## 3. Click "Sign up" and create _FREE_ account (email, name, some other info)
## 4. Under "My Profile", click "Download data"
## 5. Under "1. Choose station", enter "SXWC1"
## 6. Under "2. Dates", enter desired date range
## 7. Under "3. Variables and units", check the box to the left of "Precipitation accumulated"

## --------------------------------- ##
# Data Use Instructions ----
## --------------------------------- ##

# !!!THIS IS IMPORTANT!!!
## Once you've downloaded the data,
## _you still need to move it to the right place_
## for our code to access it

# To use the data with following code files:
## 1. Run "00_setup.r" to get necessary local folders in your working directory
## 2. Moved downloaded file(s) into "data/"
## 3. Move the downloaded file(s) then into "precip/" (subfolder of "data/")

# End ----
