# About Panel
function() {
  fluidPage(
    fluidRow(
      box(title = "Sample Select"
          , status = "primary"
          , solidHeader = TRUE
          , width = 3
          , selectInput(inputId = "select_sampid"
                        , label = "Select SampleID"
                        , choices = ""))
      , box(title = "General Notes"
            , status = "primary"
            , solidHeader = TRUE
            , width = 9
            , textAreaInput( 
              "notes_gencom"
              , NULL
              , value = "Record sample notes and those from specific reviewers.
              Then download using the button below.")
            , downloadButton("dwnld_gencom", "Download"))
    ) # fluidRow ~ END
    , fluidRow(
      box(title = "Site Metadata"
          , status = "primary"
          , solidHeader = TRUE
          , width = 12
          , DT::dataTableOutput("df_DT_sites")
          , collapsible = TRUE
          , collapsed = TRUE)
    ) # fluidRow ~ END
    , fluidRow(
      box(title = "Metrics"
          , status = "primary"
          , solidHeader = TRUE
          , width = 12
          , DT::dataTableOutput("df_DT_metrics")
          , collapsible = TRUE
          , collapsed = TRUE)
    ) # fluidRow ~ END
    , fluidRow(
      box(title = "Sample"
          , status = "primary"
          , solidHeader = TRUE
          , width = 12
          , downloadButton("downloadData", "Download")
          , br()
          , DT::dataTableOutput("df_DT_samps"))
    ) # fluidRow ~ END
  ) # fluidPage ~ END
}##FUNCTION ~ END
