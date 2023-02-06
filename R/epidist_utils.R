#' Specify distribution parameter uncertainty
#'
#' @description A helper function when creating uncertainty for the parameters
#' of the distribution for the `epidist` object
#'
#' @param ci_limits A numeric vector of length two with the lower and upper bound of
#' the confidence interval or credible interval
#' @param ci A numeric specifying the interval for the ci, e.g. 95 is
#' 95% ci
#' @param ci_type A character string, either "confidence interval" or "credible
#' interval"
#'
#' @return List of three elements
#' @export
#'
#' @examples
#' # example with uncertainty for a single parameter
#' create_epidist_uncertainty(
#'   ci_limits = c(1, 3),
#'   ci = 95,
#'   ci_type = "confidence interval"
#' )
#'
#' # example for multiple parameters
#' # lengh of list should match number of parameters
#' list(
#'   shape = create_epidist_uncertainty(
#'     ci_limits = c(1,3),
#'     ci = 95,
#'     ci_type = "confidence interval"
#'   ),
#'   scale = create_epidist_uncertainty(
#'     ci_limits = c(2, 4),
#'     ci = 95,
#'     ci_type = "confidence interval"
#'   )
#' )
#'
#' # example with unknown uncertainty
#' # the function can be called without arguments
#' create_epidist_uncertainty()
#' # or give NA as the first argument
#' create_epidist_uncertainty(NA)
create_epidist_uncertainty <- function(ci_limits = NA_real_, ci, ci_type) {

  # when no uncertainty is given
  if (anyNA(ci_limits)) return(list(
    ci_limits = NA_real_,
    ci = c(NA_real_, NA_real_),
    ci_type = NA_character_
  ))

  # check input
  checkmate::assert_numeric(ci_limits, any.missing = FALSE, len = 2)
  checkmate::assert_number(ci, lower = 0, upper = 100)
  checkmate::assert_character(ci_type)
  stopifnot(
    "ci_type must be either 'confidence interval or credible interval" =
      all(ci_type %in% c("confidence interval", "credible interval"))
  )

  # return list of parameter uncertainty
  list(
    ci_limits = ci_limits,
    ci = ci,
    ci_type = ci_type
  )
}


#' A helper function when creating an epidist object to create a metadata list
#' with sensible defaults, type checking and arguments to help remember metadata
#' list structure (element names)
#'
#' @param sample_size The sample of the data used to fit the delay distribution.
#' This is usually the number of people with data on a primary and possibly
#' secondary event of interest. In cases where the sample size is not stated
#' NA can be used.
#' @param region The geographical location the data was collected. This can
#' either be given at sub-national, national, continental. Multiple nested
#' regions can be given and are comma separated. When the region is not
#' specified NA can be given.
#' @param vector_borne  A boolean value as to whether a pathogen is
#' vector-borne (i.e. is transmitted between humans through an intermediate
#' vector).
#' @param vector The name of the vector transmitting the vector-borne disease.
#' This can be a common name, or a latin binomial name of a specific vector
#' species. Both the common name and taxonomic name can be given with one given
#' in parentheses. When a disease is not vector-borne NA should be given.
#' @param extrinsic A boolean value defining whether the data entry is an
#' extrinsic delay distribution, such as the extrinsic incubation period.
#' This field is required because intrinsic and extrinsic delay distributions
#' are stored as separate entries in the database and can be linked.
#' When the disease is not vector-borne FALSE should be given.
#' @param inference_method The type of inference used to fit the delay
#' distribution to the data. Abbreviations of model fitting techniques can be
#' specified as long as they are non-ambiguous. This field is only used to
#' determine whether the uncertainty intervals possibly specified in the other
#' fields are: confidence intervals (in the case of maximum likelihood), or
#' credible intervals (in the case of bayesian inference). Uncertainty bounds
#' for another types of inference methods, or if the inference method is
#' unstated are assumed to be confidence intervals. When the inference method
#' is unknown or a disease does not have a probability distribution NA can be
#' given.
#'
#' @return named list
#' @export
#'
#' @examples
#' # it will automatically populate the fields with defaults if left empty
#' create_epidist_metadata()
#'
#' # supplying each field
#' create_epidist_metadata(
#' sample_size = 10,
#' region = "UK",
#' vector_borne = TRUE,
#' vector = "mosquito",
#' extrinsic = FALSE,
#' inference_method = "MLE"
#' )
create_epidist_metadata <- function(sample_size = NA_integer_,
                                    region = NA_character_,
                                    vector_borne = FALSE,
                                    vector = NA_character_,
                                    extrinsic = FALSE,
                                    inference_method = NA_character_) {

  # check input
  checkmate::assert_number(
    sample_size,
    na.ok = TRUE,
    lower = 0,
    finite = TRUE,
    null.ok = TRUE
  )
  checkmate::assert_character(region)
  checkmate::assert_logical(vector_borne, len = 1)
  checkmate::assert_character(vector)
  checkmate::assert_logical(extrinsic, len = 1)
  checkmate::assert_character(inference_method)

  if (isFALSE(vector_borne) && !is.na(vector)) {
    stop("A vector is given for a non-vector-borne disease please check input")
  }

  # return list of metadata
  list(
    sample_size = sample_size,
    region = region,
    vector_borne = vector_borne,
    vector = vector,
    extrinsic = extrinsic,
    inference_method = inference_method
  )
}

