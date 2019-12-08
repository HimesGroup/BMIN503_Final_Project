# Sample code fragments that may be useful for final project.

library(urbnmapr)
ggplot() + 
  geom_polygon(data = urbnmapr::states, mapping = aes(x = long, y = lat, group = group),
               fill = "grey", color = "white") +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)

# Creating chloropleth maps
# Data files are part of the urbnmapr package.

household_data <- left_join(countydata, counties, by = "county_fips") 
state_data <- left_join(statedata, states, by = "state_fips")

household_data %>%
  ggplot(aes(long, lat, group = group, fill = medhhincome)) +
  geom_polygon(color = NA) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  labs(fill = "Median Household Income")

state_data %>%
  ggplot(aes(long, lat, group = group, fill = medhhincome)) +
  geom_polygon(color = NA) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  labs(fill = "Median Household Income")

black_IMR_14_17 <- IMR_By_Race_2014_2017 %>%
                    select(State, 
                           "Mother's Bridged Race",
                           Births, Deaths) %>%
                    rename(race="Mother's Bridged Race", state_name=State) %>%
                    filter(race == "Black or African American")

black_IMR_14_17$Deaths <- as.numeric(black_IMR_14_17$Deaths)
black_IMR_14_17$IMR <- (black_IMR_14_17$Deaths/black_IMR_14_17$Births)*1000

black_IMR_map_14_17 <- left_join(black_IMR_14_17, states, 
                                 by = "state_name")
black_IMR_map_14_17 %>%
  ggplot(aes(long, lat, group = group, fill = IMR)) +
  ggtitle("Infant Mortality Rate Among Black Infants in the US 2014-2017") +
  geom_polygon(color = NA) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  scale_fill_gradient(limits = c(1,15), low = "yellow",high = "red") + 
  labs(fill = "Infant Mortality Rate")

white_IMR_14_17 <- IMR_By_Race_2014_2017 %>%
  select(State, 
         "Mother's Bridged Race",
         Births, Deaths) %>%
  rename(race="Mother's Bridged Race", state_name=State) %>%
  filter(race == "White")

white_IMR_14_17$Deaths <- as.numeric(white_IMR_14_17$Deaths)
white_IMR_14_17$IMR <- (white_IMR_14_17$Deaths/white_IMR_14_17$Births)*1000   

white_IMR_map_14_17 <- left_join(white_IMR_14_17, states, 
                                          by = "state_name")
white_IMR_map_14_17 %>%
  ggplot(aes(long, lat, group = group, fill = IMR)) +
  ggtitle("Infant Mortality Rate Among White Infants in the US 2014-2017") +
  geom_polygon(color = NA) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  scale_fill_gradient(limits = c(1,15), low = "yellow",high = "red") + 
  labs(fill = "Infant Mortality Rate")

