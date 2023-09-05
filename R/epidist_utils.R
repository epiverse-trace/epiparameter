#' Specify distribution parameter uncertainty
#'
#' @description A helper function when creating uncertainty for the parameters
#' of the distribution for the `epidist` object
#'
#' @param ci_limits A numeric vector of length two with the lower and upper
#' bound of the confidence interval or credible interval
#' @param ci A numeric specifying the interval for the ci, e.g. 95 is
#' 95% ci
#' @param ci_type A character string, either "confidence interval" or "credible
#' interval"
#'
#' @return List of three elements:
#'
#' 1. `$ci_limits` is the upper and lower bounds
#' of the CI (either confidence interval or credible interval) (i.e. a two
#' element numeric vector)
#' 2. `$ci` the interval (e.g. 95 is 95% CI) given by a
#' single numeric
#' 3. `$ci_type` a character string specifying the type of
#' uncertainty (can be either `"confidence interval"` or `"credible interval"`).
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


#' Specify metadata associated with data set
#'
#' @description A helper function when creating an epidist object to create a
#' metadata list with sensible defaults, type checking and arguments to help
#' remember metadata list structure (element names)
#'
#' @details In vector-borne diseases the transmissibility of a disease is
#' dependent on both the time taken for a host (i.e. human) to become
#' infectious, but also on the time it takes the vector to become infectious.
#' Therefore, the extrinsic delay, in which the vector has been infected by is
#' not yet infectious can have a role in the spread of a disease.
#'
#' @param sample_size The sample of the data used to fit the delay distribution.
#' This is usually the number of people with data on a primary and possibly
#' secondary event of interest. In cases where the sample size is not stated
#' NA can be used.
#' @param region The geographical location the data was collected. This can
#' either be given at sub-national, national, continental. Multiple nested
#' regions can be given and are comma separated. When the region is not
#' specified NA can be given.
#' @param transmission_mode A character string specifying how the pathogen is
#' transmitted. This information is used to determine whether the
#' epidemiological parameters are from a vector-borne disease (i.e. is
#' transmitted between humans through an intermediate vector), this is specified
#' by `transmission_mode = "vector_borne"`.
#' @param vector The name of the vector transmitting the vector-borne disease.
#' This can be a common name, or a latin binomial name of a specific vector
#' species. Both the common name and taxonomic name can be given with one given
#' in parentheses. When a disease is not vector-borne NA should be given.
#' @param extrinsic A boolean value defining whether the data entry is an
#' extrinsic delay distribution, such as the extrinsic incubation period.
#' This field is required because intrinsic and extrinsic delay distributions
#' are stored as separate entries in the database and can be linked.
#' When the disease is not vector-borne FALSE should be given. See Details for
#' explanation of extrinsic distribution.
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
#' @return A named list containing information on the sample size of the study,
#' geography, whether the disease is vector-borne and if so whether it is the
#' intrinsic or extrinsic distribution as well as method of distribution
#' parameter estimation.
#' @export
#'
#' @examples
#' # it will automatically populate the fields with defaults if left empty
#' create_epidist_metadata()
#'
#' # supplying each field
#' create_epidist_metadata(
#'   sample_size = 10,
#'   region = "UK",
#'   transmission_mode = "vector_borne",
#'   vector = "mosquito",
#'   extrinsic = FALSE,
#'   inference_method = "MLE"
#' )
create_epidist_metadata <- function(sample_size = NA_integer_,
                                    region = NA_character_,
                                    transmission_mode = NA_character_,
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
  checkmate::assert_character(transmission_mode, len = 1)
  checkmate::assert_character(vector)
  checkmate::assert_logical(extrinsic, len = 1)
  checkmate::assert_character(inference_method)

  if (transmission_mode != "vector_borne" && !is.na(vector)) {
    stop(
      "A vector is given for a non-vector-borne disease please check input",
      call. = FALSE
    )
  }

  # return list of metadata
  list(
    sample_size = sample_size,
    region = region,
    transmission_mode = transmission_mode,
    vector = vector,
    extrinsic = extrinsic,
    inference_method = inference_method
  )
}

#' Specify the geography of the data entry
#'
#' @description The geography of the data set can be a single geographical
#' region at either continent, country, region or city level. By specifying
#' the level of the geography the other fields may be deduced.
#'
#' @param continent A character string specifying the continent
#' @param country A character string specifying the country
#' @param region A character string specifying the region
#' @param city A character string specifying the city
#'
#' @return A named list
#' @export
#'
#' @examples
#' create_epidist_region(country = "UK")
create_epidist_region <- function(continent = NA_character_,
                                  country = NA_character_,
                                  region = NA_character_,
                                  city = NA_character_) {

  checkmate::assert_string(continent, na.ok = TRUE)
  checkmate::assert_string(country, na.ok = TRUE)
  checkmate::assert_string(region, na.ok = TRUE)
  checkmate::assert_string(city, na.ok = TRUE)

  # return list of regions
  list(
    continent = continent,
    country = country,
    region = region,
    city = city
  )

}