#' A helper function when creating an epidist object to create a summary
#' statistics list with sensible defaults, type checking and arguments to help
#' remember which summary statistics can be accepted in the list
#'
#' @param mean A numeric of the mean (expectation) of the probability
#' distribution
#' @param mean_ci_limits A numeric vector of length two of the confidence interval
#' around the mean
#' @param mean_ci A numeric specifying the confidence interval width,
#' e.g. 95 would be the 95% CI
#' @param sd A numeric of the standard deviation of the probability distribution
#' @param sd_ci_limits A numeric vector of length 2 of the confidence interval around
#' the standard deviation
#' @param sd_ci A numeric specifying the confidence interval width,
#' e.g. 95 would be 95% confidence interval
#' @param median A numeric of the median of the probability distribution
#' @param median_ci_limits A numeric vector of length two of the confidence interval
#' around the median
#' @param median_ci A numeric specifying the confidence interval width
#' of the median
#' @param dispersion A numeric of the dispersion parameter of a distribution
#' @param dispersion_ci_limits A numeric vector of length two of the confidence
#' interval around the dispersion
#' @param dispersion_ci A numeric specifying the confidence interval
#' width of the dispersion parameter
#' @param lower_range The lower range of the data, used to infer the parameters
#' of the distribution when not provided
#' @param upper_range The upper range of the data, used to infer the parameters
#' of the distribution when not provided
#' @param q_025 The 2.5th quantile of the probability distribution
#' @param q_05 The 5th quantile of the probability distribution
#' @param q_25 The 25th quantile of the probability distribution
#' @param q_75 The 75th quantile of the probability distribution
#' @param q_875 The 87.5th quantile of the probability distribution
#' @param q_95 The 95th quantile of the probability distribution
#' @param q_975 The 97.5th quantile of the probability distribution
#'
#' @return A nested list of summary statistics. The highest level are
#' - `$central_tendency_spread`
#' - `$quantiles`
#' - `$range`
#' - `$dispersion`
#' @export
#'
#' @examples
#' create_epidist_summary_stats(mean = 5, sd = 2)
create_epidist_summary_stats <- function(mean = NA_real_,
                                         mean_ci_limits = c(NA_real_, NA_real_),
                                         mean_ci = NA_real_,
                                         sd = NA_real_,
                                         sd_ci_limits = c(NA_real_, NA_real_),
                                         sd_ci = NA_real_,
                                         median = NA_real_,
                                         median_ci_limits = c(NA_real_, NA_real_),
                                         median_ci = NA_real_,
                                         dispersion = NA_real_,
                                         dispersion_ci_limits = c(NA_real_, NA_real_),
                                         dispersion_ci = NA_real_,
                                         lower_range = NA_real_,
                                         upper_range = NA_real_,
                                         q_025 = NA_real_,
                                         q_05 = NA_real_,
                                         q_25 = NA_real_,
                                         q_75 = NA_real_,
                                         q_875 = NA_real_,
                                         q_95 = NA_real_,
                                         q_975 = NA_real_) {

  # check input
  checkmate::assert_number(mean, na.ok = TRUE)
  checkmate::assert_numeric(mean_ci_limits, len = 2, any.missing = TRUE)
  checkmate::assert_number(mean_ci, na.ok = TRUE)
  checkmate::assert_number(sd, na.ok = TRUE)
  checkmate::assert_numeric(sd_ci_limits, len = 2, any.missing = TRUE)
  checkmate::assert_number(sd_ci, na.ok = TRUE)
  checkmate::assert_number(median, na.ok = TRUE)
  checkmate::assert_numeric(median_ci_limits, len = 2, any.missing = TRUE)
  checkmate::assert_number(median_ci, na.ok = TRUE)
  checkmate::assert_number(dispersion, na.ok = TRUE)
  checkmate::assert_numeric(dispersion_ci_limits, len = 2, any.missing = TRUE)
  checkmate::assert_number(dispersion_ci, na.ok = TRUE)
  checkmate::assert_number(lower_range, na.ok = TRUE)
  checkmate::assert_number(upper_range, na.ok = TRUE)
  checkmate::assert_number(q_025, na.ok = TRUE)
  checkmate::assert_number(q_05, na.ok = TRUE)
  checkmate::assert_number(q_25, na.ok = TRUE)
  checkmate::assert_number(q_75, na.ok = TRUE)
  checkmate::assert_number(q_95, na.ok = TRUE)
  checkmate::assert_number(q_975, na.ok = TRUE)

  # return list of summary stats
  list(
    central_tendency_spread = list(
      mean = mean,
      mean_ci_limits = mean_ci_limits,
      mean_ci = mean_ci,
      sd = sd,
      sd_ci_limits = sd_ci_limits,
      sd_ci = sd_ci,
      median = median,
      median_ci_limits = median_ci_limits,
      median_ci = median_ci
    ),
    quantiles = list(
      q_025 = q_025,
      q_05 = q_05,
      q_25 = q_25,
      q_50 = median,
      q_75 = q_75,
      q_875 = q_875,
      q_95 = q_95,
      q_975 = q_975
    ),
    range = list(lower_range = lower_range, upper_range = upper_range),
    dispersion = list(
      dispersion = dispersion,
      dispersion_ci_limits = dispersion_ci_limits,
      dispersion_ci = dispersion_ci
    )
  )
}

