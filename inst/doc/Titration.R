## ----setup, include=FALSE, eval=TRUE------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message=FALSE, eval=FALSE)
require(ubiquity)
require(deSolve)
require(ggplot2)
require(foreach)
require(doParallel)
require(rhandsontable)

# The presim variable will contain presimualted data when eval is set to true
presim_loaded = FALSE

## ----echo=FALSE, results=FALSE------------------------------------------------
#    presim= list()
#    if(file.exists("Titration_presim.RData")){
#      file.remove("Titration_presim.RData")
#    }

## ----echo=FALSE, results=FALSE, eval=TRUE-------------------------------------
if(file.exists("Titration_presim.RData")){
  load("Titration_presim.RData")
  presim_loaded = TRUE
}

## ----eval=FALSE---------------------------------------------------------------
#  library(ubiquity)
#  fr = workshop_fetch(section="Titration", overwrite=TRUE)

## ----results="hide", message=FALSE, echo=FALSE--------------------------------
#  library(ubiquity)
#  system_new(file_name="system.txt", system_file="mab_pk", overwrite = TRUE)

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  cfg = build_system()
#  cfg = system_select_set(cfg, "default")
#  parameters = system_fetch_parameters(cfg)
#  cfg=system_set_option(cfg,group   = "simulation", option = "solver",       value = "lsoda")
#  cfg=system_set_option(cfg, group  = "simulation", option = "output_times",  seq(0,10*7,1))
#  cfg = system_zero_inputs(cfg)
#  cfg = system_set_bolus(cfg, state   = "Cc",
#                              times   = c(0, 14, 28, 42, 56),
#                              values  = c(500, 500, 500, 500, 500))
#  som_fix = run_simulation_ubiquity(parameters, cfg)

## ----results="hide", message=FALSE--------------------------------------------
#  cfg=system_set_option(cfg,
#                        group       = "titration",
#                        option      = "titrate",
#                        value       = TRUE)

## ----results="hide", message=FALSE--------------------------------------------
#  cfg=system_new_tt_rule(cfg,
#                         name       = "ivdose",
#                         times      = c(0, 2, 4, 6, 8),
#                         timescale  = "weeks")

## ----results="hide", message=FALSE--------------------------------------------
#  cfg=system_set_tt_cond(cfg,
#                         name       = "ivdose",
#                         cond       = "TRUE",
#                         action     = "SI_TT_BOLUS[state='Cc', values=500, times=0]",
#                         value      = "1")

## ----results="hide", message=FALSE--------------------------------------------
#  som_tt = run_simulation_titrate(parameters, cfg)

## ----results="hide", warning=FALSE, echo=FALSE--------------------------------
#  # When eval is set to TRUE we save the presimulated results
#  presim$bolus$som_tt$simout  = data.frame(ts.days = som_tt$simout$ts.days,
#                                           Cc      = som_tt$simout$Cc)
#  presim$bolus$som_fix$simout = data.frame(ts.days = som_fix$simout$ts.days,
#                                           Cc      = som_fix$simout$Cc)

## ----results="hide", warning=FALSE, echo=FALSE, eval=TRUE---------------------
if(presim_loaded){
  som_tt  = presim$bolus$som_tt
  som_fix = presim$bolus$som_fix
}

## ----warning=FALSE, message=FALSE, fig.width=7, fig.height=3, eval=TRUE-------
 myfig = ggplot() + 
         geom_line(data=som_fix$simout, aes(x=ts.days,   y=Cc, color="Fixed Dosing"), linetype=1) +
         geom_line(data=som_tt$simout,  aes(x=ts.days,   y=Cc, color="Titration"   ), linetype=2)  +
         scale_colour_manual(values=c("Fixed Dosing"="darkblue", "Titration"="firebrick3"))  +
         theme(legend.title = element_blank()) +
         theme(legend.position = 'bottom')     

 myfig = prepare_figure('present', myfig) 

 print(myfig)

## ----warning=FALSE, message=FALSE, echo=FALSE---------------------------------
#  # resetting everything for the repeat infusion example
#  cfg = system_select_set(cfg, "default")
#  parameters = system_fetch_parameters(cfg)
#  cfg=system_set_option(cfg,group = "simulation", option = "solver", value = "lsoda")
#  cfg=system_set_option(cfg, group  = "simulation",
#                             option = "output_times",
#                             seq(0,10*7,.5))

