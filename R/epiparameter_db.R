#' Create `<epiparameter>` object(s) directly from the epiparameter library
#' (database)
#'
#' @description Extract `<epiparameter>` object(s) directly from
#' the library of epidemiological parameters. The epiparameter
#' library of epidemiological parameters is compiled from primary literature
#' sources. The list output from [epiparameter_db()] can be subset by the data
#' it contains, for example by: disease, pathogen, epidemiological distribution,
#' sample size, region, etc.
#'
#' If a distribution from a specific study is required, the `author` argument
#' can be specified.
#'
#' Multiple entries (`<epiparameter>` objects) can be returned, use the
#' arguments to subset entries and use `single_epiparameter = TRUE` to force a
#' single `<epiparameter>` to be returned.
#'
#' @details `disease`, `epi_name` and `author` are given as individual arguments
#' as these are the most common variables to subset the parameter library by.
#' The `subset` argument facilitates all other subsetting of rows to select the
#' `<epiparameter>` object(s) desired. To subset based on multiple variables
#' separate each expression with `&`.
#'
#' List of epidemiological parameters:
#'
#' * "all" (default, returns all entries in library)
#' * "incubation period"
#' * "onset to hospitalisation"
#' * "onset to death"
#' * "serial interval"
#' * "generation time"
#' * "offspring distribution"
#' * "hospitalisation to death"
#' * "hospitalisation to discharge"
#' * "notification to death"
#' * "notification to discharge"
#' * "onset to discharge"
#' * "onset to ventilation"
#'
#' @param disease A `character` string specifying the disease.
#' @param pathogen A `character` string specifying the pathogen.
#' @param epi_name A `character` string specifying the epidemiological
#' parameter. See details for full list of epidemiological distributions.
#' @param author A `character` string specifying the author of the study
#' reporting the distribution. Only the first author will be matched. It is
#' recommended to use the family name as first names may or may not be
#' initialised.
#' @param subset Either `NULL` or a valid R expressions that evaluates to
#' logicals to subset the list of `<epiparameter>`, or a function that can be
#' applied over a list of `<epiparameter>` objects.
#'
#' Subsetting (using `subset`) can be combined with the subsetting done with
#' the `disease` and `epi_name` arguments (and `author` if specified). If left
#' as `NULL` (default) no subsetting is carried out.
#'
#' The `subset` argument is similar to subsetting a `<data.frame>`, but the
#' difference is that fixed comparisons and not vectorised comparisons are
#' needed. For example `sample_size > 10` is a valid subset expression, but
#' `sample_size == max(sample_size)`, which would be a valid subset expression
#' for a `<data.frame>` does not work. The vectorised expression will often
#' not error, but will likely return unexpected results. For the
#' `sample_size == max(sample_size)` example it will always return `TRUE`
#' (except for `NA`s) as it is a single numeric so will be equal to it's
#' max value.
#'
#' The expression should be specified without using the data object name
#' (e.g. `df$var`) and instead just `var` should be supplied. In
#' other words, this argument uses non-standard evaluation, just as the
#' `subset` argument in [subset()], and is similar to `<data-masking>` used
#' by the `dplyr` package.
#'
#' @param single_epiparameter A boolean `logical` determining whether a single
#' `<epiparameter>` or multiple entries from the library can be returned if
#' matched by the other arguments (`disease`, `epi_name`, `author`). This
#' argument is used to prevent multiple sets of parameters being returned
#' when only one is wanted.
#'
#' **Note**: If multiple entries match the arguments supplied and
#' `single_epiparameter = TRUE` then the `<epiparameter>` that is parameterised
#' (and accounts for truncation if available) and has the largest sample size
#' will be returned (see [is_parameterised()]). If multiple entries are equal
#' after this sorting the first entry will be returned.
#'
#' @return An `<epiparameter>` object or list of `<epiparameter>` objects.
#' @export
#'
#' @examples
#' epiparameter_db(disease = "influenza", epi_name = "serial_interval")
#'
#' # example using custom subsetting
#' eparam <- epiparameter_db(
#'   disease = "SARS",
#'   epi_name = "offspring_distribution",
#'   subset = sample_size > 40
#' )
#'
#' # example using functional subsetting
#' eparam <- epiparameter_db(
#'   disease = "COVID-19",
#'   epi_name = "incubation_period",
#'   subset = is_parameterised
#' )
#'
#' # example forcing a single <epiparameter> to be returned
#' eparam <- epiparameter_db(
#'   disease = "SARS",
#'   epi_name = "offspring_distribution",
#'   single_epiparameter = TRUE
#' )
epiparameter_db <- function(disease = "all",
                            pathogen = "all",
                            epi_name = "all",
                            author = NULL,
                            subset = NULL,
                            single_epiparameter = FALSE) {
  # check input
  checkmate::assert_string(disease)
  checkmate::assert_string(pathogen)
  checkmate::assert_string(epi_name)
  checkmate::assert_logical(single_epiparameter, len = 1)

  # capture expression from subset and check type
  expr <- substitute(subset)
  if (is.character(expr)) {
    stop(
      "Subsetting is done with expressions that return logical values.\n",
      "Remove quotation marks.",
      call. = FALSE
    )
  }

  cache_db <- cache_env$cache$get("multi_epiparameter")
  if (inherits(cache_db, "multi_epiparameter")) {
    multi_epiparameter <- cache_env$cache$get("multi_epiparameter")
  } else {
    multi_epiparameter <- .read_epiparameter_db()
  }

  attrib <- attributes(multi_epiparameter)

  multi_epiparameter <- .filter_epiparameter_db(
    multi_epiparameter = multi_epiparameter,
    disease = disease,
    pathogen = pathogen,
    epi_name = epi_name
  )

  # extract study by author if given
  if (!is.null(author)) {
    first_author <- lapply(multi_epiparameter, function(x) {
      x$citation$author[1]
    })
    author_set <- grepl(pattern = author, x = first_author, ignore.case = TRUE)

    if (!any(author_set)) {
      disease_str <- ifelse(
        test = disease == "all", yes = "", no = paste(" for", disease)
      )
      stop(
        "Parameters by ", author, " are not available", disease_str,
        call. = FALSE
      )
    }

    # subset by authors
    multi_epiparameter <- multi_epiparameter[author_set]
  }

  # subset by subset conditions
  if (is.call(expr)) {
    nse_subject <- as.character(expr)[2]
    cond_list <- lapply(
      multi_epiparameter,
      .is_cond_epiparameter,
      expr,
      nse_subject
    )
    set <- vapply(cond_list, function(x) any(unlist(x)), FUN.VALUE = logical(1))
    set[is.na(set)] <- FALSE
    multi_epiparameter <- multi_epiparameter[set]
  } else if (is.function(subset)) {
    set <- vapply(multi_epiparameter, subset, FUN.VALUE = logical(1))
    multi_epiparameter <- multi_epiparameter[set]
  }

  attributes(multi_epiparameter) <- attrib

  if (length(multi_epiparameter) == 0) {
    stop(
      "No entries in the database meet the search criteria.",
      call. = FALSE
    )
  }

  lapply(multi_epiparameter, assert_epiparameter)
  is_param <- vapply(
    multi_epiparameter,
    is_parameterised,
    FUN.VALUE = logical(1)
  )

  if (single_epiparameter) {
    # select parameterised entries
    if (sum(is_param) >= 1) {
      multi_epiparameter <- multi_epiparameter[is_param]
    }
    # select delay distribution entries that accounted for truncation
    idx <- vapply(
      multi_epiparameter,
      function(x) {
        # only delay distributions have $right_truncated
        ifelse(
          test = "right_truncated" %in% names(x$method_assess),
          yes = x$method_assess$right_truncated,
          no = FALSE
        )
      },
      FUN.VALUE = logical(1)
    )
    if (sum(idx) >= 1) {
      multi_epiparameter <- multi_epiparameter[idx]
    }
    # select largest sample size
    idx <- which.max(
      vapply(
        multi_epiparameter,
        function(x) x$metadata$sample_size,
        FUN.VALUE = numeric(1)
      )
    )
    single_epiparameter <- multi_epiparameter[[idx]]

    message(
      "Using ", format(get_citation(single_epiparameter)), ". \n",
      "To retrieve the citation use the 'get_citation' function"
    )

    return(single_epiparameter)
  }

  message(
    "Returning ", length(multi_epiparameter), " results that match the ",
    "criteria (", sum(is_param), " are parameterised). \n",
    "Use subset to filter by entry variables or ",
    "single_epiparameter to return a single entry. \n",
    "To retrieve the citation for each use the ",
    "'get_citation' function"
  )

  if (length(multi_epiparameter) == 1) {
    multi_epiparameter <- multi_epiparameter[[1]]
  }

  # return epiparameter
  multi_epiparameter
}

