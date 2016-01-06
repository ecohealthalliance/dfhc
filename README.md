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

## License
Copyright 2016 EcoHealth Alliance

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