## ----warning=FALSE, message=FALSE---------------------------------------------
#  cfg = system_zero_inputs(cfg)
#  cfg = system_set_rate(cfg, rate    = "Dinf",
#                  times   = c( 0, 30, 20160, 20190, 40320, 40350, 60480, 60510, 80640, 80670),
#                  levels  = c(15 , 0,    15,     0,    15,     0,    15,     0,    15,     0))
#  som_fix = run_simulation_ubiquity(parameters, cfg)

## ----warning=FALSE, message=FALSE---------------------------------------------
#  cfg=system_set_option(cfg, group = "titration", option = "titrate",        value     = TRUE)
#  cfg=system_new_tt_rule(cfg, name = "ivdose",    times  = c(0, 2, 4, 6, 8), timescale = "weeks")

## ----warning=FALSE, message=FALSE---------------------------------------------
#  cfg=system_set_tt_cond(cfg,
#                         name       = "ivdose",
#                         cond       = "TRUE",
#                         action     = "SI_TT_RATE[rate='Dinf', times=c(0,30), levels=c(15,0)]",
#                         value      = "1")

## ----warning=FALSE, message=FALSE---------------------------------------------
#  som_tt = run_simulation_titrate(parameters, cfg)

## ----results="hide", warning=FALSE, echo=FALSE--------------------------------
#  # When eval is set to TRUE we save the presimulated results
#  presim$infusion$som_tt$simout  = data.frame(ts.days = som_tt$simout$ts.days,
#                                              Cc      = som_tt$simout$Cc)
#  presim$infusion$som_fix$simout = data.frame(ts.days = som_fix$simout$ts.days,
#                                              Cc      = som_fix$simout$Cc)

## ----results="hide", warning=FALSE, echo=FALSE, eval=TRUE---------------------
if(presim_loaded){
  som_tt  = presim$infusion$som_tt
  som_fix = presim$infusion$som_fix
}

## ----warning=FALSE, message=FALSE, fig.width=7, fig.height=3, eval=TRUE-------
 myfig = ggplot() + 
         geom_line(data=som_fix$simout, aes(x=ts.days,   y=Cc, color="Fixed Dosing"), linetype=1) +
         geom_line(data=som_tt$simout,  aes(x=ts.days,   y=Cc, color="Titration"   ), linetype=2)  +
         scale_colour_manual(values=c("Fixed Dosing"="darkblue", "Titration"="firebrick3"))  +
         theme(legend.title = element_blank()) +
         theme(legend.position = 'bottom')     

 myfig = prepare_figure('present', myfig) 

 print(myfig)

## ----warning=FALSE, message=FALSE, echo=FALSE---------------------------------
#  cfg = system_select_set(cfg, "default")
#  parameters = system_fetch_parameters(cfg)
#  cfg=system_set_option(cfg,group = "simulation", option = "solver", value = "lsoda")
#  cfg=system_set_option(cfg, group  = "simulation",
#                             option = "output_times",
#                             seq(0,28*7*4,8))
#  cfg=system_set_option(cfg,
#                        group       = "titration",
#                        option      = "titrate",
#                        value       = TRUE)

## ----warning=FALSE, message=FALSE---------------------------------------------
#  cfg=system_new_tt_rule(cfg,
#      name       = "ivdose",
#      times      = c(0, 6, 12, 18, 24),
#      timescale  = "months")
#  cfg=system_set_tt_cond(cfg,
#      name   = "ivdose",
#      cond   = "Cc < 900",
#      action = "SI_TT_BOLUS[state='At', values=700, times=0, repdose='last', number=11, interval=14]",
#      value  = "700")
#  cfg=system_set_tt_cond(cfg,
#      name   = "ivdose",
#      cond   = "Cc > 900",
#      action = "SI_TT_BOLUS[state='At', values=600, times=0, repdose='last', number=11, interval=14]",
#      value  = "600")
#  
#  som_tt = run_simulation_titrate(parameters, cfg)

## ----results="hide", warning=FALSE, echo=FALSE--------------------------------
#  # When eval is set to TRUE we save the presimulated results
#  presim$visit$som_tt$simout  = data.frame(ts.days  = som_tt$simout$ts.days,
#                                           ts.weeks = som_tt$simout$ts.weeks,
#                                           Cc       = som_tt$simout$Cc)
#  presim$visit$som_tt$titration         = som_tt$titration[1:100,]
#  presim$visit$som_tt$titration_history = som_tt$titration_history