#' @inherit epiparameter_db title
#'
#' @description
#' `r lifecycle::badge('deprecated')`
#'
#' `epidist_db()` has been renamed [epiparameter_db()]. Please use
#' `epiparameter_db()` instead as the `epidist_db()` alias will be removed from
#' the package in the future.
#'
#' @inheritParams epiparameter_db
#'
#' @inherit epiparameter_db return
#' @export
#' @keywords internal
epidist_db <- function(disease = "all",
                       pathogen = "all",
                       epi_name = "all",
                       author = NULL,
                       subset = NULL,
                       single_epiparameter = FALSE) {
  lifecycle::deprecate_warn(
    when = "v0.3.0",
    what = "epidist_db()",
    with = "epiparameter_db()",
    details = "Function will be removed in v0.5.0."
  )

  # DUE TO NON-STANDARD EVALUATION epidist_db() CANNOT CALL epiparameter_db()
  # SO THE FUNCTION CODE NEEDS TO BE COPIED

  # check input
  checkmate::assert_string(disease)
  checkmate::assert_string(pathogen)
  checkmate::assert_string(epi_name)
  checkmate::assert_logical(single_epiparameter, len = 1)

  # capture expression from subset and check type
  expr <- substitute(subset)
  if (is.character(expr)) {
    stop(
      "Subsetting is done with expressions that return logical values.\n",
      "Remove quotation marks.",
      call. = FALSE
    )
  }

  multi_epiparameter <- .read_epiparameter_db()
  attrib <- attributes(multi_epiparameter)

  multi_epiparameter <- .filter_epiparameter_db(
    multi_epiparameter = multi_epiparameter,
    disease = disease,
    pathogen = pathogen,
    epi_name = epi_name
  )

  # extract study by author if given
  if (!is.null(author)) {
    first_author <- lapply(multi_epiparameter, function(x) {
      x$citation$author[1]
    })
    author_set <- grepl(pattern = author, x = first_author, ignore.case = TRUE)

    if (!any(author_set)) {
      disease_str <- ifelse(
        test = disease == "all", yes = "", no = paste(" for", disease)
      )
      stop(
        "Parameters by ", author, " are not available", disease_str,
        call. = FALSE
      )
    }

    # subset by authors
    multi_epiparameter <- multi_epiparameter[author_set]
  }

  # subset by subset conditions
  if (is.call(expr)) {
    nse_subject <- as.character(expr)[2]
    cond_list <- lapply(
      multi_epiparameter,
      .is_cond_epiparameter,
      expr,
      nse_subject
    )
    set <- vapply(cond_list, function(x) any(unlist(x)), FUN.VALUE = logical(1))
    set[is.na(set)] <- FALSE
    multi_epiparameter <- multi_epiparameter[set]
  } else if (is.function(subset)) {
    set <- vapply(multi_epiparameter, subset, FUN.VALUE = logical(1))
    multi_epiparameter <- multi_epiparameter[set]
  }

  attributes(multi_epiparameter) <- attrib

  if (length(multi_epiparameter) == 0) {
    stop(
      "No entries in the database meet the search criteria.",
      call. = FALSE
    )
  }

  lapply(multi_epiparameter, assert_epiparameter)
  is_param <- vapply(
    multi_epiparameter,
    is_parameterised,
    FUN.VALUE = logical(1)
  )

  if (single_epiparameter) {
    # select parameterised entries
    if (sum(is_param) >= 1) {
      multi_epiparameter <- multi_epiparameter[is_param]
    }
    # select delay distribution entries that accounted for truncation
    idx <- vapply(
      multi_epiparameter,
      function(x) {
        # only delay distributions have $right_truncated
        ifelse(
          test = "right_truncated" %in% names(x$method_assess),
          yes = x$method_assess$right_truncated,
          no = FALSE
        )
      },
      FUN.VALUE = logical(1)
    )
    if (sum(idx) >= 1) {
      multi_epiparameter <- multi_epiparameter[idx]
    }
    # select largest sample size
    idx <- which.max(
      vapply(
        multi_epiparameter,
        function(x) x$metadata$sample_size,
        FUN.VALUE = numeric(1)
      )
    )
    single_epiparameter <- multi_epiparameter[[idx]]

    message(
      "Using ", format(get_citation(single_epiparameter)), ". \n",
      "To retrieve the citation use the 'get_citation' function"
    )

    return(single_epiparameter)
  }

  message(
    "Returning ", length(multi_epiparameter), " results that match the ",
    "criteria (", sum(is_param), " are parameterised). \n",
    "Use subset to filter by entry variables or ",
    "single_epiparameter to return a single entry. \n",
    "To retrieve the citation for each use the ",
    "'get_citation' function"
  )

  if (length(multi_epiparameter) == 1) {
    multi_epiparameter <- multi_epiparameter[[1]]
  }

  # return epiparameter
  multi_epiparameter
}

