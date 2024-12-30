# Map Panel
function() {
  fluidPage(
    h1("Interactive map of sites")
    , leafletOutput("Map_Sites", height = "80vh")
    # fluidRow(
    #   leafletOutput("Map_Sites")
    # ) # fluidRow ~ END
  ) # fluidPage ~ END
}##FUNCTION ~ END
