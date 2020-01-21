## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message=FALSE, eval=FALSE)
require(ubiquity)
require(deSolve)
require(ggplot2)
require(foreach)
require(doParallel)
require(rhandsontable)

## ----eval=FALSE----------------------------------------------------------
#  library(ubiquity)
#  fr = workshop_fetch(section="Estimation", overwrite=TRUE)

## ----results="hide", message=FALSE---------------------------------------
#  library(ubiquity)
#  system_new(file_name="system.txt", system_file="adapt", overwrite = TRUE)
#  cfg = build_system(system_file = "system.txt")

## ----results="hide", message=FALSE---------------------------------------
#  system_fetch_template(cfg, template="Estimation")

## ----results="hide", echo=TRUE, warning=FALSE----------------------------
#  flowctl = 'estimate'
#  archive_results = TRUE
#  analysis_name = 'parent_d1030'

## ----results="hide", echo=TRUE-------------------------------------------
#  pnames = c('Vp', 'Vt', 'CLp', 'Q')
#  cfg = system_select_set(cfg, "default", pnames)

## ----results="hide", echo=TRUE-------------------------------------------
#  cfg=system_set_option(cfg, group  = "simulation",
#                             option = "output_times",
#                             seq(0,100,1))

## ----results="hide", echo=TRUE, warning=FALSE----------------------------
#  cfg = system_load_data(cfg, dsname     = "pm_data",
#                              data_file  = system.file("ubinc", "csv",
#                                                       "pm_data.csv",
#                                                       package = "ubiquity"))

## ----results="hide", echo=FALSE------------------------------------------
#  dataset = read.csv(system.file("ubinc", "csv", "pm_data.csv", package = "ubiquity"))

## ----echo=FALSE, fig.align="center"--------------------------------------
#  rhandsontable(dataset, width=400, height=200)

## ----results="hide", echo=TRUE, warning=FALSE----------------------------
#  cfg = system_clear_cohorts(cfg)

## ----results="hide", echo=TRUE, warning=FALSE----------------------------
#  cohort  = c()
#  cohort$name                                   = 'dose_10'
#  cohort$dataset                                = 'pm_data'
#  cohort$cf$DOSE                                = c(10)

## ----results="hide", echo=TRUE, warning=FALSE----------------------------
#  cohort$inputs$bolus$Mpb$AMT                   = c(10)
#  cohort$inputs$bolus$Mpb$TIME                  = c(0)

## ----results="hide", echo=TRUE, warning=FALSE----------------------------
#  cohort$outputs$Parent$obs$time                = 'TIME'
#  cohort$outputs$Parent$obs$value               = 'PT'
#  cohort$outputs$Parent$obs$missing             = -1
#  cohort$outputs$Parent$model$time              = 'hours'
#  cohort$outputs$Parent$model$value             = 'Cpblood'
#  cohort$outputs$Parent$model$variance          = '1'

## ----results="hide", echo=TRUE, warning=FALSE----------------------------
#  cohort$outputs$Parent$options$marker_color    = 'black'
#  cohort$outputs$Parent$options$marker_shape    = 1
#  cohort$outputs$Parent$options$marker_line     = 2

## ----results="hide", echo=TRUE, warning=FALSE----------------------------
#  cfg = system_define_cohort(cfg, cohort)

## ----results="hide", echo=TRUE, warning=FALSE----------------------------
#  cohort  = c()
#  cohort$name                                   = 'dose_30'
#  cohort$dataset                                = 'pm_data'
#  cohort$cf$DOSE                                = c(30)
#  cohort$inputs$bolus$Mpb$AMT                   = c(30)
#  cohort$inputs$bolus$Mpb$TIME                  = c(0)
#  cohort$outputs$Parent$obs$time                = 'TIME'
#  cohort$outputs$Parent$obs$value               = 'PT'
#  cohort$outputs$Parent$obs$missing             = -1
#  cohort$outputs$Parent$model$time              = 'hours'
#  cohort$outputs$Parent$model$value             = 'Cpblood'
#  cohort$outputs$Parent$model$variance          = '1'
#  cohort$outputs$Parent$options$marker_color    = 'red'
#  cohort$outputs$Parent$options$marker_shape    = 2
#  cohort$outputs$Parent$options$marker_line     = 2
#  
#  cfg = system_define_cohort(cfg, cohort)
#  

