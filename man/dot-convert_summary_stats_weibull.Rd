% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convert_params.R
\name{.convert_summary_stats_weibull}
\alias{.convert_summary_stats_weibull}
\title{Convert summary statistics to parameters of the Weibull distribution}
\usage{
.convert_summary_stats_weibull(...)
}
\arguments{
\item{...}{<\code{\link[rlang:dyn-dots]{dynamic-dots}}> \code{Numeric} named summary
statistics used to convert to parameter(s). An example is the \code{mean}
and \code{sd} summary statistics for the lognormal (\code{lnorm}) distribution.}
}
\value{
A list of two elements, the shape and scale.
}
\description{
Convert summary statistics input into the shape and scale
parameters of the Weibull distribution.
}
\keyword{internal}
