library(stringr)
library(plyr)
library(dplyr)
library(magrittr)

dfhc <- read.csv("rawdata/predict_hac_data_raw.csv",
                 as.is = TRUE)

dfhc <- dfhc[1:406, ]

colnames(dfhc)

# I'll test functions on the animal column and on age of males in household.

ages <- dfhc[, 12]
names(ages) <- dfhc[, 1]
ages[ages == ""] <- "blank"

# To Lowercase

ages_lower <- tolower(ages)

# Tokenize

# # First we remove spaces from the start and end.
# ages_trimmed <- unlist(strsplit(ages_lower, split = "^\\s+|\\s+$"))
# # Then we tokenize on commas and the word "and", also removing interior spaces.
# ages_tokenized <- strsplit(ages_trimmed, split = ",\\s*|\\s*(\\band?\\b)\\s*")


ages_tokenized <- strsplit(ages_lower, split = "^\\s+|\\s*,\\s*|\\s*(\\band?\\b)\\s*|\\s+$")




all_ages <- as.data.frame(table(unlist(ages_tokenized)))
arrange(all_ages, -Freq)

ages_tokenized

ages_df <- ldply(seq_along(ages_tokenized), function(i) {
  ages_orig <- ages_tokenized[[i]]
  PID <- names(ages_tokenized[i])

  df <- data.frame(PID, ages_orig, stringsAsFactors = FALSE)
})

x <- ages_df$ages_orig

clean_ages <- function(x) {
  # Identify "months" in columns and clean them
  x[grep("m", x)] <- as.numeric(gsub("[A-Za-z]| ", "", x[grep("m", x)])) / 12

  # Strip all characters and spaces
  x <- gsub("[A-Za-z]| ", "", x)

  # Convert "0" to NA
  x[x == "0" | x == "" | x == "-"] <- NA

  x <- as.numeric(x)
}

ages_df$ages_clean <- clean_ages(ages_df$ages_orig)