## ----echo=FALSE, message=FALSE, warning=FALSE, results="hide"------------
#  cfg = system_set_option(cfg, group  = "estimation",
#                               option = "control",
#                               value  = list(trace  = TRUE,
#                                             maxit  = 10,
#                                             REPORT = 10))

## ----echo=TRUE, message=FALSE, warning=FALSE, results="hide"-------------
#  pest = system_estimate_parameters(cfg,
#                                    flowctl         = flowctl,
#                                    analysis_name   = analysis_name,
#                                    archive_results = archive_results)

## ----results="hide", echo=TRUE, warning=FALSE----------------------------
#  cfg=system_set_option(cfg, group  = "simulation",
#                             option = "output_times",
#                             seq(0,100,5))

## ----results="hide", echo=TRUE, warning=FALSE----------------------------
#  erp = system_simulate_estimation_results(pest = pest, cfg = cfg)
#  

## ----results="hide", echo=TRUE, warning=FALSE, fig.align="center", fig.width=2----
#  plot_opts = c()
#  plot_opts$outputs$Parent$yscale       = 'log'

## ----results="hide", echo=TRUE, warning=FALSE, message=FALSE-------------
#  plinfo = system_plot_cohorts(erp, plot_opts, cfg, analysis_name=analysis_name)

## ----echo=FALSE----------------------------------------------------------
#  # Creating a reduced form of the estimation output to save it and use less disk space
#  estout = list()
#  estout$tc =  plinfo$timecourse$Parent
#  estout$op =  plinfo$obs_pred$Parent
#  ggsave(filename="Estimation-parent-tc.png", plot=estout$tc, height=4, width=7, units="in", dpi=72)
#  ggsave(filename="Estimation-parent-op.png", plot=estout$op, height=4, width=7, units="in", dpi=72)

## ----results="hide", echo=TRUE, eval=FALSE-------------------------------
#  cfg = system_report_init(cfg, rpttype="PowerPoint")
#  cfg = system_report_estimation(cfg=cfg, analysis_name=analysis_name)
#  system_report_save(cfg=cfg, output_file=file.path("output",paste(analysis_name, "-report.pptx", sep="")))

## ----results="hide", echo=TRUE, eval=FALSE-------------------------------
#  cfg = system_report_init(cfg, rpttype="Word")
#  cfg = system_report_estimation(cfg=cfg, analysis_name=analysis_name)
#  system_report_save(cfg=cfg, output_file=file.path("output",paste(analysis_name, "-report.docx", sep="")))

## ----results="hide", echo=TRUE, eval=FALSE-------------------------------
#  pnames = c('Vp',
#             'Vt',
#             'Vm',
#             'CLp',
#             'Q',
#             'CLm',
#             'slope_parent',
#             'slope_metabolite');
#  
#  cfg = system_select_set(cfg, "default", pnames)

