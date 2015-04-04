library(stringr)
library(plyr)
library(dplyr)
library(magrittr)

source("R/helper_functions.R")

dfhc_raw <- read.csv("rawdata/predict_hac_data_raw.csv",
                 as.is = TRUE)


cols_to_keep <- c("pid" = 1,
                  "respondent_gender" = 6,
                  "wildlife_near_home_yn" = 22,
                  "wildlife_near_home_tax_cat" = 24,
                  "wildlife_in_home_yn" = 26,
                  "wildlife_in_home_tax_cat" = 28,
                  "wildlife_in_home_freq_cat" = 30,
                  "wildlife_contact_cat" = 132,
                  "where_contact_happened_cat" = 134,
                  "wildlife_species_tax_cat" = 136,
                  "enter_forest_how_often_freq_cat" = 76,
                  "enter_forest_why_self_cat" = 78,
                  "self_past_consumption_wildlife_yn" = 122,
                  "people_in_community_past_consumption_wildlife_yn" = 123,
                  "self_wildlife_currently_consumed_tax_cat" = 124,
                  "community_wildlife_currently_consumed_tax_cat" = 126)

cols_raw <- dfhc_raw[, cols_to_keep]

names(cols_raw) <- names(cols_to_keep)

cols_raw <- colwise(initial_character_column_cleaning)(cols_raw)

n_responses <- dplyr::summarise_each(cols_raw, funs(n_distinct))

knitr::kable(n_responses)

descending_table(cols_raw$respondent_gender)
descending_table(cols_raw$wildlife_near_home_yn)
descending_table(cols_raw$wildlife_near_home_tax_cat)
descending_table(cols_raw$wildlife_in_home_yn)
descending_table(cols_raw$wildlife_in_home_tax_cat)
descending_table(cols_raw$wildlife_in_home_freq_cat)
descending_table(cols_raw$wildlife_contact_cat)
descending_table(cols_raw$where_contact_happened_cat)
descending_table(cols_raw$wildlife_species_tax_cat)
descending_table(cols_raw$enter_forest_how_often_freq_cat)
descending_table(cols_raw$enter_forest_why_self_cat)
descending_table(cols_raw$self_past_consumption_wildlife_yn)
descending_table(cols_raw$people_in_community_past_consumption_wildlife_yn)
descending_table(cols_raw$self_wildlife_currently_consumed_tax_cat)
descending_table(cols_raw$community_wildlife_currently_consumed_tax_cat)


descending_table <- function(x) {
  dplyr::arrange(data.frame(table(x)), -Freq)
}

descending_kable <- function(x) {
  knitr::kable(descending_table(x))
}

