#' @title Parse CSV from Synoptic Data into Tidy Format
#' 
#' @description Synoptic Data is a useful source of meteorological data for the La Kretz Center and Sedgewick Reserve. However, their data portal returns malformed, untidy data that is not machine readable as a table. So, this function accepts the download as-is and does the needed wrangling to get it into a format with standard rows and columns. A number of pieces of important metadata are stored in bizarre header rows above the 'real' data from Synoptic Data so these values are extracted and added back as columns so they can be actually used.
#' 
#' @param csv (character) File name / path of the _raw_ download from Synoptic Data
#' 
parse_synoptic <- function(csv = NULL){

  # Error checks for 'csv'
  if(is.null(csv) || is.character(csv) != T || length(csv) != 1)
    stop("'csv' must be a single file name as a character")

  # Read in data
  df_v01 <- data.frame("x" = readLines(con = csv))

  # Grab Some of the values stored only in the bizarre header rows 
  ex_stn <- pull_header(vec = df_v01$x, prefix = "# STATION: ")
  ex_name <- pull_header(vec = df_v01$x, prefix = "# STATION NAME: ")
  ex_lat <- pull_header(vec = df_v01$x, prefix = "# LATITUDE: ")
  ex_lon <- pull_header(vec = df_v01$x, prefix = "# LONGITUDE: ")
  ex_elv <- pull_header(vec = df_v01$x, prefix = "# ELEVATION \\[ft\\]: ")
  ex_state <- pull_header(vec = df_v01$x, prefix = "# STATE: ")

  # Now ditch the bad header rows
  df_v02 <- dplyr::filter(df_v01, stringr::str_detect(string = x, pattern = "#") != T)

  # Put data into 'real' columns
  df_v03 <- df_v02 |> 
    tidyr::separate_wider_delim(cols = x, delim = ",", names = c("a", "b", "c"))

  # Identify what should be the column names
  real_names <- as.character(df_v03[1, ])
  real_names[3] <- paste0(real_names[3], "_", df_v03[2, 3])

  # Fix column names
  df_v04 <- setNames(object = df_v03, nm = real_names)

  # Remove column name rows now that we have them as actual column names
  df_v05 <- dplyr::filter(df_v04, Station_ID %in% c(ex_stn))

  # Add in columns for the metadata that we extracted earlier
  df_v06 <- df_v05 |> 
    dplyr::mutate(
      Station_Name = ex_name,
      Latitude_deg = as.numeric(ex_lat),
      Longitude_deg = as.numeric(ex_lon),
      Elevation_m = (as.numeric(ex_elv) / 3.281),
      .after = Station_ID)

  # Return that version of the data
  return(df_v06) }

# End ----
