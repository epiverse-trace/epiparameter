#' Calculates the parameters of a probability distribution from a list of
#' available summary statistics
#'
#' @description When the parameters of a probability distribution are not
#' provided (e.g. when describing the distribution in the literature) and
#' instead summary statistics of a distribution are provided, the parameters
#' can usually be calculated from the summary statistics. The
#' `calc_dist_params()` function computes the parameters for the gamma,
#' lognormal and weibull distributions.
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
#' @examples
#' calc_dist_params(
#'   prob_dist = "gamma",
#'   prob_dist_params = NA,
#'   summary_stats = create_epidist_summary_stats(
#'     q_025 = 0.2, q_975 = 9.2
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
calc_dist_params <- function(prob_dist,
                             prob_dist_params,
                             summary_stats,
                             sample_size = NA) {

  # check input
  checkmate::assert_string(prob_dist)
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
    mean = summary_stats$centre_spread$mean,
    sd = summary_stats$centre_spread$sd
  )

  # extract quantiles of distribution to calculate parameters as second choice
  quantiles <- unlist(summary_stats$quantiles)
  lower_quantiles <- quantiles[c("q_025", "q_05", "q_25", "q_50")]
  upper_quantiles <- quantiles[c("q_75", "q_875", "q_95", "q_975")]

  # extract median and range to calculate parameters as third choice
  median_range <- c(
    median = summary_stats$centre_spread$median,
    unlist(summary_stats$range)
  )

  if (!anyNA(mean_sd)) {
    # make mean_sd a class with the name of the prob dist for multiple dispatch
    prob_dist_params <- convert_params(
      summary_stats = summary_stats,
      prob_dist = prob_dist
    )
  } else if (!all(is.na(lower_quantiles)) && !all(is.na(upper_quantiles))) {
    # use the first numeric quantile in the set to calculate the parameters
    lower_percentile <- lower_quantiles[!is.na(lower_quantiles)][1]
    upper_percentile <- upper_quantiles[!is.na(upper_quantiles)][1]

    # change percentile names to give correct numbers
    names(lower_percentile) <- ifelse(
      test = grepl(pattern = "_0", x = names(lower_percentile)),
      yes = gsub(
        pattern = "(.*)_0",
        replacement = "0.",
        x = names(lower_percentile)
      ),
      no = gsub(
        pattern = "q_",
        replacement = "",
        x = names(lower_percentile)
      )
    )

    names(upper_percentile) <- ifelse(
      test = grepl(pattern = "_0", x = names(upper_percentile)),
      yes = gsub(
        pattern = "(.*)_0",
        replacement = "0.",
        x = names(upper_percentile)
      ),
      no = gsub(
        pattern = "q_",
        replacement = "",
        x = names(upper_percentile)
      )
    )

    percentiles <- c(names(lower_percentile), names(upper_percentile))

    # extract the numeric quantiles from the vector names
    percentiles <- unname(vapply(
      percentiles, function(x) {
        as.numeric(ifelse(
          test = x >= 100,
          yes = gsub(
            pattern = "^(.{2})(.*)$",
            replacement = "\\1.\\2",
            x = x
          ),
          no = x
        ))
      },
      FUN.VALUE = numeric(1)
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

#' Converts summary statistics to parameters of a probability distribution
#'
#' @description The summary_stats object needs to have a class attribute with
#' the name of the probability distribution in order for the correct conversion
#' function to be dispatched.
#'
#' @inheritParams new_epidist
#' @inheritParams epidist
#'
#' @return Named vector
#' @keywords internal
convert_params <- function(summary_stats,
                           prob_dist) {
  params <- switch(prob_dist,
    "gamma" = unlist(
      gamma_meansd2shapescale(
        mean = summary_stats$centre_spread$mean,
        sd = summary_stats$centre_spread$sd
      )
    ),
    "lognormal" =  unlist(
      lnorm_meansd2musigma(
        mean = summary_stats$centre_spread$mean,
        sd = summary_stats$centre_spread$sd
      )
    ),
    "weibull" = unlist(
      weibull_meansd2shapescale(
        mean = summary_stats$centre_spread$mean,
        sd = summary_stats$centre_spread$sd
      )
    ),
    stop("No conversion functions for ", prob_dist)
  )

  # return params
  params
}