## ----results="hide", echo=TRUE, eval=FALSE-------------------------------
#  cfg = system_clear_cohorts(cfg)
#  cohort = c()
#  cohort$name                                      = 'dose_10'
#  cohort$cf$DOSE                                   = c(10)
#  cohort$dataset                                   = 'pm_data'
#  
#  cohort$inputs$bolus$Mpb$TIME                     = c(0)  # hours
#  cohort$inputs$bolus$Mpb$AMT                      = c(10) # mpk
#  
#  cohort$outputs$Parent$obs$time                   = 'TIME'
#  cohort$outputs$Parent$obs$value                  = 'PT'
#  cohort$outputs$Parent$obs$missing                = -1;
#  cohort$outputs$Parent$model$time                 = 'hours'
#  cohort$outputs$Parent$model$value                = 'Cpblood'
#  cohort$outputs$Parent$model$variance             = 'slope_parent*PRED^2'
#  cohort$outputs$Parent$options$marker_color       = 'black'
#  cohort$outputs$Parent$options$marker_shape       = 1
#  cohort$outputs$Parent$options$marker_line        = 1
#  
#  cohort$outputs$Metabolite$obs$time               = 'TIME'
#  cohort$outputs$Metabolite$obs$value              = 'MT'
#  cohort$outputs$Metabolite$obs$missing            = -1;
#  cohort$outputs$Metabolite$model$time             = 'hours'
#  cohort$outputs$Metabolite$model$value            = 'Cmblood'
#  cohort$outputs$Metabolite$model$variance         = 'slope_metabolite*PRED^2'
#  cohort$outputs$Metabolite$options$marker_color   = 'blue'
#  cohort$outputs$Metabolite$options$marker_shape   = 1
#  cohort$outputs$Metabolite$options$marker_line    = 1
#  cfg = system_define_cohort(cfg, cohort)

## ----eval=FALSE----------------------------------------------------------
#  cfg = system_set_option(cfg, group  = "estimation",
#                               option = "method",
#                               value  = "SANN")

## ----eval=FALSE----------------------------------------------------------
#  library("pso")
#  cfg = system_set_option(cfg, group  = "estimation",
#                               option = "optimizer",
#                               value  = "pso")
#  
#  cfg = system_set_option(cfg, group  = "estimation",
#                               option = "method",
#                               value  = "psoptim")

## ----eval=FALSE----------------------------------------------------------
#  library(GA)
#  
#  cfg = system_set_option(cfg, group  = "estimation",
#                               option = "optimizer",
#                               value  = "ga")
#  
#  cfg = system_set_option(cfg, group  = "estimation",
#                               option = "method",
#                               value  = "ga")
#  
#  cfg = system_set_option(cfg, group  = "estimation",
#                               option = "control",
#                               value  = list(maxiter   = 10000,
#                                             optimArgs = list(method  = "Nelder-Mead",
#                                                              maxiter = 1000)))

## ----eval=FALSE----------------------------------------------------------
#  cfg = system_load_data(cfg, dsname     = "nm_pm_data",
#                              data_file  = system.file("ubinc", "csv",
#                                                       "nm_data.csv",
#                                                       package = "ubiquity"))
#  cfg = system_clear_cohorts(cfg);

## ----eval=FALSE----------------------------------------------------------
#  filter = list()
#  filter$DOSE = c(10, 30)

## ----eval=FALSE----------------------------------------------------------
#  OBSMAP = list()
#  OBSMAP$PT = list(variance     = 'slope_parent*PRED^2',
#                   CMT          =  1,
#                   output       = 'Cpblood',
#                   missing      =  -1 )
#  
#  OBSMAP$MT = list(variance     = 'slope_metabolite*PRED^2',
#                   CMT          =  2,
#                   output       = 'Cmblood',
#                   missing      =  -1 )

## ----eval=FALSE----------------------------------------------------------
#  INPUTMAP = list()
#  INPUTMAP$bolus$Mpb$CMT_NUM             =  1

## ----eval=FALSE----------------------------------------------------------
#  cfg = system_define_cohorts_nm(cfg,
#                                 DS       = 'nm_pm_data',
#                                 col_ID   = 'ID',   col_CMT  = 'CMT', col_DV   = 'DV',
#                                 col_TIME = 'TIME', col_AMT  = 'AMT', col_RATE = 'RATE',
#                                 col_EVID = 'EVID', col_GROUP= 'DOSE',
#                                 filter   =  filter,
#                                 INPUTS   =  INPUTMAP,
#                                 OBS      =  OBSMAP,
#                                 group    =  FALSE)

## ----echo=FALSE, comment='', message=TRUE, eval=TRUE---------------------
cat(readLines(system.file("ubinc", "systems","system-adapt.txt", package="ubiquity")), sep="\n")

