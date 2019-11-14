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
  info
}

#creating some better names for the demographic variables
dem_names <- function(info){
  colnames(info)[colnames(info)=="not_part_ethnicity"] <- "Ethnicity"
  colnames(info)[colnames(info)=="not_part_asthma"] <- "Asthma?"
  colnames(info)[colnames(info)=="not_part_gender"] <- "Gender"
  colnames(info)[colnames(info)=="not_part_obese"] <- "Obese?"
  info
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
  info
}

#add columns as needed
survey_columns <- function(info, list) {
  for(i in 1:length(list)){
    info[[list[i]]] <- NA
  }
  info
}

#get some row means for the survey, pass the dataframe, first and last column (inclusive) to be included
rowmeaning <- function(info, col1, col2){
  store <- info[grep(paste("^", col1, "$", sep = ""), colnames(info)):grep(paste("^", col2, "$", sep = ""), colnames(info))]
  info <- rowMeans(store)
  info[rowSums(is.na(store)) >= 0.5] <- NA
  info[which(rowSums(is.na(store)) / ncol(store) >= 0.5)] <- NA
  info
}

#applies ttest to column that ends in .x and .y (usually after merging two datasets)
ttest <- function(info, col){
  t.test(info[[col]], info[[gsub(".x", ".y", col)]], paired=TRUE, alternative = "two.sided")
}

#trying to make easier fxn to apply ttest, applies tteest to all columns between col1 and col2 inclusive
applying <- function(col1, col2, info){
  info <- as.data.frame(lapply(select(info, col1:col2, gsub(".x", ".y", col1):gsub(".x", ".y", col2)), as.numeric))
  info <- t(sapply(colnames(select(info, col1:col2)), ttest, info=info)) %>%
    as.data.frame() %>%
    .[.$p.value <= 0.05,] %>%
    add_column(., "Name" = gsub(".x", ".f", row.names(.)), .before = "statistic")
}

#boxplot for significant changes from first and last visits
boxy <- function(info, name, sig){
  ggplot(info, aes_string(x = "redcap_event_name", y=name)) + 
    geom_boxplot() +
    labs(x = "Visit", title = label(complete[grep(name, colnames(complete))])) +
    if(paste(name, ".f", sep="") %in% sig$Name) { theme(plot.background = element_rect(colour = "yellow", fill=NA, size=5)) }
}



#####older functions I'm not using anymore#####

#plots percentages of change
plotchange = function(info, col, sig){
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
  
#recodes sections of dataframe, pass full dataframe, 1st/last column (inclusive) to recode, plus string for recoding
recoding <- function(info, col1, col2, code){
  info[,colnames(select(info, col1:col2))] <- apply(info[,colnames(select(info, col1:col2))], 2, function(x) {x <- recode(x, code); x})
  info
}