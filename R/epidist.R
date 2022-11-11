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
#' @param delay_dist A `character` specifying type of parameter: `"incubation"`,
#' `"onset_to_admission"`, `"onset_to_death"`
#' @param study A `character` specifying dataset to use. Defaults to study
#' with largest sample size.
#'
#' @return Produces an object of class `epidist` which is composed of:
#' - `pathogen`: The pathogen of interest
#' - `dist`: The best-fit distribution from the literature, either from the
#' study with the largest sample size (default) or a specific study (using the
#' `study` argument)
#' - `delay_dist`: The metric of interest, could be either "incubation",
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
#' list_distributions(delay_dist = "incubation")
#'
#' # example of epidist() using incubation period for ebola
#' epidist(pathogen = "ebola", delay_dist = "incubation")
#'
#' # when more than one study is available in the database a study can be
#' # specified
#' epidist(
#'   pathogen = "MERS_CoV",
#'   delay_dist = "incubation",
#'   study = "Cauchemez_et_al"
#' )
#'
#' # example using onset to admission as the metric
#' epidist(pathogen = "ebola", delay_dist = "onset_to_death")
epidist  <- function(pathogen,
                     delay_dist = c(
                       "incubation",
                       "onset_to_admission",
                       "onset_to_death",
                       "serial_interval",
                       "generation_time"),
                     study = NULL) {

  # read the data to get possible pathogen names
  params <- utils::read.csv(
    system.file(
      "extdata",
      "parameters.csv",
      package = "epiparameter",
      mustWork = TRUE
    )
  )

  # order params by pathogen, delay dist and study
  params <- params[order(
    tolower(params$pathogen_id),
    tolower(params$type_id),
    tolower(params$study_id),
    method = "radix"
  ), ]

  # match pathogen names against data
  pathogen <- match.arg(
    arg = pathogen,
    choices = unique(params$pathogen_id),
    several.ok = FALSE
  )

  delay_dist <- match.arg(arg = delay_dist, several.ok = FALSE)

  # filter based on pathogen and delay distribution
  params <- params[params$pathogen_id == pathogen, ]
  params <- params[params$type_id == delay_dist, ]

  if (nrow(params) == 0) {
    stop("Need to select pathogen and distribution in the dataset")
  }

  # Extract study or default to largest sample size
  if (is.null(study)) {
    params <- params[params$size == max(params$size), ]
  } else {
    study <- match.arg(
      arg = study,
      choices = unique(params$study_id),
      several.ok = FALSE
    )
    params <- params[params$study_id == study, ]
  }

  # Throw warning if more than one row found and select first
  if (nrow(params) > 1) {
    warning("More than one study found. Selecting first one.
    Please report an issue with duplicated studies.")
    params <- params[1, ]
  }

  # Define distribution
  if (params$distribution == "lnorm") {
    param_vector <- c(meanlog = params$meanlog, sdlog = params$sdlog)
    cdf_function <- function(x) {
      stats::plnorm(x, meanlog = params$meanlog, sdlog = params$sdlog)
    }
    pmf_function <- function(x) {
      cdf_function(x + 1) - cdf_function(x)
    }
    pdf_function <- function(x) {
      stats::dlnorm(x, meanlog = params$meanlog, sdlog = params$sdlog)
    }
  }

  if (params$distribution == "gamma") {
    param_vector <- c(shape = params$shape, scale = params$scale)
    cdf_function <- function(x) {
      stats::pgamma(x, shape = params$shape, scale = params$scale)
    }
    pmf_function <- function(x) {
      cdf_function(x + 1) - cdf_function(x)
    }
    pdf_function <- function(x) {
      stats::dgamma(x, shape = params$shape, scale = params$scale)
    }
  }

  if (params$distribution == "weibull") {
    param_vector <- c(shape = params$shape, scale = params$scale)
    cdf_function <- function(x) {
      stats::pweibull(x, shape = params$shape, scale = params$scale)
    }
    pmf_function <- function(x) {
      cdf_function(x + 1) - cdf_function(x)
    }
    pdf_function <- function(x) {
      stats::dweibull(x, shape = params$shape, scale = params$scale)
    }
  }

  out <- list(pathogen = pathogen,
              dist = params$distribution,
              delay_dist = delay_dist,
              param = param_vector,
              pmf = pmf_function,
              pdf = pdf_function,
              cdf = cdf_function)

  class(out) <- "epidist"
  out
}

##' @export
print.epidist <- function(x, ...) {

  writeLines(
    c(
      sprintf("Pathogen: %s", x$pathogen),
      sprintf("Delay Distribution: %s", x$delay_dist),
      sprintf("Distribution: %s", x$dist),
      sprintf("Parameters:"),
      sprintf("  %s: %s", names(x$param), as.character(x$param))
    )
  )

  invisible(x)
}

#' Plots an `epidist` object by displaying the probability mass function (PMF),
#' probability density function (PDF) and cumulative distribution function (CDF)
#'
#' @param x An `epidist` object
#' @param day_range A vector with the sequence of days to be plotted on the
#' x-axis of the distribution
#' @param ... Allow other graphical parameters
#'
#' @author Joshua W. Lambert
#' @export
#'
#' @examples
#' ebola_si <- epidist(pathogen = "ebola", delay_dist = "serial_interval")
#' plot(ebola_si)
plot.epidist <- function(x, day_range = 0:10, ...) {

  if (!inherits(x, "epidist")) {
    stop("x must be an epidist object")
  }

  oldpar <- graphics::par(no.readonly = TRUE)
  on.exit(graphics::par(oldpar))

  # set plotting parameters to plot on a 2x2 grid
  graphics::par(mfrow = c(2, 2), mar = c(4, 3, 3, 1), oma = c(0, 0, 0, 0))

  # plot PMF
  plot(
    day_range,
    x$pmf(day_range),
    ylab = "",
    xlab = "Time since infection",
    type = "p",
    pch = 16,
    main = "Probability Mass Function"
  )

  # plot PDF
  plot(
    day_range,
    x$pdf(day_range),
    ylab = "",
    xlab = "Time since infection",
    type = "p",
    pch = 16,
    main = "Probability Density Function"
  )

  # plot CDF
  plot(
    day_range,
    x$cdf(day_range),
    ylab = "",
    xlab = "Time since infection",
    type = "p",
    pch = 16,
    ylim = c(0, 1),
    main = "Cumulative Distribution Function"
  )

  # add a plot title
  graphics::title("Distributions", outer = TRUE, line = -1)
}
