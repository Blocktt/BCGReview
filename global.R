# Shiny Global File

# Version ----
pkg_version <- "v0.0.1.9000"

# Packages----
library(shiny)
library(shinydashboard)
library(shinydashboardPlus) # only using for footer
# library(shinyjs)
# library(shinyBS)
library(DT)
library(dplyr)
library(readxl)
# library(httr)
# library(reshape2)
library(knitr)
# library(zip)
library(shinyalert)
library(readr)
library(rmarkdown)
# library(tools)
# library(openxlsx)
# library(sf)
library(kableExtra)
library(tidyr)

## tabs ----
# sourced in global.R
# ref in db_main_body.R
# menu in db_main_sb.R
db_main_sb                     <- source("external/db_main_sb.R"
                                         , local = TRUE)$value
db_main_body                   <- source("external/db_main_body.R"
                                        , local = TRUE)$value
tab_code_primary               <- source("external/tab_primary.R"
                                         , local = TRUE)$value

# Console Message ----
message(paste0("Interactive: ", interactive()))

# File Size ----
# By default, the file size limit is 5MB.
mb_limit <- 200
options(shiny.maxRequestSize = mb_limit * 1024^2)

# Load files ----
fn_samps <- "samples.csv"
fn_sites <- "sites.csv"
fn_metrics <- "metrics.csv"

df_samps <- read.csv(file = file.path("Data", fn_samps))
df_sites <- read.csv(file = file.path("Data", fn_sites))
df_metrics <- read.csv(file = file.path("Data", fn_metrics))
