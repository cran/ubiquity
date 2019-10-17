## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message=FALSE, eval=FALSE )
require(ubiquity)
require(deSolve)
require(ggplot2)
require(foreach)
require(doParallel)
require(doRNG)
require(ubiquity)
require(officer)
require(flextable)

## ------------------------------------------------------------------------
#  library(ubiquity)
#  fr = workshop_fetch(section="Reporting", overwrite=TRUE)

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  system_new(file_name="system.txt", system_file="mab_pk", overwrite = TRUE)
#  cfg = build_system(system_file = "system.txt")
#  cfg = system_report_init(cfg)

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  cfg = system_report_slide_title(cfg,
#             title     = "Generating Inline Reports",
#             sub_title = "A Working Example")

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  cfg = system_report_slide_content(cfg,
#             title     = "Single text area",
#             content   = "This vignette provides examples of how to add different types of slide content" )

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  lcont = c(1, "Top level item",
#            2, "This is a sub bullet",
#            2, "This is another sub bullet")
#  cfg = system_report_slide_content(cfg,
#             title        = "Lists are pretty straight forward",
#             content_type = "list",
#             content      = lcont)

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  parameters = system_fetch_parameters(cfg)
#  cfg = system_zero_inputs(cfg)
#  cfg = system_set_bolus(cfg, state = "At",
#                             times  = c(  0.0),
#                             values = c(400.0))
#  
#  cfg=system_set_option(cfg, group  = "simulation",
#                             option = "output_times",
#                             value  = seq(0,60,.1))
#  
#  som = run_simulation_ubiquity(parameters, cfg)

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  myfig = ggplot() +
#          geom_line(data=som$simout, aes(x=ts.days,   y=C_ng_ml), color="red")  +
#          xlab("Time (days)")+
#          ylab("C (ng/ml) (units)")
#  myfig = gg_log10_yaxis(myfig, ylim_min=1e3, ylim_max=1e5)
#  myfig = prepare_figure("present", myfig)

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  cfg = system_report_slide_content(cfg,
#             title        = "ggplot objects can be inserted directly",
#             content_type = "ggplot",
#             content      = myfig)

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  cfg = system_report_slide_content(cfg,
#             title        = "Images can be inserted from files",
#             sub_title    = "But the image should have the same aspect ratio as the placeholder",
#             content_type = "imagefile",
#             content      = system.file("ubinc", "images", "report_image.png", package="ubiquity"))

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  tcont = list()
#  tcont$table = parameters
#  cfg = system_report_slide_content(cfg,
#             title        = "Simple Tables",
#             content_type = "table",
#             content      = tcont)

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  tcont = list()
#  tcont$table = parameters
#  cfg = system_report_slide_content(cfg,
#             title        = "Flextables",
#             content_type = "flextable",
#             content      = tcont)

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  cfg = system_report_slide_two_col(cfg,
#         title                  = "Two columns of lists",
#         sub_title              = NULL,
#         content_type           = "list",
#         left_content           = lcont,
#         right_content_type     = "flextable",
#         right_content          = tcont)

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  cfg = system_report_slide_two_col(cfg,
#         title                  = "ggplot vs imagefile",
#         sub_title              = NULL,
#         content_type           = "list",
#         left_content_header    = "Image file",
#         left_content_type      = 'imagefile',
#         left_content           = system.file("ubinc", "images", "report_image.png", package="ubiquity"),
#         right_content_header   = "ggplot object",
#         right_content_type     = "ggplot",
#         right_content          = myfig)

## ----results="hide", message=FALSE, warning=FALSE------------------------
#  system_report_save(cfg, output_file = "report_vignette.pptx")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE------------
#  cfg = build_system()
#  cfg = system_report_init(cfg, template="mytemplate.pptx")
#  cfg = system_report_view_layout(cfg)

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE------------
#  tr = system_fetch_template(cfg, template="myOrg")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE------------
#  source("myOrg.R")
#  cfg = system_report_init(cfg  = cfg,
#              meta     = org_pptx_meta(),
#              template = "mytemplate.pptx")

