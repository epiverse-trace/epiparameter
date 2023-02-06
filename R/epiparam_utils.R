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

  # check input
  validate_epiparam(x)

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
#'
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
  } else if (x$prob_distribution %in% "lognormal") {
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
    uncertainty <- list(
      mean = create_epidist_uncertainty(
        ci = x$mean_ci,
        ci_interval = x$mean_ci_interval,
        ci_type =  ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      ),
      dispersion = create_epidist_uncertainty(
        ci = x$dispersion_ci,
        ci_interval = x$dispersion_ci_interval,
        ci_type = ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      )
    )
  } else if (x$prob_distribution %in% c("poisson", "geometric")) {
    parameters <- c(mean = x$mean)
    uncertainty <- list(
      mean = create_epidist_uncertainty(
        ci = x$mean_ci,
        ci_interval = x$mean_ci_interval,
        ci_type =  ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      )
    )
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

#' Converts an `epidist` object to an `epiparam` object
#'
#' @param x An `epidist` object
#'
#' @return An `epiparam` object
#' @export
#'
#' @examples
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "lognormal",
#'   prob_distribution_params = c(meanlog = 1, sdlog = 1)
#' )
#' as_epiparam(edist)
as_epiparam <- function(x) {

  # for vb_epidist or list of epidists call as_epiparam recursively
  if (!is_epidist(x)) {
    eparam <- data.frame()
    for (i in seq_along(x)) {
      eparam_row <- as_epiparam(x[[i]])
      eparam <- rbind(eparam, eparam_row)
    }
    return(eparam)
  }

  # check input
  validate_epidist(x)

  # set default citation
  author <- NA_character_
  year <- NA_integer_
  doi <- NA_character_
  pmid <- NA_character_

  # if citation is available extract info
  if (x$citation != "No citation available") {
    # extract author from citation
    author <- sub(" \\(.*", "", x$citation)
    # extract year from citation
    year <- gsub(pattern = "<(.*)", replacement = "", x = x$citation)
    year <- sub("\\).*", "", sub(".*\\(", "", year))
    # extract DOI from citation
    doi <- sub(">.*", "",  sub(".*<", "", x$citation))
    # extract PMID if available
    if (grepl(pattern = "PMID", x = x$citation, fixed = TRUE)) {
      pmid <- sub(".*PMID: ", "", x$citation)
    } else {
      pmid <- NA
    }
  }

  if (inherits(x$prob_dist, "distcrete")) {
    parameters <- unlist(x$prob_dist$parameters)
    discretised <- TRUE
    prob_dist <- x$prob_dist$name
    # TODO: make use of lognormal or lnorm consistent
    if (prob_dist == "lnorm") prob_dist <- "lognormal"
    truncation <- NA
  } else {
    parameters <- unlist(distributional::parameters(x$prob_dist))
    discretised <- FALSE
    prob_dist <- stats::family(x$prob_dist)
    if (is.null(distributional::parameters(x$prob_dist)$upper)) {
      truncation <- NA
    } else {
      truncation <- distributional::parameters(x$prob_dist)$upper
    }
  }

  # standardise distribution parameterisation
  class(parameters) <- prob_dist
  parameters <- clean_epidist_params(prob_dist_params = parameters)

  if (anyNA(x$uncertainty)) {
    x$uncertainty <- lapply(
      x$uncertainty,
      function(x) {
        list(ci = NA_real_, ci_interval = NA_real_, ci_type = NA_character_)
      })
  }

  ## TODO: look into redudancy of median and quantile 50 in epidist and
  ## epiparam class

  eparam <- data.frame(
    disease = x$disease$disease,
    pathogen = x$disease$pathogen,
    epi_distribution = x$epi_dist,
    author = author,
    year = as.numeric(year),
    sample_size = x$metadata$sample_size,
    region = x$metadata$region,
    vector_borne = x$metadata$vector_borne,
    vector = x$metadata$vector,
    extrinsic = x$metadata$extrinsic,
    prob_distribution = prob_dist,
    inference_method = x$metadata$inference_method,
    mean = x$summary_stats$central_tendency_spread$mean,
    mean_ci = I(list(x$summary_stats$central_tendency_spread$mean_ci)),
    mean_ci_interval = x$summary_stats$central_tendency_spread$mean_ci_interval,
    sd = x$summary_stats$central_tendency_spread$sd,
    sd_ci = I(list(x$summary_stats$central_tendency_spread$sd_ci)),
    sd_ci_interval = x$summary_stats$central_tendency_spread$sd_ci_interval,
    quantile_025 = unname(x$summary_stats$quantiles["q_025"]),
    quantile_05 = unname(x$summary_stats$quantiles["q_05"]),
    quantile_25 = unname(x$summary_stats$quantiles["q_25"]),
    median = x$summary_stats$central_tendency_spread$median,
    median_ci = I(list(x$summary_stats$central_tendency_spread$median_ci)),
    median_ci_interval = x$summary_stats$central_tendency_spread$median_ci_interval,
    quantile_75 = unname(x$summary_stats$quantiles["q_75"]),
    quantile_875 = unname(x$summary_stats$quantiles["q_875"]),
    quantile_95 = unname(x$summary_stats$quantiles["q_95"]),
    quantile_975 = unname(x$summary_stats$quantiles["q_975"]),
    lower_range = x$summary_stats$range$lower_range,
    upper_range = x$summary_stats$range$upper_range,
    shape = ifelse(
      test = is.na(unname(parameters["shape"])),
      yes = NA_real_,
      no = parameters["shape"]
    ),
    shape_ci = NA,
    shape_ci_interval = ifelse(
      test = is.null(x$uncertainty[["shape"]]),
      yes = NA_real_,
      no = x$uncertainty$shape$ci_interval
    ),
    scale = ifelse(
      test = is.na(unname(parameters["scale"])),
      yes = NA_real_,
      no = parameters["scale"]
    ),
    scale_ci = NA,
    scale_ci_interval = ifelse(
      test = is.null(x$uncertainty[["scale"]]),
      yes = NA_real_,
      no = x$uncertainty$scale$ci_interval
    ),
    meanlog = ifelse(
      test = is.na(unname(parameters["mu"])),
      yes = NA_real_,
      no = parameters["mu"]
    ),
    meanlog_ci = NA,
    meanlog_ci_interval = ifelse(
      test = is.null(x$uncertainty[["meanlog"]]),
      yes = NA_real_,
      no = x$uncertainty$meanlog$ci_interval
    ),
    sdlog = ifelse(
      test = is.na(unname(parameters["sigma"])),
      yes = NA_real_,
      no = parameters["sigma"]
    ),
    sdlog_ci = NA,
    sdlog_ci_interval = ifelse(
      test = is.null(x$uncertainty[["sdlog"]]),
      yes = NA_real_,
      no = x$uncertainty$sdlog$ci_interval
    ),
    dispersion = ifelse(
      test = is.na(unname(parameters["dispersion"])),
      yes = NA_real_,
      no = parameters["dispersion"]
    ),
    dispersion_ci = NA,
    dispersion_ci_interval = ifelse(
      test = is.null(x$uncertainty[["dispersion"]]),
      yes = NA_real_,
      no = x$uncertainty$dispersion$ci_interval
    ),
    precision = ifelse(
      test = is.na(unname(parameters["precision"])),
      yes = NA_real_,
      no = parameters["precision"]
    ),
    precision_ci = NA,
    precision_ci_interval = ifelse(
      test = is.null(x$uncertainty[["precision"]]),
      yes = NA_real_,
      no = x$uncertainty$precision$ci_interval
    ),
    truncation = truncation,
    discretised = discretised,
    censorred = x$method_assessment$censorred,
    right_truncated = x$method_assessment$right_truncated,
    phase_bias_adjusted = x$method_assessment$phase_bias_adjusted,
    notes = x$notes,
    PMID = pmid,
    DOI = doi
  )

  # create lists for epiparam vector columns
  shape_ci <- ifelse(
    test = is.null(x$uncertainty[["shape"]]),
    yes = I(list(c(NA_real_, NA_real_))),
    no = x$uncertainty$shape$ci
  )

  scale_ci <- ifelse(
    test = is.null(x$uncertainty[["scale"]]),
    yes = I(list(c(NA_real_, NA_real_))),
    no = x$uncertainty$scale$ci
  )

  meanlog_ci <- ifelse(
    test = is.null(x$uncertainty[["meanlog"]]),
    yes = I(list(c(NA_real_, NA_real_))),
    no = x$uncertainty$meanlog$ci
  )

  sdlog_ci <- ifelse(
    test = is.null(x$uncertainty[["sdlog"]]),
    yes = I(list(c(NA_real_, NA_real_))),
    no = x$uncertainty$sdlog$ci
  )

  dispersion_ci <- ifelse(
    test = is.null(x$uncertainty[["dispersion"]]),
    yes = I(list(c(NA_real_, NA_real_))),
    no = x$uncertainty$dispersion$ci
  )

  precision_ci <- ifelse(
    test = is.null(x$uncertainty[["precision"]]),
    yes = I(list(c(NA_real_, NA_real_))),
    no = x$uncertainty$precision$ci
  )

  # insert vector columns into data frame
  eparam$shape_ci <- shape_ci
  eparam$scale_ci <- scale_ci
  eparam$meanlog_ci <- meanlog_ci
  eparam$sdlog_ci <- sdlog_ci
  eparam$dispersion_ci <- dispersion_ci
  eparam$precision_ci <- precision_ci

  # make data an epiparam object
  class(eparam) <- c("epiparam", "data.frame")

  # validate new epiparam object
  validate_epiparam(eparam)

  # return epiparam object
  eparam
}

#' Subsetting method for `epiparam` class that fails when epiparam object is
#' invalidated
#'
#' @param epiparam An `epiparam` object
#' @inheritParams base::subset
#'
#' @return An `epiparam` object
#' @export
`[.epiparam` <- function(epiparam, ...) {
  validate_epiparam(NextMethod())
}
