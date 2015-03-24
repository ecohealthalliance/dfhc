library(stringr)
library(plyr)
library(dplyr)
library(magrittr)

dfhc <- read.csv("rawdata/predict_hac_data_raw.csv",
                 as.is = TRUE)

dfhc <- dfhc[1:406, ]

ages_m <- dfhc[, 12]
names(ages_m) <- dfhc[, 1]

ages_f <- dfhc[, 14]
names(ages_f) <- dfhc[, 1]


# To Lowercase, replace blanks. Maybe this should be a function

ages_m[ages_m == ""] <- "blank"
ages_m <- tolower(ages_m)

ages_f[ages_f == ""] <- "blank"
ages_f <- tolower(ages_f)


# Load functions
source("scratch/2015-03-24_functions.R")

ages_m_df <- ages_m %>%
  tokenized_list %>%
  tokenized_list_to_df_rows %>%
  mutate(ages_clean = clean_age_column(var_orig),
         gender = "male")

ages_f_df <- ages_f %>%
  tokenized_list %>%
  tokenized_list_to_df_rows %>%
  mutate(ages_clean = clean_age_column(var_orig),
         gender = "female")

ages_df <- rbind(ages_m_df, ages_f_df)

summary(ages_df)

write.csv(ages_df, "out/household_ages.csv", row.names = FALSE)

# Note: this code assumes that all instances of one age in a household of "0" are non-answers.