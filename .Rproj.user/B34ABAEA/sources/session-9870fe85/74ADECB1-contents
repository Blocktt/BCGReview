dashboardPage(
  header = dashboardHeader(title = "BCGreview", titleWidth = 275),
  sidebar = dashboardSidebar(db_main_sb("leftsidebarmenu")),
  body = dashboardBody(
  tags$style(HTML("/* Target the 'body' tag inside your RMarkdown content */
      body {font-size: 16px;}"))
    , db_main_body("dbBody"))
  , footer = dashboardFooter(left = pkg_version
                             , right = "https://github.com/Blocktt/BCGreview")
  , skin = NULL  # Disable the default skin
) # dashboardPage ~ END
