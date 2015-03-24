

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