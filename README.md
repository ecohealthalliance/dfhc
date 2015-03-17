# dfhc
Deep Forest Human Contact datasets

## Data flow

- Excel > CSV (exported via Excel, converted to UTF-8 with Sublime Text. I had to manually save `predict_hac_data_raw.csv` with UTF-8 encoding, because with the default encoding Excel uses R can't read it in.)
- CSV read into R.

## Columns of interest

[1] "Participant.ID.No."                
[11] "Males...Number.in.HH"
[12] "Males...Ages.in.HH"
[13] "Females...Number.in.HH"
[14] "Females...Ages.in.HH"
[24] "X1.3..Wildlife.near.home"