#Sidebar----

# tabs
# sourced in global.R
# ref in db_main_body.R
# menu in db_main_sb.R

function(id) {
  dashboardSidebar(
    width = 275
    , sidebarMenu(id = id
      , menuItem(text = "Primary"
               , tabName = "tab_primary"
               , icon = icon("house"))# END ~ menuItem
      
    )## sidebarMenu ~ END
  )## dashboardSidebar ~ END
}## FUNCTION ~ END