#' Reads in parameter library and formats data to <epiparameter>
#'
#' @inheritParams epiparameter_db
#'
#' @return `<multi_epiparameter>` object (i.e. a list of `<epiparameter>` with
#' nicer printing)
#' @keywords internal
#' @noRd
.read_epiparameter_db <- function() {

  # suppress individual <epiparameter> constructor messages
  multi_epiparameter <- suppressMessages(
    lapply(epiparameterDB::epiparameterDB, .format_epiparameter)
  )

  # create and return <multi_epiparameter> class
  structure(
    multi_epiparameter,
    class = "multi_epiparameter"
  )
}

#' Filter a list of `<epiparameter>` objects by disease and epi distribution
#'
#' @param multi_epiparameter A list of `<epiparameter>` objects.
#' @inheritParams epiparameter_db
#'
#' @return A list of `<epiparameter>` objects.
#' @keywords internal
#' @noRd
.filter_epiparameter_db <- function(multi_epiparameter,
                                    disease,
                                    pathogen,
                                    epi_name) {
  # copy of user input
  disease_ <- disease
  pathogen_ <- pathogen
  epi_name_ <- epi_name

  # clean input strings
  disease <- .clean_string(disease)
  pathogen <- .clean_string(pathogen)
  epi_name <- .clean_string(epi_name)

  # get valid options from db
  disease_db <- vapply(
    multi_epiparameter, function(x) x$disease,
    FUN.VALUE = character(1)
  )
  pathogen_db <- vapply(
    multi_epiparameter, function(x) x$pathogen,
    FUN.VALUE = character(1)
  )
  epi_name_db <- vapply(
    multi_epiparameter, function(x) x$epi_name,
    FUN.VALUE = character(1)
  )
  disease_db <- c("all", .clean_string(unique(disease_db)))
  pathogen_db <- c("all", .clean_string(unique(pathogen_db)))
  epi_name_db <- c("all", .clean_string(unique(epi_name_db)))

  # partial matching and custom error msg
  tryCatch(
    {
      disease <- match.arg(
        arg = disease,
        choices = disease_db,
        several.ok = FALSE
      )
      pathogen <- match.arg(
        arg = pathogen,
        choices = pathogen_db,
        several.ok = FALSE
      )
      epi_name <- match.arg(
        arg = epi_name,
        choices = epi_name_db,
        several.ok = FALSE
      )
    },
    error = function(cnd) {
      disease_str <- ifelse(test = disease == "all", yes = "", no = disease_)
      pathogen_str <- ifelse(test = pathogen == "all", yes = "", no = pathogen_)
      epi_name_str <- ifelse(test = epi_name == "all", yes = "", no = epi_name_)
      if (disease_str != "" && pathogen_str != "") {
        disease_str <- paste0(disease_str, " & ")
      }
      stop(
        cli::style_bold(epi_name_str), " distribution not available for ",
        cli::style_bold(disease_str), cli::style_bold(pathogen_str),
        " in the database.\n Please check spelling of disease/pathogen and ",
        "epiparameter name.",
        call. = FALSE
      )
    }
  )

  # filter based on disease
  if (disease != "all") {
    multi_epiparameter <- Filter(
      f = function(x) .clean_string(x$disease) == disease,
      x = multi_epiparameter
    )
  }

  # filter based on pathogen
  if (pathogen != "all") {
    multi_epiparameter <- Filter(
      f = function(x) .clean_string(x$pathogen) == pathogen,
      x = multi_epiparameter
    )
  }

  # filter by epi dist
  if (epi_name != "all") {
    multi_epiparameter <- Filter(
      f = function(x) .clean_string(x$epi_name) == epi_name,
      x = multi_epiparameter
    )
  }

  # return multi_epiparameter
  multi_epiparameter
}

