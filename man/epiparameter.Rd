% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/epiparameter.R
\name{epiparameter}
\alias{epiparameter}
\title{Create an \verb{<epiparameter>} object}
\usage{
epiparameter(
  disease,
  pathogen = NA_character_,
  epi_name,
  prob_distribution = create_prob_distribution(prob_distribution = NA_character_),
  uncertainty = create_uncertainty(),
  summary_stats = create_summary_stats(),
  citation = create_citation(),
  metadata = create_metadata(),
  method_assess = create_method_assess(),
  notes = NULL,
  auto_calc_params = TRUE,
  ...
)
}
\arguments{
\item{disease}{A \code{character} string with name of the infectious disease.}

\item{pathogen}{A \code{character} string with the name of the causative agent of
disease, or \code{NA} if not known.}

\item{epi_name}{A \code{character} string with the name of the
epidemiological parameter type.}

\item{prob_distribution}{An S3 class containing the probability
distribution or a character string if the parameters of the probability
distribution are unknown but the name of the distribution is known, or \code{NA}
if the distribution name and parameters are unknown. Use
\code{\link[=create_prob_distribution]{create_prob_distribution()}} to create \code{prob_distribution}.}

\item{uncertainty}{A list of named vectors with the uncertainty around
the probability distribution parameters. If uncertainty around the parameter
estimates is unknown use \code{\link[=create_uncertainty]{create_uncertainty()}} (which is the
argument default) to create a list with the correct names with missing
values.}

\item{summary_stats}{A list of summary statistics, use
\code{\link[=create_summary_stats]{create_summary_stats()}} to create list. This list can include
summary statistics about the inferred distribution such as it's mean and
standard deviation, quantiles of the distribution, or information about the
data used to fit the distribution such as lower and upper range. The summary
statistics can also include uncertainty around metrics such as confidence
interval around mean and standard deviation.}

\item{citation}{A \verb{<bibentry>} with the citation of the source of the
data or the paper that inferred the distribution parameters, use
\code{\link[=create_citation]{create_citation()}} to create citation.}

\item{metadata}{A list of metadata, this can include: units, sample size,
the transmission mode of the disease (e.g. is it vector-borne or directly
transmitted), etc. It is assumed that the disease is not
vector-borne and that the distribution is intrinsic (e.g. not an extrinsic
delay distribution such as extrinsic incubation period) unless
\code{transmission_mode = "vector_borne"} is contained in the metadata. Use
\code{\link[=create_metadata]{create_metadata()}} to create metadata.}

\item{method_assess}{A list of methodological aspects used when fitting
the distribution, use \code{\link[=create_method_assess]{create_method_assess()}} to create method
assessment.}

\item{notes}{A \code{character} string with any additional information about the
data, inference method or disease.}

\item{auto_calc_params}{A boolean \code{logical} determining whether to try and
calculate the probability distribution parameters from summary statistics if
distribution parameters are not provided. Default is \code{TRUE}. In the case when
sufficient summary statistics are provided and the parameter(s) of the
distribution are not, the \code{\link[=.calc_dist_params]{.calc_dist_params()}} function is called to
calculate the parameters and add them to the \code{epiparameter} object created.}

\item{...}{\link{dots} Extra arguments to be passed to internal functions.

This is most commonly used to pass arguments to \code{\link[distcrete:distcrete]{distcrete::distcrete()}}
that construct the discretised distribution S3 object. To see which
arguments can be adjusted for discretised distributions see
\code{\link[distcrete:distcrete]{distcrete::distcrete()}}.}
}
\value{
An \verb{<epiparameter>} object.
}
\description{
The \verb{<epiparameter>} class is used to store epidemiological
parameters for a single disease. These epidemiological parameters cover a
variety of aspects including delay distributions (e.g. incubation periods
and serial intervals, among others) and offspring distributions.

The \verb{<epiparameter>} object is the functional unit provided by
\code{{epiparameter}} to plug into epidemiological pipelines. Obtaining an
\verb{<epiparameter>} object can be achieved in two main ways:
\enumerate{
\item The epidemiological distribution is stored in
the \code{{epiparameter}} library and can be accessed by \code{\link[=epiparameter_db]{epiparameter_db()}}.
\item The alternative method is when you have information
(e.g. disease and distribution parameter estimates) and would like to input
this into an \verb{<epiparameter>} object in order to work in existing analysis
pipelines. This is where the \code{epiparameter()} function can be used to fill
out each field for which information is known.
}
}
\details{
Accepted \verb{<epiparameter>} distribution parameterisations are:
\itemize{
\item Gamma must be either 'shape' and 'scale' or 'shape' and 'rate'
\item Weibull must be 'shape' and 'scale'
\item Lognormal must be 'meanlog' and 'sdlog' or 'mu' and 'sigma'
\item Negative Binomial must be either 'mean' and 'dispersion' or 'n' and 'p'
\item Geometric must be either 'mean' or 'prob'
\item Poisson must be 'mean'
}
}
\examples{
# minimal input required for `epiparameter`
ebola_incubation <- epiparameter(
  disease = "ebola",
  epi_name = "incubation_period",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  )
)

# minimal input required for discrete `epiparameter`
ebola_incubation <- epiparameter(
  disease = "ebola",
  epi_name = "incubation_period",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = TRUE
  )
)

# example with more fields filled in
ebola_incubation <- epiparameter(
  disease = "ebola",
  pathogen = "ebola_virus",
  epi_name = "incubation",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = FALSE,
    truncation = NA
  ),
  uncertainty = list(
    shape = create_uncertainty(),
    scale = create_uncertainty()
  ),
  summary_stats = create_summary_stats(mean = 2, sd = 1),
  citation = create_citation(
    author = person(given = "John", family = "Smith"),
    year = 2002,
    title = "COVID-19 incubation period",
    journal = "Epi Journal",
    doi = "10.19832/j.1366-9516.2012.09147.x"
  ),
  metadata = create_metadata(
    units = "days",
    sample_size = 10,
    region = "UK",
    transmission_mode = "natural_human_to_human",
    inference_method = "MLE"
  ),
  method_assess = create_method_assess(
    censored = TRUE
  ),
  notes = "No notes"
)
}
