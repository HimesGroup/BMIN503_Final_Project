leaflet_basemap <- function() {
  basemap <- leaflet() %>%
    addProviderTiles("CartoDB.Positron")

  return(basemap)
}