#' Specify any reported summary statistics for `epidist`
#'
#' @description A helper function when creating an epidist object to create a
#' summary statistics list with sensible defaults, type checking and arguments
#' to help remember which summary statistics can be accepted in the list.
#'
#' @param mean A numeric of the mean (expectation) of the probability
#' distribution
#' @param mean_ci_limits A numeric vector of length two of the confidence
#' interval around the mean
#' @param mean_ci A numeric specifying the confidence interval width,
#' e.g. 95 would be the 95% CI
#' @param sd A numeric of the standard deviation of the probability distribution
#' @param sd_ci_limits A numeric vector of length 2 of the confidence interval
#' around the standard deviation
#' @param sd_ci A numeric specifying the confidence interval width,
#' e.g. 95 would be 95% confidence interval
#' @param median A numeric of the median of the probability distribution
#' @param median_ci_limits A numeric vector of length two of the confidence
#' interval around the median
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
#' @param quantiles A numeric vector of the quantiles for the distribution.
#' If quantiles are not provided a default empty vector with the 2.5th, 5th,
#' 25th, 75th, 95th, 97.5th quantiles are supplied.
#'
#' @return A nested list of summary statistics. The highest level are
#' - `$centre_spread`
#' - `$quantiles`
#' - `$range`
#' - `$dispersion`
#' @export
#'
#' @examples
#' # mean and standard deviation
#' create_epidist_summary_stats(mean = 5, sd = 2)
#'
#' # mean and standard deviation with uncertainty
#' create_epidist_summary_stats(
#'   mean = 4,
#'   mean_ci_limits = c(2.1, 5.7),
#'   mean_ci = 95,
#'   sd = 0.7,
#'   sd_ci_limits = c(0.3, 1.1),
#'   sd_ci = 95
#' )
#'
#' # median and range
#' create_epidist_summary_stats(
#'   median = 5,
#'   lower_range = 1,
#'   upper_range = 13
#' )
create_epidist_summary_stats <- function(mean = NA_real_,
                                         mean_ci_limits = c(NA_real_, NA_real_),
                                         mean_ci = NA_real_,
                                         sd = NA_real_,
                                         sd_ci_limits = c(NA_real_, NA_real_),
                                         sd_ci = NA_real_,
                                         median = NA_real_,
                                         median_ci_limits = c(NA_real_,
                                                              NA_real_),
                                         median_ci = NA_real_,
                                         dispersion = NA_real_,
                                         dispersion_ci_limits = c(NA_real_,
                                                                  NA_real_),
                                         dispersion_ci = NA_real_,
                                         lower_range = NA_real_,
                                         upper_range = NA_real_,
                                         quantiles = c(
                                           "q_2.5" = NA_real_,
                                           "q_5" = NA_real_,
                                           "q_25" = NA_real_,
                                           "q_50" = NA_real_,
                                           "q_75" = NA_real_,
                                           "q_95" = NA_real_,
                                           "q_97.5" = NA_real_)) {

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
  checkmate::assert_numeric(quantiles)

  stopifnot(
    "quantiles vector should have names with 'q_' prefix" =
     !is.null(names(quantiles)) &&
      all(startsWith(x = names(quantiles), prefix = "q_"))
  )

  # return list of summary stats
  list(
    centre_spread = list(
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
    quantiles = quantiles,
    range = list(lower_range = lower_range, upper_range = upper_range),
    dispersion = list(
      dispersion = dispersion,
      dispersion_ci_limits = dispersion_ci_limits,
      dispersion_ci = dispersion_ci
    )
  )
}

#' Create a citation for an epidist object
#'
#' @description A helper function when creating an epidist object to create a
#' citation list with sensible defaults, type checking and arguments to help
#' remember which citation information is accepted in the list.
#'
#' @details This function acts as a wrapper around [`bibentry()`] to create
#' citations for sources reporting epidemiological parameters.
#'
#' @param author A `character` string of the surname of the first author. This
#' can be underscore separated from a second author, or underscore separated
#' from "etal" if there are more than two authors.
#' @param year A `numeric` of the year of publication
#' @param title A `character` string with the title of the article that
#' published the epidemiological parameters.
#' @param journal A `character` string with the name of the journal that
#' published the article that published the epidemiological parameters.
#' This can also be a pre-print server, e.g., medRxiv.
#' @param PMID A `character` string with the PubMed unique identifier number
#' assigned to papers to give them a unique identifier within PubMed.
#' @param DOI A `character` string of the Digital Object Identifier (DOI)
#' assigned to papers which are unique to each paper.
#'
#' @return A `bibentry` object of the citation
#' @export
#'
#' @examples
#' create_epidist_citation(
#'   author = "Smith_etal",
#'   year = 2002,
#'   title = "COVID-19 incubation period",
#'   journal = "Epi Journal",
#'   DOI = "10.19832/j.1366-9516.2012.09147.x"
#' )
create_epidist_citation <- function(author = NA_character_,
                                    year = NA_integer_,
                                    title = NA_character_,
                                    journal = NA_character_,
                                    DOI = NA_character_,
                                    PMID = NA_integer_) {
  # check input
  checkmate::assert_character(author)
  checkmate::assert_number(year, na.ok = TRUE)
  checkmate::assert_character(title)
  checkmate::assert_character(journal)
  checkmate::assert_character(DOI)
  checkmate::assert_number(PMID, na.ok = TRUE)

  if (is.na(author) || is.na(year) || is.na(journal) || is.na(title)) {
    message(
      "Citation cannot be created as author, year, journal or title is missing"
    )
    return(utils::bibentry(bibtype = "Misc", title = "No citation"))
  }

  if (!inherits(author, "person")) {
    # imperfect solution as library currently only has first author
    author_names <- unlist(strsplit(x = author, split = "_", fixed = TRUE))
    authors <- lapply(author_names, utils::as.person)
    authors <- Reduce(c, authors)
  }

  citation <- utils::bibentry(
    bibtype = "article",
    author = authors,
    year = year,
    title = title,
    journal = journal,
    doi = DOI
  )
  citation$PMID <- PMID

  message(
    "Using ", format(citation), " \n",
    "To retrieve the citation use the 'get_citation' function"
  )

  citation
}

#' Specify whether certain methodological aspects have been used when fitting
#' the distribution
#'
#' @description A helper function when creating an epidist object to create a
#' method assessment list with sensible defaults, type checking and arguments
#' to help remember which method assessments can be accepted in the list
#'
#' @details Currently, the method assessment focuses on common methodological
#' aspects of delay distributions (e.g. incubation period, serial interval,
#' etc.), and does not currently take into account methodological aspects which
#' may be important when fitting offspring distributions to data on disease
#' (super)spreading.
#'
#' @param censored A boolean logical whether the study used single or double
#' interval censoring in the methods to infer the delay distribution
#' @param right_truncated A boolean logical whether the study used right-
#' truncation in the methods to infer the delay distribution
#' @param phase_bias_adjusted A boolean logical whether the study adjusted for
#' phase bias in the methods to infer the delay distribution
#'
#' @return A named list with three elements
#' @export
#'
#' @examples
#' create_epidist_method_assess(
#'   censored = FALSE,
#'   right_truncated = FALSE,
#'   phase_bias_adjusted = FALSE
#' )
create_epidist_method_assess <- function(censored = NA,
                                         right_truncated = NA,
                                         phase_bias_adjusted = NA) {
  # check input
  checkmate::assert_logical(censored, len = 1)
  checkmate::assert_logical(right_truncated, len = 1)
  checkmate::assert_logical(phase_bias_adjusted, len = 1)

  # return method assessment list
  list(
    censored = censored,
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
  matches <- vapply(
    possible_params,
    setequal,
    y = names(prob_dist_params),
    FUN.VALUE = logical(1)
  )
  is_valid_params <- any(matches)

  # return check result
  is_valid_params
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

  # if unparameterised return named vector of NAs
  if (isTRUE(is.na(prob_dist_params))) {
    prob_dist_params <- c(shape = NA_real_, scale = NA_real_)
    return(prob_dist_params)
  }

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
    stop("Names of gamma distribution parameters are incorrect", call. = FALSE)
  }
}

#' Standardises parameters for a lognormal distribution
#'
#' @inheritParams new_epidist
#'
#' @return Named vector of parameters
#' @keywords internal
clean_epidist_params.lnorm <- function(prob_dist_params) {

  # if unparameterised return named vector of NAs
  if (isTRUE(is.na(prob_dist_params))) {
    prob_dist_params <- c(meanlog = NA_real_, sdlog = NA_real_)
    return(prob_dist_params)
  }

  # if mu and sigma are provided convert to meanlog and sdlog
  if (all(c("mu", "sigma") %in% names(prob_dist_params))) {

    # find index so parameters can be in any order
    mu_index <- which(names(prob_dist_params) == "mu")
    sigma_index <- which(names(prob_dist_params) == "sigma")
    names(prob_dist_params)[c(mu_index, sigma_index)] <- c("meanlog", "sdlog")

    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # return prob_dist_params
    return(prob_dist_params)
  }
  if (all(c("meanlog", "sdlog") %in% names(prob_dist_params))) {
    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # no cleaning needed
    return(prob_dist_params)
  } else {
    stop(
      "Names of lognormal distribution parameters are incorrect",
      call. = FALSE
    )
  }
}

#' Standardises parameters for a Weibull distribution
#'
#' @inheritParams new_epidist
#'
#' @return Named vector of parameters
#' @keywords internal
clean_epidist_params.weibull <- function(prob_dist_params) {

  # if unparameterised return named vector of NAs
  if (isTRUE(is.na(prob_dist_params))) {
    prob_dist_params <- c(shape = NA_real_, scale = NA_real_)
    return(prob_dist_params)
  }

  if (all(c("shape", "scale") %in% names(prob_dist_params))) {
    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # no cleaning needed
    return(prob_dist_params)
  } else {
    stop(
      "Names of Weibull distribution parameters are incorrect",
      call. = FALSE
    )
  }
}

#' Standardises parameters for a negative binomial distribution
#'
#' @inheritParams new_epidist
#'
#' @return Named vector of parameters
#' @keywords internal
clean_epidist_params.nbinom <- function(prob_dist_params) {

  # if unparameterised return named vector of NAs
  if (isTRUE(is.na(prob_dist_params))) {
    prob_dist_params <- c(mean = NA_real_, dispersion = NA_real_)
    return(prob_dist_params)
  }

  if (all(c("n", "p") %in% names(prob_dist_params))) {

    # convert prob to mean
    prob_dist_params[["p"]] <- convert_params_to_summary_stats(
      distribution = "nbinom",
      prob = prob_dist_params[["p"]],
      dispersion = prob_dist_params[["n"]]
    )$mean

    # find index so parameters can be in any order
    n_index <- which(names(prob_dist_params) == "n")
    p_index <- which(names(prob_dist_params) == "p")
    names(prob_dist_params)[c(n_index, p_index)] <- c("dispersion", "mean")

    # rearrange vector
    prob_dist_params <- prob_dist_params[c("mean", "dispersion")]

    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # return prob_dist_params
    return(prob_dist_params)
  }
  if (all(c("mean", "dispersion") %in% names(prob_dist_params))) {
    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # no cleaning needed
    return(prob_dist_params)
  } else {
    stop(
      "Names of negative binomial distribution parameters are incorrect",
      call. = FALSE
    )
  }
}

#' Standardises parameters for a geometric distribution
#'
#' @inheritParams new_epidist
#'
#' @return Named vector of parameters
#' @keywords internal
clean_epidist_params.geom <- function(prob_dist_params) {

  # if unparameterised return named NA
  if (isTRUE(is.na(prob_dist_params))) {
    prob_dist_params <- c(prob = NA_real_)
    return(prob_dist_params)
  }

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

  } else if ("p" %in% names(prob_dist_params)) {
    names(prob_dist_params) <- gsub(
      pattern = "^p$",
      replacement = "prob",
      x = names(prob_dist_params)
    )

    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # no cleaning needed
    return(prob_dist_params)
  } else if ("prob" %in% names(prob_dist_params)) {
    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # no cleaning needed
    return(prob_dist_params)
  } else {
    stop(
      "Names of geometric distribution parameters are incorrect",
      call. = FALSE
    )
  }
}

#' Standardises parameters for a poisson distribution
#'
#' @inheritParams new_epidist
#'
#' @return Named vector of parameters
#' @keywords internal
clean_epidist_params.pois <- function(prob_dist_params) {

  # if unparameterised return named NA
  if (isTRUE(is.na(prob_dist_params))) {
    prob_dist_params <- c(mean = NA_real_)
    return(prob_dist_params)
  }

  if (names(prob_dist_params) %in% c("mean", "l")) {
    names(prob_dist_params) <- "mean"

    # remove class attribute from prob_dist_params
    prob_dist_params <- unclass(prob_dist_params)

    # return prob_dist_params
    return(prob_dist_params)
  } else {
    stop(
      "Name of poisson distribution parameter is incorrect",
      call. = FALSE
    )
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
  tolower(out)
}

#' Standardises the names of diseases
#'
#' @param x A character string specifying a disease.
#'
#' @return A character string of equal length to the input
#' @export
clean_disease <- function(x) {
  checkmate::assert_character(x)
  gsub(pattern = "-| ", replacement = "_", x = tolower(x))
}
