#' Calculates the parameters of a probability distribution from a list of
#' available summary statistics.
#'
#' @param prob_dist A character string with the name of the probability
#' distribution
#' @param summary_stats A list of summary statistics. The structure of the list
#' can be easily made with the helper function `create_epidist_summary_stats()`.
#' @param sample_size The sample size of the data. Only needed when falling back
#' on using the median-range extraction calculation.
#'
#' @return A named vector with parameters
#' @export
calc_dist_params <- function(prob_dist,
                             summary_stats,
                             sample_size = NULL) {
  # extract mean and sd to see if conversion is possible
  mean_sd <- c(
    mean = summary_stats$central_tendency_spread$mean,
    sd = summary_stats$central_tendency_spread$sd
  )

  # extract quantiles of distribution to calculate parameters as second choice
  percentile_values <- c(
    unlist(summary_stats$quantiles[c("q_025", "q_05", "q_25", "q_50")]),
    unlist(summary_stats$quantiles[c("q_75", "q_875", "q_95", "q_975")])
  )

  # extract median and range to calculate parameters as third choice
  median_range <- c(
    median = summary_stats$central_tendency_spread$median,
    unlist(summary_stats$range)
  )

  if (length(mean_sd) == 2) {
    # make mean_sd a class with the name of the prob dist for multiple dispatch
    class(summary_stats) <- prob_dist
    params <- convert_params(summary_stats = summary_stats)
  } else if (length(percentile_values) == 2) {
    # use the first quantile in the set to calculate the parameters
    lower_percentile <- unlist(
      summary_stats$quantiles[c("q_025", "q_05", "q_25", "q_50")]
    )[1]
    upper_percentile <- unlist(
      summary_stats$quantiles[c("q_75", "q_875", "q_95", "q_975")]
    )[1]

    # extract the numeric quantiles from the vector names
    percentiles <- as.numeric(
      gsub(pattern = "q_", replacement = "0.", x = names(percentile_values))
    )

    # calculate the parameters from the percentiles
    params <- extract_param(
      type = "percentile",
      values = c(lower_percentile, upper_percentile),
      distribution = prob_dist,
      percentiles = percentiles
    )
  } else if (length(median_range) == 3 && !is.null(sample_size)) {
    params <- extract_param(
      type = "range",
      values = median_range,
      distribution = prob_dist,
      samples = sample_size
    )
  } else {
    message("No adequate summary statistics available to calculate the
    parameters of the gamma distribution")
    params <- NULL
  }

  # return params
  params
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