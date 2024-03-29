% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ubiquity.R
\name{vp}
\alias{vp}
\title{Print and Log Messages}
\usage{
vp(cfg, str, fmt = "alert")
}
\arguments{
\item{cfg}{ubiquity system object}

\item{str}{sequence of strings to print}

\item{fmt}{string format should be one of the following: \code{"h1"},
\code{"h2"}, \code{"h3"}, \code{"verbatim"}, \code{"alert"} (default), \code{"warning"},
\code{"danger"}.}
}
\value{
Boolean variable indicating success (\code{TRUE}) or failure (\code{FALSE})
}
\description{
Used to print messages to the screen and the log file.
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

# Initialzing the log file
vp(cfg, "Message that will be logged")
}
}
