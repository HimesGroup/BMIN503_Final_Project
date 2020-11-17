
#Reading in Sparta scan data - all sports
sparta.scans <- read.csv("U:/PhD program/600 Data Science_Final proj_Sparta/sparta_scan_summaries.csv", header = TRUE)

#library(tidyverse)
library(dplyr)
library(ggplot2)

#ID sport with most number of scans - we see that it's Men's Lacrosse.
scans.by.sport <- sparta.scans %>%
  group_by(Group.s.) %>%
  summarise(n()) %>%
  arrange(desc(`n()`))
print(scans.by.sport)

#Cleaning up dataset here - remove identifiers, new labels, Men's Lacrosse only, Jump scan only.
sparta.scans.clean <- sparta.scans %>%
  select(Unique.ID, Group.s., Date, Time, Scan.Type, Load.t.score, Explode.t.score, Drive.t.score, Jump.height..in., Weight..lb., Injury.risk) %>%
  rename(id = Unique.ID, sport = Group.s., date.scan = Date, time.scan = Time, scan.type = Scan.Type, load.tscore = Load.t.score, explode.tscore = Explode.t.score, drive.tscore = Drive.t.score, jump.ht.in = Jump.height..in., jump.wt.lb = Weight..lb., injury.riskscore = Injury.risk) %>%
  filter(sport == "Lacrosse (M)") %>%
  filter(scan.type == "Jump")

#Check if missing - no.
sapply(sparta.scans.clean, function(x) length(x[is.na(x)]))

#Assigning new unique ID (pre-assigned from software is very long).
sparta.scans.clean <- sparta.scans.clean %>%
  group_by(id) %>%
  mutate(id.new = row_number())

#More cleaning - make new ID class character.
sparta.scans.clean$id.new <- as.character(sparta.scans.clean$id.new)
#Remove old ID from software.
sparta.scans.clean <- sparta.scans.clean[-c(1)]
#Make injury risk score a factor (1-5) from numeric.
sparta.scans.clean$injury.riskscore <- as.factor(sparta.scans.clean$injury.riskscore)

str(sparta.scans.clean)

#Men's lacrosse - we have 35 players, 852 jump scans
length(unique(sparta.scans.clean$id.new))

#This table shows the number of scans per athlete, range 49-1
scans.per.athlete <- sparta.scans.clean %>%
  group_by(id.new) %>%
  summarise(n()) %>%
  arrange(desc(`n()`))
print(scans.per.athlete)

#Shows frequencies of scans by injury risk score (scale range 0-5, no 4)
scans.injury.riskscore <- sparta.scans.clean %>% count(injury.riskscore)
print(scans.injury.riskscore)

#This shows most common injury risk score is 1 (then 3, 0, 5, 2)
ggplot(data = sparta.scans.clean, aes(x = injury.riskscore)) +
  geom_bar() +
  labs(y = "Scans (count)",
     x = "Injury risk score (0-5)") +
  ggtitle("# Scans by Injury Risk Score")

#This shows variability in scans by injury risk score both within the same athlete and across the 35 M lacrosse athletes. 
ggplot(data = sparta.scans.clean, aes(y = id.new, fill = injury.riskscore)) +
  geom_bar() +
  labs(y = "Athlete ID",
     x = "Scans (counts)",
     fill = "Injury risk score(0-5)") +
  ggtitle("Variability in Injury Risk Score within and across athletes")

#Jump height and injury risk score
#ggplot(data = sparta.scans.clean, aes(x = jump.ht.in, y = injury.riskscore)) +
  #geom_point()
ggplot(data = sparta.scans.clean, aes(x = jump.ht.in, y = injury.riskscore)) +
  geom_boxplot() +
  labs(y = "Injury risk score",
        x = "Jump height (in)") +
  ggtitle("Jump height (in) and Injury risk score")

#This shows median, IQR of LOAD, EXPLODE, DRIVE tscores within and across all M lacrosse athletes
#LOAD
#ggplot(data = sparta.scans.clean, aes(x = load.tscore, y = id.new)) +
  #geom_point()
