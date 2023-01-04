#' A helper function when creating uncertainty for the parameters of the
#' distribution for the epidist object
#'
#' @param ci A numeric vector of length two with the lower and upper bound of
#' the confidence interval or credible interval
#' @param ci_interval A numeric specifying the interval for the ci, e.g. 95 is
#' 95% ci
#' @param ci_type A character string, either "confidence interval" or "credible
#' interval"
#'
#' @return Numeric vector with an attribute
#' @export
#'
#' @examples
#' a = 1
create_epidist_uncertainty <- function(ci = NULL, ci_interval, ci_type) {
  # when no uncertainty is given
  if (is.null(ci)) return(NULL)

  if (!is.list(ci)) {
    ci <- list(ci)
  }

  if (!is.list(ci_interval)) {
    ci_interval <- as.list(ci_interval)
  }

  if (!is.list(ci_type)) {
    ci_type <- as.list(ci_type)
  }

  # check input
  checkmate::assert_list(ci)
  checkmate::assert_list(ci_interval)
  checkmate::assert_list(ci_type)
  lapply(ci, checkmate::assert_numeric, len = 2)
  lapply(ci_interval, checkmate::assert_number)
  lapply(ci_type, checkmate::assert_character)
  stopifnot(
    "ci_type must be either 'confidence interval or credible interval" =
      all(ci_type %in% c("confidence interval", "credible interval"))
  )

  # add ci info as attribute to ci vector
  names(ci_interval) <- ci_type
  for (i in seq_along(ci)) {
    attributes(ci[[i]]) <- ci_interval[i]
  }

  # return ci
  ci
}


#' A helper function when creating an epidist object to create a metadata list
#' with sensible defaults, type checking and arguments to help remember metadata
#' list structure (element names)
#'
#' @param sample_size stub
#' @param region stub
#' @param vector_borne stub
#' @param vector stub
#' @param inference_method stub
#'
#' @return named list
#' @export
#'
#' @examples
#' a = 1
create_epidist_metadata <- function(sample_size = NULL,
                                    region = NULL,
                                    vector_borne = FALSE,
                                    vector = NULL,
                                    inference_method = NULL) {

  # check input
  checkmate::assert_number(
    sample_size,
    na.ok = TRUE,
    lower = 0,
    finite = TRUE,
    null.ok = TRUE
  )
  checkmate::assert_character(region, null.ok = TRUE)
  checkmate::assert_logical(vector_borne, len = 1)
  checkmate::assert_character(vector, null.ok = TRUE)
  checkmate::assert_character(inference_method, null.ok = TRUE)

  if (isFALSE(vector_borne) && !is.null(vector)) {
    stop("A vector is given for a non-vector-borne disease please check input")
  }

  # return list of metadata
  list(
    sample_size = sample_size,
    region = region,
    vector_borne = vector_borne,
    vector = vector,
    inference_method = inference_method
  )
}

