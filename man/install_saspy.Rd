% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/saspy-install.R
\name{install_saspy}
\alias{install_saspy}
\title{Install SASPy package}
\usage{
install_saspy(envname = "r-saspy", extra_packages, restart_session = TRUE)
}
\arguments{
\item{envname}{Name of virtual environment to install SASPy within.}

\item{extra_packages}{Additional packages to install.}

\item{restart_session}{Restart session?}
}
\value{
No return value.
}
\description{
Installs the \code{SASPy} package and its dependencies within a
virtual Python environment.
}
\examples{
\dontrun{
install_saspy()
}
}
\seealso{
\code{\link[=configure_saspy]{configure_saspy()}}
}