#' A helper function when creating an epidist object to create a summary
#' statistics list with sensible defaults, type checking and arguments to help
#' remember which summary statistics can be accepted in the list

#' A helper function when creating an epidist object to create a citation list
#' with sensible defaults, type checking and arguments to help remember which
#' citation information is accepted in the list.
#'
#' @param author A character string of the surname of the first author. This
#' can be underscore separated from a second author, or underscore separated
#' from "etal" if there are more than two authors.
#' @param year A numeric of the year of publication
#' @param PMID A character string with the PubMed unique identifier number
#' assigned to papers to give them a unique identifier within PubMed.
#' @param DOI A character string of the Digital Object Identifier (DOI)
#' assigned to papers which are unique to each paper.
#' @param use_PMID A boolean logical determining whether the PMID is used in
#' the citation
#'
#' @return A character string of the formatted short citation
#' @export
#'
#' @examples
#' create_epidist_citation(
#'   author = "Smith_etal",
#'   year = 2002,
#'   DOI = "10.19832/j.1366-9516.2012.09147.x"
#' )
create_epidist_citation <- function(author = NA_character_,
                                    year = NA_integer_,
                                    PMID = NA_character_,
                                    DOI = NA_character_,
                                    use_PMID = FALSE) {
  # check input
  checkmate::assert_character(author)
  checkmate::assert_number(year, na.ok = TRUE)
  checkmate::assert_number(PMID, na.ok = TRUE)
  checkmate::assert_character(DOI)
  checkmate::assert_logical(use_PMID, len = 1)

  if (is.na(author) || is.na(year) || is.na(DOI)) {
    message(
      "Citation cannot be created as either author, year or DOI is missing"
    )
    return("No citation available")
  }

  if (isTRUE(use_PMID) && is.na(PMID)) {
    stop("use_PMID set to TRUE but PMID not provided")
  }

  # change author formatting if multiple authors or et al
  author <- gsub(
    pattern = "_",
    replacement = " ",
    x = author,
    fixed = TRUE
  )
  author <- gsub(
    pattern = "etal",
    replacement = "et al.",
    x = author,
    fixed = TRUE
  )

  citation <- paste0(author, " (", year, ") ", "<", DOI, ">")

  if (use_PMID) {
    citation <- paste(citation, "PMID:", PMID)
  }

  citation
}

