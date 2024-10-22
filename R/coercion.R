#' [as.function()] method for `<epiparameter>` class
#'
#' @description Converts an `<epiparameter>` object to a distribution function
#' (see [epiparameter_distribution_functions]), either probability density/mass
#' function, (`density`), cumulative distribution function (`cdf`), random
#' number generator (`generate`), or quantile (`quantile`).
#'
#' @details The function returned takes a single required argument `x`.
#'
#' @inheritParams print.epiparameter
#' @inheritParams base::as.function
#' @param func_type A single `character` string specifying which distribution to
#' convert `<epiparameter>` object into. Default is `"density"`. Other options
#' are `"cdf"`, `"generate"`, or `"quantile"`.
#'
#' @return A [function] object.
#' @export
#'
#' @examples
#' ep <- epiparameter_db(single_epiparameter = TRUE)
#' # by default it will convert to a density function
#' f <- as.function(ep)
#' # use function
#' f(10)
#'
#' f <- as.function(ep, func_type = "cdf")
#' f(10)
as.function.epiparameter <- function(x,
                                     func_type = c(
                                       "density", "cdf", "generate", "quantile"
                                     ),
                                     ...) {
  chkDots(...)
  func_type <- match.arg(func_type)
  if (!is_parameterised(x)) {
    stop(
      "Cannot convert unparameterised <epiparameter> to distribution function",
      call. = FALSE
    )
  }
  epiparameter <- x
  # return distribution function
  switch(func_type,
    density = function(x) density(x = epiparameter, at = x),
    cdf = function(x) epiparameter::cdf(x = epiparameter, q = x),
    generate = function(x) epiparameter::generate(x = epiparameter, times = x),
    quantile = function(x) quantile(x = epiparameter, p = x)
  )
}


#' [as.data.frame()] method for `<epiparameter>` class
#'
#' @details
#' The `<data.frame>` returned will contain some atomic columns (i.e. one
#' object per row), and other columns that are lists (i.e. multiple objects per
#' row). The list columns can contain lists or S3 objects (e.g. `<bibentry>`
#' object in the `citation` column).
#'
#'
#' @inheritParams print.epiparameter
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @return A `<data.frame>` with a single row.
#' @export
#'
#' @examples
#' ep <- epiparameter_db(single_epiparameter = TRUE)
#' as.data.frame(ep)
as.data.frame.epiparameter <- function(x, ...) {
  chkDots(...)
  # check object as could be invalidated by user
  assert_epiparameter(x)

  data.frame(
    disease = x$disease,
    pathogen = x$pathogen,
    epi_name = x$epi_name,
    prob_distribution = I(list(prob_distribution = x$prob_distribution)),
    uncertainty = I(list(uncertainty = x$uncertainty)),
    summary_stats = I(list(summary_stats = x$summary_stats)),
    citation = I(list(citation = x$citation)),
    metadata = I(list(metadata = x$metadata)),
    method_assess = I(list(method_assess = x$method_assess)),
    notes = x$notes,
    row.names = NULL
  )
}

#' [as.data.frame()] method for `<multi_epiparameter>` class
#'
#' @inherit as.data.frame.epiparameter details
#'
#' @inheritParams print.multi_epiparameter
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @return A `<data.frame>` with as many rows as length of input list.
#' @export
#'
#' @examples
#' db <- epiparameter_db()
#' as.data.frame(db)
as.data.frame.multi_epiparameter <- function(x, ...) {
  chkDots(...)
  do.call(rbind, lapply(x, as.data.frame))
}

#' Convert to an `<epiparameter>` object
#'
#' Convert from an \R object to an `<epiparameter>` object. If conversion is not
#' possible the function will error.
#'
#' @details
#' To create the full citation the information from the article table from the
#' \pkg{epireview} package of the corresponding entry will need to be passed
#' to function via the `...` argument. The argument should be called `article`,
#' as it will be matched by name by `$`.
#'
#' To specify a probability distribution pass a `character` string to the
#' function via the `...` argument. The argument should be called
#' `prob_distribution`. For example, to specify a gamma distribution:
#' `as_epiparameter(x, prob_distribution = "gamma")`.
#'
#' ***Warning***: distributions specified via the `prob_dist` argument will
#' overwrite the probability distribution specified in the `x` argument. For
#' example, if the probability distribution is given in an \pkg{epireview}
#' entry and the `prob_dist` argument is specified then the function may error
#' or return an unparameterised `<epiparameter>` if the parameterisation becomes
#' incompatible.
#'
#' Valid probability distributions are: `"gamma"`, `"lnorm"`, `"weibull"`,
#' `"nbinom"`, `"geom"`, `"pois"`, `"norm"`, `"exp"`.
#'
#' @inheritParams base::print
#' @param ... [dots] Extra arguments to be passed to the method.
#'
#' @inherit epiparameter_db return
#' @export
as_epiparameter <- function(x, ...) {
  UseMethod("as_epiparameter")
}

