## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message=FALSE, eval=FALSE)
require(ubiquity)
require(ggplot2)
require(rhandsontable)
require(gridExtra)
# The presim variable will contain presimualted data when eval is set to true
presim_loaded = FALSE

## ----echo=FALSE, results=FALSE-------------------------------------------
#    presim= list()
#    if(file.exists("NCA_presim.RData")){
#      file.remove("NCA_presim.RData")
#    }

## ----echo=FALSE, results=FALSE, eval=TRUE--------------------------------
if(file.exists("NCA_presim.RData")){
  load("NCA_presim.RData")
  presim_loaded = TRUE
}

## ----warning=FALSE, message=FALSE, echo=FALSE, error=FALSE, results="hide", fig.width=8, fig.height=4----
#  system_new(system_file="mab_pk", overwrite=TRUE)
#  cfg = build_system()
#  parameters = system_fetch_parameters(cfg)
#  cfg = system_zero_inputs(cfg)
#  cfg = system_set_bolus(cfg, state   ="At",
#                              times   = c(  0.0),  #  day
#                              values  = c(400.0))  #  mg
#  
#  cfg=system_set_option(cfg, group  = "simulation",
#                             option = "output_times",
#                             linspace(0,30,100))
#  
#  som_smooth = run_simulation_ubiquity(parameters, cfg)
#  som_smooth$simout$time_C_ng_ml = som_smooth$simout$C_ng_ml*som_smooth$simout$ts.days
#  
#  cfg=system_set_option(cfg, group  = "simulation",
#                              option = "include_important_output_times",
#                              value  = "no")
#  
#  cfg=system_set_option(cfg, group  = "simulation",
#                             option = "output_times",
#                             c(0,.25, .5, 1, 2,7,14,21,28))
#  som_sample = run_simulation_ubiquity(parameters, cfg)
#  som_sample$simout$time_C_ng_ml = som_sample$simout$C_ng_ml*som_sample$simout$ts.days
#  
#  
#  polydf = NULL
#  for(tidx in 1:(nrow(som_sample$simout)-1)){
#    xv = c(som_sample$simout$ts.days[tidx], som_sample$simout$ts.days[tidx+1],  som_sample$simout$ts.days[tidx+1], som_sample$simout$ts.days[tidx] )
#    yvC = c(som_sample$simout$C_ng_ml[tidx], som_sample$simout$C_ng_ml[tidx+1], 0, 0)
#    yvTC = c(som_sample$simout$time_C_ng_ml[tidx], som_sample$simout$time_C_ng_ml[tidx+1], 0, 0)
#    tmpdf = data.frame(xv = xv, yvC=yvC, yvTC=yvTC, sp=tidx)
#    if(is.null(polydf)){
#      polydf = tmpdf
#    } else {
#      polydf = rbind(tmpdf, polydf)
#    }
#  }

## ----results="hide", warning=FALSE, echo=FALSE---------------------------
#  # When eval is set to TRUE we save the presimulated results
#    presim$plots$som_smooth = som_smooth
#    presim$plots$som_sample = som_sample
#    presim$plots$polydf     = polydf

## ----results="hide", warning=FALSE, echo=FALSE, eval=TRUE----------------
if(presim_loaded){
  som_smooth = presim$plots$som_smooth 
  som_sample = presim$plots$som_sample 
  polydf     = presim$plots$polydf
}

## ----warning=FALSE, message=FALSE, echo=FALSE, error=FALSE, eval=TRUE, results="hide", fig.width=8, fig.height=4----
p_C = ggplot()
p_C = p_C +  geom_line(data=som_smooth$simout, aes(x=ts.days, y=C_ng_ml))
p_C = p_C + geom_point(data=som_sample$simout, aes(x=ts.days, y=C_ng_ml), color="blue")
p_C = p_C + xlab("Time") + ylab("Concentration") + ggtitle("AUC")
p_C = p_C +  geom_polygon(data=polydf, aes(x=xv, y=yvC, group=sp), color="blue", linetype='dashed', fill="lightblue")
p_C = p_C + theme(plot.title = element_text(hjust = 0.5))
p_C = prepare_figure(fo=p_C, purpose="shiny")


p_TC = ggplot()
p_TC = p_TC +  geom_line(data=som_smooth$simout, aes(x=ts.days, y=time_C_ng_ml))
p_TC = p_TC + geom_point(data=som_sample$simout, aes(x=ts.days, y=time_C_ng_ml), color="blue")
p_TC = p_TC + xlab("Time") + ylab("Time x Concentration") + ggtitle("AUMC")
p_TC = p_TC +  geom_polygon(data=polydf, aes(x=xv, y=yvTC, group=sp), color="blue", linetype='dashed', fill="lightblue")
p_TC = p_TC + theme(plot.title = element_text(hjust = 0.5))
p_TC = prepare_figure(fo=p_TC, purpose="shiny")


