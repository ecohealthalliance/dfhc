library(stringr)
library(plyr)
library(dplyr)
library(magrittr)

dfhc <- read.csv("rawdata/predict_hac_data_raw.csv",
                 as.is = TRUE)

dfhc <- dfhc[1:406, ]

colnames(dfhc)

# I'll test functions on the animal column and on age of males in household.

animals <- dfhc[, 24]
names(animals) <- dfhc[, 1]
animals[animals == ""] <- "blank"

# To Lowercase

animals_lower <- tolower(animals)

# Tokenize
ages_tokenized <- strsplit(ages_lower, split = "^\\s+|\\s*,\\s*|\\s*(\\band?\\b)\\s*|\\s+$")

all_animals <- as.data.frame(table(unlist(animals_tokenized)))
arrange(all_animals, -Freq)


animal_replace = c("rodents" = "rodent",
                   "rats" = "rodent",
                   "shrew-faced ground squirrel" = "rodent",
                   "small mammal" = "small mammal",
                   "foxes" = "small mammal",
                   "bats" = "bat",
                   "bird" = "bird",
                   "birds" = "bird",
                   "primate" = "primate",
                   "reptile" = "reptile",
                   "snake" = "reptile",
                   "snakes" = "reptile",
                   "other" = "other",
                   "elephants" = "other",
                   "yellow trotted" = "other",
                   "not answered" = "not answered",
                   "skipped" = "skipped")


animals_revalue <- llply(.data = animals_tokenized, .fun = revalue, replace = animal_replace, warn_missing = FALSE)

all_animals <- as.data.frame(table(unlist(animals_revalue)))
arrange(all_animals, -Freq)

animals_revalue

convert_vector_to_logical_df <- function(x) {
  x <- t(as.matrix(x))
  colnames(x) <- x[1, ]
  x[1, ] <- TRUE
  mode(x) <- "logical"
  x <- as.data.frame(x)
}

animals_dfs <- llply(animals_revalue, convert_vector_to_logical_df)

animals_dfs_2 <- llply(seq_along(animals_dfs), function(i) {
  PID <- names(animals_dfs)[i] 
  cbind(PID, animals_dfs[[i]], stringsAsFactors = FALSE)
})


animals_combined <- bind_rows(animals_dfs_2)
animals_combined[is.na(animals_combined)] <- FALSE

animals_combined

write.csv(animals_combined, "out/animals_near_house.csv", row.names = FALSE)




# Distance matrix using adist

animal_names <- as.character(all_animals[, 1])

name_distances <- as.matrix(adist(animal_names))
dimnames(name_distances) <- list(animal_names, animal_names)

name_distances <- matrix(adist(animal_names), dimnames = list(animal_names, animal_names))
# This is silly, I should just do it manually.

animals_tokenized
