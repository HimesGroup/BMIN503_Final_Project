# # Color Palette
# c_palette <- c(
#   "#E69F00", # orange
#   "#56B4E9", # sky blue
#   "#009E73", # bluish green
#   "#F0E442", # yellow
#   "#0072B2", # blue
#   "#D55E00", # vermillion
#   "#CC79A7", # reddish purple
#   "#999999", # grey
#   "#117733", # dark green
#   "#882255", # wine
#   "#44AA99", # teal
#   "#332288", # indigo
#   "#DDCC77", # sand
#   "#AA4499", # magenta
#   "#88CCEE", # light blue
#   "#661100"  # dark brown
# )
# 
# plot_opts <- list(
#   scale_color_manual(values = c_palette),
#   scale_fill_manual(values = c_palette),
#   theme_clean(),
#   theme(legend.title=element_blank(),
#           legend.position="bottom",
#           plot.title = element_text(hjust = 0.5),
#           axis.line = element_line(color="black"),
#           axis.ticks = element_line(color="black")
#   )
# )
# 
# ods_geo %>%
#   mutate(year = year(death_date)) %>%
#   st_drop_geometry() %>% group_by(year) %>%
#   tally() %>%
#   ggplot(aes(x=year,y=n)) +
#     geom_col() +
#     labs(title = "Overdoses by Year",
#          subtitle = "Cook County, IL, 2014-2024",
#          x="Year",
#          y="Fatal Accidental Overdose Count") +
#     plot_opts

plot_city_clinic_by_year <- function(clinics,selected_city){
  city = strsplit(selected_city,", ")[[1]][1] # First element of first list
  state = strsplit(selected_city,", ")[[1]][2] # Second element of second list
  
  summary <- clinics %>% 
    filter(
      (City == city & State == state) & 
       year >= 2005 & 
       Country == "USA"
      ) %>% 
    rename(city = City) %>% # Match other columns as lowercase
    mutate(city_orig = city,
           city = case_when(
             Subregion == "Los Angeles County" ~ "Los Angeles",
             ((city == "New York" & State == "New York") | (city == "Brooklyn" & State == "New York") | (city == "Bronx" & State == "New York") | (city == "Staten Island" & State == "New York")) | (city == "Queens" & State == "New York") ~ "New York", # We don't have any in Queens for some reason?
             .default = city
           )) %>%
    select(group,city,lat,lon,year,clinic_id) %>%
    distinct(group,city,year,lat,lon) %>%
    group_by(city,year) %>% mutate(count = n()) %>%
    tally()
  
  ggplot(summary, aes(x = year, y = n)) +
    geom_point(color = "#2c7bb6") + 
    xlab("Year") +
    ylab("Clinics (n)") +
    labs(title = paste0("Clinic Count by Year: ",selected_city), subtitle = paste0(min(summary$year),"-",max(summary$year)))+
    theme(legend.position = "none",
          axis.text.x = element_text(angle = 90,vjust = 0.5)) +
    theme_minimal()
  
}

plot_city_clinic_avail_year <- function(clinics,selected_city){
  city = strsplit(selected_city,", ")[[1]][1] # First element of first list
  state = strsplit(selected_city,", ")[[1]][2] # Second element of second list
  
# Plot flattened clinic availability by year
avail <- clinics %>%
  filter(city == city & State == state) %>%
  select(group,lat,lon,year,clinic_id) %>%
  group_by(group) %>% mutate(count = n()) %>%
  # filter(count <= 17) %>% # Need to investigate and decide what to do with these guys, as they are duplicates
  distinct(year,lat,lon,.keep_all = TRUE) %>%
  ungroup() %>%
  select(group,year,count,lat,lon) %>%
  mutate(
    observations = case_when(count >= 1 ~ 1, .default = 0)) %>%
  ungroup() %>%
  group_by(group) %>%
  mutate(years = sum(observations), 
         clinic = paste0("clinic_",group),
         run = cumsum(year - lag(year, default = TRUE) == 1),
         max_run = max(run),
         min_year = min(year)
  ) %>%
  arrange(desc(max_run)) %>%
  ungroup()

  ggplot(avail, aes(x = reorder(reorder(clinic, max_run),min_year), y = year, fill = observations)) +
  geom_tile(color = "white",
            lwd = .05,
            linetype = 1) +
  coord_fixed() +
  xlab("Clinic") +
  ylab("Year") +
  labs(title = paste0("DTC Data Availability: ",selected_city), subtitle = paste0(min(avail$year),"-",max(avail$year)))+
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 90,vjust = 0.5))
}