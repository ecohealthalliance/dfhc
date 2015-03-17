library(stringr)
library(plyr)
library(dplyr)
library(magrittr)

dfhc <- read.csv("rawdata/predict_hac_data_raw.csv",
                 as.is = TRUE)

colnames(dfhc)

# I'll test functions on the animal column and on age of males in household.

animals <- dfhc[, 24]

# To Lowercase

animals_lower <- tolower(animals)

animals_1 <- animals_lower[1]

# Tokenize

# First we remove spaces from the start and end.
animals_trimmed <- unlist(strsplit(animals_lower, split = "^\\s+|\\s+$"))
# Then we tokenize on commas and the word "and", also removing interior spaces.
animals_tokenized <- strsplit(animals_trimmed, split = ",\\s*|\\s*(\\band?\\b)\\s*")


all_animals <- as.data.frame(table(unlist(animals_tokenized)))
arrange(all_animals, -Freq)

animal_names <- as.character(all_animals[, 1])

name_distances <- as.matrix(adist(animal_names))
dimnames(name_distances) <- list(animal_names, animal_names)

name_distances <- matrix(adist(animal_names), dimnames = list(animal_names, animal_names))
# This is silly, I should just do it manually.

animals_tokenized
