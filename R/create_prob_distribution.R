#' Create a distribution object
#'
#' @description Creates an S3 class holding the distribution and parameters
#' from the probability distribution name, its parameters and distribution
#' truncation and discretisation.
#'
#' The class holding the distribution depends on whether it is a discretised
#' distribution. For continuous and discrete distributions S3 classes from the
#' \pkg{distributional} package are used, for discretised continuous
#' distributions the an S3 class from the \pkg{distcrete} package is used.
#'
#' For details on the properties of the distribution classes
#' from each respective package see their documentation (either
#' `?distributional` or `?distcrete`)
#'
#' @details Truncation is enabled only for continuous distributions as there
#' is no truncation implemented in \pkg{distcrete}.
#'
#' By default the discretisation of continuous distributions uses a
#' discretisation interval (`interval`) of 1. If the unit of the distribution
#' is days, then this will be discretised by day. The endpoint weighting (`w`)
#' for the discretisation is 1. `w` can be `[0,1]`. For more information please
#' see [distcrete::distcrete()].
#'
#' @param prob_distribution A `character` string specifying the probability
#' distribution. This should match the \R naming convention of probability
#' distributions (e.g. lognormal is `lnorm`, negative binomial is `nbinom`, and
#' geometric is `geom`).
#' @param prob_distribution_params A named vector of probability distribution
#' parameters.
#' @param discretise A boolean `logical` whether the distribution is
#' discretised. Default is `FALSE` which assumes a continuous probability
#' distribution.
#' @param truncation A `numeric` specifying the truncation point if the inferred
#' distribution was truncated, `NA` if not or unknown.
#' @param ... [dots] Extra arguments to be passed to
#' \pkg{distributional} or \pkg{distcrete} functions that construct the S3
#' distribution objects. To see which arguments can be adjusted for discretised
#' distributions see [distcrete::distcrete()], for other distributions see
#' the `?distributional` documentation and find the specific distribution
#' constructor function, e.g. for the Gamma distribution see
#' [distributional::dist_gamma()].
#'
#' @return An S3 class containing the probability distribution or a `character`
#' string if the parameters of the probability distribution are unknown.
#' @export
#'
#' @examples
#' # example with continuous distribution without truncation
#' create_prob_distribution(
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1),
#'   discretise = FALSE,
#'   truncation = NA
#' )
#'
#' # example with continuous distribution with truncation
#' create_prob_distribution(
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1),
#'   discretise = FALSE,
#'   truncation = 10
#' )
#'
#' # example with discrete distribution
#' create_prob_distribution(
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1),
#'   discretise = TRUE,
#'   truncation = NA
#' )
#'
#' # example passing extra arguments to distcrete
#' create_prob_distribution(
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1),
#'   discretise = TRUE,
#'   truncation = NA,
#'   w = 0.5
#' )
create_prob_distribution <- function(prob_distribution,
                                     prob_distribution_params,
                                     discretise = FALSE,
                                     truncation = NA,
                                     ...) {
  checkmate::assert_character(
    prob_distribution,
    min.chars = 1,
    min.len = 1,
    max.len = 2
  )

  # when only the type of probability distribution is known return string
  if (missing(prob_distribution_params)) return(prob_distribution)

  checkmate::assert_numeric(prob_distribution_params, names = "unique")
  checkmate::assert_logical(discretise, len = 1)
  checkmate::assert_number(truncation, na.ok = TRUE)

  # set prob_distribution to lowercase for downstream case sensitive matching
  prob_distribution <- .clean_string(prob_distribution)

  if (is_epiparameter_params(prob_distribution, prob_distribution_params)) {
    # standardise common distribution parameters
    prob_distribution_params <- .clean_params(
      prob_distribution = prob_distribution,
      prob_distribution_params = prob_distribution_params
    )
  } else {
    stop(
      "Incorrect parameters provided for probability distribution.",
      call. = FALSE
    )
  }

  dots <- list(...)
  if (discretise) {
    prob_distribution <- match.arg(
      prob_distribution,
      choices = c("gamma", "lnorm", "weibull", "norm")
    )
    # create default list of args to construct <distcrete>
    distcrete_args <- c(
      name = prob_distribution,
      interval = 1,
      as.list(prob_distribution_params),
      w = 1
    )
    # modify <distcrete> args if provided in dots
    distcrete_args <- utils::modifyList(distcrete_args, dots)
    # create discretised probability distribution object
    prob_distribution <- do.call(
      distcrete::distcrete,
      distcrete_args
    )
  } else {
    # currently dots not used to construct <distribution>
    chkDots(...)
    # create non-discretised probability distribution object
    prob_distribution <- switch(prob_distribution,
      gamma = distributional::dist_gamma(
        shape = prob_distribution_params[["shape"]],
        rate = 1 / prob_distribution_params[["scale"]]
      ),
      lnorm = distributional::dist_lognormal(
        mu = prob_distribution_params[["meanlog"]],
        sigma = prob_distribution_params[["sdlog"]]
      ),
      weibull = distributional::dist_weibull(
        shape = prob_distribution_params[["shape"]],
        scale = prob_distribution_params[["scale"]]
      ),
      nbinom = distributional::dist_negative_binomial(
        size = prob_distribution_params[["dispersion"]],
        prob = convert_summary_stats_to_params(
          "nbinom",
          mean = prob_distribution_params[["mean"]],
          dispersion = prob_distribution_params[["dispersion"]]
        )$prob
      ),
      geom = distributional::dist_geometric(
        prob = unname(prob_distribution_params)
      ),
      pois = distributional::dist_poisson(
        lambda = unname(prob_distribution_params)
      ),
      norm = distributional::dist_normal(
        mu = prob_distribution_params[["mean"]],
        sigma = prob_distribution_params[["sd"]]
      ),
      exp = distributional::dist_exponential(
        rate = prob_distribution_params[["rate"]]
      ),
      stop("Did not recognise distribution name", call. = FALSE)
    )
  }

  # apply truncation to distribution if specified
  if (!is.na(truncation)) {
    if (discretise) {
      stop(
        "Truncation is not yet implemented for discrete distributions.",
        call. = FALSE
      )
    } else {
      prob_distribution <- distributional::dist_truncated(
        prob_distribution,
        upper = truncation
      )
    }
  }

  # return prob_distribution object
  prob_distribution
}
