% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/epiparameter-utils.R
\name{.clean_string}
\alias{.clean_string}
\title{Standardise the variables input by users}
\usage{
.clean_string(x)
}
\arguments{
\item{x}{A \code{character} string.}
}
\value{
A \code{character} vector of equal length to the input.
}
\description{
Checks a user has supplied a \code{character} string and converts
to \pkg{epiparameter} standards: lower-case and whitespace instead of
dashes or underscores.

Examples of strings needing to be cleaned are: disease and pathogen names,
and epidemiological distributions.
}
\keyword{internal}
