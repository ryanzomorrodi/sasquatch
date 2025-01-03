% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/saspy-configure.R
\name{configure_saspy}
\alias{configure_saspy}
\title{Configure SASPy package}
\usage{
configure_saspy(template = c("none", "oda"))
}
\arguments{
\item{template}{Default template to base configuration files off of.}
}
\value{
No return value.
}
\description{
Adds \code{sascfg_personal.py} and \code{authinfo} files and prefills relevant info
according to a specified template.
}
\examples{
\dontrun{
config_saspy()
}
}