p_AUC = p_C
p_AUMC = p_TC

## ----warning=FALSE, message=FALSE, echo=FALSE, error=FALSE, eval=TRUE, fig.width=8, fig.height=3.5----
gridExtra::grid.arrange(p_AUC, p_AUMC, ncol=2)

## ----warning=FALSE, message=FALSE, echo=TRUE, error=FALSE, results="hide", fig.width=8, fig.height=4----
#  library(ubiquity)
#  fr = workshop_fetch(section="NCA", overwrite=TRUE)

## ----warning=FALSE, message=FALSE, echo=TRUE,  error=FALSE, results="hide", fig.width=8, fig.height=4----
#  library(ubiquity)
#  cfg = build_system()
#  fr = system_fetch_template(cfg, template = "NCA")

## ----warning=FALSE, message=FALSE, echo=TRUE,  error=FALSE, results="hide", fig.width=8, fig.height=4----
#  cfg = build_system(system_file="system.txt")
#  cfg = system_load_data(cfg, dsname     = "PKDATA",
#                              data_file  = "pk_all_sd.csv")

## ----echo=FALSE, fig.align="center", eval=TRUE---------------------------
rhandsontable(read.csv(system.file("ubinc", "csv", "pk_all_sd.csv" , package="ubiquity")), width=500, height=200)

## ----warning=FALSE, message=FALSE, echo=TRUE, error=FALSE, results="hide", fig.width=8, fig.height=4----
#  cfg = system_nca_run(cfg, dsname        = "PKDATA",
#                             dscale        = 1e6,
#                             analysis_name = "pk_single_dose",
#                             extrap_C0     = FALSE,
#                             dsmap         = list(TIME    = "TIME_HR",
#                                                  NTIME   = "TIME_HR",
#                                                  CONC    = "C_ng_ml",
#                                                  DOSE    = "DOSE",
#                                                  ROUTE   = "ROUTE",
#                                                  ID      = "ID"),
#                             digits        = 3)

## ----warning=FALSE, message=FALSE, echo=FALSE, error=FALSE---------------
#  nca_summary = read.csv(file.path("output", "pk_single_dose-nca_summary-pknca.csv"))
#  presim$sd$nca_summary = nca_summary

## ----results="hide", warning=FALSE, echo=FALSE, eval=TRUE----------------
if(presim_loaded){
  nca_summary = presim$sd$nca_summary
}

## ----echo=FALSE, fig.align="center", eval=TRUE---------------------------
rhandsontable(nca_summary,  width=500, height=200)

## ----warning=FALSE, message=FALSE, eval=FALSE, echo=TRUE, error=FALSE, results="hide", fig.width=8, fig.height=4----
#  cfg = system_report_init(cfg, rpttype="PowerPoint")
#  cfg = system_report_slide_title(cfg, title = "NCA of Single Dose PK")
#  cfg = system_report_nca(cfg, analysis_name = "pk_single_dose")
#  system_report_save(cfg, output_file=file.path("output", "pk_single_dose-report.pptx"))

## ----warning=FALSE, message=FALSE, eval=FALSE, echo=TRUE, error=FALSE, results="hide", fig.width=8, fig.height=4----
#  cfg = system_report_init(cfg, rpttype="Word")
#  cfg = system_report_nca(cfg, analysis_name = "pk_single_dose")
#  system_report_save(cfg=cfg, output_file=file.path("output", "pk_single_dose-report.docx"))

## ----warning=FALSE, message=FALSE, echo=TRUE, error=FALSE, results="hide", fig.width=8, fig.height=4----
#  cfg = build_system(system_file="system.txt")
#  cfg = system_load_data(cfg, dsname     = "PKDATA",
#                              data_file  = "pk_all_md.csv")

## ----echo=FALSE, fig.align="center", eval=TRUE---------------------------
rhandsontable(read.csv(system.file("ubinc", "csv", "pk_all_md.csv" , package="ubiquity")), width=500, height=200)

## ----warning=FALSE, message=FALSE, echo=FALSE, error=FALSE, results="hide", fig.width=8, fig.height=4----
#  cfg = system_nca_run(cfg, dsname        = "PKDATA",
#                            dscale        = 1e6,
#                            analysis_name = "pk_multiple_dose",
#                            dsmap         = list(TIME    = "TIME_HR",
#                                                 NTIME   = "NTIME_HR",
#                                                 CONC    = "C_ng_ml",
#                                                 DOSE    = "DOSE",
#                                                 ROUTE   = "ROUTE",
#                                                 ID      = "ID",
#                                                 DOSENUM = "DOSENUM",
#                                                 EXTRAP  = "EXTRAP"),
#                            digits        = 3)

