% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_epidist_prob_dist.R
\name{create_epidist_prob_dist}
\alias{create_epidist_prob_dist}
\title{Create a distribution object}
\usage{
create_epidist_prob_dist(
  prob_dist,
  prob_dist_params,
  discretise = FALSE,
  truncation = NA,
  ...
)
}
\arguments{
\item{prob_dist}{A character string specifying the probability
distribution. This should match the R naming convention of probability
distributions (e.g. lognormal is \code{lnorm}, negative binomial is \code{nbinom}, and
geometric is \code{geom}).}

\item{prob_dist_params}{A named vector of probability distribution
parameters.}

\item{discretise}{A boolean \code{logical} whether the distribution is
discretised.
Default is FALSE which assumes a continuous probability distribution}

\item{truncation}{A \code{numeric} specifying the truncation point if the inferred
distribution was truncated, \code{NA} if not or unknown.}

\item{...}{\link{dots} Extra arguments to be passed to
\pkg{distributional} or \pkg{distcrete} functions that construct the S3
distribution objects. To see which arguments can be adjusted for discretised
distributions see \code{\link[distcrete:distcrete]{distcrete::distcrete()}}, for other distributions see
the \code{?distributional} documentation and find the specific distribution
constructor function, e.g. for the Gamma distribution see
\code{\link[distributional:dist_gamma]{distributional::dist_gamma()}}.}
}
\value{
An S3 class containing the probability distribution.
}
\description{
Creates an S3 class holding the distribution and parameters
from the probability distribution name, its parameters and distribution
truncation and discretisation.

The class holding the distribution depends on whether it is a discretised
distribution. For continuous and discrete distributions S3 classes from the
\pkg{distributional} package are used, for discretised continuous
distributions the an S3 class from the \pkg{distcrete} package is used.

For details on the properties of the distribution classes
from each respective package see their documentation (either
\code{?distributional} or \code{?distcrete})
}
\details{
Truncation is enabled only for continuous distributions as there
is no truncation implemented in \pkg{distcrete}.

By default the discretisation of continuous distributions uses a
discretisation interval (\code{interval}) of 1. If the unit of the distribution
is days, then this will be discretised by day. The endpoint weighting (\code{w})
for the discretisation is 1. \code{w} can be \verb{[0,1]}. For more information please
see \code{\link[distcrete:distcrete]{distcrete::distcrete()}}.
}
\examples{
# example with continuous distribution without truncation
create_epidist_prob_dist(
  prob_dist = "gamma",
  prob_dist_params = c(shape = 1, scale = 1),
  discretise = FALSE,
  truncation = NA
)

# example with continuous distribution with truncation
create_epidist_prob_dist(
  prob_dist = "gamma",
  prob_dist_params = c(shape = 1, scale = 1),
  discretise = FALSE,
  truncation = 10
)

# example with discrete distribution
create_epidist_prob_dist(
  prob_dist = "gamma",
  prob_dist_params = c(shape = 1, scale = 1),
  discretise = TRUE,
  truncation = NA
)

# example passing extra arguments to distcrete
create_epidist_prob_dist(
  prob_dist = "gamma",
  prob_dist_params = c(shape = 1, scale = 1),
  discretise = TRUE,
  truncation = NA,
  w = 0.5
)
}
