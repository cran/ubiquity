## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message=FALSE, eval=FALSE)
require(ubiquity)
require(ggplot2)
require(ubiquity)
require(officer)
require(onbrand)
require(flextable)

## ----results="hide", warning=FALSE, echo=FALSE--------------------------------
# fr = system_new(file_name        = "system.txt",
#                 system_file      = "mab_pk",
#                 overwrite        = TRUE,
#                 output_directory = tempdir())
# cfg = build_system(system_file  = file.path(tempdir(), "system.txt"),
#       output_directory          = file.path(tempdir(), "output"),
#       temporary_directory       = tempdir())
# cfg_pptx = system_rpt_read_template(cfg, "PowerPoint")
# cfg_docx = system_rpt_read_template(cfg, "Word")
# fr_pptx = system_rpt_template_details(cfg_pptx)
# fr_docx = system_rpt_template_details(cfg_docx)
# 
# tdeets = list()
# tdeets[["pptx"]][["txt"]] = fr_pptx[["txt"]]
# tdeets[["docx"]][["txt"]] = fr_docx[["txt"]]
# tdeets[["pptx"]][["ft"]]  = fr_pptx[["ft"]]
# tdeets[["docx"]][["ft"]]  = fr_docx[["ft"]]
# 
# save(tdeets, file="Reporting.RData")

## ----echo=FALSE, eval=TRUE----------------------------------------------------
# This should create tdeets
load("Reporting.RData")

## -----------------------------------------------------------------------------
# library(ubiquity)
# fr = workshop_fetch(section="Reporting", overwrite=TRUE)

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# cfg = build_system("system.txt")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# library(ggplot2)
# p = ggplot() + annotate("text", x=0, y=0, label = "picture example")
# imgfile = tempfile(pattern="image", fileext=".png")
# ggsave(filename=imgfile, plot=p, height=5.15, width=9, units="in")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# tdata =  data.frame(Parameters = c("Vp", "Cl", "Q", "Vt"),
#                     Values     = 1:4,
#                     Units      = c("L", "L/hr", "L/hr", "L") )

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# tco  = list(table     = tdata,
#             header    = TRUE,
#             first_row = FALSE)

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# tcf = list(table       = tdata,             # This element contains the table data
#            header_top  = list(              # Defining the table headers
#              Parameters = "Name",
#              Values     = "Value",
#              Units      = "Units"),
#            cwidth         = 0.8,            # Column width
#            table_autofit  = TRUE,           # Making the tables automatically fit
#            table_theme    = "theme_zebra",  # Selecting the table theme
#            first_row = FALSE)
# 

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# tfo = flextable::flextable(tdata)
# tfo = flextable::autofit(tfo)

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# lcontent = c(1, "First major item",
#              2, "first sub bullet",
#              2, "second sub bullet",
#              3, "sub sub bullet",
#              1, "Second major item",
#              2, "first sub bullet",
#              2, "second sub bullet")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# cfg = system_rpt_read_template(cfg, "PowerPoint")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# cfg = system_rpt_add_slide(cfg,
#    template = "title_slide",
#    elements = list(
#       title=list(content = "Reporting in ubiquity",
#                  type    = "text")))
# cfg = system_rpt_add_slide(cfg,
#    template = "section_slide",
#    elements = list(
#       title=list(content = "Content Types",
#                  type    = "text")))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# fr = system_rpt_template_details(cfg)