ggplot(data = sparta.scans.clean, aes(x = load.tscore, y = id.new)) +
  geom_boxplot() +
  labs(y = "Athlete ID",
         x = "Load t-score") +
  ggtitle("Variability in Load within and across athletes")

#EXPLODE
#ggplot(data = sparta.scans.clean, aes(x = explode.tscore, y = id.new)) +
  #geom_point()
ggplot(data = sparta.scans.clean, aes(x = explode.tscore, y = id.new)) +
  geom_boxplot() +
  labs(y = "Athlete ID",
         x = "Explode t-score") +
  ggtitle("Variability in Explode within and across athletes")

#DRIVE
#ggplot(data = sparta.scans.clean, aes(x = drive.tscore, y = id.new)) +
  #geom_point()
ggplot(data = sparta.scans.clean, aes(x = drive.tscore, y = id.new)) +
  geom_boxplot() +
  labs(y = "Athlete ID",
        x = "Drive t-score") +
  ggtitle("Variability in Drive within and across athletes")

#Scatterplots - LOAD, EXPLODE, DRIVE and injury.riskscore
ggplot(sparta.scans.clean, aes(x = load.tscore, y = explode.tscore,)) +
  geom_point(aes(color=factor(injury.riskscore))) +
  labs(y = "Explode t-score",
        x = "Load t-score")
ggplot(sparta.scans.clean, aes(x = explode.tscore, y = drive.tscore,)) +
  geom_point(aes(color=factor(injury.riskscore))) +
  labs(y = "Drive t-score",
         x = "Explode t-score")
ggplot(sparta.scans.clean, aes(x = load.tscore, y = drive.tscore,)) +
  geom_point(aes(color=factor(injury.riskscore))) +
  labs(y = "Drive t-score",
        x = "Load t-score")
  



#Splitting LOAD, EXPLODE, DRIVE tscores into tertiles - low, med, high and added these columns to df
sparta.scans.clean <- sparta.scans.clean %>%
  mutate(load.tert = ntile(load.tscore, 3)) %>%
  mutate(load.tert = if_else(load.tert == 1, 'Low', if_else(load.tert == 2, 'Medium', 'High'))) %>%
  mutate(explode.tert = ntile(explode.tscore, 3)) %>%
  mutate(explode.tert = if_else(explode.tert == 1, 'Low', if_else(explode.tert == 2, 'Medium', 'High'))) %>%
  mutate(drive.tert = ntile(drive.tscore, 3)) %>%
  mutate(drive.tert = if_else(drive.tert == 1, 'Low', if_else(drive.tert == 2, 'Medium', 'High'))) %>%
  arrange(id.new)
#concatenate their "movement signature" into a "jump profile"
sparta.scans.clean$jump.profile <- paste(sparta.scans.clean$load.tert,sparta.scans.clean$explode.tert,sparta.scans.clean$drive.tert)

#This shows variability in LOAD, EXPLODE, DRIVE within and across athletes
#Load
ggplot(data = sparta.scans.clean, aes(y = id.new, fill = load.tert)) +
  geom_bar() +
  labs(y = "Athlete ID",
       x = "Scans (counts)",
       fill = "Load tertiles") +
  ggtitle("Variability in Load within and across athletes")

#Explode
ggplot(data = sparta.scans.clean, aes(y = id.new, fill = explode.tert)) +
  geom_bar() +
  labs(y = "Athlete ID",
       x = "Scans (counts)",
       fill = "Explode tertiles") +
  ggtitle("Variability in Explode within and across athletes") 

#Drive
ggplot(data = sparta.scans.clean, aes(y = id.new, fill = drive.tert)) +
  geom_bar() +
  labs(y = "Athlete ID",
       x = "Scans (counts)",
       fill = "Drive tertiles") +
  ggtitle("Variability in Drive within and across athletes")

#This shows the variability in jump profile within and across athletes
ggplot(data = sparta.scans.clean, aes(y = id.new, fill = jump.profile)) +
  geom_bar() +
  labs(y = "Athlete ID",
       x = "Scans (counts)",
       fill = "Jump profile - LOAD, EXPLODE, DRIVE") +
  ggtitle("Variability in jump profile within and across athletes")

       
