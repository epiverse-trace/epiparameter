#' Constructor for epidist class
#'
#' @description Create an epidist object and provides input checking. The
#' constructor will search whether parameters of the probability distribution
#' are supplied and if not look to see whether they can be inferred/extracted/
#' converted from summary statistics provided.
#'
#' @param disease A list contains the `$disease` a character string of the
#' infectious disease specified in the study, and the `4pathogen` a character
#' string or NULL of the causative agent of disease specified in study.
#' @param epi_dist A character string with the name of the epidemiological
#' distribution type
#' @param prob_dist A character string specifying the probability distribution
#' @param prob_dist_params A named vector of probability distribution parameters
#' @param uncertainty Either a list of named vectors with the uncertainty around
#' the probability distribution parameters or NULL when uncertainty around the
#' parameter estimates is unknown
#' @param summary_stats A list of summary statistics
#' @param citation A character string with the short form citation
#' @param metadata A list of metadata
#' @param method_assessment A list of methodological aspects assessed
#' @param notes A character string with additional notes
#'
#' @return epidist object
#' @keywords internal
#'
#' @examples
#' new_epidist(
#'   disease = list(
#'     disease = "ebola",
#'     pathogen = "ebola_virus"
#'   ),
#'   epi_dist = "incubation_period",
#'   prob_dist = "gamma",
#'   prob_dist_params = c(shape = 1.4, scale = 0.5),
#'   uncertainty = NULL,
#'   summary_stats = create_epidist_summary_stats(),
#'   metadata = create_epidist_metadata(
#'     sample_size = 83
#'   ),
#'   method_assessment = create_epidist_method_assessment(),
#'   citation = "Smith et al (2010) <10.19832/j.1366-9516.2012.09147.x>",
#'   notes = "No additional notes"
#' )
new_epidist <- function(disease = list(),
                        epi_dist = character(),
                        prob_dist = character(),
                        prob_dist_params = numeric(),
                        uncertainty = list(),
                        summary_stats = list(),
                        citation = character(),
                        metadata = list(),
                        method_assessment = list(),
                        notes = character()) {
  # check input
  stopifnot(
    "A disease is required for the epidist class" =
      !is.null(disease$disease)
  )
  checkmate::assert_list(disease, types = c("character", "null"), len = 2)
  checkmate::assert_character(epi_dist, min.chars = 1)
  checkmate::assert_character(prob_dist, min.chars = 1)
  checkmate::assert_numeric(
    prob_dist_params,
    min.len = 1,
    max.len = 2,
    names = "unique",
    null.ok = TRUE
  )
  checkmate::assert_list(
    summary_stats,
    types = c("list", "double", "null"),
    names = "unique"
  )
  checkmate::assert_character(citation, min.len = 1)
  checkmate::assert_list(metadata)
  checkmate::assert_list(method_assessment)
  checkmate::assert_character(notes, null.ok = TRUE)

  # calculate parameters if not provided
  if (length(prob_dist_params) == 0) {

    # calculate parameters if not provided
    prob_dist_params <- calc_dist_params(
      prob_dist = prob_dist,
      summary_stats = summary_stats,
      sample_size = metadata$sample_size
    )
  }

  # check parameters if provided
  checkmate::assert_numeric(prob_dist_params, names = "unique")
  stopifnot(
    "distribution parameters must have valid names,
       use possible_epidist_params() to see valid names" =
      is_epidist_params(prob_dist_params)
  )

  # make the probability distribution object
  prob_dist <- switch(prob_dist,
                      gamma = distributional::dist_gamma(
                        shape = prob_dist_params[["shape"]],
                        rate = 1/prob_dist_params[["scale"]]
                      ),
                      lognormal = distributional::dist_lognormal(
                        mu = prob_dist_params[["mu"]],
                        sigma = prob_dist_params[["sigma"]]
                      ),
                      weibull = distributional::dist_weibull(
                        shape = prob_dist_params[["shape"]],
                        scale = prob_dist_params[["scale"]]
                      ),
                      negative_binomial = distributional::dist_negative_binomial(
                        size = prob_dist_params[["dispersion"]],
                        prob = negative_binomial_meandispersion2probdispersion(
                          mean = prob_dist_params[["mean"]],
                          dispersion = prob_dist_params[["dispersion"]]
                        )$prob
                      ),
                      geometric = distributional::dist_geometric(
                        prob = unname(prob_dist_params)
                      )
  )

  # TODO: calculate standard deviation from confidence interval

  # TODO: handle parameter uncertainty

  quantiles <- quantile(
    prob_dist,
    c(0.025, 0.05, 0.25, 0.5, 0.75, 0.875, 0.95, 0.975)
  )[[1]]
  names(quantiles) <- c(
    "q_025",	"q_05",	"q_25",	"q_50", "q_75", "q_875", "q_95", "q_975"
  )
  summary_stats$quantiles <- quantiles

  if (epi_dist == "offspring_distribution") {
    method_assessment <- paste(
      "There is currently no method assessment for offspring distributions",
      "stored in epiparameter"
    )
  }

  if (is.null(notes)) {
    notes <- "No additional notes"
  }

  # create and return epidist class
  structure(
    list(
      disease = disease,
      epi_dist = epi_dist,
      prob_dist = prob_dist,
      uncertainty = uncertainty,
      summary_stats = summary_stats,
      citation = citation,
      metadata = metadata,
      method_assessment = method_assessment,
      notes = notes
    ),
    class = "epidist"
  )
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

  out <- list(
    pathogen = pathogen,
    dist = params$distribution,
    delay_dist = delay_dist,
    param = param_vector,
    pmf = pmf_function,
    pdf = pdf_function,
    cdf = cdf_function
  )

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
#' \dontrun{
#' ebola_si <- epidist(pathogen = "ebola", delay_dist = "serial_interval")
#' plot(ebola_si)
#' }
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
