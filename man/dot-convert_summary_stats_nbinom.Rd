% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convert_params.R
\name{.convert_summary_stats_nbinom}
\alias{.convert_summary_stats_nbinom}
\title{Convert summary statistics to parameters of the negative binomial
distribution}
\usage{
.convert_summary_stats_nbinom(...)
}
\arguments{
\item{...}{<\code{\link[rlang:dyn-dots]{dynamic-dots}}> \code{Numeric} named summary
statistics used to convert to parameter(s). An example is the \code{mean}
and \code{sd} summary statistics for the lognormal (\code{lnorm}) distribution.}
}
\value{
A list of two elements, the probability and dispersion parameters.
}
\description{
Convert summary statistics of the negative binomial
distribution the parameters (\code{prob}) and (\code{dispersion}) of the negative
binomial distribution.
}
\keyword{internal}
