% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/conversion.R
\name{r_to_sas}
\alias{r_to_sas}
\title{Convert R table to SAS}
\usage{
r_to_sas(x, table_name, libref = "WORK")
}
\arguments{
\item{x}{R table}

\item{table_name}{Name of table to be created in SAS.}

\item{libref}{Name of libref to store SAS table within.}
}
\value{
No return value.
}
\description{
Converts R table into a table in the current SAS session. Translation errors
may occur.
}
\examples{
\dontrun{
sas_connect()
r_to_sas(mtcars, "mtcars")
}
}
