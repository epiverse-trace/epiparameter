#' Calculates the parameters of a probability distribution from a list of
#' available summary statistics
#'
#' @description When the parameters of a probability distribution are not
#' provided (e.g. when describing the distribution in the literature) and
#' instead summary statistics of a distribution are provided, the parameters
#' can usually be calculated from the summary statistics. The
#' `calc_dist_params()` function computes the parameters for the gamma,
#' lognormal and Weibull distributions.
#'
#' This function can provide a convinient wrapper around the conversion and
#' extraction functions it is not known which summary statistics can be used to
#' calculate the parameters of a distribution.
#'
#' @details The hierarchy of methods are: conversion is prioritised if the mean
#' and standard deviation are available as these are mostly analytical
#' conversions (except for one of the Weibull conversions), next method if
#' possible is extraction from percentiles. This method requires a lower
#' percentile (between(0-50]) and an upper percentile(between (50-100)). If
#' multiple percentiles in each of these ranges is provided the lowest value is
#' used for the calculation. The last method is the extraction using a median
#' and range of the data.
#'
#' @inheritParams new_epidist
#' @inheritParams epidist
#' @param sample_size The sample size of the data. Only needed when falling back
#' on using the median-range extraction calculation.
#'
#' @return A named vector with parameters
#' @keywords internal
#' @examples
#' \dontrun{
#' # set seed for stochastic optimisation
#' set.seed(1)
#'
#' calc_dist_params(
#'   prob_dist = "gamma",
#'   prob_dist_params = NA,
#'   summary_stats = create_epidist_summary_stats(
#'     quantiles = c(q_2.5 = 0.2, q_97.5 = 9.2)
#'   ),
#'   sample_size = NA
#' )
#'
#' calc_dist_params(
#'   prob_dist = "gamma",
#'   prob_dist_params = NA,
#'   summary_stats = create_epidist_summary_stats(
#'     median = 5, lower_range = 3, upper_range = 12
#'   ),
#'   sample_size = 25
#' )
#' }
calc_dist_params <- function(prob_dist,
                             prob_dist_params,
                             summary_stats,
                             sample_size = NA) {
  # check input
  checkmate::assert_string(prob_dist)
  checkmate::assert_list(
    summary_stats,
    types = c("list", "double", "logical", "null"),
    names = "unique"
  )
  checkmate::assert_number(sample_size, na.ok = TRUE)
  stopifnot(
    "probability distribution params must be a named vector or NA" =
      anyNA(prob_dist_params) ||
        !is.null(names(prob_dist_params))
  )

  # extract mean and sd to see if conversion is possible
  mean_sd <- c(
    mean = summary_stats$centre_spread$mean,
    sd = summary_stats$centre_spread$sd
  )

  # convert percentile names to numbers
  percentiles <- get_percentiles(summary_stats$quantiles)

  # extract median and range to calculate parameters as third choice
  median_range <- c(
    median = summary_stats$centre_spread$median,
    unlist(summary_stats$range)
  )

  if (!anyNA(mean_sd)) {
    # unlist and remove NAs
    summary_stats_ <- unlist(summary_stats)
    summary_stats_ <- summary_stats_[!is.na(summary_stats_)]
    # remove name prefixes from unlisting
    names(summary_stats_) <- gsub(
      pattern = ".*\\.",
      replacement = "",
      x = names(summary_stats_)
    )
    # drop summary stats not used in conversion
    idx <- names(summary_stats_) %in% c(
      "mean", "median", "mode", "var", "sd", "cv",
      "skewness", "ex_kurtosis", "dispersion"
    )
    summary_stats_ <- summary_stats_[idx]
    # create flat list structure to be passed to ... in conversion
    args <- unlist(list(prob_dist, as.list(summary_stats_)), recursive = FALSE)
    prob_dist_params <- unlist(do.call(
      convert_summary_stats_to_params, args = args
    ))
  } else if (!anyNA(percentiles)) {
    # calculate the parameters from the percentiles
    # percentiles required to be [0, 1] so divide by 100
    prob_dist_params <- extract_param(
      type = "percentile",
      values = percentiles,
      distribution = prob_dist,
      percentiles = as.numeric(names(percentiles)) / 100
    )
  } else if (!anyNA(median_range) && !is.na(sample_size)) {
    prob_dist_params <- extract_param(
      type = "range",
      values = median_range,
      distribution = prob_dist,
      samples = sample_size
    )
  } else {
    message(
      "No adequate summary statistics available to calculate the parameters ",
      "of the ", prob_dist, " distribution"
    )
  }

  # return params
  prob_dist_params
}
