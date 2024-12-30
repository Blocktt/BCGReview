library(shiny)

shinyServer(function(input, output, session) {
  # Filters ----
  updateSelectInput(session, "select_sampid"
                    , choices = c("", df_sites$SampleID))
  
  # Filter tables ----
  ## df_samps ----
  df_samps_editable <- reactiveVal(df_samps)
  
  df_samps_filtr <- reactive({
    if (is.null(input$select_sampid) || input$select_sampid == "") {
      return(df_samps_editable())
    } else {
      return(df_samps_editable()[df_samps_editable()$SampleID == input$select_sampid, ])
    }
  }) # reactive~END
  
  ## df_sites ----
  df_sites_filtr <- reactive({
    if (input$select_sampid == "") {
      return(df_sites)
    } else {
      return(df_sites[df_sites$SampleID == input$select_sampid, ])
    }
  }) # reactive~END
  
  ## df_metrics ----
  df_metrics_filtr <- reactive({
    if (input$select_sampid == "") {
      return(df_metrics)
    } else {
      return(df_metrics[df_metrics$SampleID == input$select_sampid, ])
    }
  }) # reactive~END
  
  ## df_particips ----
  df_particips_editable <- reactiveVal(df_particips_v2)
  
  # Display tables ----
  ## Samps ----
  output$df_DT_samps <- DT::renderDT({
    DT::datatable(
      df_samps_filtr(),
      filter = "none",
      editable = TRUE,
      options = list(
        scrollX = TRUE,
        pageLength = 25,
        lengthMenu = c(25, 50, 100, 500),
        autoWidth = FALSE,
        searching = FALSE
      )) %>% DT::formatStyle("BCG.Attribute"
        , backgroundColor = styleEqual(c(1, 2, 3, 4, 5, 6)
          , c('#006600', '#33ff33', '#ffff00', '#ff6600', '#ff0000', '#990000')))
  }) # renderDT ~ END
  
  ## Metrics ----
  output$df_DT_metrics <- DT::renderDT({
    df_metrics_filtr()
    # df_metrics
  }##expression~END
  , filter = "none"
  , rownames = FALSE
  , options = list(scrollX = TRUE
                   , pageLength = 5
                   , lengthMenu = c(5, 10, 25, 50, 100, 1000)
                   , autoWidth = FALSE
                   , searching = FALSE)
  )##df_DT_metrics~END
  
  ## Sites ----
  output$df_DT_sites <- DT::renderDT({
    df_sites_filtr()
    # df_sites
  }##expression~END
  , filter = "none"
  , rownames = FALSE
  , options = list(scrollX = TRUE
                   , pageLength = 5
                   , lengthMenu = c(5, 10, 25, 50, 100, 1000)
                   , autoWidth = FALSE
                   , searching = FALSE)
  )##df_DT_sites~END
  
  ## Participants ----
  output$df_DT_particip <- DT::renderDT({
    df_particips_editable()
  }##expression~END
  , editable = TRUE
  , filter = "none"
  # , rownames = FALSE
  , options = list(dom = 't'  # Only show the table
                   , paging = FALSE  # Disable paginatio
                   # , pageLength = 15
                   , autoWidth = FALSE
                   , searching = FALSE)
  )##df_DT_metrics~END
  
  # Edit tables ----
  # Update the data based on edits
  ## df_samps ----
  observeEvent(input$df_DT_samps_cell_edit, {
    cell <- input$df_DT_samps_cell_edit
    newdf_samps <- df_samps_editable()
    newdf_samps[cell$row, cell$col] <- cell$value
    df_samps_editable(newdf_samps)
  }) #observeEvent ~ END
  
  ## df_particips ----
  observeEvent(input$df_DT_particip_cell_edit, {
    cell <- input$df_DT_particip_cell_edit
    newdf_particips <- df_particips_editable()
    newdf_particips[cell$row, cell$col] <- cell$value
    df_particips_editable(newdf_particips)
  }) #observeEvent ~ END
  
  # Downloads ----
  ## General Download ----
  output$dwnld_gencom <- downloadHandler(
    filename = function() {
      if (input$select_sampid == "") {
        "default.txt"
      } else {
        paste0(input$select_sampid, ".txt")
      }
    }# function ~ END
    , content = function(file) {
      cat(input$notes_gencom, file = file)
      }# function ~ END
  ) # downloadHandler ~ END
  
  ## Participants ----
  output$dwnld_particips <- downloadHandler(
    filename = function() {
      if (input$select_sampid == "") {
        paste("Participant_comments", "_default_", Sys.Date(), ".csv")
      } else {
        paste0("Participant_comments", "_", input$select_sampid, "_", Sys.Date()
               , ".csv")
      }
    }# function ~ END
    , content = function(file) {
      write.csv(df_particips_editable(), file, row.names = FALSE)
    }# function ~ END
  ) # downloadHandler ~ END
  
  ## Edited sample table ----
  # Download the edited data
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("Samp_Edits", "_", input$select_sampid, "_", Sys.Date()
            , ".csv")
    },
    content = function(file) {
      write.csv(df_samps_editable(), file, row.names = FALSE)
    }
  ) # downloadHandler ~ END
  
  # Map ----
  output$Map_Sites <- renderLeaflet({
    leaflet(df_sites) %>%
      addTiles() %>%
      addMarkers(~Longitude, ~Latitude, popup = ~SampleID) %>% 
      addMiniMap()
  }) #renderLeaflet ~ END

})##shinyServer ~ END
