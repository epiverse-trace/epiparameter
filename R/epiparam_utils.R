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
#' \donttest{
#'   eparam <- epiparam()
#'   as_epidist(eparam[1, ])
#' }
as_epidist <- function(x) {

  # check input
  validate_epiparam(x)

  # convert each epiparam row into an epidist object
  out <- apply(x, 1, make_epidist)

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
        ci_limits = x$shape_ci_limits,
        ci = x$shape_ci,
        ci_type =  ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      ),
      scale = create_epidist_uncertainty(
        ci_limits = x$scale_ci_limits,
        ci = x$scale_ci,
        ci_type = ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      )
    )
  } else if (x$prob_distribution %in% "lnorm") {
    parameters <- c(meanlog = x$meanlog, sdlog = x$sdlog)
    uncertainty <- list(
      meanlog = create_epidist_uncertainty(
        ci_limits = x$meanlog_ci_limits,
        ci = x$meanlog_ci,
        ci_type =  ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      ),
      sdlog = create_epidist_uncertainty(
        ci_limits = x$sdlog_ci_limits,
        ci = x$sdlog_ci,
        ci_type = ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      )
    )
  } else if (x$prob_distribution %in% "nbinom") {
    parameters <- c(mean = x$mean, dispersion = x$dispersion)
    uncertainty <- list(
      mean = create_epidist_uncertainty(
        ci_limits = x$mean_ci_limits,
        ci = x$mean_ci,
        ci_type =  ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      ),
      dispersion = create_epidist_uncertainty(
        ci_limits = x$dispersion_ci_limits,
        ci = x$dispersion_ci,
        ci_type = ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      )
    )
  } else if (x$prob_distribution %in% c("pois", "geom")) {
    parameters <- c(mean = x$mean)
    uncertainty <- list(
      mean = create_epidist_uncertainty(
        ci_limits = x$mean_ci_limits,
        ci = x$mean_ci,
        ci_type =  ifelse(
          test = x$inference_method == "mle",
          yes = "confidence interval",
          no = "credible interval"
        )
      )
    )
  } else if (is.na(x$prob_distribution)) {
    parameters <- NA_real_
    uncertainty <- create_epidist_uncertainty()
  } else {
    stop("Distribution in epiparam object not recognised", call. = FALSE)
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
      mean_ci_limits = x$mean_ci_limits,
      mean_ci = x$mean_ci,
      sd = x$sd,
      sd_ci_limits = x$sd_ci_limits,
      sd_ci = x$sd_ci,
      median = x$median,
      median_ci_limits = x$median_ci_limits,
      median_ci = x$median_ci,
      dispersion = x$dispersion,
      dispersion_ci_limits = x$dispersion_ci_limits,
      dispersion_ci = x$dispersion_ci,
      lower_range = x$lower_range,
      upper_range = x$upper_range,
      quantiles = c(
        q_2.5 = x$quantile_2.5,
        q_5 = x$quantile_5,
        q_25 = x$quantile_25,
        q_75 = x$quantile_75,
        q_87.5 = x$quantile_87.5,
        q_95 = x$quantile_95,
        q_97.5 = x$quantile_97.5
      )
    ),
    citation = create_epidist_citation(
      author = x$author,
      year = x$year,
      title = x$title,
      journal = x$journal,
      DOI = x$DOI,
      PMID = x$PMID
    ),
    metadata = create_epidist_metadata(
      sample_size = x$sample_size,
      region = x$region,
      transmission_mode = x$transmission_mode,
      vector = x$vector
    ),
    method_assess = create_epidist_method_assess(
      censored = x$censored,
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
#'   prob_distribution = "lnorm",
#'   prob_distribution_params = c(meanlog = 1, sdlog = 1)
#' )
#' as_epiparam(edist)
as_epiparam <- function(x) {

  # for vb_epidist or list of epidists call as_epiparam recursively
  if (!is_epidist(x)) {
    eparam <- as.data.frame(matrix(nrow = length(x), ncol = 58))
    for (i in seq_along(x)) {
      if (i == 1) colnames(eparam) <- colnames(as_epiparam(x[[i]]))
      eparam[i, ] <- as_epiparam(x[[i]])
    }
    class(eparam) <- c("epiparam", "data.frame")
    return(eparam)
  }

  # check input
  validate_epidist(x)

  params <- get_parameters(x)
  prob_dist <- family(x)

  if (inherits(x$prob_dist, "distcrete")) {
    discretised <- TRUE
    truncation <- NA_real_
  } else {
    discretised <- FALSE
    if (!("upper" %in% names(params))) {
      truncation <- NA_real_
    } else {
      truncation <- params[["upper"]]
    }
  }

  # standardise distribution parameterisation
  class(params) <- prob_dist
  params <- clean_epidist_params(prob_dist_params = params)

  if (anyNA(x$uncertainty)) {
    x$uncertainty <- lapply(
      x$uncertainty,
      function(x) {
        list(ci_limits = NA_real_, ci = NA_real_, ci_type = NA_character_)
      })
  }

  author <- ifelse(
    test = is.null(x$citation$author),
    yes = NA_character_,
    no = Reduce(
      f = function(x, y) {
        paste(x, y, sep = "_")
      },
      x = x$citation$author
    )
  )

  ## TODO: look into redudancy of median and quantile 50 in epidist and
  ## epiparam class

  eparam <- data.frame(
    disease = x$disease$disease,
    pathogen = x$disease$pathogen,
    epi_distribution = x$epi_dist,
    author = author,
    title = ifelse(
      test = is.null(x$citation$title),
      yes = NA_character_,
      no = x$citation$title
    ),
    journal = ifelse(
      test = is.null(x$citation$journal),
      yes = NA_character_,
      no = x$citation$journal
    ),
    year = ifelse(
      test = is.null(x$citation$year),
      yes = NA_integer_,
      no = as.numeric(x$citation$year)
    ),
    sample_size = x$metadata$sample_size,
    region = x$metadata$region,
    transmission_mode = x$metadata$transmission_mode,
    vector = x$metadata$vector,
    extrinsic = x$metadata$extrinsic,
    prob_distribution = prob_dist,
    inference_method = x$metadata$inference_method,
    mean = x$summary_stats$centre_spread$mean,
    mean_ci_limits = I(list(x$summary_stats$centre_spread$mean_ci_limits)),
    mean_ci = x$summary_stats$centre_spread$mean_ci,
    sd = x$summary_stats$centre_spread$sd,
    sd_ci_limits = I(list(x$summary_stats$centre_spread$sd_ci_limits)),
    sd_ci = x$summary_stats$centre_spread$sd_ci,
    quantile_2.5 = unname(x$summary_stats$quantiles["q_2.5"]),
    quantile_5 = unname(x$summary_stats$quantiles["q_5"]),
    quantile_25 = unname(x$summary_stats$quantiles["q_25"]),
    median = x$summary_stats$centre_spread$median,
    median_ci_limits = I(list(x$summary_stats$centre_spread$median_ci_limits)),
    median_ci = x$summary_stats$centre_spread$median_ci,
    quantile_75 = unname(x$summary_stats$quantiles["q_75"]),
    quantile_87.5 = unname(x$summary_stats$quantiles["q_87.5"]),
    quantile_95 = unname(x$summary_stats$quantiles["q_95"]),
    quantile_97.5 = unname(x$summary_stats$quantiles["q_97.5"]),
    lower_range = x$summary_stats$range$lower_range,
    upper_range = x$summary_stats$range$upper_range,
    shape = unname(params["shape"]),
    shape_ci_limits = NA,
    shape_ci = ifelse(
      test = is.null(x$uncertainty[["shape"]]),
      yes = NA_real_,
      no = x$uncertainty$shape$ci
    ),
    scale = unname(params["scale"]),
    scale_ci_limits = NA,
    scale_ci = ifelse(
      test = is.null(x$uncertainty[["scale"]]),
      yes = NA_real_,
      no = x$uncertainty$scale$ci
    ),
    meanlog = unname(params["meanlog"]),
    meanlog_ci_limits = NA,
    meanlog_ci = ifelse(
      test = is.null(x$uncertainty[["meanlog"]]),
      yes = NA_real_,
      no = x$uncertainty$meanlog$ci
    ),
    sdlog = unname(params["sdlog"]),
    sdlog_ci_limits = NA,
    sdlog_ci = ifelse(
      test = is.null(x$uncertainty[["sdlog"]]),
      yes = NA_real_,
      no = x$uncertainty$sdlog$ci
    ),
    dispersion = unname(params["dispersion"]),
    dispersion_ci_limits = NA,
    dispersion_ci = ifelse(
      test = is.null(x$uncertainty[["dispersion"]]),
      yes = NA_real_,
      no = x$uncertainty$dispersion$ci
    ),
    precision = unname(params["precision"]),
    precision_ci_limits = NA,
    precision_ci = ifelse(
      test = is.null(x$uncertainty[["precision"]]),
      yes = NA_real_,
      no = x$uncertainty$precision$ci
    ),
    truncation = truncation,
    discretised = discretised,
    censored = x$method_assess$censored,
    right_truncated = x$method_assess$right_truncated,
    phase_bias_adjusted = x$method_assess$phase_bias_adjusted,
    notes = x$notes,
    PMID = ifelse(
      test = is.null(x$citation$PMID),
      yes = NA_integer_,
      no = as.numeric(x$citation$PMID)
    ),
    DOI = ifelse(
      test = is.null(x$citation$doi),
      yes =  NA_character_,
      no = x$citation$doi
    )
  )

  # create lists for epiparam vector columns
  eparam <- add_ci_limits(eparam = eparam, x = x)

  # make data an epiparam object
  class(eparam) <- c("epiparam", "data.frame")

  # validate new epiparam object
  validate_epiparam(eparam)

  # return epiparam object
  eparam
}

#' Adds confidence interval limits from an `epidist` object to an `epiparam`
#' data frame
#'
#' @param eparam A data frame with `<epiparam>` data
#' @param x An `<epidist>` object
#'
#' @return A data frame containing `<epiparam>` data
#' @keywords internal
#' @noRd
add_ci_limits <- function(eparam, x) {

  if (is.null(x$uncertainty[["shape"]])) {
    eparam$shape_ci_limits <- I(list(c(NA_real_, NA_real_)))
  } else {
    eparam$shape_ci_limits <- list(x$uncertainty$shape$ci)
  }

  if (is.null(x$uncertainty[["scale"]])) {
    eparam$scale_ci_limits <- I(list(c(NA_real_, NA_real_)))
  } else {
    eparam$scale_ci_limits <- list(x$uncertainty$scale$ci)
  }

  if (is.null(x$uncertainty[["meanlog"]])) {
    eparam$meanlog_ci_limits <- I(list(c(NA_real_, NA_real_)))
  } else {
    eparam$meanlog_ci_limits <- list(x$uncertainty$meanlog$ci)
  }

  if (is.null(x$uncertainty[["sdlog"]])) {
    eparam$sdlog_ci_limits <- I(list(c(NA_real_, NA_real_)))
  } else {
    eparam$sdlog_ci_limits <- list(x$uncertainty$sdlog$ci)
  }

  if (is.null(x$uncertainty[["dispersion"]])) {
    eparam$dispersion_ci_limits <- I(list(c(NA_real_, NA_real_)))
  } else {
    eparam$dispersion_ci_limits <- list(x$uncertainty$dispersion$ci)
  }

  if (is.null(x$uncertainty[["precision"]])) {
    eparam$precision_ci_limits <- I(list(c(NA_real_, NA_real_)))
  } else {
    eparam$precision_ci_limits <- list(x$uncertainty$precision$ci)
  }

  # return epiparam
  eparam
}

#' Subsetting method for `epiparam`
#'
#' @description If the subsetting invalidates the `epiparam` object (defined by
#' its invariants, and encoded in [`validate_epiparam()`]) the subsetting will
#' return a data frame with a message to console stating the class of the object
#' has been converted to `data.frame` with the other attributes of the class
#' preserved.
#'
#' @param epiparam An `epiparam` object
#' @inheritParams base::subset
#'
#' @return An `epiparam` object or a `data.frame`
#' @export
`[.epiparam` <- function(epiparam, ...) {
  out <- NextMethod()
  epiparam_reconstruct(out, epiparam)
}

#' Set names on `epiparam` class
#'
#' @description If the modifying the names invalidates the `epiparam` object
#' (defined by its invariants, and encoded in [`validate_epiparam()`]) the
#' subsetting will return a data frame with a message to console stating the
#' class of the object has been converted to `data.frame` with the other
#' attributes of the class preserved.
#'
#' @inheritParams base::names
#'
#' @return An `epiparam` object or a `data.frame`
#' @export
`names<-.epiparam` <- function(x, value) {
  out <- NextMethod()
  epiparam_reconstruct(out, x)
}

#' Set accessor for `epiparam` class
#'
#' @param x An `epiparam` object
#' @inheritParams base::Extract
#'
#' @return An `epiparam` object or a `data.frame`
#' @export
`$<-.epiparam` <- function(x, name, value) {
  out <- NextMethod()
  epiparam_reconstruct(out, x)
}

#' Decides whether `epiparam` object can be reconstructed from input
#'
#' @description Uses [`epiparam_can_reconstruct()`] to determine whether the
#' data input can be reconstructed in a valid `epiparam` object. If it can not,
#' it is returned as a `data.frame`.
#'
#' @param x A `data.frame` or subclass of `data.frame` (e.g. `tibble` or
#' `epiparam`)
#' @param to The reference object, in this case an `epiparam` object
#'
#' @return An `epiparam` object (if the input is valid) or a `data.frame`
#' @keywords internal
epiparam_reconstruct <- function(x, to) {
  if (epiparam_can_reconstruct(x)) {
    df_reconstruct(x, to)
  } else {
    x <- as.data.frame(x)
    message("Removing crucial column in `<epiparam>` returning `<data.frame>`")
    x
  }
}

#' Checks whether the `epiparam` object is valid
#'
#' @description This is a wrapper for [`validate_epiparam`] in a [`tryCatch()`]
#' in order to not error if the input object is invalid and returns `TRUE` or
#' `FALSE` on if the object is valid. If the object is valid it can be
#' "reconstructed" and not downgraded to a `data.frame`.
#'
#' @inheritParams epiparam_reconstruct
#'
#' @return A boolean logical (`TRUE` or `FALSE`)
#' @keywords internal
epiparam_can_reconstruct <- function(x) {

  # check whether input is valid, ignoring its class
  out <- tryCatch(
    { validate_epiparam(x, reconstruct = TRUE) },
    error = function(cnd) FALSE
  )

  # return boolean
  !isFALSE(out)
}

#' Transplants the attributes of one input (`to`) to the other input (`x`)
#'
#' @inheritParams epiparam_reconstruct
#'
#' @return An `epiparam` object
#' @keywords internal
df_reconstruct <- function(x, to) {
  attrs <- attributes(to)
  attrs$names <- names(x)
  attrs$row.names <- .row_names_info(x, type = 0L)
  attributes(x) <- attrs
  x
}

#' @exportS3Method dplyr::dplyr_reconstruct
dplyr_reconstruct.epiparam <- function(data, template) {
  epiparam_reconstruct(data, template)
}
