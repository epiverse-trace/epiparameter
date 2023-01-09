#' Converts rows of an epiparam object into an epidist object
#'
#' @description Can convert the entries (rows) of an epiparam object to one or
#' list of several epidist objects. This allows subsetting of epiparam records
#' into a class that can then be used to to calculate the cdf, random number
#' generation and other methods of the epidist class
#' (see `?epidist_distribution_functions`).
#'
#' @param x A epiparam object
#'
#' @return An epidist object or a list of epidist objects
#' @export
#'
#' @examples
#' eparam <- epiparam()
#' as_epidist(eparam[1, ])
as_epidist <- function(x) {

  # determine parameters
  if (x$prob_distribution %in% c("gamma", "weibull")) {
    parameters <- c(shape = x$shape, scale = x$scale)
    uncertainty <- list(
      shape = create_epidist_uncertainty(
        ci = x$shape_ci,
        ci_interval = x$shape_ci_interval,
        ci_type =  ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      ),
      scale = create_epidist_uncertainty(
        ci = x$scale_ci,
        ci_interval = x$scale_ci_interval,
        ci_type = ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      )
    )
  } else if (x$prob_distribution %in% c("lognormal")) {
    parameters <- c(meanlog = x$meanlog, sdlog = x$sdlog)
    uncertainty <- list(
      meanlog = create_epidist_uncertainty(
        ci = x$meanlog_ci,
        ci_interval = x$meanlog_ci_interval,
        ci_type =  ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      ),
      sdlog = create_epidist_uncertainty(
        ci = x$sdlog_ci,
        ci_interval = x$sdlog_ci_interval,
        ci_type = ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      )
    )
  } else if (x$prob_distribution == "negative_binomial") {
    parameters <- c(mean = x$mean, dispersion = x$dispersion)
  } else if (x$prob_distribution %in% c("poisson", "geometric")) {
    parameters <- x$mean
  } else {
    stop("Distribution in epiparam object not recognised")
  }

  epidist(
    disease = x$disease,
    pathogen = x$pathogen,
    epi_distribution = x$epi_distribution,
    prob_distribution = x$prob_distribution,
    prob_distribution_params = parameters,
    uncertainty = uncertainty,
    summary_stats = create_epidist_summary_stats(
      mean = x$mean,
      mean_ci = x$mean_ci[[1]],
      mean_ci_interval = x$mean_ci_interval,
      sd = x$sd,
      sd_ci = x$sd_ci[[1]],
      sd_ci_interval = x$sd_ci_interval,
      median = x$median,
      median_ci = x$median_ci[[1]],
      median_ci_interval = x$median_ci_interval,
      dispersion = x$dispersion,
      dispersion_ci = x$dispersion_ci[[1]],
      dispersion_ci_interval = x$dispersion_ci_interval,
      lower_range = x$lower_range,
      upper_range = x$upper_range,
      q_025 = x$quantile_025,
      q_05 = x$quantile_05,
      q_25 = x$quantile_25,
      q_75 = x$quantile_75,
      q_875 = x$quantile_875,
      q_95 = x$quantile_95,
      q_975 = x$quantile_975
    ),
    citation = create_epidist_citation(
      author = x$author,
      year = x$year,
      PMID = x$PMID,
      DOI = x$DOI,
      use_PMID = FALSE
    ),
    metadata = create_epidist_metadata(
      sample_size = x$sample_size,
      region = x$region,
      vector_borne = x$vector_borne,
      vector = x$vector
    ),
    method_assessment = create_epidist_method_assessment(
      censorred = x$censorred,
      right_truncated = x$right_truncated,
      phase_bias_adjusted = x$phase_bias_adjusted
    ),
    discretise = x$discretised,
    truncation = x$truncation,
    notes = x$notes)

}
