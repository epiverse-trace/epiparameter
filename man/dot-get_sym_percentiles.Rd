% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_percentiles.R
\name{.get_sym_percentiles}
\alias{.get_sym_percentiles}
\title{Get the lower and upper percentiles with a preference for symmetrical
percentiles}
\usage{
.get_sym_percentiles(percentiles)
}
\arguments{
\item{percentiles}{A named vector of percentiles. The names are in the
correct format to be converted to their numeric value using \code{as.numeric()}.}
}
\value{
A named \code{numeric} vector of two elements with the lower
(first element) and upper (second element) percentiles.
}
\description{
Get the lower and upper percentiles with a preference for symmetrical
percentiles
}
\keyword{internal}