#' Convert `<data.frame>` to an `<epiparameter>` object
#'
#' Convert the tabular information in `<data.frame>` to an `<epiparameter>`.
#' If the information in the `<data.frame>` cannot be converted into an
#' `<epiparameter>` the function will error.
#'
#' @param x A `<data.frame>`.
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @inherit epiparameter_db return
#' @export
#'
#' @examples
#' ep <- epiparameter_db(single_epiparameter = TRUE)
#' df <- as.data.frame(ep)
#' ep <- as_epiparameter(df)
as_epiparameter.data.frame <- function(x, ...) {
  if (is_epiparameter_df(x)) {
    epiparameter <- .epiparameter_df_to_epiparameter(x, ...)
  } else if (.is_epireview(x)) {
    epiparameter <- .epireview_to_epiparameter(x, ...)
  } else {
    stop(
      "<data.frame> input into as_epiparameter() cannot be converted to ",
      "<epiparameter>",
      call. = FALSE
    )
  }
  # return <epiparameter>
  epiparameter
}

#' Check if `<data.frame>` input is from [as.data.frame.epiparameter()]
#'
#' @param x A `<data.frame>`.
#'
#' @return A single `logical` boolean.
#' @keywords internal
is_epiparameter_df <- function(x) {
  valid_colnames <- identical(
    colnames(x),
    c(
      "disease", "pathogen", "epi_name", "prob_distribution",
      "uncertainty", "summary_stats", "citation", "metadata", "method_assess",
      "notes"
    )
  )
  # return logical
  valid_colnames
}

#' Check if `<data.frame>` input is from \pkg{epireview}
#'
#' @param x A `<data.frame>`.
#'
#' @return A single `logical` boolean.
#' @keywords internal
.is_epireview <- function(x) {
  valid_colnames <- all(epiparameter::epireview_core_cols %in% colnames(x))
  # return logical
  valid_colnames
}

#' Convert `<data.frame>` from [as.data.frame.epiparameter()] to
#' `<epiparameter>`
#'
#' @param x A `<data.frame>`.
#' @param ... [dots] Extra arguments to pass to [epiparameter()].
#'
#' @inherit epiparameter return
#' @keywords internal
.epiparameter_df_to_epiparameter <- function(x, ...) { # nolint object_length_linter
  prob_dist <- x$prob_distribution[[1]]
  if (inherits(prob_dist, "distribution")) {
    prob_distribution_params <- unlist(
      distributional::parameters(x$prob_distribution[[1]])
    )
  }
  # create uncertainty list of parameters if not provided
  if (all(unlist(lapply(x$uncertainty$uncertainty, is.na)))) {
    uncertainty <- x$uncertainty$uncertainty
  } else {
    uncertainty <- lapply(
      prob_distribution_params,
      function(x) create_uncertainty()
    )
  }

  # return <epiparameter> from class constructor
  epiparameter(
    disease = x$disease,
    pathogen = x$pathogen,
    epi_name = x$epi_name,
    prob_distribution = prob_dist,
    uncertainty = uncertainty,
    summary_stats = x$summary_stats$summary_stats,
    citation = x$citation[[1]],
    metadata = x$metadata,
    method_assess = x$method_assess,
    notes = x$notes
  )
}