## ----message=FALSE, warning=FALSE, eval=TRUE, echo=FALSE, message=FALSE-------
trim_idx = min(c(18, length(tdeets[["pptx"]][["txt"]])))
cat(paste(tdeets[["pptx"]][["txt"]][1:trim_idx], collapse="\n"))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# cfg = system_rpt_add_slide(cfg,
#    template = "content_list",
#    elements = list(
#       title=
#         list(content = "Lists",
#              type    = "text"),
#       sub_title=
#         list(content = "For placholders that contain lists.",
#              type    = "text"),
#       content_body=
#         list(content = lcontent,
#              type    = "list")))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# cfg = system_rpt_add_slide(cfg,
#    template = "content_text",
#    elements = list(
#       title=
#         list(content = "Figures: ggplot object",
#              type    = "text"),
#       sub_title=
#         list(content = "Using ggplot objects directly",
#              type    = "text"),
#       content_body=
#         list(content = p,
#              type    = "ggplot")))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# cfg = system_rpt_add_slide(cfg,
#    template = "content_text",
#    elements = list(
#       title=
#         list(content = "Figures: image file",
#              type    = "text"),
#       sub_title=
#         list(content = "Inserting figures from files",
#              type    = "text"),
#       content_body=
#         list(content = imgfile,
#              type    = "imagefile")))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# cfg = system_rpt_add_slide(cfg,
#    template = "content_text",
#    elements = list(
#       title=
#         list(content = "Tables: Office",
#              type    = "text"),
#       sub_title=
#         list(content = "Table in native Office format",
#              type    = "text"),
#       content_body=
#         list(content = tco,
#              type    = "table")))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# cfg = system_rpt_add_slide(cfg,
#    template = "content_text",
#    elements = list(
#       title=
#         list(content = "Tables: flextable",
#              type    = "text"),
#       sub_title=
#         list(content = "Flextables using onbrand abstraction",
#              type    = "text"),
#       content_body=
#         list(content = tcf,
#              type    = "flextable")))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# cfg = system_rpt_add_slide(cfg,
#    template = "content_text",
#    elements = list(
#       title=
#         list(content = "Tables: flextable object",
#              type    = "text"),
#       sub_title=
#         list(content = "Flextables using a user-created flextable object",
#              type    = "text"),
#       content_body=
#         list(content = tfo,
#              type    = "flextable_object")))

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# system_rpt_save_report(cfg, output_file = "example.pptx")

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# plain_text_content = paste(rep("The quick brown fox jumped over the lazy dog.", 70), collapse= " ")
# md_text_content    = paste(rep("The *quick* <color:brown>brown</color> fox **jumped** over the ~lazy dog~.", 70), collapse=" ")
# fpar_text_content  = officer::fpar(
#    officer::ftext("The quick ", prop=NULL),
#    officer::ftext("brown", prop=officer::fp_text(color="brown")),
#    officer::ftext(" fox jumped over the lazy dog.", prop=NULL))

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# library(ggplot2)
# p = ggplot() + annotate("text", x=0, y=0, label = "picture example")
# imgfile = tempfile(pattern="image", fileext=".png")
# ggsave(filename=imgfile, plot=p, height=5.15, width=9, units="in")
# 
# gpc = list(image   = p,
#            caption = "This is an example of an image from a ggplot object.")
# 
# ifc  = list(image   = imgfile,
#             caption = "This is an example of an image from a file.")

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# tdata =  data.frame(Parameters = c("Vp", "Cl", "Q", "Vt"),
#                     Values     = 1:4,
#                     Units      = c("L", "L/hr", "L/hr", "L") )

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# tco  = list(table     = tdata,    # This element contains the table data
#             header    = TRUE,     # These two lines control the header
#             first_row = FALSE,
#             caption   = "This creates a table using an Office theme/format.")

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# tcf = list(table       = tdata,             # This element contains the table data
#            caption_format = "md",
#            caption     = "This creates a <ff:courier>flextable</ff> using the <ff:courier>onbrand</ff> abstraction",
#            header_top  = list(              # Defining the table headers
#              Parameters = "Name",
#              Values     = "Value",
#              Units      = "Units"),
#            cwidth         = 0.8,            # Column width
#            table_autofit  = TRUE,           # Making the tables automatically fit
#            table_theme    = "theme_zebra",  # Making the tables automatically fit
#            first_row = FALSE)

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# tfo = flextable::flextable(tdata)
# tfo = flextable::autofit(tfo)
# 
# tcfo = list(ft = tfo,
#             caption  = "This inserts a flextable object created by the user")

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# cfg = system_rpt_read_template(cfg, "Word")

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# cfg = system_rpt_add_doc_content(cfg,
#         type="text",
#         content = list(
#           style = "Heading_1",
#           text  = "Formatting Text"))

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# fr = system_rpt_template_details(cfg)

## ----message=FALSE, warning=FALSE, eval=TRUE, echo=FALSE, message=FALSE-------
cat(paste(tdeets[["docx"]][["txt"]], collapse="\n"))

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# cfg = system_rpt_add_doc_content(cfg,
#   type="text",
#   content = list(
#     text  = plain_text_content))

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# cfg = system_rpt_add_doc_content(cfg,
#         type="text",
#         content = list(
#           style  = "Normal",
#           format = "md",
#           text   = md_text_content))
# 

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# cfg = system_rpt_add_doc_content(cfg,
#         type="text",
#         content = list(
#           style  = "Normal",
#           format = "fpar",
#           text   = fpar_text_content))

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# cfg = system_rpt_add_doc_content(cfg,
#   type     = "imagefile",
#   content  = ifc)
# cfg = system_rpt_add_doc_content(cfg,
#   type     = "ggplot",
#   content  = gpc)

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# cfg = system_rpt_add_doc_content(cfg,
#   type     = "table",
#   content  = tco)
# cfg = system_rpt_add_doc_content(cfg,
#   type     = "flextable",
#   content  = tcf)
# cfg = system_rpt_add_doc_content(cfg,
#   type     = "flextable_object",
#   content  = tcfo)

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# system_rpt_save_report(cfg, output_file = "example.docx")

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# tr = system_fetch_template(cfg, template="myOrg")

## ----message=FALSE, warning=FALSE, eval=TRUE, echo=FALSE----------------------
tdeets[["pptx"]][["ft"]]

## ----message=FALSE, warning=FALSE, eval=TRUE, echo=FALSE----------------------
tdeets[["docx"]][["ft"]]

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# cfg = system_rpt_read_template(cfg,
#                                mapping  = "myOrg.yaml",
#                                template = "myOrg.pptx")

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# cfg = system_rpt_estimation(cfg=cfg, analysis_name="analysis_name")

## ----message=FALSE, warning=FALSE, eval=FALSE, echo=TRUE----------------------
# cfg = system_rpt_nca(cfg=cfg, analysis_name="analysis_name")

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# rpt = system_fetch_rpt_officer_object(cfg)

## ----results="hide", message=FALSE, warning=FALSE, eval=FALSE-----------------
# cfg  = system_set_rpt_officer_object(cfg, rpt)

