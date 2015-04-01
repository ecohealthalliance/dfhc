library(stringr)
library(plyr)
library(dplyr)
library(magrittr)

source("scratch/2015-03-24_functions.R")

dfhc <- read.csv("rawdata/predict_hac_data_raw.csv",
                 as.is = TRUE)

dfhc <- dfhc[1:406, ]

animals <- dfhc[, 24]
names(animals) <- dfhc[, 1]

animals <- initial_character_column_cleaning(animals)

animals <- tokenized_list(animals)

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

animals <- replace_values(animals, animal_replace)

animals <- list_of_character_vectors_to_logical_matrix(animals)