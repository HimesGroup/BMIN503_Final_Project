# # ##ORS Configuration
# #options(openrouteservice.url = "http://Mount-Ellen.local:8080/ors") #Docker container running a local routing service on my network
# options(openrouteservice.url = "http://localhost:8080/ors") #Docker container running a local routing service on my network
# options(
#   openrouteservice.paths = list(
#     directions = "v2/directions",
#     isochrones = "v2/isochrones",
#     matrix = "v2/matrix",
#     geocode = "geocode",
#     pois = "pois",
#     elevation = "elevation",
#     optimization = "optimization"
#   )
# )
# #Test ORS connection by mapping a route
# testcoordinates <- list(c(-86.48653, 32.46481), c(-86.42121, 32.45187))
# test <- ors_directions(testcoordinates)

# #Map it to see the directions
# leaflet() %>%
#   addTiles() %>%
#   addGeoJSON(test, fill = FALSE) %>%
#   fitBBox(test$bbox)

# #Clean up
# rm(test, testcoordinates)