## ----results="hide", warning=FALSE, echo=FALSE, eval=TRUE---------------------
if(presim_loaded){
  som_tt  = presim$visit$som_tt
}

## ----warning=FALSE, message=FALSE, fig.width=7, fig.height=3, eval=TRUE-------
myfig = ggplot() + 
        geom_line(data=som_tt$simout, aes(x=ts.weeks,   y=Cc), color="blue")  
myfig = prepare_figure('present', myfig) 
print(myfig)

## ----echo=FALSE, fig.align="center", eval=TRUE--------------------------------
rhandsontable(som_tt$titration, width=550)

## ----echo=FALSE, fig.align="center", eval=TRUE--------------------------------
rhandsontable(som_tt$titration_history, width=550)

## ----echo=TRUE, message=FALSE, results=FALSE, warning=FALSE-------------------
#  cfg = system_set_option(cfg, group="stochastic", option="nsub",    value=20)
#  som= simulate_subjects(parameters, cfg)

## ----results="hide", warning=FALSE, echo=FALSE--------------------------------
#  # When eval is set to TRUE we save the presimulated results
#  sdf = som_to_df(cfg, som)
#  sdf = sdf[1:100,]
#  #presim$visit$som  = som
#  presim$visit$sdf  = sdf

## ----results="hide", warning=FALSE, echo=FALSE, eval=TRUE---------------------
if(presim_loaded){
  #som = presim$visit$som       
  sdf = presim$visit$sdf
}

## ----message=FALSE, results=FALSE, eval=FALSE---------------------------------
#  sdf = som_to_df(cfg, som)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
rhandsontable(sdf, width=600, height=300)

## ----warning=FALSE, message=FALSE, echo=FALSE---------------------------------
#  cfg = system_select_set(cfg, "default")
#  parameters = system_fetch_parameters(cfg)
#  cfg=system_set_option(cfg,group = "simulation", option = "solver", value = "lsoda")
#  cfg=system_set_option(cfg, group  = "simulation",
#                             option = "output_times",
#                             seq(0,10*7,1))
#  cfg=system_set_option(cfg,
#                        group       = "titration",
#                        option      = "titrate",
#                        value       = TRUE)

## ----message=FALSE, results=FALSE---------------------------------------------
#  cfg=system_new_tt_rule(cfg,
#                         name       = "ivdose",
#                         times      = c(0, 2, 4, 6, 8),
#                         timescale  = "weeks")
#  
#  cfg=system_set_tt_cond(cfg,
#                         name       = "ivdose",
#                         cond       = 'TRUE',
#                         action     = "SI_TT_BOLUS[state='Cc', values=500, times=0]",
#                         value      = "5")

## ----message=FALSE, results=FALSE---------------------------------------------
#  cfg=system_new_tt_rule(cfg,
#                         name       = "state_reset",
#                         times      = c(3),
#                         timescale  = "weeks")
#  cfg=system_set_tt_cond(cfg,
#                         name       = "state_reset",
#                         cond       = 'TRUE',
#                         action     = "SI_TT_STATE[Cc][0.5*Cc]",
#                         value      = "0")
#  cfg=system_set_tt_cond(cfg,
#                         name       = "state_reset",
#                         cond       = 'TRUE',
#                         action     = "SI_TT_STATE[Cp][0.5*Cp]",
#                         value      = "0")
#  som_tt = run_simulation_titrate(parameters, cfg)

## ----results="hide", warning=FALSE, echo=FALSE--------------------------------
#  # When eval is set to TRUE we save the presimulated results
#  presim$state$som_tt$simout  = data.frame(ts.weeks = som_tt$simout$ts.weeks,
#                                           Cc       = som_tt$simout$Cc)

## ----results="hide", warning=FALSE, echo=FALSE, eval=TRUE---------------------
if(presim_loaded){
  som_tt  = presim$state$som_tt
}

## ----warning=FALSE, message=FALSE, fig.width=7, fig.height=3, eval=TRUE-------
myfig = ggplot() +
        geom_line(data=som_tt$simout, aes(x=ts.weeks,   y=Cc), color="red")  
myfig = prepare_figure('present', myfig) 
print(myfig)

## ----warning=FALSE, message=FALSE, echo=FALSE---------------------------------
#  save(presim, file="Titration_presim.RData")

## ----echo=FALSE, comment='', message=TRUE, eval=TRUE--------------------------
cat(readLines(system.file("ubinc", "systems","system-mab_pk.txt", package="ubiquity")), sep="\n")

