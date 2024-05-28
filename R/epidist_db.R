#' Create `<epidist>` object(s) directly from the epiparameter library
#' (database)
#'
#' @description Extract `<epidist>` object(s) directly from
#' the library of epidemiological parameters. The epiparameter
#' library of epidemiological parameters is compiled from primary literature
#' sources. The list output from [epidist_db()] can be subset by the data it
#' contains, for example by: disease, pathogen, epidemiological distribution,
#' sample size, region, etc.
#'
#' If a distribution from a specific study is required, the `author` argument
#' can be specified.
#'
#' Multiple entries (`<epidist>` objects) can be returned, use the arguments
#' to subset entries and use `single_epidist = TRUE` to force a single
#' `<epidist>` to be returned.
#'
#' @details `disease`, `epi_dist` and `author` are given as individual arguments
#' as these are the most common variables to subset the parameter library by.
#' The `subset` argument facilitates all other subsetting of rows to select the
#' `<epidist>` object(s) desired. To subset based on multiple variables separate
#' each expression with `&`.
#'
#' List of epidemiological distributions:
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
#' @param epi_dist A `character` string specifying the epidemiological
#' distribution. See details for full list of epidemiological distributions.
#' @param author A `character` string specifying the author of the study
#' reporting the distribution. Only the first author will be matched. It is
#' recommended to use the family name as first names may or may not be
#' initialised.
#' @param subset Either `NULL` or a valid R expressions that evaluates to
#' logicals to subset the list of `<epidist>`, or a function that can be
#' applied over a list of `<epidist>` objects.
#'
#' Subsetting (using `subset`) can be combined with the subsetting done with
#' the `disease` and `epidist` arguments (and `author` if specified). If left
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
#' @param single_epidist A boolean `logical` determining whether a single
#' `<epidist>` or multiple entries from the library can be returned if
#' matched by the other arguments (`disease`, `epi_dist`, `author`). This
#' argument is used to prevent multiple sets of parameters being returned
#' when only one is wanted.
#'
#' **Note**: If multiple entries match the arguments supplied and
#' `single_epidist = TRUE` then the `<epidist>` that is parameterised
#' (and accounts for truncation if available) and has the largest sample size
#' will be returned (see [is_parameterised()]). If multiple entries are equal
#' after this sorting the first entry will be returned.
#'
#' @return An `<epidist>` object or list of `<epidist>` objects.
#' @export
#'
#' @examples
#' epidist_db(disease = "influenza", epi_dist = "serial_interval")
#'
#' # example using custom subsetting
#' eparam <- epidist_db(
#'   disease = "SARS",
#'   epi_dist = "offspring_distribution",
#'   subset = sample_size > 40
#' )
#'
#' # example using functional subsetting
#' eparam <- epidist_db(
#'   disease = "COVID-19",
#'   epi_dist = "incubation_period",
#'   subset = is_parameterised
#' )
#'
#' # example forcing a single <epidist> to be returned
#' eparam <- epidist_db(
#'   disease = "SARS",
#'   epi_dist = "offspring_distribution",
#'   single_epidist = TRUE
#' )
epidist_db <- function(disease = "all",
                       pathogen = "all",
                       epi_dist = "all",
                       author = NULL,
                       subset = NULL,
                       single_epidist = FALSE) {
  # check input
  checkmate::assert_string(disease)
  checkmate::assert_string(pathogen)
  checkmate::assert_string(epi_dist)
  checkmate::assert_logical(single_epidist, len = 1)

  # capture expression from subset and check type
  expr <- substitute(subset)
  if (is.character(expr)) {
    stop(
      "Subsetting is done with expressions that return logical values.\n",
      "Remove quotation marks.",
      call. = FALSE
    )
  }

  # <multi_epidist> is sysdata
  attrib <- attributes(multi_epidist)

  multi_epidist <- .filter_epidist_db(
    multi_epidist = multi_epidist,
    disease = disease,
    pathogen = pathogen,
    epi_dist = epi_dist
  )

  # extract study by author if given
  if (!is.null(author)) {
    first_author <- lapply(multi_epidist, function(x) {
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
    multi_epidist <- multi_epidist[author_set]
  }

  # subset by subset conditions
  if (is.call(expr)) {
    nse_subject <- as.character(expr)[2]
    cond_list <- lapply(multi_epidist, .is_cond_epidist, expr, nse_subject)
    set <- vapply(cond_list, function(x) any(unlist(x)), FUN.VALUE = logical(1))
    set[is.na(set)] <- FALSE
    multi_epidist <- multi_epidist[set]
  } else if (is.function(subset)) {
    set <- vapply(multi_epidist, subset, FUN.VALUE = logical(1))
    multi_epidist <- multi_epidist[set]
  }

  attributes(multi_epidist) <- attrib

  if (length(multi_epidist) == 0) {
    stop(
      "No entries in the database meet the search criteria.",
      call. = FALSE
    )
  }

  lapply(multi_epidist, validate_epidist)
  is_param <- vapply(multi_epidist, is_parameterised, FUN.VALUE = logical(1))

  if (single_epidist) {
    # select parameterised entries
    if (sum(is_param) >= 1) {
      multi_epidist <- multi_epidist[is_param]
    }
    # select entries that accounted for truncation
    idx <- vapply(
      multi_epidist,
      function(x) x$method_assess$right_truncated,
      FUN.VALUE = logical(1)
    )
    if (sum(idx) >= 1) {
      multi_epidist <- multi_epidist[idx]
    }
    # select largest sample size
    idx <- which.max(
      vapply(
        multi_epidist,
        function(x) x$metadata$sample_size,
        FUN.VALUE = numeric(1)
      )
    )
    single_epidist <- multi_epidist[[idx]]

    message(
      "Using ", format(get_citation(single_epidist)), ". \n",
      "To retrieve the citation use the 'get_citation' function"
    )

    return(single_epidist)
  }

  message(
    "Returning ", length(multi_epidist), " results that match the criteria ",
    "(", sum(is_param), " are parameterised). \n",
    "Use subset to filter by entry variables or ",
    "single_epidist to return a single entry. \n",
    "To retrieve the citation for each use the ",
    "'get_citation' function"
  )

  if (length(multi_epidist) == 1) {
    multi_epidist <- multi_epidist[[1]]
  }

  # return epidist
  multi_epidist
}

#' Reads in parameter library and formats data to <epidist>
#'
#' @inheritParams epidist_db
#'
#' @return `<multi_epidist>` object (i.e. a list of `<epidist>` with nicer
#' printing)
#' @keywords internal
#' @noRd
.read_epidist_db <- function() {

  if (!.is_pkg_installed("jsonlite")) {
    stop(
      "Cannot use this internal function without {jsonlite} installed",
      call. = FALSE
    )
  }

  params_json <- jsonlite::read_json(
    path = system.file(
      "extdata",
      "parameters.json",
      package = "epiparameter",
      mustWork = TRUE
    )
  )

  # suppress individual <epidist> constructor messages
  multi_epidist <- suppressMessages(lapply(params_json, .format_epidist))

  # create and return <multi_epidist> class
  structure(
    multi_epidist,
    class = "multi_epidist"
  )
}

#' Filter a list of `<epidist>` objects by disease and epi distribution
#'
#' @param multi_epidist A list of `<epidist>` objects.
#' @inheritParams epidist_db
#'
#' @return A list of `<epidist>` objects.
#' @keywords internal
#' @noRd
.filter_epidist_db <- function(multi_epidist, disease, pathogen, epi_dist) {
  # copy of user input
  disease_ <- disease
  pathogen_ <- pathogen
  epi_dist_ <- epi_dist

  # clean input strings
  disease <- .clean_string(disease)
  pathogen <- .clean_string(pathogen)
  epi_dist <- .clean_string(epi_dist)

  # get valid options from db
  disease_db <- vapply(
    multi_epidist, function(x) x$disease,
    FUN.VALUE = character(1)
  )
  pathogen_db <- vapply(
    multi_epidist, function(x) x$pathogen,
    FUN.VALUE = character(1)
  )
  epi_dist_db <- vapply(
    multi_epidist, function(x) x$epi_dist,
    FUN.VALUE = character(1)
  )
  disease_db <- c("all", .clean_string(unique(disease_db)))
  pathogen_db <- c("all", .clean_string(unique(pathogen_db)))
  epi_dist_db <- c("all", .clean_string(unique(epi_dist_db)))

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
      epi_dist <- match.arg(
        arg = epi_dist,
        choices = epi_dist_db,
        several.ok = FALSE
      )
    },
    error = function(cnd) {
      disease_str <- ifelse(
        test = disease == "all", yes = "", no = paste(" for", disease_)
      )
      pathogen_str <- ifelse(
        test = pathogen == "all", yes = "", no = paste(" for", pathogen_)
      )
      epi_dist_str <- ifelse(test = epi_dist == "all", yes = "", no = epi_dist_)
      stop(
        epi_dist_str, " distribution not available", disease_str, pathogen_str,
        call. = FALSE
      )
    }
  )

  # filter based on disease
  if (disease != "all") {
    multi_epidist <- Filter(
      f = function(x) .clean_string(x$disease) == disease,
      x = multi_epidist
    )
  }

  # filter based on pathogen
  if (pathogen != "all") {
    multi_epidist <- Filter(
      f = function(x) .clean_string(x$pathogen) == pathogen,
      x = multi_epidist
    )
  }

  # filter by epi dist
  if (epi_dist != "all") {
    multi_epidist <- Filter(
      f = function(x) .clean_string(x$epi_dist) == epi_dist,
      x = multi_epidist
    )
  }

  # return multi_epidist
  multi_epidist
}

