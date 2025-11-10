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

# Load custom functions
purrr::walk(.x = dir(path = file.path("tools"), pattern = "fxn_"),
            .f = ~ source(file = file.path("tools", .x)))

## --------------------------------- ##
# Load Data ----
## --------------------------------- ##

# Downloaded data has the date downloaded as part of the file name
## So just list all the files in the right folder
(local_prec <- dir(path = file.path("data", "precip"), pattern = "SXWC1"))

# Identify just the last file (if more than one exists, it's probably earlier/later downloads)
(raw_prec <- file.path("data", "precip", local_prec[length(local_prec)]))

# The downloaded data are malformed coming from Synoptic Data (bad header rows)
## so we need to use a custom function to load it and get it into real rows/columns
prec_v01 <- parse_synoptic(csv = raw_prec)

# Check structure
dplyr::glimpse(prec_v01)

# Let's go ahead and rename these slightly
prec_v02 <- prec_v01 |> 
  # Make them lowercase
  dplyr::rename_with(.fn = tolower) |> 
  # Simplify precip column name
  dplyr::rename(precip.accum_mm = precip_accum_set_1_millimeters)

# Check structure
dplyr::glimpse(prec_v02)

## --------------------------------- ##
# Date/Time Wrangling ----
## --------------------------------- ##

# Need to get date/time into a use-able format
prec_v03 <- prec_v02 |> 
  # Strip out date 
  dplyr::mutate(date = as.Date(stringr::str_sub(string = date_time,
                                                start = 1, end = 10)),
                .before = date_time) |> 
  # Remove time column
  dplyr::select(-date_time) |> 
  # And keep only unique rows
  dplyr::distinct()
  
# Check structure
dplyr::glimpse(prec_v03)

## --------------------------------- ##
# Export ----
## --------------------------------- ##

# Make a final object
prec_v99 <- prec_v03

# Re-check structure
dplyr::glimpse(prec_v99)

# Generate a nice file name
(tidy_prec <- paste0("precipitation_", min(prec_v99$date, na.rm = T), "_", max(prec_v99$date, na.rm = T), ".csv"))

# Export this locally
write.csv(x = prec_v99, row.names = F, na = '',
          file = file.path("data", "precip", tidy_prec))

# End ----
