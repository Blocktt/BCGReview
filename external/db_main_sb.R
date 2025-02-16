#Sidebar----

# tabs
# sourced in global.R
# ref in db_main_body.R
# menu in db_main_sb.R

function(id) {
  dashboardSidebar(
    width = 275
    , sidebarMenu(id = id
      , menuItem(text = "Sample Review"
               , tabName = "tab_samp_review"
               , icon = icon("magnifying-glass"))# END ~ menuItem
      , menuItem(text = "Site Map"
                 , tabName = "tab_map"
                 , icon = icon("map"))# END ~ menuItem
    )## sidebarMenu ~ END
  )## dashboardSidebar ~ END
}## FUNCTION ~ END
