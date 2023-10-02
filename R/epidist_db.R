#' Create an `<epidist>` object(s) directly from the epiparameter library
#' (database)
#'
#' @description Extract an `<epidist>` object(s) directly from
#' the library of epidemiological parameters. This bypasses the need to
#' read in an `<epiparam>` object and convert to an `<epidist>` object.
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
#' @param disease A `character` string specifying the disease.
#' @param epi_dist A `character` string specifying the epidemiological
#' distribution.
#' @param author A `character` string specifying the author of the study
#' reporting the distribution. Only the first author will be matched. It is
#' recommended to use the family name as first names may or may not be
#' initialised.
#' @param subset Either `NULL` or a valid R expressions that evaluates to
#' logicals to subset the rows of `<epiparam>`, or a function that can be
#' applied directly to an `<epiparam>` object.
#'
#' This argument allows general `<data.frame>` subsetting that can be combined
#' with the subsetting done with the `disease` and `epidist` arguments
#' (and `author` if specified). If left as `NULL` (default) no subsetting is
#' carried out.
#'
#' The expression should be specified without using the data object name
#' (e.g. `df$var`) and instead just `var` should be supplied. In
#' other words, this argument works the same as the `subset` argument in
#' [subset()]. It is similar to `<data-masking>` using by the `dplyr` package.
#'
#' @param single_epidist A boolean `logical` determining whether a single
#' `<epidist>` or multiple entries from the library can be returned if
#' matched by the other arguments (`disease`, `epi_dist`, `author`). This
#' argument is used to prevent multiple sets of parameters being returned
#' when only one is wanted.
#'
#' **Note**: If multiple entries match the arguments supplied and
#' `single_epidist = TRUE` then the `<epidist>` that is parameterised and
#' has the largest sample size will be returned (see [is_parameterised()]).
#' If multiple entries are equal after this sorting the first entry will
#' be returned.
#'
#' @return An `<epidist>` object or list of `<epidist>` objects.
#' @export
#'
#' @examples
#' epidist_db(disease = "influenza", epi_dist = "serial_interval")
#'
#' # comparison between using `epidist_db()` and `epiparam()` with
#' # `as_epidist()`
#'
#' # load influenza serial interval from database
#' edist <- epidist_db(disease = "influenza", epi_dist = "serial_interval")
#'
#' # load database of serial intervals
#' eparam <- epiparam(epi_dist = "serial_interval")
#' # subset database to only influenza entries
#' eparam <- eparam[clean_disease(eparam$disease) == "influenza", ]
#' # convert to `epidist`
#' edist2 <- as_epidist(eparam)
#' # check the two methods produce the same `epidist` object
#' identical(edist, edist2)
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
epidist_db <- function(disease,
                       epi_dist = c(
                         "incubation_period",
                         "onset_to_hospitalisation",
                         "onset_to_death",
                         "serial_interval",
                         "generation_time",
                         "offspring_distribution"
                       ),
                       author = NULL,
                       subset = NULL,
                       single_epidist = FALSE) {
  # check input
  checkmate::assert_string(disease)
  epi_dist <- match.arg(arg = epi_dist, several.ok = FALSE)
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

  # read in database
  eparam <- epiparam(epi_dist = epi_dist)

  if (!any(grepl(pattern = disease, x = eparam$disease, ignore.case = TRUE))) {
    stop(epi_dist, " distribution not available for ", disease, call. = FALSE)
  }

  # match disease names against data
  disease <- match.arg(
    arg = clean_disease(disease),
    choices = clean_disease(unique(eparam$disease)),
    several.ok = FALSE
  )

  # filter based on pathogen and delay distribution
  eparam <- eparam[clean_disease(eparam$disease) == disease, ]

  # extract study by author if given
  if (!is.null(author)) {
    first_author <- lapply(eparam$author, "[[", 1)
    author_set <- grepl(pattern = author, x = first_author, ignore.case = TRUE)

    if (!any(author_set)) {
      stop(
        "Parameters by ", author, " are not available for ", disease,
        call. = FALSE
      )
    }

    # subset by authors
    eparam <- subset(eparam, author_set)
  }

  # subset by subset conditions
  if (is.call(expr)) {
    set <- eval(expr = expr, envir = eparam, enclos = parent.frame())
    eparam <- eparam[set, ]
  } else if (is.function(subset)) {
    set <- do.call(subset, args = list(eparam))
    eparam <- eparam[set, ]
  }

  if (nrow(eparam) == 0) {
    stop(
      "No entries in the database meet the subset criteria.",
      call. = FALSE
    )
  }

  # convert epiparam to epidist
  if (nrow(eparam) == 1) {
    edist <- as_epidist(x = eparam)
    validate_epidist(edist)
  } else {
    edist <- suppressMessages(as_epidist(x = eparam))
    is_param <- vapply(edist, is_parameterised, FUN.VALUE = logical(1))

    if (single_epidist) {
      # select parameterised entries
      if (sum(is_param) >= 1) {
        edist <- edist[is_param]
      }
      # select largest sample size
      idx <- which.max(
        vapply(
          edist,
          function(x) x$metadata$sample_size,
          FUN.VALUE = numeric(1)
        )
      )
      edist <- edist[[idx]]
      validate_epidist(edist)

      message(
        "Using ", format(get_citation(edist)), ". \n",
        "To retrieve the short citation use the 'get_citation' function"
      )
    } else {
      lapply(edist, validate_epidist)

      message(
        "Returning ", nrow(eparam), " results that match the criteria ",
        "(", sum(is_param), " are parameterised). \n",
        "Use subset to filter by entry variables or ",
        "single_epidist to return a single entry. \n",
        "To retrieve the short citation for each use the ",
        "'get_citation' function"
      )
    }
  }

  # return epidist
  edist
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
  cit <- lapply(x$citation, unlist)
  cit$PMID <- ifelse(is.null(cit$PMID), yes = NA_real_, no = cit$PMID)
  cit <- suppressMessages(
    create_epidist_citation(
      author = cit$author,
      year = cit$year,
      title = cit$title,
      journal = cit$journal,
      DOI = cit$DOI,
      PMID = cit$PMID
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
        params = NA,
        uncertainty = create_epidist_uncertainty()
      )
    )
  }

  # return params without uncertainty
  if (!any(grepl(pattern = "ci", x = names(params)))) {
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
    if (!any(grepl(pattern = "_ci", x = nms))) {
      params_ci <- list(params[[i]], c(NA_real_, NA_real_), NA_real_)
      names(params_ci) <- c(nm, paste0(nm, "_ci_limits"), paste0(nm, "_ci"))
      params_ <- append(params_, params_ci)
    } else {
      params_ <- append(params_, params[i])
    }
  }
  params <- params_

  # params and uncertainty
  ci_limits <- params[grepl(pattern = "ci_limits$", x = names(params))]
  ci <- params[grepl(pattern = "ci$", x = names(params))]
  ci_type <- switch(x$metadata$inference_method,
                    "mle" = "confidence_interval",
                    "bayesian" = "credible_interval",
                    NA_character_
  )

  # separate parameters and uncertainty
  ci_idx <- grepl(pattern = "_ci", x = names(params))
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