#' Format data from JSON database into `<epiparameter>` objects
#'
#' @param x A single entry (element/object) from the database.
#'
#' @return An `<epiparameter>` object.
#' @keywords internal
#' @noRd
.format_epiparameter <- function(x) {
  # convert nulls to NA
  null2na <- function(l) {
    if (is.list(l)) l <- lapply(l, null2na) else if (is.null(l)) l <- NA
    l
  }
  x <- lapply(x, null2na)

  # format parameters and parameter uncertainty
  params_uncertainty <- .format_params(x)
  params <- params_uncertainty$params
  uncertainty <- params_uncertainty$uncertainty

  # TODO: remove this and move precision from parameter to summary statistic
  if ("precision" %in% names(params)) {
    if (length(params) == 1) {
      params <- NA_real_
      uncertainty <- list(uncertainty = create_uncertainty())
    } else {
      params <- params[-which(names(params) == "precision")]
      uncertainty <- uncertainty[-which(names(uncertainty) == "precision")]
    }
  }

  # format summary statistics
  ss <- lapply(x$summary_statistics, unlist)
  names(ss$quantile_values) <- ss$quantile_names
  ss$quantile_names <- NULL
  names(ss)[names(ss) == "quantile_values"] <- "quantiles"

  # format citation
  cit <- x$citation
  cit$author <- lapply(
    cit$author,
    function(aut) utils::person(given = aut$given, family = aut$family)
  )
  cit$author <- Reduce(f = c, x = cit$author)
  cit$pmid <- ifelse(is.null(cit$pmid), yes = NA_real_, no = cit$pmid)
  cit <- suppressMessages(
    create_citation(
      author = cit$author,
      year = cit$year,
      title = cit$title,
      journal = cit$journal,
      doi = cit$doi,
      pmid = cit$pmid
    )
  )

  # format metadata
  meta <- create_metadata()
  meta[names(x$metadata)] <- x$metadata

  # format method assessment
  method <- create_method_assess()
  truncation <- ifelse(
    is.null(x$method_assessment$truncation),
    yes = NA_real_,
    no = x$method_assessment$truncation
  )
  discretised <- x$method_assessment$discretised
  x$method_assessment[c("truncation", "discretised")] <- NULL
  method[names(x$method_assessment)] <- x$method_assessment

  # return <epiparameter>
  epiparameter(
    disease = x$disease,
    pathogen = x$pathogen,
    epi_name = x$epi_name,
    prob_distribution = create_prob_distribution(
      prob_distribution = x$probability_distribution$prob_distribution,
      prob_distribution_params = params,
      discretise = discretised,
      truncation = truncation
    ),
    uncertainty = uncertainty,
    summary_stats = ss,
    auto_calc_params = TRUE,
    citation = cit,
    metadata = meta,
    method_assess = method,
    notes = x$notes
  )
}

