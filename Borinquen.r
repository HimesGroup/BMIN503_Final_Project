#Clear existing data and graphics
#rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv('ChronicConditionSpec_DATA_2019-10-02_1538.csv')

#Set factors
source('factors.r')

#Set Levels
source('levels.r')

#remove '.factor' from names
data <- data[c(1, 473, 3, 474:478, 9:10, 479:483, 16, 484, 18, 485:487, 22, 488, 24, 489:491, 28, 492, 30, 493:504, 43, 505:510, 50, 511:536, 77, 537:560, 102, 561:588, 131, 589:606, 150, 607:684, 229, 685:715, 261, 716:765, 312, 766:789, 337, 790:821, 370, 822:899, 449, 900:917, 468, 918:919, 471, 920)]
names(data) <- gsub(".factor", "", names(data), fixed = TRUE)

#Name all columns
source('labels.r')