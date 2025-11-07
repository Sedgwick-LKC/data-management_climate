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

# Identify just the last file (if more than one exists, it's probably earlier/later downloads)
(raw_prec <- file.path("data", "precip", local_prec[length(local_prec)]))

# The downloaded table as-is is malformed so we need to be tricky about reading it in
prec_v01 <- data.frame("x" = readLines(con = raw_prec))

# Check the first few rows of the data
head(prec_v01, n = 10)

# Need to ditch some dumb/bad header rows
prec_v02 <- prec_v01 |> 
  dplyr::filter(stringr::str_detect(string = x, pattern = "#") != T) |> 
  dplyr::filter(x %in% c("Station_ID,Date_Time,precip_accum_set_1", ",,Millimeters") != T)

# Re-check some rows
head(prec_v02)

## --------------------------------- ##
# Generic Column Creation ----
## --------------------------------- ##

# Let's get all the columns that we need
prec_v03 <- prec_v02 |> 
  # Separate out the columns we want
  tidyr::separate_wider_delim(cols = x, delim = ",",
                              names = c("station", "date_time", "precip.accum_mm")) |> 
  # Fix column class issues
  dplyr::mutate(precip.accum_mm = as.numeric(precip.accum_mm)) |> 
  # Add some columns for info we stripped out of the bad header rows
  dplyr::mutate(elev_ft = 1402.0,
                lat_deg = 34.680630,
                lon_deg = -120.047440,
                .after = station) |> 
  # Convert elevation to meters
  dplyr::mutate(elevation_m = (elev_ft / 3.281),
                .after = elev_ft) |> 
  dplyr::select(-elev_ft)

# Check structure
dplyr::glimpse(prec_v03)

## --------------------------------- ##
# Date/Time Wrangling ----
## --------------------------------- ##

# Need to get date/time into a use-able format
prec_v04 <- prec_v03 |> 
  # Strip out date 
  dplyr::mutate(date = as.Date(stringr::str_sub(string = date_time,
                                                start = 1, end = 10)),
                .before = date_time) |> 
  # Remove time column
  dplyr::select(-date_time) |> 
  # And keep only unique rows
  dplyr::distinct()
  
# Check structure
dplyr::glimpse(prec_v04)

## --------------------------------- ##
# Export ----
## --------------------------------- ##

# Make a final object
prec_v99 <- prec_v04

# Re-check structure
dplyr::glimpse(prec_v99)

# Generate a nice file name
(tidy_prec <- paste0("precipitation_", min(prec_v99$date, na.rm = T), "_", max(prec_v99$date, na.rm = T), ".csv"))

# Export this locally
write.csv(x = prec_v99, row.names = F, na = '',
          file = file.path("data", "precip", tidy_prec))

# End ----
