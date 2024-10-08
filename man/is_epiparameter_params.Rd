% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/epiparameter-utils.R
\name{is_epiparameter_params}
\alias{is_epiparameter_params}
\title{Check whether the vector of parameters for the probability distribution
are in the set of possible parameters used in the epiparameter package}
\usage{
is_epiparameter_params(prob_distribution, prob_distribution_params)
}
\arguments{
\item{prob_distribution}{A \code{character} string specifying the probability
distribution. This should match the \R naming convention of probability
distributions (e.g. lognormal is \code{lnorm}, negative binomial is \code{nbinom}, and
geometric is \code{geom}).}

\item{prob_distribution_params}{A named vector of probability distribution
parameters.}
}
\value{
A boolean \code{logical}.
}
\description{
Check whether the vector of parameters for the probability distribution
are in the set of possible parameters used in the epiparameter package
}
\details{
This check for valid parameters is independent of whether the distribution
is truncated or discretised.
}
\examples{
is_epiparameter_params(
  prob_distribution = "gamma",
  prob_distribution_params = c(shape = 2, scale = 1)
)
}
