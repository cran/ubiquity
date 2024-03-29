% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ubiquity.R
\name{system_rpt_add_slide}
\alias{system_rpt_add_slide}
\title{Add Slide to a Powerpoint Report}
\usage{
system_rpt_add_slide(
  cfg,
  template = NULL,
  elements = NULL,
  rptname = "default"
)
}
\arguments{
\item{cfg}{ubiquity system object}

\item{template}{Name of slide template to use}

\item{elements}{List with content to populate placeholders in the slide. See the
onbrand functions \code{\link[onbrand]{report_add_slide}} and
\code{\link[onbrand]{add_pptx_ph_content}} for details on the expected
format of this list.}

\item{rptname}{Report name}
}
\value{
ubiquity system object with the slide added to the specified
report
}
\description{
Adds a slide to a ubiquity report.
}
\seealso{
\code{\link[onbrand]{report_add_slide}}, 
\code{\link[onbrand]{add_pptx_ph_content}}, and 
Reporting vignette (\code{vignette("Reporting", package = "ubiquity")})
}
