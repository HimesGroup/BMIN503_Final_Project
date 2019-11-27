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

- **ld_steroids** - Questinable as to what this variable really means. Character variable but not as expected regarding frequency of exposure in infants less than 1,000g. Would have expected near 80% use in infants less than 1,000g.

- **f_ld_steroids** - Numeric variable as 0 or 1. This also is confusing. Guide published offers little help to deicpher what coding means.

- **apgar5** - 5-minute APGAR score.

- **dplural** - Singleton or twin.

- **sex** - Sex of infant. Male or female only.

- **imp_sex** - Whether the sex of the infant was imputed.

- **combgest** - Gestational age(GA) in weeks.

- **gest_imp** - Whether the GA was imputed.

- **dbwt** - Birth weight.

_ **f_ab_vent** - Ever ventilated.

_ **f_ab_vent6** - Ventilated more than 6 hours.

_ **f_ab_nicu** - Admitted to a NICU.
