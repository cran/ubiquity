% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ubiquity.R
\name{system_set_covariate}
\alias{system_set_covariate}
\title{Set Covariate Values}
\usage{
system_set_covariate(cfg, covariate, times, values)
}
\arguments{
\item{cfg}{ubiquity system object}

\item{covariate}{name of the covariate}

\item{times}{list of times (system time units)}

\item{values}{corresponding list of values}
}
\value{
Ubiquity system object with the covariate set
}
\description{
Covariates specified in the system file using  \code{<CV:?>}
and \code{<CVSET:?:?>} will have their default values for a given parameter
set. This function is a means to overwrite those values.
}
\examples{
\donttest{
# Creating a system file from the mab_pk example
fr = system_new(file_name        = "system.txt", 
                system_file      = "mab_pk", 
                overwrite        = TRUE, 
                output_directory = tempdir())

# Building the system 
cfg = build_system(system_file  = file.path(tempdir(), "system.txt"),
      output_directory          = file.path(tempdir(), "output"),
      temporary_directory       = tempdir())

# Setting the covariate WT to 50
cfg = system_set_covariate(cfg, 
                           covariate = "WT",
                           times     = c(0), 
                           values    = c(50))
}
}
