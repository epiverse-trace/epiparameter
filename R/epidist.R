#' Distribution (PDF, CDF, PMF) and its parameters for epidemiological 
#' characteristics of a pathogen
#'
#' Parametric probability distribution (lognormal, gamma, or weibull) for the 
#' epidemiological characteristics (incubation period, onset to admission, 
#' onset to death, and serial interval) of various pathogens. The distributions 
#' and associated best-fit parameters can be used to inform modelling and 
#' estimation of other epidemiological metrics (e.g. reproduction number) and 
#' public health decisions (e.g. quarantine period).
#' 
#' @param pathogen A `character` specifying pathogen of interest
#' @param type A `character` specifying type of parameter: `"incubation"`,
#' `"onset_to_admission"`, `"onset_to_death"`
#' @param study A `character` specifying dataset to use. Defaults to study
#' with largest sample size.
#' 
#' @return Produces an object of class `epidist` which is composed of:
#' - `pathogen`: The pathogen of interest
#' - `dist`: The best-fit distribution from the literature, either from the 
#' study with the largest sample size (default) or a specific study (using the 
#' `study` argument)
#' - `type`: The metric of interest, could be either "incubation", 
#' "onset_to_admission", or "onset_to_death"
#' - `param`: The parameters of the distribution
#' - `pmf`, `pdf`, `cdf`: The distributions: probability mass function (`pmf`), 
#' probability density function (`pdf`) and cumulative distribution function 
#' (`cdf`)
#' @keywords incubation
#' @author Adam Kucharski
#' @export
#' @examples
#' # list_distributions() will show which pathogens are available for each
#' # metric here we search for which incubation periods are available
#' list_distributions(type = "incubation")
#'
#' # example of epidist() using incubation period for ebola
#' epidist(pathogen = "ebola", type = "incubation")
#'
#' # when more than one study is available in the database a study can be
#' # specified
#' epidist(
#'   pathogen = "MERS_CoV",
#'   type = "incubation",
#'   study = "Cauchemez_et_al"
#' )
#'
#' # example using onset to admission as the metric
#' epidist(pathogen = "ebola", type = "onset_to_admission")
epidist  <- function(pathogen, type, study = NULL) {

  # DEBUG
  # pathogen="SARS1"; type="incubation"; study=NULL; pmf = T

  pathogen_ID <- NULL # remove global variable note
  type_ID <- NULL # remove global variable note
  size <- NULL # remove global variable note
  study_ID <- NULL # remove global variable note

  # Extract pathogen and parameter type
  pick_path <- utils::read.csv(file = system.file(
    "extdata",
    "parameters.csv",
    package = "epiparameter",
    mustWork = TRUE
    )) |> dplyr::filter(pathogen_ID == pathogen & type_ID == type)

  if (nrow(pick_path) == 0) {
    stop("Need to select pathogen and distribution in the dataset")
  }

  # Extract study or default to largest sample size
  if (is.null(study)) {
    pick_study <- pick_path |> dplyr::filter(size == max(size))
  }
  if (!is.null(study)) {
    pick_study <- pick_path |> dplyr::filter(study_ID == study)
  }

  # Define distribution
  if (pick_study$distribution == "lnorm") {
    param_vector <- c(meanlog = pick_study$meanlog, sdlog = pick_study$sdlog)
    cdf_function <- function(x) {
      stats::plnorm(x, meanlog = pick_study$meanlog, sdlog = pick_study$sdlog)
    }
    pmf_function <- function(x) {
      cdf_function(x + 1) - cdf_function(x)
    }
    pdf_function <- function(x) {
      stats::dlnorm(x, meanlog = pick_study$meanlog, sdlog = pick_study$sdlog)
    }
  }

  if (pick_study$distribution == "gamma") {
    param_vector <- c(shape = pick_study$shape, scale = pick_study$scale)
    cdf_function <- function(x) {
      stats::pgamma(x, shape = pick_study$shape, scale = pick_study$scale)
    }
    pmf_function <- function(x) {
      cdf_function(x + 1) - cdf_function(x)
    }
    pdf_function <- function(x) {
      stats::dgamma(x, shape = pick_study$shape, scale = pick_study$scale)
    }
  }

  if (pick_study$distribution == "weibull") {
    param_vector <- c(shape = pick_study$shape, scale = pick_study$scale)
    cdf_function <- function(x) {
      stats::pweibull(x, shape = pick_study$shape, scale = pick_study$scale)
    }
    pmf_function <- function(x) {
      cdf_function(x + 1) - cdf_function(x)
    }
    pdf_function <- function(x) {
      stats::dweibull(x, shape = pick_study$shape, scale = pick_study$scale)
    }
  }

  out <- list(pathogen = pathogen,
              dist = pick_study$distribution,
              type = type,
              param = param_vector,
              pmf = pmf_function,
              pdf = pdf_function,
              cdf = cdf_function)

  class(out) <- "epidist"
  out
}

##' @export
print.epidist <- function(x, ...) {

  cat(sprintf("Pathogen: %s\n", x$pathogen))
  cat(sprintf("Type: %s\n", x$type))
  cat(sprintf("Distribution: %s\n", x$dist))
  p_vals <- x$param
  cat(sprintf("Parameters:\n"))
  cat(sprintf("  %s: %s\n", names(p_vals), as.character(p_vals)))

  invisible(x)
}
