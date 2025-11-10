#' @title Pull Metadata from a Bad Header Row
#' 
#' @description Some data providers share data that are malformed (i.e., not in tidy rows/columns). To further compound this issue, some providers put critical metadata in the bad header rows above the 'real' data. We often want to retain such metadata but extracting it can be difficult to do in a scripted fashion. This function accepts a vector (can be a single column in a dataframe) and finds the match to the user-specified prefix that defines that value. Contains an optional argument for removing that prefix from the extracted value(s) if desired.
#' 
#' @param vec (character) Vector containing the offending values
#' @param prefix (character) Pattern to which to filter the provided vector
#' @param rm_prefix (logical) Whether the prefix should be removed from the returned value(s). Defaults to TRUE
#' 
pull_header <- function(vec = NULL, prefix = NULL, rm_prefix = TRUE){

  # Error checks for 'vec'
  if(is.null(vec) || is.character(vec) != T)
    stop("'vec' must be provided as a character vector")

  # Error checks for prefix
  if(is.null(prefix) || is.character(prefix) != T || length(prefix) != 1)
    stop("'prefix' must be supplied as a character vector containing one element")

  # Warning for rm_prefix
  if(is.null(rm_prefix) || is.logical(rm_prefix) != T){
    warning("'rm_prefix' must be a logical. Coercing to TRUE")
    rm_prefix <- TRUE }
  
  # Filter vector to only desired pattern match
  header_v01 <- vec[stringr::str_detect(string = vec, pattern = prefix)]

  # If the user wants to remove the prefix,
  if(rm_prefix == T){
    ## Do so
    header_v02 <- gsub(pattern = prefix, replacement = "", x = header_v01)

  # Otherwise, just get an alias for the previous value
  } else { header_v02 <- header_v01 }

  # Return the final object
  return(header_v02) }

# End ----