#' Format data from JSON database into `<epidist>` objects
#'
#' @param x A single entry (element/object) from the database.
#'
#' @return An `<epidist>` object.
#' @keywords internal
#' @noRd
.format_epidist <- function(x) {
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
    create_epidist_citation(
      author = cit$author,
      year = cit$year,
      title = cit$title,
      journal = cit$journal,
      doi = cit$doi,
      pmid = cit$pmid
    )
  )

  # format metadata
  meta <- create_epidist_metadata()
  meta[names(x$metadata)] <- x$metadata

  # format method assessment
  method <- create_epidist_method_assess()
  truncation <- ifelse(
    is.null(x$method_assessment$truncation),
    yes = NA_real_,
    no = x$method_assessment$truncation
  )
  discretised <- x$method_assessment$discretised
  x$method_assessment[c("truncation", "discretised")] <- NULL
  method[names(x$method_assessment)] <- x$method_assessment

  # return <epidist>
  epidist(
    disease = x$disease,
    pathogen = x$pathogen,
    epi_dist = x$epi_distribution,
    prob_distribution = x$probability_distribution$prob_distribution,
    prob_distribution_params = params,
    uncertainty = uncertainty,
    summary_stats = ss,
    auto_calc_params = TRUE,
    citation = cit,
    metadata = meta,
    method_assess = method,
    discretise = discretised,
    truncation = truncation,
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
        uncertainty = create_epidist_uncertainty()
      )
    )
  }

  # return params without uncertainty
  if (!any(grepl(pattern = "ci", x = names(params), fixed = TRUE))) {
    uncertainty <- lapply(
      vector(mode = "list", length = length(params)),
      function(x) x <- create_epidist_uncertainty()
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
    function(x) x <- create_epidist_uncertainty()
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

#' Check `<epidist>` based on condition
#'
#' @return list of logical booleans.
#' @keywords internal
#' @noRd
.is_cond_epidist <- function(lst, condition, nse_subject) {
  # check input
  stopifnot(is_epidist(lst))
  if (nse_subject == "prob_dist") {
    # special case to subset by dist as name is extracted first
    if (is.object(lst$prob_dist) || is.character(lst$prob_dist)) {
      prob_dist <- family(lst) # nolint prob_dist used in eval
      eval(expr = condition)
    } else {
      FALSE
    }
  } else {
    # apply condition to <epidist> name matching elements
    lapply(lst, function(x) {
      if (nse_subject %in% names(x)) {
        # <epidist> is only nested once so no need for recursive search
        eval(expr = condition, envir = x)
      } else {
        FALSE
      }
    })
  }
}

#' Print method for `<multi_epidist>` class
#'
#' @param x A `<multi_epidist>` object.
#' @inheritParams print.epidist
#'
#' @return Invisibly returns a `<multi_epidist>`. Called for side-effects.
#' @export
print.multi_epidist <- function(x, ...) {
  if (length(x) <= 5) {
    x <- unclass(x)
    NextMethod()
  } else {
    chkDots(...)
    writeLines(
      c(
        sprintf("List of <epidist> objects"),
        sprintf("  Number of entries in library: %s", length(x)),
        sprintf(
          "  Number of studies in library: %s",
          length(unique(
            vapply(
              x, function(y) y$citation$doi,
              FUN.VALUE = character(1)
            )
          ))
        ),
        sprintf(
          "  Number of diseases: %s",
          length(unique(
            vapply(x, function(y) y$disease, FUN.VALUE = character(1))
          ))
        ),
        sprintf(
          "  Number of delay distributions: %s",
          sum(
            vapply(
              x, function(y) y$epi_dist != "offspring distribution",
              FUN.VALUE = logical(1)
            )
          )
        ),
        sprintf(
          "  Number of offspring distributions: %s",
          sum(
            vapply(
              x, function(y) y$epi_dist == "offspring distribution",
              FUN.VALUE = logical(1)
            )
          )
        )
      )
    )
    invisible(x)
  }
}

#' Check whether a package is installed
#'
#' @details This functions allows mock testing for when a package is not
#' installed on a users system (i.e. not a dependency of {epiparameter}).
#'
#' @inheritParams base::requireNamespace
#'
#' @return Invisibly returns a boolean `logical`.
#' @noRd
#' @keywords internal
.is_pkg_installed <- function(package) {
  requireNamespace(package, quietly = TRUE)
}
