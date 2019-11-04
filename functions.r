#selects columns for demographics
demographics <- function(info) {
  info <- select(info, 1, 4:5, 9:12, 17:19, 21, 41:47, 227:258)
  return(info)
}

#selects columns about tech
pttech <- function(info) {
  info <- select(info, 1, 48:124, 509:609)
  return(info)
}

#selects columns for pedsql
pedsql <- function(info) {
  info <- select(info, 1, 125:149, 610:634)
  return(info)
}

#selects columns for physical activity and nutrition
physnut <- function(info) {
  info <- select(info, 1, 150:228, 635:717)
  return(info)
}

#selects columns for weight questionnaire
weight <- function(info) {
  info <- select(info, 1, 229:247)
  return(info)
}

#selects columns for asthma questionnaire
asthma <- function(info) {
  info <- select(info, 1, 248:426, 718:846)
  return(info)
}

#selects columns for usherwood questionnaire
asthma <- function(info) {
  info <- select(info, 1, 847:885)
  return(info)
}