#' [as.function()] method for `<epidist>` class
#'
#' @description Converts an `<epidist>` object to a distribution function
#' (see [epidist_distribution_functions]), either probability density/mass
#' function, (`density`), cumulative distribution function (`cdf`), random
#' number generator (`generate`), or quantile (`quantile`).
#'
#' @details The function returned takes a single required argument `x`.
#'
#' @inheritParams print.epidist
#' @inheritParams base::as.function
#' @param func_type A single `character` string specifying which distribution to
#' convert `<epidist>` object into. Default is `"density"`. Other options are
#' `"cdf"`, `"generate"`, or `"quantile"`.
#'
#' @return A [function] object.
#' @export
as.function.epidist <- function(x,
                                func_type = c(
                                  "density", "cdf", "generate", "quantile"
                                ),
                                ...) {
  chkDots(...)
  func_type <- match.arg(func_type)
  if (!is_parameterised(x)) {
    stop(
      "Cannot convert unparameterised <epidist> to distribution function",
      call. = FALSE
    )
  }
  epidist <- x
  x <- switch(func_type,
    density = function(x) density(x = epidist, at = x),
    cdf = function(x) epiparameter::cdf(x = epidist, q = x),
    generate = function(x) epiparameter::generate(x = epidist, times = x),
    quantile = function(x) quantile(x = epidist, p = x)
  )

  # return distribution function
  x
}


#' [as.data.frame()] method for `<epidist>` class
#'
#' @details
#' The `<data.frame>` returned will contain some atomic columns (i.e. one
#' object per row), and other columns that are lists (i.e. multiple objects per
#' row). The list columns can contain lists or S3 objects (e.g. `<bibentry>`
#' object in the `citation` column).
#'
#'
#' @inheritParams print.epidist
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @return A `<data.frame>` with a single row.
#' @export
as.data.frame.epidist <- function(x, ...) {
  chkDots(...)
  # check object as could be invalidated by user
  validate_epidist(x)

  # make data frame
  df <- data.frame(
    disease = x$disease,
    pathogen = x$pathogen,
    epi_distribution = x$epi_dist,
    prob_distribution = I(list(prob_dist = x$prob_dist)),
    uncertainty = I(list(uncertainty = x$uncertainty)),
    summary_stats = I(list(summary_stats = x$summary_stats)),
    citation = I(x$citation),
    metadata = I(list(metadata = x$metadata)),
    method_assess = I(list(method_assess = x$method_assess)),
    notes = x$notes
  )
  row.names(df) <- NULL

  # return data frame
  df
}

#' [as.data.frame()] method for `<multi_epidist>` class
#'
#' @inherit as.data.frame.epidist details
#'
#' @inheritParams print.multi_epidist
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @return A `<data.frame>` with as many rows as length of input list.
#' @export
as.data.frame.multi_epidist <- function(x, ...) {
  chkDots(...)
  do.call(rbind, lapply(x, as.data.frame))
}

#' Convert to an `<epidist>` object
#'
#' Convert from an \R object to an `<epidist>` object. If conversion is not
#' possible the function will error.
#'
#' @details
#' To create the full citation the information from the article table from the
#' \pkg{epireview} package of the corresponding entry will need to be passed
#' to function via the `...` argument. The argument should be called `article`,
#' as it will be matched by name by `$`.
#'
#' To specify a probability distribution pass a `character` string to the
#' function via the `...` argument. The argument should be called `prob_dist`.
#' For example, to specify a gamma distribution:
#' `as_epidist(x, prob_dist = "gamma")`.
#'
#' ***Warning***: distributions specified via the `prob_dist` argument will
#' overwrite the probability distribution specified in the `x` argument. For
#' example, if the probability distribution is given in an \pkg{epireview}
#' entry and the `prob_dist` argument is specified then the function may error
#' or return an unparameterised `<epidist>` if the parameterisation becomes
#' incompatible.
#'
#' Valid probability distributions are: `"gamma"`, `"lnorm"`, `"weibull"`,
#' `"nbinom"`, `"geom"`, `"pois"`, `"norm"`, `"exp"`.
#'
#' @inheritParams base::print
#' @param ... [dots] Extra arguments to be passed to the method.
#'
#' @inherit epidist_db return
#' @export
as_epidist <- function(x, ...) {
  UseMethod("as_epidist")
}

#' Convert `<data.frame>` to an `<epidist>` object
#'
#' Convert the tabular information in `<data.frame>` to an `<epidist>`. If the
#' information in the `<data.frame>` cannot be converted into an `<epidist>` the
#' function will error.
#'
#' @param x A `<data.frame>`.
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @inherit epidist_db return
#' @export
#'
#' @examples
#' # stub
as_epidist.data.frame <- function(x, ...) {
  if (is_epidist_df(x)) {
    epidist <- epidist_df_to_epidist(x, ...)
  } else if (is_epireview(x)) {
    epidist <- epireview_to_epidist(x, ...)
  } else {
    stop(
      "<data.frame> input into as_epidist() cannot be converted to <epidist>",
      call. = FALSE
    )
  }
  # return <epidist>
  epidist
}

