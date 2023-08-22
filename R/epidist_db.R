#' Create an `epidist` object(s) directly from the epiparameter library
#' (database)
#'
#' @description This function can extract an `epidist` object(s) directly from
#' the library of epidemiological parameters without having to read in an
#' `epiparam` object and pull out an `epidist` object from one of the entries.
#' If a distribution from a specific study is required, the `author` argument
#' can be specified. For now this must match the author entry in the database
#' exactly to be recognised.
#'
#' @details `disease`, `epi_dist` and `author` are given as individual arguments
#' as these are the most common variables to subset the parameter library by.
#' The `subset` argument facilitates all other subsetting of rows to select the
#' `<epidist>` object(s) desired. To subset based on multiple variables separate
#' each expression with `&`.
#'
#' @param disease A character string specifying the disease
#' @param epi_dist A character string specifying the epidemiological
#' distribution
#' @param author The author of the study reporting the distribution
#' @param subset Either `NULL` or a valid R expressions that evaluates to
#' logicals to subset the rows of `<epiparam>`.
#'
#' This argument allows general `<data.frame>` subsetting that can be combined
#' with the subsetting done with the `disease` and `epidist` arguments
#' (and `author` if specified). If left as `NULL` (default) no subsetting is
#' carried out.
#'
#' With and without subsetting multiple entries (`<epdist>` objects) can be
#' returned (but see `single_epidist` argument).
#'
#' The expression can be specified without using the data object name
#' (e.g. `df$var`) and instead just `var` can be supplied (see details). In
#' other words, this argument works the same as the `subset` argument in
#' [`subset()`]. It is similar to `<data-masking>` using by the `dplyr` package.
#' @param single_epidist A boolean logical determining whether multiple entries
#' from the library can be returned if matched by the other arguments
#' (`disease`, `epi_dist`, `author`). This argument is used to prevent
#' multiple sets of parameters being returned when only one is wanted.
#'
#' **Warning**: If multiple entries match the arguments supplied and
#' `single_epidist = TRUE` then the first entry will be naively returned. To
#' specifically subset based on a variable use the `subset` argument.
#'
#' @return An `epidist` object or list of `epidist` objects.
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
#' # example forcing a single <epidist> to be returned
#' eparam <- epidist_db(
#'   disease = "SARS",
#'   epi_dist = "offspring_distribution",
#'   single_epidist = TRUE
#' )
epidist_db <- function(disease,
                       epi_dist = c("incubation_period",
                                    "onset_to_hospitalisation",
                                    "onset_to_death",
                                    "serial_interval",
                                    "generation_time",
                                    "offspring_distribution"),
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
      "Remove quotation marks.", call. = FALSE
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
    study <- match.arg(
      arg = author,
      choices = unique(eparam$author),
      several.ok = FALSE
    )
    eparam <- eparam[eparam$author == study, ]
  }

  # subset by subset conditions
  if (is.call(expr)) {
    set <- eval(expr = expr, envir = eparam, enclos = parent.frame())
    eparam <- eparam[set, ]
  }

  if (single_epidist) {
    eparam <- eparam[1, ]
  } else if (nrow(eparam) > 1) {
    message(
      "Returning multiple studies that match the criteria.\n",
      "Use subset to filter by entry variables or ",
      "single_epidist to return a single entry."
    )
  }

  # convert epiparam to epidist
  if (nrow(eparam) > 1) {
    edist <- suppressMessages(as_epidist(x = eparam))
    unparam <- length(edist) - sum(vapply(
      edist,
      is_parameterised,
      FUN.VALUE = logical(1)
    ))
    message(
      "Returning ", nrow(eparam), " results. \n",
      unparam, " are unparameterised <epidist> objects. \n",
      "To retrieve the short citation for each use the 'get_citation' function"
    )
  } else {
    edist <- as_epidist(x = eparam)
  }


  # return epidist
  edist
}
