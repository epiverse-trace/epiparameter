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
#' \dontrun{
#'   eparam <- epiparam()
#'   as_epidist(eparam[1, ])
#' }
as_epidist <- function(x) {

  # convert each epiparam row into an epidist object
  out <- apply(x, 1, function(y) {
    make_epidist(x = y)
  })

  # remove names of list
  names(out) <- NULL

  # unpack from list if only one epidist
  if (length(out) == 1) out <- out[[1]]

  # return list of epidist objects
  out
}

#' Creates an `epidist` object from a list of input from an `epiparam` object

#' @description Unpacks list of inputs from an epiparam object into the epidist
#' helper, including the parameters and uncertainty from the correct type of
#' probability distribution
#'
#' @param x List of data to be used to construct an epidist object
#'
#' @return An `epidist` object
#' @keywords internal
make_epidist <- function(x) {

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
    epi_dist = x$epi_distribution,
    prob_distribution = x$prob_distribution,
    prob_distribution_params = parameters,
    uncertainty = uncertainty,
    summary_stats = create_epidist_summary_stats(
      mean = x$mean,
      mean_ci = x$mean_ci,
      mean_ci_interval = x$mean_ci_interval,
      sd = x$sd,
      sd_ci = x$sd_ci,
      sd_ci_interval = x$sd_ci_interval,
      median = x$median,
      median_ci = x$median_ci,
      median_ci_interval = x$median_ci_interval,
      dispersion = x$dispersion,
      dispersion_ci = x$dispersion_ci,
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
    notes = x$notes
  )
}

as_epiparam <- function(x) {

  if (inherits(edist, "epidist")) {
    n <- 1
  } else {
    n <- length(x)
  }

  # set default citation
  author <- NA_character_
  year <- NA_integer_
  DOI <- NA_character_
  PMID <- NA_character_

  # if citation is available extract info
  if (x$citation != "No citation available") {
    # extract author from citation
    author <- sub(" \\(.*", "", x$citation)
    # extract year from citation
    year <- sub("\\).*", "", sub(".*\\(", "", x$citation))
    # extract DOI from citation
    doi <- sub(">.*", "",  sub(".*<", "", x$citation))
    # extract PMID if available
    if (grepl(pattern = "PMID", x = x$citation)) {
      pmid <- sub(".*PMID: ", "", x$citation)
    }
  }

  if (inherits(x$prob_dist[[1]], "distcrete")) {
    parameters <- x$prob_dist[[1]]$parameters
  } else {
    parameters <- unlist(distributional::parameters(x$prob_dist[[1]]))
  }

  # standardise distribution parameterisation
  class(parameters) <- stats::family(x$prob_dist[[1]])
  parameters <- clean_epidist_params(prob_dist_params = parameters)

  ## TODO: sort out extrinsic

  ## TODO: work out how to sort out ci fields

  if (any(is.na(x$uncertainty))) {
    uncertainty <- list(ci = NA_real_, ci_interval = NA_real_, ci_type = NA_character_)
  } else {
    uncertainty <- list(ci = x$uncertainty)
  }

  ## TODO: look into redudancy of median and quantile 50 in epidist and epiparam class

  eparam <- data.frame(
    disease = x$disease$disease, pathogen = x$disease$pathogen,
    epi_distribution = x$epi_dist, author = author,
    year = year, sample_size = x$metadata$sample_size,
    region = x$metadata$region, vector_borne = x$metadata$vector_borne,
    vector = x$metadata$vector, extrinsic = FALSE,
    prob_distribution = x$prob_dist,
    inference_method = x$metadata$inference_method,
    mean = x$summary_stats$central_tendency_spread$mean,
    mean_ci = x$summary_stats$central_tendency_spread$mean_ci,
    mean_ci_interval = x$summary_stats$central_tendency_spread$mean_ci_interval,
    sd = x$summary_stats$central_tendency_spread$sd,
    sd_ci = x$summary_stats$central_tendency_spread$sd_ci,
    sd_ci_interval = x$summary_stats$central_tendency_spread$sd_ci_interval,
    quantile_025 = x$summary_stats$quantiles$q_025,
    quantile_05 = x$summary_stats$quantiles$q_05,
    quantile_25 = x$summary_stats$quantiles$q_25,
    median = x$summary_stats$central_tendency_spread$median,
    median_ci = x$summary_stats$central_tendency_spread$median_ci,
    median_ci_interval = x$summary_stats$central_tendency_spread$median_ci_interval,
    quantile_75 = x$summary_stats$quantiles$q_75,
    quantile_875 = x$summary_stats$quantiles$q_875,
    quantile_95 = x$summary_stats$quantiles$q_95,
    quantile_975 = x$summary_stats$quantiles$q_975,
    lower_range = x$summary_stats$range$lower_range,
    upper_range = x$summary_stats$range$upper_range,
    shape = parameters["shape"],
    shape_ci = x$uncertainty["shape"],
    shape_ci_interval = , scale = numeric(),
    scale_ci = numeric(),
    scale_ci_interval = numeric(), meanlog = numeric(),
    meanlog_ci = numeric(),
    meanlog_ci_interval = numeric(), sdlog = numeric(),
    sdlog_ci= numeric(),
    sdlog_ci_interval = numeric(), dispersion = numeric(),
    dispersion_ci = numeric(),
    dispersion_ci_interval = numeric(), precision = numeric(),
    precision_ci = numeric(),
    precision_ci_interval = numeric(), truncation = numeric(),
    discretised = logical(), censorred = logical(),
    right_truncated = logical(), phase_bias_adjusted = logical(),
    notes = character(), PMID = character(),
    DOI = character()
  )


  unlist(edist)
}


.get_epidist_params <- function(x) {
  # determine parameters
  if (x$prob_dist %in% c("gamma", "weibull")) {
    parameters <- c(shape = x$shape, scale = x$scale)
    uncertainty <- list(
      shape = create_epidist_uncertaintx(
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

  # return list of parameters and uncertainty
  list(
    parameters = parameters,
    uncertainty = uncertainty
  )
}