#' Convert `<data.frame>` from \pkg{epireview} to `<epiparameter>`
#'
#' @param x A `<data.frame>`.
#' @param ... [dots] Extra arguments to pass to [epiparameter()].
#'
#' @inherit epiparameter return
#' @keywords internal
#' @noRd
.epireview_to_epiparameter <- function(x, ...) { # nolint cyclocomp_linter
  # capture dots and extract article info if supplied
  dots <- list(...)
  article <- dots$article
  prob_dist_in <- dots$prob_distribution
  # validate multi-row entries
  if (nrow(x) > 1) {
    stopifnot(
      "Multiple entries passed to as_epiparameter() do not have the same ID" =
        length(unique(x$id)) == 1L
    )
  }

  pathogen <- .unique(x$pathogen, var_name = "pathogen")
  # get disease from pathogen lookup
  disease <- switch(pathogen,
    "Marburg virus" = "Marburg Virus Disease",
    "Lassa mammarenavirus" = "Lassa fever",
    "Ebola virus" = "Ebola Virus Disease",
    "SARS-CoV" = "Severe Acute Respiratory Syndrome (SARS)",
    stop("Pathogen in {epireview} not recognised", call. = FALSE)
  )
  epi_name <- .unique(x$parameter_type, var_name = "parameter types")
  prob_dist <- .unique(x$distribution_type, var_name = "distribution types")
  sd_ <- NULL
  if (rlang::is_na(prob_dist)) {
    prob_dist_params <- NA_real_
    uncertainty <- list(uncertainty = create_uncertainty())
  } else {
    prob_dist <- switch(
      prob_dist,
      Gamma = "gamma",
      "Negative-Binomial" = "nbinom",
      Normal = "norm",
      Exponential = "exp",
      "Normal-Log" = NA_character_,
      Weibull = "weibull",
      stop(
        "Probability distribution in epireview not recognised",
        call. = FALSE
      )
    )
    if (rlang::is_chr_na(prob_dist)) {
      stop(
        "epireview entry has Normal-log distribution, this is not currently ",
        "supported in {epiparameter}.\n Cannot convert to <epiparameter>",
        call. = FALSE
      )
    }
    prob_dist_params <- list(
      x$distribution_par1_value,
      x$distribution_par2_value
    )
    prob_dist_params <- prob_dist_params[!is.na(prob_dist_params)]
    prob_dist_params_names <- c(
      x$distribution_par1_type,
      x$distribution_par2_type
    )
    prob_dist_params_names <-
      prob_dist_params_names[!is.na(prob_dist_params_names)]
    # {epireview} uses "Standard deviation" or "Mean sd" for sd
    prob_dist_params_names <- gsub(
      pattern = "Standard deviation|Mean sd",
      replacement = "sd",
      x = prob_dist_params_names
    )
    prob_dist_params_names <- .clean_string(prob_dist_params_names)
    names(prob_dist_params) <- prob_dist_params_names

    # overwrite prob_dist with user specified if given to make use of conversion
    if (!is.null(prob_dist_in)) {
      prob_dist <- prob_dist_in
      # remove user specified to not trigger overwriting prob_dist below
      prob_dist_in <- NULL
    }

    if (all(c("mean", "sd") %in% names(prob_dist_params))) {
      sd_ <- prob_dist_params[["sd"]]
      prob_dist_params <- do.call(
        convert_summary_stats_to_params,
        c(prob_dist, prob_dist_params)
      )
    }
    prob_dist_params <- unlist(prob_dist_params)
    uncertainty <- lapply(
      prob_dist_params,
      function(x) create_uncertainty()
    )
    names(uncertainty) <- names(prob_dist_params)
  }
  # overwrite prob_dist with user specified if given
  if (!is.null(prob_dist_in)) {
    prob_dist <- prob_dist_in
    # erase uncertainty, new prob_dist will likely have different param names
    uncertainty <- create_uncertainty()
  }
  # vectorise switch (cannot use vapply due to various return FUN.VALUE)
  param_type <- sapply( # nolint undesirable_function_linter
    x$parameter_value_type,
    switch,
    Mean = "mean",
    "Standard Deviation" = "sd",
    Median = "median",
    Other = NA_character_,
    "NA" = NULL,
    stop("Parameter value type not recognised", call. = FALSE)
  )
  # ensure param_type is unnamed vector as it is used for list subsetting
  param_type <- unlist(unname(param_type))
  is_other <- vapply(
    param_type,
    rlang::is_chr_na,
    FUN.VALUE = logical(1)
  )
  if (any(is_other)) {
    warning(
      "Parameter value type specified as 'Other'.\n",
      "Parameter value will not be input into <epiparameter>.",
      call. = FALSE
    )
    param_type <- NULL
  }
  summary_stats <- create_summary_stats()
  summary_stats[param_type] <- x$parameter_value
  uncertainty_type <- .unique(
    x$parameter_uncertainty_type,
    var_name = "uncertainty types"
  )
  if (grepl(pattern = "Range", x = uncertainty_type, fixed = TRUE)) {
    summary_stats$range <- c(x$parameter_lower_bound, x$parameter_upper_bound)
    inference_method <- NA
  } else if (grepl(pattern = "CI", x = uncertainty_type, fixed = TRUE)) {
    summary_stats <- .ss_ci(x, summary_stats, param_type)
    inference_method <- "Maximum likelihood"
  } else if (grepl(pattern = "CrI", x = uncertainty_type, fixed = TRUE)) {
    summary_stats <- .ss_ci(x, summary_stats, param_type)
    inference_method <- "Bayesian"
  } else {
    inference_method <- NA
  }
  # underscore to prevent mix-up with variable and sd()
  if (!is.null(sd_)) {
    summary_stats$sd <- sd_
  }
  metadata <- create_metadata()
  metadata$units <- .unique(x$parameter_unit, var_name = "units")
  metadata$sample_size <- .unique(x$population_sample_size)
  metadata$inference_method <- inference_method
  location <- .unique(x$population_location)
  if (rlang::is_na(location)) location <- NULL
  country <- .unique(x$population_country)
  if (rlang::is_na(country)) country <- NULL
  # NULL get removed from vector
  region <- c(location, country)
  if (length(region) > 1) {
    region <- toString(region)
  }
  metadata$region <- region
  if (is.null(article)) {
    citation <- create_citation(
      author = .unique(x$first_author_surname, var_name = "citation authors"),
      year = .unique(x$year_publication, var_name = "citation years"),
      title = "<title not available>",
      journal = "<journal not available>"
    )
    warning(
      "Cannot create full citation for epidemiological parameters without ",
      "bibliographic information \n see ?as_epiparameter for help.",
      call. = FALSE
    )
  } else {
    if (!identical(x$id, article$id)) {
      stop(
        "ID of epidemiological parameter does not match ID of article info",
        call. = FALSE
      )
    }
    citation <- create_citation(
      author = article$first_author_surname,
      year = article$year_publication,
      title = article$article_title,
      journal = article$journal,
      doi = article$doi
    )
  }
  # <epiparameter> constructor and return
  epiparameter(
    disease = disease,
    pathogen = pathogen,
    epi_name = epi_name,
    prob_distribution = create_prob_distribution(
      prob_distribution = prob_dist,
      prob_distribution_params = prob_dist_params
    ),
    uncertainty = uncertainty,
    summary_stats = summary_stats,
    citation = citation,
    metadata = metadata
  )
}

