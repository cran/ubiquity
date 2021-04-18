## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message=FALSE, eval=FALSE)
require(ubiquity)
require(deSolve)
require(ggplot2)
require(foreach)
require(doParallel)
require(ubiquity)
require(officer)
require(flextable)

## -----------------------------------------------------------------------------
#  library(ubiquity)
#  fr = workshop_fetch(section="Reporting", overwrite=TRUE)

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  system_new(file_name="system.txt", system_file="mab_pk", overwrite = TRUE)
#  cfg = build_system(system_file = "system.txt")
#  cfg = system_report_init(cfg, rpttype="PowerPoint")

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  cfg = system_report_slide_title(cfg,
#             title     = "Generating Inline Reports",
#             sub_title = "A Working Example")

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  cfg = system_report_slide_content(cfg,
#             title     = "Single text area",
#             content   = "This vignette provides examples of how to add different types of slide content" )

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  lcont = c(1, "Top level item",
#            2, "This is a sub bullet",
#            2, "This is another sub bullet")
#  cfg = system_report_slide_content(cfg,
#             title        = "Lists are pretty straight forward",
#             content_type = "list",
#             content      = lcont)

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
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

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  myfig = ggplot() +
#          geom_line(data=som$simout, aes(x=ts.days,   y=C_ng_ml), color="red")  +
#          xlab("Time (days)")+
#          ylab("C (ng/ml) (units)")
#  myfig = gg_log10_yaxis(myfig, ylim_min=1e3, ylim_max=1e5)
#  myfig = prepare_figure("present", myfig)

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  cfg = system_report_slide_content(cfg,
#             title        = "ggplot objects can be inserted directly",
#             content_type = "ggplot",
#             content      = myfig)

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  cfg = system_report_slide_content(cfg,
#             title        = "Images can be inserted from files",
#             sub_title    = "But the image should have the same aspect ratio as the placeholder",
#             content_type = "imagefile",
#             content      = system.file("ubinc", "images", "report_image.png", package="ubiquity"))

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  tcont = list()
#  tcont$table = parameters
#  cfg = system_report_slide_content(cfg,
#             title        = "Simple Tables",
#             content_type = "table",
#             content      = tcont)

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  tcont = list()
#  tcont$table = parameters
#  cfg = system_report_slide_content(cfg,
#             title        = "Flextables",
#             content_type = "flextable",
#             content      = tcont)

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  cfg = system_report_slide_two_col(cfg,
#          title                  = "Two columns of plain text",
#          sub_title              = "Subtitle",
#          content_type           = "text",
#          left_content           = "Left Side",
#          right_content          = "Right Side")
#  
#  cfg = system_report_slide_two_col(cfg,
#         title                  = "Two Col Text w/Headers",
#         sub_title              = "Two columns of text with headers",
#         content_type           = "list",
#         right_content          = c(1, "Right Text"),
#         left_content_type      = "list",
#         left_content           = c(1, "Left Text"),
#         right_content_type     = "list")

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  cfg = system_report_slide_two_col(cfg,
#         title                  = "Two columns of lists",
#         sub_title              = NULL,
#         content_type           = "list",
#         left_content           = lcont,
#         right_content_type     = "flextable",
#         right_content          = tcont)

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  
#  cfg = system_report_slide_two_col(cfg,
#         title                  = "Two Col Text w/Headers",
#         sub_title              = "Two columns of text with headers",
#         content_type           = "text",
#         right_content          = "Right Text",
#         left_content_type      = "text",
#         left_content           = "Left Text",
#         left_content_header    = "Left Header",
#         right_content_header   = "Right Header")
#  
#  cfg = system_report_slide_two_col(cfg,
#         title                  = "Two Col Text w/Headers",
#         sub_title              = "Two columns of text with headers",
#         content_type           = "list",
#         right_content          = c(1, "Right Text"),
#         left_content_type      = "list",
#         left_content           = c(1, "Left Text"),
#         left_content_header    = "Left Header",
#         right_content_type     = "list",
#         right_content_header   = "Right Header")

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
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

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  data = data.frame(property = c("mean",   "variance"),
#                    Cmax     = c(2,         0.1),
#                    AUCinf   = c(22,       0.21),
#                    AUClast  = c(22,       0.21))
#  
#  header = list(property = c("",              ""),
#                Cmax     = c("Cmax",          "ng/ml"),
#                AUCinf   = c("AUCinf",        "mL/hr"),
#                AUClast  = c("AUClast",       "mL/hr"))

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  library(magrittr)
#  library(flextable)
#  ft = flextable::flextable(data)                     %>%
#       flextable::delete_part(part = "header")        %>%
#       flextable::add_header(values =as.list(header)) %>%
#       flextable::theme_zebra()

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  cfg = system_report_slide_content(cfg,
#         title        = "Userdefined Flextable",
#         sub_title    = "flextable_object",
#         content_type = "flextable_object",
#         content      = ft)

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  system_report_save(cfg, output_file = "report_vignette.pptx")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = system_report_init(cfg, rpttype="Word")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = system_report_doc_add_content(cfg,
#    content_type  = "toc",
#    content       = list(level=1))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = system_report_doc_add_content(cfg,
#    content_type  = "text",
#    content       = list(style   = "h1",
#                         text    = "This will insert a level 1 header"))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = system_report_doc_add_content(cfg,
#    content_type  = "text",
#    content       = list(style   = "normal",
#                         text    = "This is plain text"))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  fpartext = fpar(
#  ftext("Formatted text can be created using the ", prop=prop=officer::fp_text()),
#  ftext("fpar ", prop=officer::fp_text(color="green")),
#  ftext("command from the officer package.", prop=prop=officer::fp_text()))
#  
#  cfg = system_report_doc_add_content(cfg,
#    content_type  = "text",
#    content       = list(style   = "normal",
#                         format  = "fpar",
#                         text    = fpartext))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  mdtext = "Text can be specified in markdown format as well. You can specify
#  *bold text*, **italicized text**, ^superscripts^ and ~subscripts~. These can
#  be combined as well *H*~*2*~*0*.
#  
#  You can change colors to  <color:red>red</color>, <color:blue>blue</color>, etc and
#  change the <shade:#33ff33>shading</shade>. Again these can be combined
#  <shade:orange><color:green>both color and shading</color></shade>. You can also
#  change the font to things like <ff:symbol>*symbol*</ff>."
#  
#  cfg = system_report_doc_add_content(cfg,
#    content_type  = "text",
#    content       = list(style  = "normal",
#                         format = "md",
#                         text   = mdtext))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  p = ggplot() + annotate("text", x=0, y=0, label = "picture example")
#  imagefile = tempfile(pattern="image", fileext=".png")
#  ggsave(filename=imagefile, plot=p, height=5.15, width=9, units="in")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = system_report_doc_add_content(cfg,
#    content_type  = "imagefile",
#    content       = list(image   = imagefile,
#                         caption = "This is an image file"))
#  
#  cfg = system_report_doc_add_content(cfg,
#    content_type  = "ggplot",
#    content       = list(image   = p,
#                         caption = "This is a ggplot image"))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  tc = list()
#  tc$table = data.frame(Parameters = c("Vp", "Cl", "Q", "Vt"),
#                        Values     = 1:4,
#                        Units      = c("L", "L/hr", "L/hr", "L") )
#  tc$header    = TRUE
#  tc$first_row = TRUE
#  tc$caption = "This is a table"
#  
#  cfg = system_report_doc_add_content(cfg,
#    content_type  = "table",
#    content       = tc)

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  tcf = list()
#  tcf$caption = "This is a flextable"
#  tcf$table = data.frame(Parameters = c("Vp", "Cl", "Q", "Vt"),
#                         Values     = 1:4,
#                         Units      = c("L", "L/hr", "L/hr", "L") )
#  tcf$header_top   =
#       list(Parameters     = "Name",
#            Values         = "Value",
#            Units          = "Units")
#  
#  tcf$cwidth        = 0.8
#  tcf$table_autofit = TRUE
#  tcf$table_theme   ='theme_zebra'
#  
#  cfg = system_report_doc_add_content(cfg,
#    content_type  = "flextable",
#    content       = tcf)

## ----results="hide", message=FALSE, warning=FALSE, eval=TRUE------------------
library(magrittr)
library(flextable)

data = data.frame(property = c("mean",   "variance"),
                  Cmax     = c(2,         0.1),
                  AUCinf   = c(22,       0.21),
                  AUClast  = c(22,       0.21))

header = list(property = c("",              ""),
              Cmax     = c("Cmax",          "ng/ml"),
              AUCinf   = c("AUCinf",        "mL/hr"),
              AUClast  = c("AUClast",       "mL/hr"))

# This creates a flextable object:
ft = flextable::flextable(data)                     %>% 
     flextable::delete_part(part = "header")        %>%
     flextable::add_header(values =as.list(header)) %>%
     flextable::theme_zebra()

## ----eval=TRUE, message=FALSE, warning=FALSE, echo=FALSE----------------------
knitr::knit_print(ft)

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  tcfo = list(caption = "This is a flextable object",
#              key     = "TAB_FTO",
#              ft      = ft)
#  
#  cfg = system_report_doc_add_content(cfg,
#    content_type  = "flextable_object",
#    content       = tcfo)

## ----results="hide", message=FALSE, warning=FALSE, eval=TRUE------------------
ftf = flextable::flextable(data)                                                                       %>% 
      flextable::delete_part(part = "header")                                                          %>%
      flextable::add_header(values =as.list(header)) %>%
      flextable::compose(j    = "Cmax",                                                    
                        part  = "header",                                                          
                        value = c(md_to_oo("*C*~*max*~")$oo, md_to_oo("*ng/ml*")$oo))                  %>%
      flextable::compose(j    = "AUClast",                                                    
                        part  = "header",                                                          
                        value = c(md_to_oo("*AUC*~*last*~")$oo, md_to_oo("*ml\U00B7hr*^*-1*^")$oo))         %>%
      flextable::compose(j    = "AUCinf",                                                    
                        part  = "header",                                                          
                        value = c(md_to_oo("*AUC*~*inf*~")$oo, md_to_oo("*ml\U00B7hr*^*-1*^")$oo))          %>%
      flextable::compose(j     = "property",                                                         
                         i     = match("mean", data$property),                        
                         part  = "body",                                                          
                         value = c(md_to_oo("Mean (<ff:symbol>m</ff>)")$oo))                            %>%
      flextable::compose(j     = "property",                                                         
                         i     = match("variance", data$property),                        
                         part  = "body",                                                          
                         value = c(md_to_oo("Variance (<ff:symbol>s</ff>^2^)")$oo))                     %>%
      flextable::autofit()                                                                             %>%
      flextable::theme_zebra()

## ----eval=TRUE, message=FALSE, warning=FALSE, echo=FALSE----------------------
knitr::knit_print(ftf)

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  tcfo = list(caption = "This is a flextable object",
#              key     = "TAB_FTO_FORMATTED",
#              ft      = ftf)
#  cfg = system_report_doc_add_content(cfg,
#    content_type  = "flextable_object",
#    content       = tcfo)

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = system_report_doc_set_ph(cfg,
#        ph_content  = "Jill Smith" ,
#        ph_name     = "PHName",
#        ph_location = "header")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = system_report_doc_format_section(cfg, section_type="continuous")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  p = ggplot() + annotate("text", x=0, y=0, label = "picture example")
#  
#  cfg = system_report_doc_add_content(cfg,
#    content_type  = "ggplot",
#    content       = list(image   = p,
#                         height  = 2.5,
#                         width   = 9,
#                         caption = "This is a landscape figure"))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = system_report_doc_format_section(cfg, section_type="landscape", h=8, w=10)

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
#  system_report_save(cfg, output_file = "report_vignette.docx")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = build_system()
#  cfg = system_report_init(cfg, template="mytemplate.pptx")
#  cfg = system_report_view_layout(cfg)

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = build_system()
#  cfg = system_report_init(cfg, template="mytemplate.docx")
#  cfg = system_report_view_layout(cfg)

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  tr = system_fetch_template(cfg, template="myOrg")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  source("myOrg.R")
#  cfg = system_report_init(cfg  = cfg,
#              meta     = org_pptx_meta(),
#              template = "mytemplate.pptx")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  source("myOrg.R")
#  cfg = system_report_init(cfg  = cfg,
#              meta     = org_docx_meta(),
#              template = "mytemplate.docx")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = system_report_estimation(cfg=cfg, analysis_name="analysis_name")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = system_report_nca(cfg, analysis_name = "default")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  rpt = system_report_fetch(cfg)

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
#  cfg = system_report_set(cfg, rpt = rpt)

