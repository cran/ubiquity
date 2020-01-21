## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message=FALSE, eval=FALSE)
require(ubiquity)
require(deSolve)
require(ggplot2)
require(foreach)
require(doParallel)
require(rhandsontable)

## ----results="hide", message=FALSE, echo=TRUE----------------------------
#  library(ubiquity)
#  system_new(file_name = "system.txt", system_file = "mab_pk", overwrite = TRUE)
#  cfg = build_system(system_file = "system.txt")

## ----eval=FALSE----------------------------------------------------------
#  system_fetch_template(cfg, template = "ShinyApp", overwrite = TRUE)

## ---- eval=FALSE---------------------------------------------------------
#  #source("analysis_NAME_lib.r");

## ---- eval=FALSE---------------------------------------------------------
#  if(!require(ubiquity)){
#    source(file.path('library', 'r_general', 'ubiquity.R')) }
#  cfg = build_system(system_file="system.txt")

## ---- eval=FALSE---------------------------------------------------------
#  cfg$gui$save$system_txt = TRUE
#  cfg$gui$save$user_log   = TRUE

## ---- eval=FALSE---------------------------------------------------------
#  system_fetch_template(cfg, template="Model Diagram")

## ---- eval=FALSE---------------------------------------------------------
#  system_fetch_template(cfg, template="Shiny Rmd Report")

## ---- eval=FALSE---------------------------------------------------------
#  cfg$gui$modelreport_files$R1$title = "Tab Title"
#  cfg$gui$modelreport_files$R1$file  = "system_report.Rmd"

## ---- eval=FALSE---------------------------------------------------------
#  load("transient/rgui/default/gui_som.RData")
#  load("transient/rgui/default/gui_state.RData")
#  params = list()
#  params$cfg = cfg
#  params$som = som
#  rmarkdown::render("system_report.Rmd",
#                     params = params,
#                     output_format = "html_document")

## ---- eval=FALSE---------------------------------------------------------
#  cfg$gui$modelreport_files$R1$title = "Tab Title"
#  cfg$gui$modelreport_files$R1$file  = "system_report.html"

## ---- eval=FALSE---------------------------------------------------------
#  cfg$gui$functions$user_def = 'mylibs.r'

## ---- eval=FALSE---------------------------------------------------------
#  cfg$gui$functions$sim_ind = 'function_name(parameters, cfg)'

## ---- eval=FALSE---------------------------------------------------------
#  cfg$gui$functions$sim_var = 'function_name(parameters, cfg)'

## ---- eval=FALSE---------------------------------------------------------
#  cfg$gui$functions$plot_ind =  'function_name(cfg, parameters,som)'

## ---- eval=FALSE---------------------------------------------------------
#  cfg$gui$functions$plot_var =  'function_name(cfg, parameters,som)'

## ---- eval=FALSE---------------------------------------------------------
#  deploying = TRUE

## ---- eval=FALSE---------------------------------------------------------
#  nat.utils::touch("REBUILD")

## ---- eval=FALSE---------------------------------------------------------
#  R -e "source('ubiquity_app.R')"

