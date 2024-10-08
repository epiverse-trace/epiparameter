% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coercion.R
\name{as_epiparameter}
\alias{as_epiparameter}
\title{Convert to an \verb{<epiparameter>} object}
\usage{
as_epiparameter(x, ...)
}
\arguments{
\item{x}{an object used to select a method.}

\item{...}{\link{dots} Extra arguments to be passed to the method.}
}
\value{
An \verb{<epiparameter>} object or list of \verb{<epiparameter>} objects.
}
\description{
Convert from an \R object to an \verb{<epiparameter>} object. If conversion is not
possible the function will error.
}
\details{
To create the full citation the information from the article table from the
\pkg{epireview} package of the corresponding entry will need to be passed
to function via the \code{...} argument. The argument should be called \code{article},
as it will be matched by name by \code{$}.

To specify a probability distribution pass a \code{character} string to the
function via the \code{...} argument. The argument should be called
\code{prob_distribution}. For example, to specify a gamma distribution:
\code{as_epiparameter(x, prob_distribution = "gamma")}.

\emph{\strong{Warning}}: distributions specified via the \code{prob_dist} argument will
overwrite the probability distribution specified in the \code{x} argument. For
example, if the probability distribution is given in an \pkg{epireview}
entry and the \code{prob_dist} argument is specified then the function may error
or return an unparameterised \verb{<epiparameter>} if the parameterisation becomes
incompatible.

Valid probability distributions are: \code{"gamma"}, \code{"lnorm"}, \code{"weibull"},
\code{"nbinom"}, \code{"geom"}, \code{"pois"}, \code{"norm"}, \code{"exp"}.
}
