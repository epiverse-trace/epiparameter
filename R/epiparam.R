#' epiparam constructor
#'
#' @description The constructor reads the data stored internally in the package
#' and subsets by epidemiological distribution (epi_dist)
#'
#' @return epiparam object
#' @keywords internal
#'
#' @examples
#' eparam <- epiparameter:::new_epiparam("all")
new_epiparam <- function(epi_dist = character()) {

  # check input
  checkmate::assert_string(epi_dist)

  # Extract relevant values
  params <- utils::read.csv(system.file(
    "extdata",
    "parameters.csv",
    package = "epiparameter",
    mustWork = TRUE
  ))

  # convert intervals from strings to numeric vectors
  ci_cols_index <- grep(pattern = "_ci_limits$", colnames(params))
  for (i in ci_cols_index) {
    split_ci <- strsplit(as.character(params[, i]), split = ",", fixed = TRUE)
    split_ci <- lapply(split_ci, function(x) {
      if (all(is.na(x))) c(NA_real_, NA_real_) else as.numeric(x)
    })
    params[[i]] <- split_ci
  }

  # convert NAs to correct type
  na_col_index <- which(
    vapply(params, function(x) all(is.na(x)), FUN.VALUE = logical(1))
  )
  params[, na_col_index] <- NA_real_

  # order params by pathogen, delay dist and study
  params <- params[order(
    tolower(params$disease),
    tolower(params$epi_distribution),
    tolower(params$author),
    method = "radix"
  ), ]

  if (epi_dist != "all") {
    # filter by delay distribution
    params <- params[params$epi_distribution == epi_dist, ]
  }

  # reset indexing of rows
  rownames(params) <- NULL

  structure(params, class = c("epiparam", "data.frame"))

}

#' Create an `epiparam` object
#'
#' @description The `epiparam` class holds information on epidemiological
#' distribution and their estimated parameters as well as other information and
#' metadata. This library of epidemiological parameters is compiled from
#' primary literature sources. An `epiparam` object can be used to compare the
#' availability of distribution for a certain disease or pathogen, or refine
#' by, for example, region or sample size. Additionally, the `epiparam` class
#' can be subset and converted into `epidist` or `vb_epidist` objects to the be
#' used in epidemiological analysis in which a delay distribution or offspring
#' distribution is required.
#'
#' The `epiparam()` function reads the library of epidemiological parameters
#' from `{epiparameter}` into memory and stores it as an `epiparam` object.
#'
#' @details The `epiparam` object has certain protected fields, and thus if
#' one of these protected fields is removed when subsetting columns an error
#' will be returned. The subsetting checks are carried out by
#' [`validate_epiparam()`].
#'
#' `epiparam` objects can be added to by using [`bind_epiparam()`] to add either
#' `epidist`s, `vb_epdist`s, `epiparam`s, lists of `epdist` objects, or data
#' frames with the correct columns to an existing `epiparam` object.
#'
#' @param epi_dist A character string of which epidemiological distributions
#' to select
#'
#' @return `epiparam` object
#' @export
#'
#' @examples
#' # the object can be made without arguments
#' eparam <- epiparam()
#'
#' # specifying incubation periods
#' incub_eparam <- epiparam("incubation")
#'
#' # subset by disease
#' influenza_dists <- eparam[eparam$disease == "influenza", ]
epiparam <- function(epi_dist = c("all",
                                  "incubation_period",
                                  "onset_to_admission",
                                  "onset_to_death",
                                  "serial_interval",
                                  "generation_time",
                                  "offspring_distribution")) {

  # check input
  epi_dist <- match.arg(arg = epi_dist, several.ok = FALSE)

  # create epiparam object
  epiparam <- new_epiparam(epi_dist = epi_dist)

  # validate epiparam object
  validate_epiparam(epiparam)

  # return epiparam object
  epiparam
}

