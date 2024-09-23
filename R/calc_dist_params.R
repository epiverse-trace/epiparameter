#' Calculate the parameters of a probability distribution from a list of
#' summary statistics
#'
#' @description If parameters of a probability distribution are not
#' provided (e.g. when describing the distribution in the literature) and
#' instead summary statistics of a distribution are provided, the parameters
#' can usually be calculated from the summary statistics.
#'
#' This function can provide a convenient wrapper around
#' [convert_summary_stats_to_params()] and [extract_param()]
#' when it is not known which summary statistics can be used to
#' calculate the parameters of a distribution.
#'
#' @details The hierarchy of methods is:
#'
#' 1. Conversion is prioritised if the mean and standard deviation are
#' available as these are mostly analytical conversions (except for one of the
#' Weibull conversions).
#' 2. Next method if possible is extraction from percentiles. This method
#' requires a lower percentile (between(0-50]) and an upper percentile
#' (between (50-100)). If multiple percentiles in each of these ranges is
#' provided the lowest value is used for the calculation.
#' 3. The last method is the extraction using a median and range of the data.
#'
#' @inheritParams new_epiparameter
#' @inheritParams epiparameter
#' @param sample_size The sample size of the data. Only needed when falling back
#' on using the median-range extraction calculation.
#'
#' @return A named `numeric` vector with parameters.
#' @keywords internal
.calc_dist_params <- function(prob_distribution, # nolint cyclocomp
                              summary_stats,
                              sample_size) {
  if (is.na(prob_distribution)) {
    message(
      "No adequate summary statistics available to calculate the parameters ",
      "of the ", prob_distribution, " distribution"
    )
    return(NA)
  }

  is_percentiles <- checkmate::test_numeric(
    summary_stats$quantiles,
    all.missing = FALSE,
    names = "unique",
    null.ok = FALSE
  )
  if (is_percentiles) {
    # convert percentile names to numbers
    percentiles <- .get_percentiles(summary_stats$quantiles)
  } else {
    percentiles <- NA
  }

  # extract median and range to calculate parameters as third choice
  median_range <- c(
    median = summary_stats$median,
    unlist(summary_stats$range)
  )

  # extract mean and sd
  mean_sd <- c(summary_stats$mean, summary_stats$sd)

  is_mean_sd <- checkmate::test_numeric(
    mean_sd, any.missing = FALSE, len = 2, finite = TRUE
  )

  is_median_disp <- checkmate::test_number(
    summary_stats$median,
    finite = TRUE
  ) && checkmate::test_number(
    summary_stats$dispersion,
    finite = TRUE
  )

  is_median_range <- checkmate::test_numeric(
    median_range, len = 3, finite = TRUE
  ) && checkmate::test_count(sample_size, positive = TRUE)
  # convert from mean and sd
  if (is_mean_sd) {
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
    args <- unlist(
      list(prob_distribution, as.list(summary_stats_)),
      recursive = FALSE
    )
    prob_distribution_params <- unlist(do.call(
      convert_summary_stats_to_params,
      args = args
    ))
  } else if (is_median_disp) {
    args <- list(
      x = prob_distribution,
      median = summary_stats$median,
      dispersion = summary_stats$dispersion
    )
    prob_distribution_params <- do.call(
      convert_summary_stats_to_params,
      args = args
    )
    prob_distribution_params <- unlist(prob_distribution_params)
  } else if (!anyNA(percentiles)) {
    # calculate the parameters from the percentiles
    # percentiles required to be [0, 1] so divide by 100
    prob_distribution_params <- extract_param(
      type = "percentile",
      values = percentiles,
      distribution = prob_distribution,
      percentiles = as.numeric(names(percentiles)) / 100
    )
  } else if (is_median_range) {
    prob_distribution_params <- extract_param(
      type = "range",
      values = median_range,
      distribution = prob_distribution,
      samples = sample_size
    )
  } else {
    message(
      "No adequate summary statistics available to calculate the parameters ",
      "of the ", prob_distribution, " distribution"
    )
    return(NA)
  }

  # return params
  prob_distribution_params
}
