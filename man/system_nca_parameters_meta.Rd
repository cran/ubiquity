% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ubiquity.R
\name{system_nca_parameters_meta}
\alias{system_nca_parameters_meta}
\title{List NCA parameters, text names and descriptions}
\usage{
system_nca_parameters_meta(cfg)
}
\arguments{
\item{cfg}{ubiquity system object}
}
\value{
List with the following elements:

\itemize{
  \item \code{isgood} Boolean value indicating the success of the function call.
  \item \code{parameters} List with element names for each standard column header for NCA output. Each element name is a list with the following elements:
  \itemize{
    \item \code{label} Textual descriptor of the parameter.
    \item \code{description} Verbose description of the parameter.
    \item \code{from} Text indicating the source of the parameter (either PKNCA or ubiquity).
    }
  }
}
\description{
Provides a verbose information about NCA parameters
}
\seealso{
Vignette on NCA (\code{vignette("NCA", package = "ubiquity")})
}