#' A helper function when creating an epidist object to create a method
#' assessment list with sensible defaults, type checking and arguments to help
#' remember which method assessments can be accepted in the list
#'
#' @param censorred A boolean logical whether the study used single or double
#' interval censorring in the methods to infer the delay distribution
#' @param right_truncated A boolean logical whether the study used right-
#' truncation in the methods to infer the delay distribution
#' @param phase_bias_adjusted A boolean logical whether the study adjusted for
#' phase bias in the methods to infer the delay distribution
#'
#' @return A list of three elements
#' @export
#'
#' @examples
#' create_epidist_method_assessment(
#'   censorred = FALSE,
#'   right_truncated = FALSE,
#'   phase_bias_adjusted = FALSE
#' )
create_epidist_method_assessment <- function(censorred = NA,
                                             right_truncated = NA,
                                             phase_bias_adjusted = NA) {
  # check input
  checkmate::assert_logical(censorred, len = 1)
  checkmate::assert_logical(right_truncated, len = 1)
  checkmate::assert_logical(phase_bias_adjusted, len = 1)

  # return method assessment list
  list(
    censorred = censorred,
    right_truncated = right_truncated,
    phase_bias_adjusted = phase_bias_adjusted
  )
}

#' A helper function to check whether the vector of parameters for the
#' probability distribution are in the set of possible parameters used in
#' the `epiparameter` package
#'
#' @inheritParams new_epidist
#'
#' @return A logical boolean
#' @export
#'
#' @examples
#' is_epidist_params(prob_dist_params = c(shape = 2, scale = 1))
is_epidist_params <- function(prob_dist_params) {
  # check input
  checkmate::assert_numeric(
    prob_dist_params,
    min.len = 1,
    max.len = 2,
    names = "unique"
  )

  # create dictionary of valid parameter combinations
  possible_params <- list(
    c("shape", "scale"),
    c("shape", "rate"),
    c("meanlog", "sdlog"),
    c("mu", "sigma"),
    "mean",
    "prob",
    c("mean", "dispersion"),
    c("mean", "k")
  )

  # check whether any combinations are valid
  matches <- lapply(
    possible_params,
    function(x, y) x == y,
    y = names(prob_dist_params)
  )
  is_valid_params <- any(unlist(lapply(matches, all)))

  # return check result
  is_valid_params
}

#' Helper function that prints the distribution parameters accepted by
#' `epiparameter`
#'
#' @return Nothing, prints to console
#' @export
#'
#' @examples
#' possible_epidist_params()
possible_epidist_params <- function() {
  cat(
    "Gamma or Weibull must be either 'shape' and 'scale' or 'shape' and 'rate'",
    "Lognormal must be 'mealog' and 'sdlog' or 'mu' and 'sigma'",
    "Negative Binomial must be 'mean' and 'dispersion'",
    "Poisson must be 'mean'",
    "Geometric must be 'prob'",
    sep = "\n"
  )
}

clean_epidist_params <- function(prob_dist_params, ...) {
  UseMethod("clean_epidist_params")
}

