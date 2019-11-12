#selects columns for demographics
demographics <- function(info) {
  info <- select(info, 1:2, `Patient's Language`:`Parent's Language`, Ethnicity:Gender, parent_or_guardian___1:parent_or_guardian___2, dem_gender:dem_grade, dem_parent_sex:demographics_parent_complete)
  return(info)
}

#this takes as arguments name of first and last column to combine, then loops through, seeing which columns are empty, and collecting them all in first column, then deleting it.
cleaner <- function(string1, string2, info){
  cols <- which(colnames(info)==string1):which(colnames(info)==string2) #get col numbers for first and last string
  info[cols] <- sapply(info[cols], as.character)
  for(j in 1:nrow(info)){
    for(i in cols){
      info[cols[1]][[1]][j] <- paste(if_else(is.na(info[cols[1]][[1]][j]), "", info[cols[1]][[1]][j]),
                                     if_else(is.na(info[i][[1]][j]), "", info[i][[1]][j]), sep="") #combine the current first column with any others that aren't null
    }
  }
  info[cols[1]][[1]] <- na_if(info[cols[1]][[1]], "") #replace all "" with NA
  info[cols[-1]] <- NULL
  return(info)
}

#selects just the questions for pedsql
pedsql <- function(info) {
  info <- info[c(1:2, 
                 which(colnames(info)=="pedsql_patient_timestamp"):which(colnames(info)=="pedsql_patient_complete"),
                 which(colnames(info)=="pedsql_parent_timestamp"):which(colnames(info)=="pedsql_parent_complete"))]
  return(info)
}

#collect the 4 columns on language preference into 2
languages <-function(info){
  info <- add_column(info, "Patient's Language" = NA, .before = "eng")
  info$`Patient's Language` <- case_when(
    info$eng == 1 ~ "English",
    info$esp == 1 ~ "Spanish",
    TRUE ~ NA_character_
  )
  info <- add_column(info, "Parent's Language" = NA, .before = "eng")
  info$`Parent's Language` <- case_when(
    info$eng2 == 1 ~ "English",
    info$esp2 == 1 ~ "Spanish",
    TRUE ~ NA_character_
  )
  info[6:9] <- NULL
  return(info)
}

#creating some better names for the demographic variables
dem_names <- function(info){
  colnames(info)[colnames(info)=="not_part_ethnicity.f"] <- "Ethnicity"
  colnames(info)[colnames(info)=="not_part_asthma.f"] <- "Asthma?"
  colnames(info)[colnames(info)=="not_part_gender.f"] <- "Gender"
  colnames(info)[colnames(info)=="not_part_obese.f"] <- "Obese?"
  return(info)
}

#plots percentages of change
plotperc = function(info, col, sig){
  prop.table(table(info$redcap_event_name, info[,which(colnames(info)==col)]), margin = 1) %>%
    as.data.frame() %>%
    ggplot(aes(x=Var1, y=Freq, group=Var2)) +
    geom_line(aes(linetype=Var2, color=Var2)) +
    geom_point(aes(shape=Var2)) +
    facet_grid(Var2 ~ .) +
    labs(x = "Visit", y = "Percentage per Visit", title = label(info[which(colnames(info)==col)])) +
    if(col %in% sig$Name) { theme(plot.background = element_rect(colour = "yellow", fill=NA, size=5)) }
}

#plots actual counts of change
plotct = function(info, col){
  table(info$redcap_event_name, info[,which(colnames(info)==col)]) %>%
    as.data.frame() %>%
    ggplot(aes(x=Var1, y=Freq, group=Var2)) +
    geom_line(aes(linetype=Var2, color=Var2)) +
    geom_point(aes(shape=Var2)) +
    labs(x = "Visit", y = "Total Count", title = label(info[which(colnames(info)==col)]))
}