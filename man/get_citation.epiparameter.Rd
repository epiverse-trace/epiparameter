% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/accessors.R
\name{get_citation.epiparameter}
\alias{get_citation.epiparameter}
\title{Get citation from an \verb{<epiparameter>} object}
\usage{
\method{get_citation}{epiparameter}(x, ...)
}
\arguments{
\item{x}{An \verb{<epiparameter>} object.}

\item{...}{\link{dots} Not used, extra arguments supplied will cause a warning.}
}
\value{
A \verb{<bibentry>} object.
}
\description{
Extract the citation stored in an \verb{<epiparameter>} object.
}
\examples{
# example with <epiparameter>
ep <- epiparameter_db(single_epiparameter = TRUE)
get_citation(ep)

# example returning bibtex format
ep <- epiparameter_db(disease = "COVID-19", single_epiparameter = TRUE)
cit <- get_citation(ep)
format(cit, style = "bibtex")
}