#' `epiparam` class validator
#'
#' @param epiparam An `epiparam` object
#'
#' @return Nothing, errors when invalid `epiparam` object is provided
validate_epiparam <- function(epiparam) {

  if (!is_epiparam(epiparam)) {
    stop("Object should be of class epiparam")
  }

  # check for class invariants
  stopifnot(
    "epiparam object does not contain the correct columns" =
      c("disease", "epi_distribution", "author", "year", "vector_borne",
        "extrinsic", "prob_distribution", "discretised", "censored",
        "right_truncated", "phase_bias_adjusted", "DOI") %in%
      colnames(epiparam),
    "disease needs to be a character" =
      is.character(epiparam$disease),
    "epi_distribution needs to be a character" =
      is.character(epiparam$epi_distribution),
    "author must be a string" =
      is.character(epiparam$author),
    "year must be a numeric" =
      is.numeric(epiparam$year),
    "vector_borne must be a logical" =
      is.logical(epiparam$vector_borne),
    "extrinsic must be a logical" =
      is.logical(epiparam$extrinsic),
    "prob_distribution needs to be a character" =
      is.character(epiparam$prob_distribution),
    "discretised needs to be a logical" =
      is.logical(epiparam$discretised),
    "censored needs to be a logical" =
      is.logical(epiparam$censored),
    "right_truncated needs to be a logical" =
      is.logical(epiparam$right_truncated),
    "phase_biase_adjusted needs to be a logical" =
      is.logical(epiparam$phase_bias_adjusted),
    "DOI needs to be a character" =
      is.character(epiparam$DOI)
  )

  invisible(epiparam)
}

#' Print method for epiparam class
#'
#' @param x epiparam object
#' @param ... further arguments passed to or from other methods
#'
#' @return Nothing (prints output)
#' @export
#'
#' @examples
#' epiparam <- epiparam()
#' epiparam
print.epiparam <- function(x, ...) {
  format(x, ...)
}

#' Format method for epiparam class
#'
#' @param x epiparam object
#' @param ... further arguments passed to or from other methods
#'
#' @return Nothing (prints output)
#' @export
#'
#' @examples
#' x <- epiparam()
#' format(x)
format.epiparam <- function(x, ...) {
  validate_epiparam(x)
  summ <- summary(x)
  writeLines(
    c(
      sprintf("Epiparam object"),
      sprintf("Number of distributions in library: %s", summ$num_entries),
      sprintf("Number of diseases: %s", summ$num_diseases),
      sprintf("Number of delay distributions: %s", summ$num_delay_dist),
      sprintf("Number of offspring distributions: %s", summ$num_offspring_dist),
      sprintf("Number of studies in library: %s", summ$num_studies),
      sprintf("<Head of library>")
    )
  )
  print(head(x)[c("disease", "epi_distribution", "prob_distribution")])
  remaining_rows <- max(0, nrow(x) - 6)
  remaining_cols <- max(0, ncol(x) - 3)
  writeLines(
    sprintf(
      "<%s more rows & %s more cols not shown>",
      remaining_rows,
      remaining_cols
    )
  )
  invisible(x)
}

#' Checks whether the object is an `epiparam`
#'
#' @param x An R object
#'
#' @return A boolean logical, `TRUE` if the object is an `epiparam` and `FALSE`
#' if not
#' @export
#'
#' @examples
#' eparam <- epiparam()
#'
#' is_epiparam(eparam)
is_epiparam <- function(x) {
  inherits(x, "epiparam")
}

#' Summary method for epiparam class
#'
#' @param object epiparam object
#' @param ... further arguments passed to or from other methods
#'
#' @return data frame of information
#' @export
#'
#' @examples
#' x <- epiparam()
#' summary(x)
summary.epiparam <- function(object, ...) {
  num_entries <- nrow(object)
  num_diseases <- length(unique(object$disease))
  num_delay_dist <- sum(
    object$epi_distribution %in% c(
      "incubation_period", "generation_time",
      "serial_interval", "onset_to_death")
  )
  num_offspring_dist <- sum(
    object$epi_distribution %in% "offspring_distribution"
  )
  num_studies <- length(unique(object$DOI))
  num_cont_dist <- nrow(object) - sum(object$discretised)
  num_disc_dist <- sum(object$discetised)
  num_vector_borne <- sum(object$extrinsic)
  # return epiparam summary
  list(num_entries = num_entries,
       num_diseases = num_diseases,
       num_delay_dist = num_delay_dist,
       num_offspring_dist = num_offspring_dist,
       num_studies = num_studies,
       num_continuous_distributions = num_cont_dist,
       num_discrete_distributions = num_disc_dist,
       num_vector_borne_diseases = num_vector_borne
  )
}

#' head method for epiparam class
#'
#' @param x epiparam object
#'
#' @return Data frame
#' @export
#'
#' @examples
#' head(epiparam())

#' @export
head.epiparam <- function(x) {
 utils::head(as.data.frame(x))
}

#' tail method for epiparam class
#'
#' @param x epiparam object
#'
#' @return Data frame
#' @export
#'
#' @examples
#' tail(epiparam())
tail <- function(x) UseMethod("tail")

#' @export
tail.epiparam <- function(x) {
  utils::tail(as.data.frame(x))
}
