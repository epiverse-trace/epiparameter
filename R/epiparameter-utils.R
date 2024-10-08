#' Specify distribution parameter uncertainty
#'
#' @description A helper function when creating uncertainty for the parameters
#' of the distribution for the `<epiparameter>` object.
#'
#' @param ci_limits A numeric vector of length two with the lower and upper
#' bound of the confidence interval or credible interval.
#' @param ci A numeric specifying the interval for the ci, e.g. 95 is
#' 95% ci.
#' @param ci_type A character string, either `"confidence interval"` or
#' `"credible interval"`.
#'
#' @return List of three elements:
#'
#' 1. `$ci_limits` is the upper and lower bounds
#' of the CI (either confidence interval or credible interval) (i.e. a two
#' element numeric vector).
#' 2. `$ci` the interval (e.g. 95 is 95% CI) given by a
#' single numeric.
#' 3. `$ci_type` a character string specifying the type of
#' uncertainty (can be either `"confidence interval"` or `"credible interval"`).
#' @export
#'
#' @examples
#' # example with uncertainty for a single parameter
#' create_uncertainty(
#'   ci_limits = c(1, 3),
#'   ci = 95,
#'   ci_type = "confidence interval"
#' )
#'
#' # example for multiple parameters
#' # lengh of list should match number of parameters
#' list(
#'   shape = create_uncertainty(
#'     ci_limits = c(1, 3),
#'     ci = 95,
#'     ci_type = "confidence interval"
#'   ),
#'   scale = create_uncertainty(
#'     ci_limits = c(2, 4),
#'     ci = 95,
#'     ci_type = "confidence interval"
#'   )
#' )
#'
#' # example with unknown uncertainty
#' # the function can be called without arguments
#' create_uncertainty()
#' # or give NA as the first argument
#' create_uncertainty(NA)
create_uncertainty <- function(ci_limits = NA_real_, ci, ci_type) {
  # when no uncertainty is given
  if (anyNA(ci_limits)) {
    return(list(
      ci_limits = NA_real_,
      ci = c(NA_real_, NA_real_),
      ci_type = NA_character_
    ))
  }

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
#' @description A helper function when creating an `<epiparameter>` object to
#' create a metadata list with sensible defaults, type checking and arguments
#' to help remember metadata list structure (element names).
#'
#' @details In vector-borne diseases the transmissibility of a disease is
#' dependent on both the time taken for a host (i.e. human) to become
#' infectious, but also on the time it takes the vector to become infectious.
#' Therefore, the extrinsic delay, in which the vector has been infected by is
#' not yet infectious can have a role in the spread of a disease.
#'
#' @param units A `character` for the units of the epidemiological parameter.
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
#' create_metadata()
#'
#' # supplying each field
#' create_metadata(
#'   units = "days",
#'   sample_size = 10,
#'   region = "UK",
#'   transmission_mode = "vector_borne",
#'   vector = "mosquito",
#'   extrinsic = FALSE,
#'   inference_method = "MLE"
#' )
create_metadata <- function(units = NA_character_,
                            sample_size = NA_integer_,
                            region = NA_character_,
                            transmission_mode = NA_character_,
                            vector = NA_character_,
                            extrinsic = FALSE,
                            inference_method = NA_character_) {
  # check input
  checkmate::assert_character(units)
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
    units = units,
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
#' @param continent A `character` string specifying the continent.
#' @param country A `character` string specifying the country.
#' @param region A `character` string specifying the region.
#' @param city A `character` string specifying the city.
#'
#' @return A named list.
#' @export
#'
#' @examples
#' create_region(country = "UK")
create_region <- function(continent = NA_character_,
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

# nolint start: line_length_linter
#' Specify reported summary statistics
#'
#' @description A helper function when creating an `<epiparameter>` object to
#' create a summary statistics list with sensible defaults, type checking
#' and arguments to help remember which summary statistics can be accepted in
#' the list.
#'
#' @param mean A `numeric` of the mean (expectation) of the probability
#' distribution.
#' @param mean_ci_limits A `numeric` vector of length two of the confidence
#' interval around the mean.
#' @param mean_ci A `numeric` specifying the confidence interval width,
#' e.g. `95` would be the 95% CI
#' @param sd A `numeric` of the standard deviation of the probability
#' distribution.
#' @param sd_ci_limits A `numeric` vector of length 2 of the confidence interval
#' around the standard deviation.
#' @param sd_ci A `numeric` specifying the confidence interval width,
#' e.g. `95` would be 95% confidence interval.
#' @param median A `numeric` of the median of the probability distribution.
#' @param median_ci_limits A `numeric` vector of length two of the confidence
#' interval around the median.
#' @param median_ci A `numeric` specifying the confidence interval width
#' of the median.
#' @param dispersion A `numeric` of the dispersion of the probability
#' distribution. **Important** this is the dispersion for probability
#' distributions that are not usually parameterised by a dispersion parameter,
#' for example a lognormal distribution. If a probability distribution is
#' usually parameterised with a dispersion parameter, e.g. negative binomial
#' distribution, then this should be considered a parameter and not a summary
#' statistic and should go in the `prob_distribution` argument when
#' constructing an `<epiparameter>` object with [epiparameter()]
#' (see [create_prob_distribution()]).
#' @param dispersion_ci_limits A `numeric` vector of length 2 of the confidence
#' interval around the dispersion.
#' @param dispersion_ci A `numeric` specifying the confidence interval width,
#' e.g. `95` would be 95% confidence interval.
#' @param lower_range The lower range of the data, used to infer the parameters
#' of the distribution when not provided.
#' @param upper_range The upper range of the data, used to infer the parameters
#' of the distribution when not provided.
#' @param quantiles A `numeric` vector of the quantiles for the distribution.
#' If quantiles are not provided a default empty vector with the 2.5th, 5th,
#' 25th, 75th, 95th, 97.5th quantiles are supplied.
#'
#' @return A list of summary statistics. The output list has element names
#' equal to the function arguments:
#' \preformatted{
#' `r paste("$", names(formals(create_summary_stats)), sep = "", collapse = "\n")`
#' }
#' @export
#'
#' @examples
#' # mean and standard deviation
#' create_summary_stats(mean = 5, sd = 2)
#'
#' # mean and standard deviation with uncertainty
#' create_summary_stats(
#'   mean = 4,
#'   mean_ci_limits = c(2.1, 5.7),
#'   mean_ci = 95,
#'   sd = 0.7,
#'   sd_ci_limits = c(0.3, 1.1),
#'   sd_ci = 95
#' )
#'
#' # median and range
#' create_summary_stats(
#'   median = 5,
#'   lower_range = 1,
#'   upper_range = 13
#' )
# nolint end: line_length_linter
create_summary_stats <- function(mean = NA_real_,
                                 mean_ci_limits = c(NA_real_, NA_real_),
                                 mean_ci = NA_real_,
                                 sd = NA_real_,
                                 sd_ci_limits = c(NA_real_, NA_real_),
                                 sd_ci = NA_real_,
                                 median = NA_real_,
                                 median_ci_limits = c(
                                   NA_real_,
                                   NA_real_
                                 ),
                                 median_ci = NA_real_,
                                 dispersion = NA_real_,
                                 dispersion_ci_limits = c(NA_real_, NA_real_),
                                 dispersion_ci = NA_real_,
                                 lower_range = NA_real_,
                                 upper_range = NA_real_,
                                 quantiles = NA_real_) {
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
  if (!all(is.na(quantiles))) {
    checkmate::assert_named(quantiles)
  }

  # return list of summary stats
  list(
    mean = mean,
    mean_ci_limits = mean_ci_limits,
    mean_ci = mean_ci,
    sd = sd,
    sd_ci_limits = sd_ci_limits,
    sd_ci = sd_ci,
    median = median,
    median_ci_limits = median_ci_limits,
    median_ci = median_ci,
    dispersion = dispersion,
    dispersion_ci_limits = dispersion_ci_limits,
    dispersion_ci = dispersion_ci,
    quantiles = quantiles,
    range = c(lower_range, upper_range)
  )
}

#' Create a citation for an `<epiparameter>` object
#'
#' @description A helper function when creating an `<epiparameter>` object to
#' create a citation list with sensible defaults, type checking and arguments
#' to help remember which citation information is accepted in the list.
#'
#' @details This function acts as a wrapper around [bibentry()] to create
#' citations for sources reporting epidemiological parameters.
#'
#' @param author Either a `<person>`, a `character` string, or a vector or list
#' of `characters` in the case of multiple authors. Specify the full name
#' (`"<given name>" "<family name>"`). When using `characters` make sure the
#' name can be converted to a `<person>` (see [as.person()]). Use white space
#' separation between names. Multiple names can be stored within a single
#' `<person>` (see [person()]).
#' @param year A `numeric` of the year of publication.
#' @param title A `character` string with the title of the article that
#' published the epidemiological parameters.
#' @param journal A `character` string with the name of the journal that
#' published the article that published the epidemiological parameters.
#' This can also be a pre-print server, e.g., medRxiv.
#' @param pmid A `character` string with the PubMed unique identifier number
#' (PMID) assigned to papers to give them a unique identifier within PubMed.
#' @param doi A `character` string of the Digital Object Identifier (DOI)
#' assigned to papers which are unique to each paper.
#'
#' @return A `<bibentry>` object of the citation
#' @export
#'
#' @examples
#' create_citation(
#'   author = person(given = "John", family = "Smith"),
#'   year = 2002,
#'   title = "COVID-19 incubation period",
#'   journal = "Epi Journal",
#'   doi = "10.19832/j.1366-9516.2012.09147.x"
#' )
create_citation <- function(author = utils::person(),
                            year = NA_integer_,
                            title = NA_character_,
                            journal = NA_character_,
                            doi = NA_character_,
                            pmid = NA_integer_) {
  # if not <person> try and convert author to <person>
  if (!inherits(author, "person"))
    tryCatch(expr = {
      author <- lapply(author, utils::as.person)
      author <- Reduce(f = c, x = author)
    },
    error = function(cnd) {
      stop("Authors incorrectly formatted", call. = FALSE)
    }
    )

  # check input
  checkmate::assert_class(author, classes = "person")
  checkmate::assert_number(year, na.ok = TRUE)
  checkmate::assert_character(title)
  checkmate::assert_character(journal)
  checkmate::assert_character(doi)
  checkmate::assert_number(pmid, na.ok = TRUE)

  if (length(author) == 0 || is.na(year) || is.na(journal) || is.na(title)) {
    message(
      "Citation cannot be created as author, year, journal or title is missing"
    )
    return(utils::bibentry(bibtype = "Misc", title = "No citation"))
  }

  citation <- utils::bibentry(
    bibtype = "article",
    author = author,
    year = year,
    title = title,
    journal = journal,
    doi = doi
  )
  citation$pmid <- pmid

  message(
    "Using ", format(citation), " \n",
    "To retrieve the citation use the 'get_citation' function"
  )

  citation
}

#' Specify methodological aspects of distribution fitting
#'
#' @description A helper function when creating an `<epiparameter>` object to
#' create a method assessment list with sensible defaults, type checking and
#' arguments to help remember which method assessments can be accepted in
#' the list.
#'
#' @details Currently, the method assessment focuses on common methodological
#' aspects of delay distributions (e.g. incubation period, serial interval,
#' etc.), and does not currently take into account methodological aspects which
#' may be important when fitting offspring distributions to data on disease
#' (super)spreading.
#'
#' @param censored A boolean `logical` whether the study used single or double
#' interval censoring in the methods to infer the delay distribution
#' @param right_truncated A boolean `logical` whether the study used right-
#' truncation in the methods to infer the delay distribution
#' @param phase_bias_adjusted A boolean `logical` whether the study adjusted for
#' phase bias in the methods to infer the delay distribution
#'
#' @return A named list with three elements
#' @export
#'
#' @examples
#' create_method_assess(
#'   censored = FALSE,
#'   right_truncated = FALSE,
#'   phase_bias_adjusted = FALSE
#' )
create_method_assess <- function(censored = NA,
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

#' Check whether the vector of parameters for the probability distribution
#' are in the set of possible parameters used in the epiparameter package
#'
#' @details
#' This check for valid parameters is independent of whether the distribution
#' is truncated or discretised.
#'
#' @inheritParams create_prob_distribution
#'
#' @return A boolean `logical`.
#' @export
#'
#' @examples
#' is_epiparameter_params(
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 2, scale = 1)
#' )
is_epiparameter_params <- function(prob_distribution,
                                   prob_distribution_params) {
  if (is.na(prob_distribution) || anyNA(prob_distribution_params)) {
    return(FALSE)
  }

  # mixture distributions can multiple of the same parameters
  if (prob_distribution != "mixture") {
    checkmate::assert_numeric(
      prob_distribution_params,
      min.len = 1,
      names = "unique"
    )
  }

  # remove truncation parameters if truncated
  if ("upper" %in% names(prob_distribution_params)) {
    prob_distribution_params <- prob_distribution_params[
      names(prob_distribution_params) != c("lower", "upper")
    ]
  }

  # create dictionary of valid parameter combinations
  possible_params <- list(
    gamma = list(c("shape", "scale"), c("shape", "rate")),
    weibull = list(c("shape", "scale")),
    lnorm = list(c("meanlog", "sdlog"), c("mu", "sigma")),
    nbinom = list(c("mean", "dispersion"), c("mean", "k"), c("n", "p")),
    geom = list("mean", "p", "prob"),
    pois = list("mean", "l", "lambda"),
    norm = list(c("mean", "sd"), c("mu", "sigma")),
    exp = list("rate", "lambda", "mean")
  )
  if (prob_distribution != "mixture") {
    possible_params <- possible_params[[prob_distribution]]
  } else {
    possible_params <- list(names(prob_distribution_params))
  }

  # check whether any combinations are valid
  matches <- vapply(
    possible_params,
    function(x, y) all(names(y) %in% x) && identical(length(y), length(x)),
    y = prob_distribution_params,
    FUN.VALUE = logical(1)
  )

  # return whether check for valid params result
  any(matches)
}

#' Standardise distribution parameters
#'
#' @description `.clean_params()` dispatches to a distribution
#' specific parameter cleaning function depending on `prob_dist`. For example
#' `prob_dist = "gamma"` will call `.clean_params_gamma()`.
#'
#' @details
#' Calling [is_epiparameter_params()] at the start of
#' `.clean_params()` ensures that if the parameterisation is
#' incorrect that it will error early and dispatch to the distribution
#' specific cleaning functions (e.g. `.clean_params_gamma()`).
#' This means that the distribution specific parameter cleaning functions do
#' not need to check and error for incorrect parameterisation.
#'
#' @inheritParams create_prob_distribution
#'
#' @name .clean_params
#'
#' @return Named `numeric` vector of parameters.
#' @keywords internal
.clean_params <- function(prob_distribution, prob_distribution_params) {
  valid_params <- is_epiparameter_params(
    prob_distribution = prob_distribution,
    prob_distribution_params = prob_distribution_params
  )
  if (!valid_params) {
    stop(
      "Invalid parameterisation for ", prob_distribution, " distribution",
      call. = FALSE
    )
  }
  is_trunc <- "upper" %in% names(prob_distribution_params)
  # remove truncation parameters if truncated
  if (is_trunc) {
    trunc_params <- prob_distribution_params[
      names(prob_distribution_params) == c("lower", "upper")
    ]
    prob_distribution_params <- prob_distribution_params[
      names(prob_distribution_params) != c("lower", "upper")
    ]
  }
  # weibull only has one parameterisation so does not need cleaning
  # mixture can have many parameterisations so is not cleaned
  clean_func <- switch(
    prob_distribution,
    gamma = .clean_params_gamma,
    lnorm = .clean_params_lnorm,
    weibull = function(x) x,
    nbinom = .clean_params_nbinom,
    geom = .clean_params_geom,
    pois = .clean_params_pois,
    norm = .clean_params_norm,
    exp = .clean_params_exp,
    mixture = function(x) x,
    stop("Probability distribution not recognised", call. = FALSE)
  )
  clean_params <- do.call(clean_func, list(prob_distribution_params))
  # reappend truncation parameter if truncated
  if (is_trunc) {
    clean_params <- append(clean_params, trunc_params)
  }

  # return parameters
  clean_params
}

#' @name .clean_params
.clean_params_gamma <- function(prob_dist_params) {
  # no cleaning needed for shape and scale parameterisation
  # if shape and rate are provided convert to shape and scale
  if (identical(names(prob_dist_params), c("shape", "rate"))) {
    prob_dist_params[["rate"]] <- 1 / prob_dist_params[["rate"]]
    names(prob_dist_params) <- gsub(
      pattern = "rate",
      replacement = "scale",
      x = names(prob_dist_params),
      fixed = TRUE
    )
  }
  # return prob_dist_params
  prob_dist_params
}

#' @name .clean_params
.clean_params_lnorm <- function(prob_dist_params) {
  # no cleaning needed for meanlog and sdlog parameterisation
  # if mu and sigma are provided convert to meanlog and sdlog
  if (identical(names(prob_dist_params), c("mu", "sigma"))) {
    # find index so parameters can be in any order
    mu_index <- which(names(prob_dist_params) == "mu")
    sigma_index <- which(names(prob_dist_params) == "sigma")
    names(prob_dist_params)[c(mu_index, sigma_index)] <- c("meanlog", "sdlog")
  }
  # return prob_dist_params
  prob_dist_params
}

#' @name .clean_params
.clean_params_nbinom <- function(prob_dist_params) {
  # no cleaning needed for mean and dispersion parameterisation
  if (identical(names(prob_dist_params), c("n", "p"))) {
    # convert prob to mean
    prob_dist_params[["p"]] <- convert_params_to_summary_stats(
      "nbinom",
      prob = prob_dist_params[["p"]],
      dispersion = prob_dist_params[["n"]]
    )$mean

    # find index so parameters can be in any order
    n_index <- which(names(prob_dist_params) == "n")
    p_index <- which(names(prob_dist_params) == "p")
    names(prob_dist_params)[c(n_index, p_index)] <- c("dispersion", "mean")

    # rearrange vector
    prob_dist_params <- prob_dist_params[c("mean", "dispersion")]
  }
  # return prob_dist_params
  prob_dist_params
}

#' @name .clean_params
.clean_params_geom <- function(prob_dist_params) {
  # no cleaning needed for prob parameterisation
  # if mean is provided convert to prob
  if (identical(names(prob_dist_params), "mean")) {
    prob_dist_params[["mean"]] <- 1 / prob_dist_params[["mean"]]
    names(prob_dist_params) <- gsub(
      pattern = "mean",
      replacement = "prob",
      x = names(prob_dist_params),
      fixed = TRUE
    )
  } else if (identical(names(prob_dist_params), "p")) {
    names(prob_dist_params) <- gsub(
      pattern = "^p$",
      replacement = "prob",
      x = names(prob_dist_params)
    )
  }
  # return prob_dist_params
  prob_dist_params
}

#' @name .clean_params
.clean_params_pois <- function(prob_dist_params) {
  if (names(prob_dist_params) %in% c("mean", "l", "lambda")) {
    names(prob_dist_params) <- "mean"
  }
  # return prob_dist_params
  prob_dist_params
}

#' @name .clean_params
.clean_params_norm <- function(prob_dist_params) {
  # no cleaning needed for mean and sd parameterisation
  if (identical(names(prob_dist_params), c("mu", "sigma"))) {

    # find index so parameters can be in any order
    mean_index <- which(names(prob_dist_params) == "mu")
    sd_index <- which(names(prob_dist_params) == "sigma")
    names(prob_dist_params)[c(mean_index, sd_index)] <- c("mean", "sd")

    # rearrange vector
    prob_dist_params <- prob_dist_params[c("mean", "sd")]
  }
  # return prob_dist_params
  prob_dist_params
}

#' @name .clean_params
.clean_params_exp <- function(prob_dist_params) {
  # no cleaning needed for rate parameterisation
  if (identical(names(prob_dist_params), "lambda")) {
    names(prob_dist_params) <- "rate"
  } else if (identical(names(prob_dist_params), "mean")) {
    names(prob_dist_params) <- "rate"
    prob_dist_params[["rate"]] <- 1 / prob_dist_params[["rate"]]
  }
  # return prob_dist_params
  prob_dist_params
}

#' Standardise the variables input by users
#'
#' @description
#' Checks a user has supplied a `character` string and converts
#' to \pkg{epiparameter} standards: lower-case and whitespace instead of
#' dashes or underscores.
#'
#' Examples of strings needing to be cleaned are: disease and pathogen names,
#' and epidemiological distributions.
#'
#' @param x A `character` string.
#'
#' @return A `character` vector of equal length to the input.
#' @keywords internal
.clean_string <- function(x) {
  checkmate::assert_character(x)
  gsub(pattern = "_|-", replacement = " ", x = trimws(tolower(x)))
}

#' Standardise distribution parameter uncertainty
#'
#' @param x An `<epiparameter>` object.
#' @inheritParams epiparameter
#' @param uncertainty_missing A boolean `logical` as to whether `uncertainty`
#' is missing (see [missing()]) from the parent function.
#'
#' @return An uncertainty list for an `<epiparameter>` object.
#' @keywords internal
.clean_uncertainty <- function(x, prob_distribution, uncertainty_missing) {
  param_names <- names(get_parameters(x))
  param_names <- param_names %||% NA_character_
  if (uncertainty_missing ||
      !identical(prob_distribution, x$prob_distribution)) {
    # create uncertainty for each parameter if not provided or auto calculated
    x$uncertainty <- lapply(
      param_names,
      function(xx) list(uncertainty = create_uncertainty())
    )
    if (!anyNA(param_names)) names(x$uncertainty) <- param_names
  } else {
    ci_limits_ <- lapply(x$uncertainty, `[[`, 1)
    # if uncertainty is unspecified then it only needs renaming
    if (anyNA(ci_limits_, recursive = TRUE)) {
      if (!anyNA(param_names)) names(x$uncertainty) <- param_names
    } else {
      # standardise parameter uncertainty in to match parameters
      dist <- family(x)
      params_ <- vector(mode = "list", length = length(x$uncertainty))
      names(params_) <- param_names
      for (i in seq_along(ci_limits_)) {
        params <- vapply(ci_limits_, `[[`, FUN.VALUE = numeric(1), i)
        temp <-  as.list(.clean_params(
          prob_distribution = dist,
          prob_distribution_params = params
        ))
        params_ <- Map(c, params_, temp)
      }
      ci_limits_ <- lapply(params_, function(x) sort(unname(x)))
      for (i in seq_along(x$uncertainty)) {
        x$uncertainty[[i]]$ci_limits <- ci_limits_[[i]]
      }
      names(x$uncertainty) <- param_names
    }
  }
  # return <epiparameter> uncertainty
  x$uncertainty
}