#' A helper function when creating an epidist object to create a summary
#' statistics list with sensible defaults, type checking and arguments to help
#' remember which summary statistics can be accepted in the list
#'
#' @param mean A numeric of the mean (expectation) of the probability
#' distribution
#' @param mean_ci A numeric vector of length two of the confidence interval
#' around the mean
#' @param mean_ci_interval A numeric specifying the confidence interval width,
#' e.g. 95 would be the 95% CI
#' @param sd A numeric of the standard deviation of the probability distribution
#' @param sd_ci A numeric vector of length 2 of the confidence interval around
#' the standard deviation
#' @param sd_ci_interval A numeric specifying the confidence interval width,
#' e.g. 95 would be 95% confidence interval
#' @param median A numeric of the median of the probability distribution
#' @param median_ci A numeric vector of length two of the confidence interval
#' around the median
#' @param median_ci_interval A numeric specifying the confidence interval width
#' of the median
#' @param dispersion A numeric of the dispersion parameter of a distribution
#' @param dispersion_ci A numeric vector of length two of the confidence
#' interval around the dispersion
#' @param dispersion_ci_interval A numeric specifying the confidence interval
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
create_epidist_summary_stats <- function(mean = NULL,
                                         mean_ci = NULL,
                                         mean_ci_interval = NULL,
                                         sd = NULL,
                                         sd_ci = NULL,
                                         sd_ci_interval = NULL,
                                         median = NULL,
                                         median_ci = NULL,
                                         median_ci_interval = NULL,
                                         dispersion = NULL,
                                         dispersion_ci = NULL,
                                         dispersion_ci_interval = NULL,
                                         lower_range = NULL,
                                         upper_range = NULL,
                                         q_025 = NULL,
                                         q_05 = NULL,
                                         q_25 = NULL,
                                         q_75 = NULL,
                                         q_875 = NULL,
                                         q_95 = NULL,
                                         q_975 = NULL) {
  # check input
  checkmate::assert_number(mean, null.ok = TRUE)
  checkmate::assert_numeric(mean_ci, len = 2, null.ok = TRUE)
  checkmate::assert_number(mean_ci_interval, null.ok = TRUE)
  checkmate::assert_number(sd, null.ok = TRUE)
  checkmate::assert_numeric(sd_ci, len = 2, null.ok = TRUE)
  checkmate::assert_number(sd_ci_interval, null.ok = TRUE)
  checkmate::assert_number(median, null.ok = TRUE)
  checkmate::assert_numeric(median_ci, len = 2, null.ok = TRUE)
  checkmate::assert_number(median_ci_interval, null.ok = TRUE)
  checkmate::assert_number(dispersion, null.ok = TRUE)
  checkmate::assert_numeric(dispersion_ci, len = 2, null.ok = TRUE)
  checkmate::assert_number(dispersion_ci_interval, null.ok = TRUE)
  checkmate::assert_number(lower_range, null.ok = TRUE)
  checkmate::assert_number(upper_range, null.ok = TRUE)
  checkmate::assert_number(q_025, null.ok = TRUE)
  checkmate::assert_number(q_05, null.ok = TRUE)
  checkmate::assert_number(q_25, null.ok = TRUE)
  checkmate::assert_number(q_75, null.ok = TRUE)
  checkmate::assert_number(q_95, null.ok = TRUE)
  checkmate::assert_number(q_975, null.ok = TRUE)

  # return list of summary stats
  list(
    central_tendency_spread = list(
      mean = mean,
      mean_ci = mean_ci,
      mean_ci_interval = mean_ci_interval,
      sd = sd,
      sd_ci = sd_ci,
      sd_ci_interval = sd_ci_interval,
      median = median,
      median_ci = median_ci,
      median_ci_interval = median_ci_interval
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
      dispersion_ci = dispersion_ci,
      dispersion_ci_interval = dispersion_ci_interval
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
create_epidist_citation <- function(author = NULL,
                                    year = NULL,
                                    PMID = NULL,
                                    DOI = NULL,
                                    use_PMID = FALSE) {
  # check input
  checkmate::assert_character(author, null.ok = TRUE)
  checkmate::assert_number(year, null.ok = TRUE)
  checkmate::assert_number(PMID, null.ok = TRUE)
  checkmate::assert_character(DOI, null.ok = TRUE)
  checkmate::assert_logical(use_PMID, len = 1)

  if (is.null(author) || is.null(year) || is.null (DOI)) {
    message(
      "Citation cannot be created as either author, year or DOI is missing"
    )
    return("No citation available")
  }

  if (isTRUE(use_PMID) && is.null(PMID)) {
    stop("use_PMID set to TRUE but PMID not provided")
  }

  # change author formatting if multiple authors or et al
  author <- gsub(pattern = "_", replacement = " ", x = author)
  author <- gsub(pattern = "etal", replacement = "et al.", x = author)

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
create_epidist_method_assessment <- function(censorred = NULL,
                                             right_truncated = NULL,
                                             phase_bias_adjusted = NULL) {
  # check input
  checkmate::assert_logical(censorred, len = 1, null.ok = TRUE)
  checkmate::assert_logical(right_truncated, len = 1, null.ok = TRUE)
  checkmate::assert_logical(phase_bias_adjusted, len = 1, null.ok = TRUE)

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
    any.missing = FALSE,
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
    c("mean"),
    c("prob"),
    c("mean", "dispersion"),
    c("mean", "k")
  )

  # check whether any combinations are valid
  matches <- lapply(
    possible_params,
    function(x,y) x == y,
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

clean_epidist_params.gamma <- function(prob_dist_params) {
  # if shape and rate are provided convert to shape and scale
  if (all(c("shape", "rate") %in% names(prob_dist_params))) {
    prob_dist_params[["rate"]] <- 1 / prob_dist_params[["rate"]]
    names(prob_dist_params["rate"]) <- "scale"
  }

  # remove class attribute from prob_dist_params
  prob_dist_params <- unclass(prob_dist_params)

  # return prob_dist_params
  prob_dist_params
}

clean_epidist_params.lognormal <- function(prob_dist_params) {

  # if meanlog and sdlog are provided convert to mu and sigma
  if (all(c("meanlog", "sdlog") %in% names(prob_dist_params))) {

    # find index so parameters can be in any order
    meanlog_index <- which(names(prob_dist_params) == "meanlog")
    sdlog_index <- which(names(prob_dist_params) == "sdlog")
    names(prob_dist_params)[c(meanlog_index, sdlog_index)] <- c("mu", "sigma")
  }

  # return prob_dist_params
  prob_dist_params
}

#' Checks whether the data input into making an `epidist` class object is valid
#' for a vector-borne disease with two delay distributions (instrinsic and
#' extrinsic)
#'
#' @inheritParams new_epidist
#'
#' @return Boolean logical
#' @export
#'
#' @examples
#' # example where input is valid
#' is_valid_vector_borne(
#'   prob_dist = list("gamma", "gamma"),
#'   prob_dist_params = list(
#'     c(shape = 1, scale = 1),
#'     c(shape = 2, scale = 2)
#'   ),
#'   summary_stats = list(
#'     intrinsic = create_epidist_summary_stats(),
#'     extrinsic = create_epidist_summary_stats()
#'   ),
#'   metadata = create_epidist_metadata(vector_borne = TRUE)
#' )
#'
#' # example where input is invalid
#' is_valid_vector_borne(
#'   prob_dist = list("gamma"),
#'   prob_dist_params = list(
#'     c(shape = 1, scale = 1),
#'     c(shape = 2, scale = 2)
#'   ),
#'   summary_stats = list(
#'     intrinsic = create_epidist_summary_stats(),
#'     extrinsic = create_epidist_summary_stats()
#'   ),
#'   metadata = create_epidist_metadata(vector_borne = TRUE)
#' )
#'
#' is_valid_vector_borne(
#'   prob_dist = list("gamma", "gamma"),
#'   prob_dist_params = list(
#'     c(shape = 1, scale = 1)
#'   ),
#'   summary_stats = list(
#'     intrinsic = create_epidist_summary_stats(),
#'     extrinsic = create_epidist_summary_stats()
#'   ),
#'   metadata = create_epidist_metadata(vector_borne = TRUE)
#' )
#'
#' is_valid_vector_borne(
#'   prob_dist = list("gamma", "gamma"),
#'   prob_dist_params = list(
#'     c(shape = 1, scale = 1),
#'     c(shape = 2, scale = 2)
#'   ),
#'   summary_stats = list(
#'     intrinsic = create_epidist_summary_stats(),
#'     extrinsic = create_epidist_summary_stats()
#'   ),
#'   metadata = create_epidist_metadata(vector_borne = FALSE)
#' )
is_valid_vector_borne <- function(prob_dist,
                                  prob_dist_params,
                                  summary_stats,
                                  metadata) {
  # test if each aspect contains valid data on vector-borne
  valid_prob_dists <- length(prob_dist) == 2
  valid_prob_dist_params <- length(prob_dist_params) == 2
  valid_summary_stats <- length(summary_stats) == 2 &&
    identical(names(summary_stats), c("intrinsic", "extrinsic"))
  valid_metadata <- isTRUE(metadata$vector_borne)

  # check if all parts are valid
  is_valid_vector_borne <- valid_prob_dists && valid_prob_dist_params &&
    valid_summary_stats && valid_metadata

  # return output
  is_valid_vector_borne

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
  out <- gsub(pattern = "_", replacement = " ", x = epi_dist)
  out <- tolower(out)
  out
}
