## ------------------------------------------------ ##
# Data Management (Climate) - Setup
## ------------------------------------------------ ##
# Purpose:
## Do setup steps that are necessary for at least one of the datasets in this category

# Clear environment
rm(list = ls()); gc()

## ----------------------------- ##
# Make Folders ----
## ----------------------------- ##

# Create necessary folders
dir.create(path = file.path("data", "precip"), showWarnings = F, recursive = T)
dir.create(path = file.path("graphs"), showWarnings = F)

# End ----
