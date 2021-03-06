#clearing the workspace
rm(list=ls())
graphics.off()
options(show.error.locations = TRUE)

# If we cannot load the ubiquity package we try the stand alone distribution
if("ubiquity" %in% rownames(installed.packages())){require(ubiquity)} else 
{source(file.path("library", "r_general", "ubiquity.R")) }

# -------------------------------------------------------------------------
# Use system_new(system_file="empty") to create a minimal system file
# Build the system 
cfg = build_system(system_file="system-mab_pk.txt",
                   output_directory     = file.path(".", "output"),
                   temporary_directory  = file.path(".", "transient"))

# -------------------------------------------------------------------------
# Loading Dataset
cfg = system_load_data(cfg, dsname     = "PKDATA", 
                            data_file  = "pk_sparse_sd.csv")

# Performing NCA
cfg = system_nca_run(cfg, dsname        = "PKDATA", 
                          dscale        = 1e6, 
                          analysis_name = "pk_sparse",
                          sparse        = TRUE,
                          dsmap         = list(TIME        = "TIME_HR", 
                                               NTIME       = "TIME_HR", 
                                               CONC        = "C_ng_ml", 
                                               DOSE        = "DOSE",
                                               ROUTE       = "ROUTE", 
                                               ID          = "ID",
                                               SPARSEGROUP = "DOSE"),
                          dsinc         = c("ROUTE"))

# You can access the results as a csv file in the output directory
# file.path("output", "pk_sparse-nca_summary.csv")
# Or you can pull them out programmatically with the fetch function:
NCA_results = system_fetch_nca(cfg, analysis_name = "pk_sparse")
            
# -------------------------------------------------------------------------
# Writing output to PowerPoint
# Creating an empty report
cfg = system_report_init(cfg, rpttype="PowerPoint")
# Giving the report a title slide
cfg = system_report_slide_title(cfg, title = "NCA of Sparsely Sampled PK")
# Appending the NCA results to the report
cfg = system_report_nca(cfg, analysis_name = "pk_sparse")
# Writing the results to a PowerPoint report
system_report_save(cfg=cfg, output_file=file.path("output", "pk_sparse-report.pptx"))
# -------------------------------------------------------------------------
# Writing output to Word
# Creating an empty report
cfg = system_report_init(cfg, rpttype="Word")
# Appending the NCA results to the report
cfg = system_report_nca(cfg, analysis_name = "pk_sparse")
# Writing the results to a Word report
system_report_save(cfg=cfg, output_file=file.path("output", "pk_sparse-report.docx"))
# -------------------------------------------------------------------------