## ----warning=FALSE, eval=FALSE, message=FALSE, echo=TRUE, error=FALSE, results="hide", fig.width=8, fig.height=4----
#  cfg = system_nca_run(cfg, dsname        = "PKDATA",
#                            dscale        = 1e6,
#                            analysis_name = "pk_multiple_dose",
#                            dsmap         = list(TIME    = "TIME_HR",
#                                                 NTIME   = "NTIME_HR",
#                                                 CONC    = "C_ng_ml",
#                                                 DOSE    = "DOSE",
#                                                 ROUTE   = "ROUTE",
#                                                 ID      = "ID",
#                                                 DOSENUM = "DOSENUM",
#                                                 EXTRAP  = "EXTRAP"),
#                            digits        = 3)
#  cfg = system_report_init(cfg)
#  cfg = system_report_slide_title(cfg, title = "NCA of Multiple Dose PK")
#  cfg = system_report_nca(cfg, analysis_name = "pk_multiple_dose")
#  system_report_save(cfg, output_file=file.path("output", "pk_multiple_dose-report.pptx"))

## ----warning=FALSE, message=FALSE, echo=FALSE, error=FALSE---------------
#  nca_summary = read.csv(file.path("output", "pk_multiple_dose-nca_summary-pknca.csv"))
#  presim$md$nca_summary = nca_summary

## ----results="hide", warning=FALSE, echo=FALSE, eval=TRUE----------------
if(presim_loaded){
  nca_summary = presim$md$nca_summary
}

## ----echo=FALSE, fig.align="center", eval=TRUE---------------------------
rhandsontable(nca_summary,  width=500, height=200)

## ----warning=FALSE, message=FALSE, echo=TRUE, error=FALSE, results="hide", fig.width=8, fig.height=4----
#  cfg = build_system(system_file="system.txt")
#  cfg = system_load_data(cfg, dsname     = "PKDATA",
#                              data_file  = "pk_sparse_sd.csv")

## ----echo=FALSE, fig.align="center", eval=TRUE---------------------------
rhandsontable(read.csv(system.file("ubinc", "csv", "pk_sparse_sd.csv" , package="ubiquity")), width=500, height=200)

## ----warning=FALSE, message=FALSE, echo=FALSE, error=FALSE, results="hide", fig.width=8, fig.height=4----
#  cfg = system_nca_run(cfg, dsname        = "PKDATA",
#                            dscale        = 1e6,
#                            analysis_name = "pk_sparse",
#                            sparse        = TRUE,
#                            dsmap         = list(TIME        = "TIME_HR",
#                                                 NTIME       = "TIME_HR",
#                                                 CONC        = "C_ng_ml",
#                                                 DOSE        = "DOSE",
#                                                 ROUTE       = "ROUTE",
#                                                 ID          = "ID",
#                                                 SPARSEGROUP = "DOSE"),
#                            digits        = 3)
#  
#  
#  cfg = system_report_init(cfg)
#  cfg = system_report_slide_title(cfg, title = "NCA of Sparsely Sampled PK")

## ----warning=FALSE, message=FALSE, eval=FALSE, echo=TRUE, error=FALSE, results="hide", fig.width=8, fig.height=4----
#  cfg = system_nca_run(cfg, dsname        = "PKDATA",
#                            dscale        = 1e6,
#                            analysis_name = "pk_sparse",
#                            sparse        = TRUE,
#                            dsmap         = list(TIME        = "TIME_HR",
#                                                 NTIME       = "TIME_HR",
#                                                 CONC        = "C_ng_ml",
#                                                 DOSE        = "DOSE",
#                                                 ROUTE       = "ROUTE",
#                                                 ID          = "ID",
#                                                 SPARSEGROUP = "DOSE"),
#                            digits        = 3)
#  
#  
#  cfg = system_report_init(cfg)
#  cfg = system_report_slide_title(cfg, title = "NCA of Sparsely Sampled PK")
#  cfg = system_report_nca(cfg, analysis_name = "pk_sparse")
#  system_report_save(cfg=cfg, output_file=file.path("output", "pk_sparse-report.pptx"))

## ----warning=FALSE, message=FALSE, echo=FALSE, error=FALSE---------------
#  nca_summary = read.csv(file.path("output", "pk_sparse-nca_summary-pknca.csv"))
#  presim$sparse$nca_summary = nca_summary

## ----results="hide", warning=FALSE, echo=FALSE, eval=TRUE----------------
if(presim_loaded){
  nca_summary = presim$sparse$nca_summary
}

## ----echo=FALSE, fig.align="center", eval=TRUE---------------------------
rhandsontable(nca_summary,  height=150, width=500)

## ----warning=FALSE, message=FALSE, echo=FALSE----------------------------
#  save(presim, file="NCA_presim.RData")

