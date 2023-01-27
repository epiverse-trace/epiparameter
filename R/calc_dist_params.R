#' Calculates the parameters of a probability distribution from a list of
#' available summary statistics
#'
#' @description When the parameters of a probability distribution are not
#' provided (e.g. when describing the distribution in the literature) and instead
#' summary statistics of a distribution are provided, the parameters can usually
#' be calculated from the summary statistics. The `calc_dist_params()` function
#' computes the parameters for the gamma, lognormal and weibull distributions.
#'
#' This function can provide a convinient wrapper around the conversion and
#' extraction functions it is not known which summary statistics can be used to
#' calculate the parameters of a distribution.
#'
#' @details The hierarchy of methods are: conversion is prioritised if the mean
#' and standard deviation are available as these are mostly analytical
#' conversions (except for one of the weibull conversions), next method if
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
#' @export
calc_dist_params <- function(prob_dist,
                             prob_dist_params,
                             summary_stats,
                             sample_size = NA) {

  # check input
  checkmate::assert_character(prob_dist, len = 1)
  checkmate::assert_list(
    summary_stats,
    types = c("list", "double", "null"),
    names = "unique"
  )
  checkmate::assert_number(sample_size, na.ok = TRUE)
  stopifnot(
    "probability distribution params must be a named vector or NA" =
      all(is.na(prob_dist_params)) ||
      !is.null(names(prob_dist_params))
  )

  # extract mean and sd to see if conversion is possible
  mean_sd <- c(
    mean = summary_stats$central_tendency_spread$mean,
    sd = summary_stats$central_tendency_spread$sd
  )

  # extract quantiles of distribution to calculate parameters as second choice
  quantiles <- unlist(summary_stats$quantiles)
  lower_quantiles <- quantiles[c("q_025", "q_05", "q_25", "q_50")]
  upper_quantiles <- quantiles[c("q_75", "q_875", "q_95", "q_975")]

  # extract median and range to calculate parameters as third choice
  median_range <- c(
    median = summary_stats$central_tendency_spread$median,
    unlist(summary_stats$range)
  )

  if (!any(is.na(mean_sd))) {
    # make mean_sd a class with the name of the prob dist for multiple dispatch
    prob_dist_params <- convert_params(
      summary_stats = summary_stats,
      prob_dist = prob_dist
    )
  } else if (!all(is.na(lower_quantiles)) && !all(is.na(upper_quantiles))) {
    # use the first numeric quantile in the set to calculate the parameters
    lower_percentile <- lower_quantiles[!is.na(lower_quantiles)][1]
    upper_percentile <- upper_quantiles[!is.na(upper_quantiles)][1]

    # extract the numeric quantiles from the vector names
    percentiles <- as.numeric(c(
        gsub(pattern = "q_", replacement = "", x = names(lower_percentile)),
        gsub(pattern = "q_", replacement = "", x = names(upper_percentile))
    ))

    # TODO: make use of lognormal or lnorm consistent
    if (prob_dist == "lognormal") prob_dist <- "lnorm"

    # calculate the parameters from the percentiles
    prob_dist_params <- extract_param(
      type = "percentile",
      values = c(lower_percentile, upper_percentile),
      distribution = prob_dist,
      percentiles = percentiles
    )
  } else if (!any(is.na(median_range)) && !is.na(sample_size)) {
    prob_dist_params <- extract_param(
      type = "range",
      values = median_range,
      distribution = prob_dist,
      samples = sample_size
    )
  } else {
    message(paste0(
      "No adequate summary statistics available to calculate the parameters ",
      "of the ", prob_dist, " distribution"
    ))
  }

  # return params
  prob_dist_params
}

#' @export
convert_params <- function(summary_stats, ...) UseMethod("convert_params")

#' Converts summary statistics to parameters of a probability distribution
#'
#' @description The summary_stats object needs to have a class attribute with
#' the name of the probability distribution in order for the correct conversion
#' function to be dispatched.
#'
#' @param mean mean
#' @param sd standard deviation
#'
#' @rdname convert_params
#'
#' @return Named vector
#' @keywords internal
convert_params.gamma <- function(summary_stats) {
  # convert mean and sd to shape and scale
  gamma_params <- unlist(
    gamma_meansd2shapescale(
      mean = summary_stats$central_tendency_spread$mean,
      sd = summary_stats$central_tendency_spread$sd
    )
  )

  # return gamma params
  gamma_params
}

#' @rdname convert_params
convert_params.lognormal <- function(summary_stats) {
  # convert mean and sd to meanlog (mu) and sdlog (sigma)
  lognormal_params <- unlist(
    lnorm_meansd2musigma(
      mean = summary_stats$central_tendency_spread$mean,
      sd = summary_stats$central_tendency_spread$sd
    )
  )

  # return lognormal params
  lognormal_params
}

#' @rdname convert_params
convert_params.weibull <- function(summary_stats) {
  # convert mean and sd to meanlog (mu) and sdlog (sigma)
  weibull_params <- unlist(
    weibull_meansd2shapescale(
      mean = summary_stats$central_tendency_spread$mean,
      sd = summary_stats$central_tendency_spread$sd
    )
  )

  # return weibull params
  weibull_params
}

convert_params.default <- function(summary_stats, ...) {
  stop(sprintf("No conversion functions for class %s"), class(summary_stats))
}