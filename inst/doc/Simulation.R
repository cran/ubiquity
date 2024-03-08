## ----setup, include=FALSE, message=FALSE, eval=TRUE---------------------------
knitr::opts_chunk$set(echo = TRUE, message=FALSE, eval=FALSE)
require(ubiquity)
require(deSolve)
require(ggplot2)
require(foreach)
require(doParallel)
require(rhandsontable)

## ----message=FALSE------------------------------------------------------------
#  library(ubiquity)
#  fr = workshop_fetch(section="Simulation", overwrite=TRUE)

## ----results="hide",  echo=FALSE----------------------------------------------
#  library(ubiquity)
#  system_new(file_name="system.txt", system_file="mab_pk", overwrite = TRUE)

## ----results="hide"-----------------------------------------------------------
#  cfg = build_system(system_file = "system.txt")

## ----results="hide", warning=FALSE, echo=FALSE--------------------------------
#  cfg_orig = cfg
#  save(cfg_orig, file="Simulation_cfg_orig.RData")

## ----echo=FALSE, eval=TRUE----------------------------------------------------
load(file="Simulation_cfg_orig.RData")

## ----results="hide"-----------------------------------------------------------
#  system_fetch_template(cfg, template="Simulation")

## ----results="hide", warning=FALSE--------------------------------------------
#  cfg = build_system(system_file = "system.txt")
#  parameters = system_fetch_parameters(cfg)

## ----results="hide"-----------------------------------------------------------
#  cfg = system_set_option(cfg, group  = "simulation",
#                               option = "output_times",
#                               seq(0,3*4*7,1))

## ----results="hide"-----------------------------------------------------------
#  cfg = system_zero_inputs(cfg)
#  cfg = system_set_bolus(cfg, state  = "At",
#                              times  = c(  0,  14,  28,  42 ), #  day
#                              values = c(200, 200, 200, 200 )) #  mg

## ----results="hide", warning=FALSE--------------------------------------------
#  som = run_simulation_ubiquity(parameters, cfg)

## ----results="hide", warning=FALSE, echo=FALSE--------------------------------
#  save(som, file="Simulation_som_single.RData")

## ----echo=FALSE, eval=TRUE----------------------------------------------------
load("Simulation_som_single.RData")
rhandsontable(som$simout, width=600, height=300)

## ----warning=FALSE, fig.width=7, fig.height=3, eval=TRUE----------------------
p = ggplot() + 
    geom_line(data=som$simout, aes(x=ts.days, y=C_ng_ml), color="blue")  +
    xlab("Time (days)")+
    ylab("C (ng/ml) (units)")
p = gg_log10_yaxis(p, ylim_min=1e3, ylim_max=3e5)
p = prepare_figure("print", p)
print(p)

## ----warning=FALSE, comment='', message=TRUE, echo=FALSE, eval=TRUE-----------
message(paste(system_view(cfg_orig, 'iiv'), collapse="\n"))

## ----warning=FALSE, results=FALSE---------------------------------------------
#  cfg=system_set_option(cfg, group  = "stochastic",
#                             option = "nsub",
#                             value  = 20)
#  
#  som  = simulate_subjects(parameters, cfg)

## ----results="hide", warning=FALSE, echo=FALSE--------------------------------
#  # Creating a reduced form of the simulation output to save it and use less disk space
#  tmpsom = som
#  som = list()
#  som$tcsummary = data.frame(o.C_ng_ml.mean  =  tmpsom$tcsummary$o.C_ng_ml.mean,
#                             o.C_ng_ml.ub_ci =  tmpsom$tcsummary$o.C_ng_ml.ub_ci,
#                             o.C_ng_ml.lb_ci =  tmpsom$tcsummary$o.C_ng_ml.lb_ci,
#                             ts.days         =  tmpsom$tcsummary$ts.days)
#  save(som, file="Simulation_som_multiple.RData")

## ----echo=FALSE, eval=TRUE----------------------------------------------------
load("Simulation_som_multiple.RData")

## ----warning=FALSE, fig.width=7, fig.height=3, eval=TRUE----------------------
p = ggplot(som$tcsummary, aes(x=ts.days, y=o.C_ng_ml.mean)) +
           geom_ribbon(aes(ymin=o.C_ng_ml.lb_ci, 
                           ymax=o.C_ng_ml.ub_ci), 
                           fill="lightblue", 
                           alpha=0.6) +
           geom_line(linetype="solid", size=0.7, color="blue")  +
           geom_line(aes(x=ts.days, y=o.C_ng_ml.ub_ci), linetype="dashed", size=0.2, color="blue")  +
           geom_line(aes(x=ts.days, y=o.C_ng_ml.lb_ci), linetype="dashed", size=0.2, color="blue")  +
           xlab("Time (days)")+
           ylab("C (ng/ml) (units)")+
           guides(fill="none") 


p     = gg_log10_yaxis(p    , ylim_min=1e3, ylim_max=3e5)
p     = prepare_figure("print", p    )
print(p)

## ----echo=TRUE, warning=FALSE-------------------------------------------------
#  cfg = system_load_data(cfg,
#                         dsname    = "SUBS",
#                         data_file = system.file("ubinc", "csv", "mab_pk_subjects.csv",
#                                                 package = "ubiquity"))

## ----echo=FALSE, eval=TRUE----------------------------------------------------
SUBSCSV= read.csv(system.file("ubinc", "csv", "mab_pk_subjects.csv",  package = "ubiquity"))
rhandsontable( SUBSCSV, width=800, height=300)

## ----results=FALSE------------------------------------------------------------
#  cfg=system_set_option(cfg, group  = "stochastic",
#                             option = "sub_file",
#                             value  = "SUBS")
#  
#  cfg=system_set_option(cfg, group  = "stochastic",
#                             option = "sub_file_sample",
#                             value  = "with replacement")

## ----results=FALSE, warning=FALSE, eval=FALSE---------------------------------
#  som  = simulate_subjects(parameters, cfg)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  cfg=system_set_option(cfg, group  = "simulation",
#                             option = "parallel",
#                             value  = "multicore")
#  
#  cfg=system_set_option(cfg, group  = "simulation",
#                             option = "compute_cores",
#                             value  = detectCores() - 1)
#  

## ----echo=FALSE, comment='', message=TRUE, eval=TRUE--------------------------
cat(readLines(system.file("ubinc", "systems","system-mab_pk.txt", package="ubiquity")), sep="\n")

