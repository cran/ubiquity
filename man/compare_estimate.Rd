% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ubiquity.R
\name{compare_estimate}
\alias{compare_estimate}
\title{Compares Estimate to Bounds}
\usage{
compare_estimate(cfg, parameters, pname)
}
\arguments{
\item{cfg}{ubiquity system object}

\item{parameters}{list of parameter estimates}

\item{pname}{name of parameter to compare}
}
\value{
L - near the lower bound, U - near the upper bound
}
\description{
Compares the parameter estimate to the bounds and indicates if
the estimate is near the bound.
}
\keyword{internal}