#' Check vector has a single unique value if not error
#'
#' @param x A vector.
#' @param var_name A `character` to paste into the error message.
#'
#' @return A \R object of length 1.
#' @keywords internal
#' @noRd
.unique <- function(x, var_name) {
  x <- unique(x)
  if (length(x) != 1) {
    stop(
      "epireview parameters contains multiple different ", var_name, "\n",
      "Cannot convert to <epiparameter>",
      call. = FALSE
    )
  }
  x
}

#' Input summary statistic uncertainty
#'
#' @param x A `<data.frame>` from \pkg{epireview}.
#' @param summary_stats A list returned from [create_summary_stats()].
#' @param summary_stat_type A `character` string with the name of the summary
#' statistic type (e.g., `"mean"`, `"median"`).
#'
#' @return A modified summary statistic list.
#' @keywords internal
#' @noRd
.ss_ci <- function(x, summary_stats, summary_stat_type) {
  summary_stat_type_uncertainty <- paste0(summary_stat_type, "_ci_limits")
  summary_stat_uncertainty <- list(
    x$parameter_uncertainty_lower_value,
    x$parameter_uncertainty_upper_value
  )
  ss_uncertainty <- vector(
    mode = "list",
    length = length(summary_stat_type_uncertainty)
  )
  for (i in seq_along(ss_uncertainty)) {
    ss_uncertainty[[i]] <- vapply(
      summary_stat_uncertainty,
      "[[",
      FUN.VALUE = numeric(1),
      i
    )
  }
  summary_stats[summary_stat_type_uncertainty] <- ss_uncertainty
  interval <- as.numeric(gsub(
    pattern = "[[:alpha:][:punct:]]",
    replacement = "",
    x = x$parameter_uncertainty_type
  ))
  summary_stat_interval <- gsub(
    pattern = "_limits",
    replacement = "",
    x = summary_stat_type_uncertainty,
    fixed = TRUE
  )
  summary_stats[summary_stat_interval] <- interval
  summary_stats
}
