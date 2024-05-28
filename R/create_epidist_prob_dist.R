#' Create a distribution object from distribution name and parameters
#'
#' @description Creates an S3 class holding the distribution and parameters
#' from the probability distribution name, its parameters and distribution
#' truncation and discretisation.
#'
#' The class holding the distribution depends on whether it is a discretised
#' distribution. For continuous and discrete distributions S3 classes from the
#' `{distributional}` package are used, for discretised continuous
#' distributions the an S3 class from the `{distcrete}` package is used.
#'
#' For details on the properties of the distribution classes
#' from each respective package see their documentation (either
#' `?distributional` or `?distcrete`)
#'
#' @details Truncation is enabled only for continuous distributions as there
#' is no truncation implemented in `{distcrete}`.
#'
#' @inheritParams new_epidist
#' @param ... [dots] Extra arguments to be passed to
#' \pkg{distributional} or \pkg{distcrete} functions that construct the S3
#' distribution objects.
#'
#' @return An S3 class containing the probability distribution.
#' @export
#'
#' @examples
#' # example with continuous distribution without truncation
#' epiparameter:::create_epidist_prob_dist(
#'   prob_dist = "gamma",
#'   prob_dist_params = c(shape = 1, scale = 1),
#'   discretise = FALSE,
#'   truncation = NA
#' )
#'
#' # example with continuous distribution with truncation
#' epiparameter:::create_epidist_prob_dist(
#'   prob_dist = "gamma",
#'   prob_dist_params = c(shape = 1, scale = 1),
#'   discretise = FALSE,
#'   truncation = 10
#' )
#'
#' # example with discrete distribution
#' epiparameter:::create_epidist_prob_dist(
#'   prob_dist = "gamma",
#'   prob_dist_params = c(shape = 1, scale = 1),
#'   discretise = TRUE,
#'   truncation = NA
#' )
create_epidist_prob_dist <- function(prob_dist,
                                     prob_dist_params,
                                     discretise = FALSE,
                                     truncation = NA,
                                     ...) {
  dots <- list(...)
  if (discretise) {
    prob_dist <- match.arg(
      prob_dist,
      choices = c("gamma", "lnorm", "weibull", "norm")
    )
    # create default list of args to construct <distcrete>
    distcrete_args <- c(
      name = prob_dist,
      interval = 1,
      as.list(prob_dist_params),
      w = 1
    )
    # modify <distcrete> args if provided in dots
    distcrete_args <- utils::modifyList(distcrete_args, dots)
    # create discretised probability distribution object
    prob_dist <- do.call(
      distcrete::distcrete,
      distcrete_args
    )
  } else {
    # create non-discretised probability distribution object
    prob_dist <- switch(prob_dist,
      gamma = distributional::dist_gamma(
        shape = prob_dist_params[["shape"]],
        rate = 1 / prob_dist_params[["scale"]]
      ),
      lnorm = distributional::dist_lognormal(
        mu = prob_dist_params[["meanlog"]],
        sigma = prob_dist_params[["sdlog"]]
      ),
      weibull = distributional::dist_weibull(
        shape = prob_dist_params[["shape"]],
        scale = prob_dist_params[["scale"]]
      ),
      nbinom = distributional::dist_negative_binomial(
        size = prob_dist_params[["dispersion"]],
        prob = convert_summary_stats_to_params(
          "nbinom",
          mean = prob_dist_params[["mean"]],
          dispersion = prob_dist_params[["dispersion"]]
        )$prob
      ),
      geom = distributional::dist_geometric(
        prob = unname(prob_dist_params)
      ),
      pois = distributional::dist_poisson(
        lambda = unname(prob_dist_params)
      ),
      norm = distributional::dist_normal(
        mu = prob_dist_params[["mean"]],
        sigma = prob_dist_params[["sd"]]
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
      prob_dist <- distributional::dist_truncated(
        prob_dist,
        upper = truncation
      )
    }
  }

  # return prob_dist object
  prob_dist
}