#' Check if `<data.frame>` input is from [as.data.frame.epidist()]
#'
#' @param x A `<data.frame>`.
#'
#' @return A single `logical` boolean.
#' @keywords internal
is_epidist_df <- function(x) {
  valid_colnames <- identical(
    colnames(x),
    c(
      "disease", "pathogen", "epi_distribution", "prob_distribution",
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
is_epireview <- function(x) {
  valid_colnames <- all(epiparameter::epireview_core_cols %in% colnames(x))
  # return logical
  valid_colnames
}

#' Convert `<data.frame>` from [as.data.frame.epidist()] to `<epidist>`
#'
#' @param x A `<data.frame>`.
#' @param ... [dots] Extra arguments to pass to [epidist()].
#'
#' @inherit epidist return
#' @keywords internal
epidist_df_to_epidist <- function(x, ...) {
  # extract probability distribution from list and extract parameters
  # and truncation if available
  prob_dist <- x$prob_distribution[[1]]
  if (inherits(prob_dist, "distribution")) {
    prob_distribution_params <- unlist(
      distributional::parameters(x$prob_distribution[[1]])
    )
  }
  if (identical(stats::family(prob_dist), "truncated")) {
    truncation <- distributional::parameters(x$prob_distribution)$upper
  } else {
    truncation <- NA_real_
  }
  # create uncertainty list of parameters if not provided
  if (all(unlist(lapply(x$uncertainty$uncertainty, is.na)))) {
    uncertainty <- x$uncertainty$uncertainty
  } else {
    uncertainty <- lapply(
      prob_distribution_params,
      function(x) create_epidist_uncertainty()
    )
  }

  # remove <AsIs> from citation
  class(x$citation) <- setdiff(class(x$citation), "AsIs")

  # return <epidist> from class constructor
  epidist(
    disease = x$disease,
    pathogen = x$pathogen,
    epi_dist = x$epi_distribution,
    prob_distribution = family(x$prob_distribution[[1]]),
    prob_distribution_params = prob_distribution_params,
    uncertainty = uncertainty,
    summary_stats = x$summary_stats$summary_stats,
    citation = x$citation,
    metadata = x$metadata,
    method_assess = x$method_assess,
    discretise = inherits(x$prob_distribution[[1]], "distcrete"),
    truncation = truncation,
    notes = x$notes
  )
}

#' Convert `<data.frame>` from \pkg{epireview} to `<epidist>`
#'
#' @param x A `<data.frame>`.
#' @param ... [dots] Extra arguments to pass to [epidist()].
#'
#' @inherit epidist return
#' @keywords internal
#' @noRd
epireview_to_epidist <- function(x, ...) { # nolint cyclocomp_linter
  # capture dots and extract article info if supplied
  dots <- list(...)
  article <- dots$article
  prob_dist_in <- dots$prob_dist
  # validate multi-row entries
  if (nrow(x) > 1) {
    stopifnot(
      "Multiple entries passed to as_epidist() do not have the same ID" =
        length(unique(x$id)) == 1L
    )
  }

  pathogen <- .unique(x$pathogen, var_name = "pathogen")
  # get disease from pathogen lookup
  disease <- switch(
    pathogen,
    "Marburg virus" = "Marburg Virus Disease",
    "Lassa mammarenavirus" = "Lassa fever",
    "Ebola virus" = "Ebola Virus Disease",
    stop("Pathogen in epireview not recognised", call. = FALSE)
  )
  epi_dist <- .unique(x$parameter_type, var_name = "parameter types")
  prob_dist <- .unique(x$distribution_type, var_name = "distribution types")
  sd_ <- NULL
  if (rlang::is_na(prob_dist)) {
    prob_dist_params <- NA_real_
    uncertainty <- create_epidist_uncertainty()
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
        "supported in {epiparameter}.\n Cannot convert to <epidist>",
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
      function(x) create_epidist_uncertainty()
    )
    names(uncertainty) <- names(prob_dist_params)
  }
  # overwrite prob_dist with user specified if given
  if (!is.null(prob_dist_in)) {
    prob_dist <- prob_dist_in
    # erase uncertainty, new prob_dist will likely have different param names
    uncertainty <- create_epidist_uncertainty()
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
      "Parameter value will not be input into <epidist>.",
      call. = FALSE
    )
    param_type <- NULL
  }
  summary_stats <- create_epidist_summary_stats()
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
  metadata <- create_epidist_metadata()
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
    citation <- create_epidist_citation(
      author = .unique(x$first_author_surname, var_name = "citation authors"),
      year = .unique(x$year_publication, var_name = "citation years"),
      title = "<title not available>",
      journal = "<journal not available>"
    )
    warning(
      "Cannot create full citation for epidemiological parameters without ",
      "bibliographic information \n see ?as_epidist for help.",
      call. = FALSE
    )
  } else {
    if (!identical(x$id, article$id)) {
      stop(
        "ID of epidemiological parameter does not match ID of article info",
        call. = FALSE
      )
    }
    citation <- create_epidist_citation(
      author = article$first_author_surname,
      year = article$year_publication,
      title = article$article_title,
      journal = article$journal,
      doi = article$doi
    )
  }
  # <epidist> constructor and return
  epidist(
    disease = disease,
    pathogen = pathogen,
    epi_dist = epi_dist,
    prob_distribution = prob_dist,
    prob_distribution_params = prob_dist_params,
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
      "epireview parameters contains multiple different", var_name, "\n",
      "Cannot convert to <epidist>",
      call. = FALSE
    )
  }
  x
}

#' Input summary statistic uncertainty
#'
#' @param x A `<data.frame>` from \pkg{epireview}.
#' @param summary_stats A list returned from [create_epidist_summary_stats()].
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
