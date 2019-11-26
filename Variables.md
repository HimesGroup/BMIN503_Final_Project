# Variables to be included in models

## Variables from the Linked Birth and Death Certificate Data

### 2007 - 2017

There are data available from the CDC Wonder queries regarding the outcome of data including through 2017. These data do not have a linked birth and death cohort available through that late of a date. The most recent data set avialable through the National Economic Research Bureau is 2013. There is; however, linked birth and death certificate for both the numerator of all deaths as well as the denominator of all births. 

Variables to be included in models:

- **dob_yy** - Birth Year

- **mager41** - Mother's age as a continuous variable. Different from what is published in the user's guide.

- **ubfacil** - Birth facility. Hospital vs other categories. Hospital is coded a 1.

- **mracerec** - Maternal race recoded as White, Black, American Indian/Alaskan Native and Asian/Pacific Islander.

- **mracehisp** - Maternal race hispanic origin. 

- **meduc** - Maternal education.

- **precare_rec** - Month prenatal care began as as categorical. 1 is 1-3 months. 2 is 4-6 months. 3 is 7th on. 4 is none. 5 Unknown.

- **rf_ppterm** - Prior preterm birth as a character variable.