#' Standardises parameters for a gamma distribution
#'
#' @inheritParams new_epidist
#'
#' @return Named vector of parameters
#' @keywords internal
clean_epidist_params.gamma <- function(prob_dist_params) {

  # if shape and rate are provided convert to shape and scale
  if (all(c("shape", "rate") %in% names(prob_dist_params))) {
    prob_dist_params[["rate"]] <- 1 / prob_dist_params[["rate"]]
    names(prob_dist_params) <- gsub(
      pattern = "rate",
      replacement = "scale",
      x = names(prob_dist_params),
      fixed = TRUE
    )

    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # return prob_dist_params
    return(prob_dist_params)
  } else if (all(c("shape", "scale") %in% names(prob_dist_params))) {
    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # no cleaning needed
    return(prob_dist_params)
  } else {
    stop("Names of gamma distribution parameters are incorrect")
  }
}

#' Standardises parameters for a lognormal distribution
#'
#' @inheritParams new_epidist
#'
#' @return Named vector of parameters
#' @keywords internal
clean_epidist_params.lognormal <- function(prob_dist_params) {

  # if meanlog and sdlog are provided convert to mu and sigma
  if (all(c("meanlog", "sdlog") %in% names(prob_dist_params))) {

    # find index so parameters can be in any order
    meanlog_index <- which(names(prob_dist_params) == "meanlog")
    sdlog_index <- which(names(prob_dist_params) == "sdlog")
    names(prob_dist_params)[c(meanlog_index, sdlog_index)] <- c("mu", "sigma")

    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)


    # return prob_dist_params
    return(prob_dist_params)
  } else if (all(c("mu", "sigma") %in% names(prob_dist_params))) {
    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # no cleaning needed
    return(prob_dist_params)
  } else {
    stop("Names of lognormal distribution parameters are incorrect")
  }
}

#' Standardises parameters for a weibull distribution
#'
#' @inheritParams new_epidist
#'
#' @return Named vector of parameters
#' @keywords internal
clean_epidist_params.weibull <- function(prob_dist_params) {

  if (all(c("shape", "scale") %in% names(prob_dist_params))) {
    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # no cleaning needed
    return(prob_dist_params)
  } else {
    stop("Names of weibull distribution parameters are incorrect")
  }
}

#' Standardises parameters for a negative binomial distribution
#'
#' @inheritParams new_epidist
#'
#' @return Named vector of parameters
#' @keywords internal
clean_epidist_params.negative_binomial <- function(prob_dist_params) {

  if (all(c("mean", "dispersion") %in% names(prob_dist_params))) {
    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # no cleaning needed
    return(prob_dist_params)
  } else {
    stop("Names of negative binomial distribution parameters are incorrect")
  }
}

#' Standardises parameters for a geometric distribution
#'
#' @inheritParams new_epidist
#'
#' @return Named vector of parameters
#' @keywords internal
clean_epidist_params.geometric <- function(prob_dist_params) {

  # if mean is provided convert to prob
  if ("mean" %in% names(prob_dist_params)) {
    prob_dist_params[["mean"]] <- 1 / prob_dist_params[["mean"]]
    names(prob_dist_params) <- gsub(
      pattern = "mean",
      replacement = "prob",
      x = names(prob_dist_params),
      fixed = TRUE
    )

    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # return prob_dist_params
    return(prob_dist_params)
  } else if ("prob" %in% names(prob_dist_params)) {
    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # no cleaning needed
    return(prob_dist_params)
  } else {
    stop("Names of geometric distribution parameters are incorrect")
  }
}

#' Default method if class of parameters is not recognised
#'
#' @inheritParams new_epidist
#'
#' @return Named vector of parameters
#' @keywords internal
clean_epidist_params.default <- function(prob_dist_params) {
  # print message that cleaning function not dispatched
  message("parameters class not recognised")

  # remove class attribute from prob_dist_params
  prob_dist_params <- unclass(prob_dist_params)

  # return prob_dist_params
  prob_dist_params
}

#' Standardises the names of epidemiological distributions
#'
#' @param epi_dist A character string with the name of the distribution
#'
#' @return Character string
#' @export
#'
#' @examples
#' clean_epidist_name("Incubation_period")
clean_epidist_name <- function(epi_dist) {
  out <- gsub(pattern = "_", replacement = " ", x = epi_dist, fixed = TRUE)
  out <- tolower(out)
  out
}
