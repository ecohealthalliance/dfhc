# Functions to help in cleaning the DFHC Excel spreadsheet.


initial_character_column_cleaning <- function(x) {
  x <- tolower(x)
  x[x == ""] <- "blank"
  return(x)
}


replace_values <- function(x, values) {
  x <- llply(.data = x,
             .fun = revalue,
             replace = values,
             warn_missing = FALSE)
  return(x)
}


list_of_character_vectors_to_named_logical_df <- function(x) {
  x <- t(as.matrix(x))
  colnames(x) <- x[1, ]
  x[1, ] <- TRUE
  mode(x) <- "logical"
  x <- as.data.frame(x)
}


bind_list_names_to_df_columns <- function(x) {
    x <- llply(seq_along(x), function(i) {
    PID <- names(x)[i] 
    cbind(PID, x[[i]], stringsAsFactors = FALSE)
  })
}


list_of_character_vectors_to_logical_matrix <- function(x) {
  x <- llply(x, list_of_character_vectors_to_named_logical_df)

  x <- bind_list_names_to_df_columns(x)

  x <- bind_rows(x)

  x[is.na(x)] <- FALSE

  return(x)
}


tokenized_list <- function(x) {
  strsplit(x, split = "^\\s+|\\s*,\\s*|\\s*(\\band?\\b)\\s*|\\s+$")
}


tokenized_list_to_df_rows <- function(x) {
  require(plyr)

  df <- ldply(seq_along(x), function(i) {
    var_orig <- x[[i]]
    PID <- names(x[i])

    df_part <- data.frame(PID, var_orig, stringsAsFactors = FALSE)
  })

  return(df)
}


clean_age_column <- function(x) {
  # Identify "months" in columns and clean them
  x[grep("m", x)] <- as.numeric(gsub("[A-Za-z]| ", "", x[grep("m", x)])) / 12

  # Strip all characters and spaces
  x <- gsub("[A-Za-z]| ", "", x)

  # Convert "0" to NA
  x[x == "0" | x == "" | x == "-"] <- NA

  x <- as.numeric(x)

  return(x)
}