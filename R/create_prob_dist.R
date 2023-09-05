#' Creates an distribution object depending on input parameters and distribution
#' settings
#'
#' @description This function converts the probability distribution name and its
#' parameters into an S3 class holding the distribution and parameters. The
#' class holding the distribution depends on whether it is a continuous or
#' discrete distribution. For continuous distributions the `{distributional}`
#' package and classes are used, for discrete distributions the `{distcrete}`
#' package is used. For details on the properties of the distribution classes
#' from each respective package see their documentation (either
#' `?distributional` or `?distcrete`)
#'
#' @details Truncation is enabled only for continuous distributions as there
#' is no truncation implemented in `{distcrete}`.
#'
#' @inheritParams new_epidist
#'
#' @return An S3 class containing the probability distribution
#' @keywords internal
#'
#' @examples
#' \donttest{
#' # example with continuous distribution without truncation
#' epiparameter:::create_prob_dist(
#'   prob_dist = "gamma",
#'   prob_dist_params = c(shape = 1, scale = 1),
#'   discretise = FALSE,
#'   truncation = NA
#' )
#'
#' # example with continuous distribution with truncation
#' epiparameter:::create_prob_dist(
#'   prob_dist = "gamma",
#'   prob_dist_params = c(shape = 1, scale = 1),
#'   discretise = FALSE,
#'   truncation = 10
#' )
#'
#' # example with discrete distribution
#' epiparameter:::create_prob_dist(
#'   prob_dist = "gamma",
#'   prob_dist_params = c(shape = 1, scale = 1),
#'   discretise = TRUE,
#'   truncation = NA
#' )
#' }
create_prob_dist <- function(prob_dist,
                             prob_dist_params,
                             discretise,
                             truncation) {

  if (discretise) {
    prob_dist <- match.arg(prob_dist, choices = c("gamma", "lnorm", "weibull"))
    # create discretised probability distribution object
    prob_dist <- do.call(
      distcrete::distcrete,
      c(
        name = prob_dist,
        interval = 1,
        as.list(prob_dist_params),
        w = 1
      )
    )
  } else {
    # create non-discretised probability distribution object
    prob_dist <- switch(
      prob_dist,
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
          distribution = "nbinom",
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