#' Format parameters and their uncertainty
#'
#' @param x A single entry (element/object) from the database.
#'
#' @return A list with parameters (`$params`) and uncertainty (`$uncertainty`).
#' @keywords internal
#' @noRd
.format_params <- function(x) {
  params <- lapply(x$probability_distribution$parameters, unlist)

  # return unparameterised
  if (length(params) == 0) {
    return(
      list(
        params = NA_real_,
        uncertainty = list(uncertainty = create_uncertainty())
      )
    )
  }

  # return params without uncertainty
  if (!any(grepl(pattern = "ci", x = names(params), fixed = TRUE))) {
    uncertainty <- lapply(
      vector(mode = "list", length = length(params)),
      function(x) x <- create_uncertainty()
    )
    names(uncertainty) <- names(params)
    return(
      list(
        params = unlist(params),
        uncertainty = uncertainty
      )
    )
  }

  # add ci to params without for consistent data struct
  params_ <- vector(mode = "list")
  for (i in seq_along(params)) {
    nm <- names(params)[i]
    nms <- names(params)[grepl(pattern = nm, x = names(params))]
    if (any(grepl(pattern = "_ci", x = nms, fixed = TRUE))) {
      params_ <- append(params_, params[i])
    } else {
      params_ci <- list(params[[i]], c(NA_real_, NA_real_), NA_real_)
      names(params_ci) <- c(nm, paste0(nm, "_ci_limits"), paste0(nm, "_ci"))
      params_ <- append(params_, params_ci)
    }
  }
  params <- params_

  # params and uncertainty
  ci_limits <- params[!is.na(names(params)) &
    endsWith(names(params), suffix = "ci_limits")]
  ci <- params[!is.na(names(params)) & endsWith(names(params), suffix = "ci")]
  ci_type <- switch(x$metadata$inference_method,
    mle = "confidence_interval",
    bayesian = "credible_interval",
    NA_character_
  )

  # separate parameters and uncertainty
  ci_idx <- grepl(pattern = "_ci", x = names(params), fixed = TRUE)
  uncertainty <- params[ci_idx]
  params <- params[!ci_idx]

  # default uncertainty for each parameters
  uncertainty <- lapply(
    vector(mode = "list", length = length(params)),
    function(x) x <- create_uncertainty()
  )

  for (i in seq_along(ci_limits)) {
    uncertainty[[i]] <- list(
      ci_limits = ci_limits[[i]],
      ci = ci[[i]],
      ci_type = ci_type
    )
  }

  params <- unlist(params)
  names(uncertainty) <- names(params)

  # return params and uncertainty
  list(
    params = params,
    uncertainty = uncertainty
  )
}

#' Check `<epiparameter>` based on condition
#'
#' @return list of logical booleans.
#' @keywords internal
#' @noRd
.is_cond_epiparameter <- function(lst, condition, nse_subject) {
  # check input
  stopifnot(is_epiparameter(lst))
  if (nse_subject == "prob_dist") {
    # special case to subset by dist as name is extracted first
    if (is.object(lst$prob_distribution) ||
        is.character(lst$prob_distribution)) {
      prob_dist <- family(lst) # nolint prob_dist used in eval
      eval(expr = condition)
    } else {
      FALSE
    }
  } else {
    # apply condition to <epiparameter> name matching elements
    lapply(lst, function(x) {
      if (nse_subject %in% names(x)) {
        # <epiparameter> is only nested once so no need for recursive search
        eval(expr = condition, envir = x)
      } else {
        FALSE
      }
    })
  }
}
