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
    truncation <- distributional::parameters(dist)$upper
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
  class(x$citation) <- class(x$citation)[!class(x$citation) == "AsIs"]

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
#' @details
#' To create the full citation the information from the article table from the
#' \pkg{epireview} package of the corresponding entry will need to be passed
#' to function via the `...` argument. The argument should be called `article`,
#' as it will be matched by name by `$`.
#'
#' @param x A `<data.frame>`.
#' @param article A `<data.frame>` with bibliographic information on the
#' epidemiological parameters. See Details for more information.
#' @param ... [dots] Extra arguments to pass to [epidist()].
#'
#' @inherit epidist return
#' @keywords internal
epireview_to_epidist <- function(x, ...) {
  # validate multi-row entries
  if (nrow(x) > 1) {
    stopifnot(
      "Multiple entries passed to as_epidist() do not have the same ID" =
        length(unique(x$id)) == 1L,
      "Multiple entries passed to as_epidist() do not have the same pathogen" =
        length(unique(x$pathogen)) == 1L,
      "Multiple entries passed to as_epidist() do not have the same parameter" =
        length(unique(x$parameter_type)) == 1L,
      "Parameter range is not the same across entries" =
        length(unique(x$parameter_lower_bound)) == 1L &&
        length(unique(x$parameter_upper_bound))
    )
  }

  # if multi-row entries are valid only the first row is required for
  # constructing the <epidist>
  x1 <- x[1, ]


  # capture dots and extract article info if supplied
  dots <- list(...)
  article <- dots$article

  if (is.null(article)) {
    citation <- create_epidist_citation(
      author = x1$first_author_surname,
      year = x1$year_publication,
      title = "<title not available>",
      journal = "<journal not available>"
    )
    warning(
      "Cannot create full citation for epidemiological parameters without ",
      "bibliographic information \n see ?epireview_to_epidist for help.",
      call. = FALSE
    )
  } else {
    if (!identical(x1$id, article$id)) {
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
      DOI = article$doi
    )
  }

  # range is always provided or NA
  summary_stats <- create_epidist_summary_stats(
    lower_range = x1$parameter_lower_bound,
    upper_range = x1$parameter_upper_bound
  )

  # if a summary statistic is provided check what it is and add it to the list
  if (!all(is.na(x$parameter_value))) {
    summary_stat_type <- .clean_string(x$parameter_value_type)
    # <epidist> uses sd rather than standard deviation for list names
    summary_stat_type <- gsub(
      pattern = "standard deviation",
      replacement = "sd",
      x = summary_stat_type,
      fixed = TRUE
    )
    if (!all(summary_stat_type %in% names(summary_stats))) {
      stop(
        "Summary statistic from {epireview} not compatible with <epidist>",
        call. = FALSE
      )
    }
    summary_stats[summary_stat_type] <- x$parameter_value
    # apply uncertainty in summary stats
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
      ss_uncertainty[[i]] <- sapply(summary_stat_uncertainty, "[[", i)
    }
    summary_stats[summary_stat_type_uncertainty] <- ss_uncertainty
    # get the interval
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
  }

  params <- c(x$distribution_par1_value, x$distribution_par2_value)
  param_names <- .clean_string(
    c(x$distribution_par1_type, x$distribution_par2_type)
  )
  names(params) <- param_names
  if (all(is.na(params))) {
    params <- NA_character_
  }

  if (rlang::is_na(params)) {
    uncertainty <- create_epidist_uncertainty()
  } else {
    param_uncertainty <- list(
      par1 = x$distribution_par1_uncertainty,
      par2 = x$distribution_par2_uncertainty
    )
    if (all(!is.na(params))) {
      names(param_uncertainty) <- param_names
    }
    uncertainty <- lapply(
      param_uncertainty,
      function(x) if (!x) create_epidist_uncertainty() else x
    )
  }

  # epireview database does not have disease name
  # use lookup from epiparameter db to find disease from pathogen
  epiparameter_db_pathogen <- vapply(
    multi_epidist,
    "[[",
    FUN.VALUE = character(1),
    "pathogen"
  )
  pathogen_idx <- grep(
    pattern = x1$pathogen,
    x = epiparameter_db_pathogen,
    ignore.case = TRUE
  )
  epiparameter_db_disease <- vapply(
    multi_epidist,
    "[[",
    FUN.VALUE = character(1),
    "disease"
  )
  disease <- epiparameter_db_disease[pathogen_idx]
  if (length(unique(disease)) > 1) {
    stop("Disease lookup returned different names", call. = FALSE)
  }

  # clean parameter type name by removing the parameter class
  epi_dist <- gsub(
    pattern = paste0(x1$parameter_class, " \\- "),
    replacement = "",
    x = x1$parameter_type
  )

  region <- as.vector(
    na.omit(c(x1$population_location, x1$population_country)),
    mode = "character"
  )
  region <- ifelse(test = length(region) == 0, yes = NA, no = region)

  epidist(
    disease = disease[1],
    pathogen = x1$pathogen,
    epi_dist = epi_dist,
    prob_distribution = .clean_string(x1$distribution_type),
    prob_distribution_params = params,
    uncertainty = uncertainty,
    summary_stats = summary_stats,
    citation = citation,
    metadata = create_epidist_metadata(
      sample_size = x1$population_sample_size,
      region = region
    )
  )
}
