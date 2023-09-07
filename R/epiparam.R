#' Constructor for `<epiparam>` class
#'
#' @description The constructor reads the data stored internally in the package
#' and subsets by epidemiological distribution (`epi_dist`).
#'
#' @inheritParams epidist
#'
#' @inherit epiparam return
#' @keywords internal
#'
#' @examples
#' eparam <- epiparameter:::new_epiparam("all")
new_epiparam <- function(epi_dist) {
  # check input
  checkmate::assert_string(epi_dist)

  # Extract relevant values
  params <- utils::read.csv(system.file(
    "extdata",
    "parameters.csv",
    package = "epiparameter",
    mustWork = TRUE
  ))

  # ensure type correctness
  numeric_col <- epiparam_col_type(epiparam = params, col_type = "numeric")
  params[numeric_col] <- vapply(
    params[numeric_col],
    FUN = as.numeric, FUN.VALUE = numeric(nrow(params))
  )
  char_col <- epiparam_col_type(params, col_type = "character")
  params[char_col] <- vapply(
    params[char_col],
    FUN = as.character, FUN.VALUE = character(nrow(params))
  )
  logic_col <- epiparam_col_type(params, col_type = "logical")
  params[logic_col] <- vapply(
    params[logic_col],
    FUN = as.logical, FUN.VALUE = logical(nrow(params))
  )

  # convert intervals from strings to numeric vectors
  ci_cols_index <- grep(pattern = "_ci_limits$", colnames(params))
  for (i in ci_cols_index) {
    split_ci <- strsplit(as.character(params[, i]), split = ",", fixed = TRUE)
    split_ci <- lapply(split_ci, function(x) {
      if (all(is.na(x))) c(NA_real_, NA_real_) else as.numeric(x)
    })
    params[[i]] <- split_ci
  }

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

#' Create an `<epiparam>` object
#'
#' @description The `<epiparam>` class holds information on epidemiological
#' distribution and their estimated parameters as well as other information and
#' metadata. This library of epidemiological parameters is compiled from
#' primary literature sources. An `<epiparam>` object can be used to compare the
#' availability of distribution for a certain disease or pathogen, or refine
#' by, for example, region or sample size. Additionally, the `<epiparam>` class
#' can be subset and converted into `<epidist>` or `<vb_epidist>` objects to
#' the be used in epidemiological analysis in which a delay distribution or
#' offspring distribution is required.
#'
#' The [epiparam()] function reads the library of epidemiological parameters
#' from `{epiparameter}` into memory and stores it as an `<epiparam>` object.
#'
#' @details The `<epiparam>` object has certain protected fields, and thus if
#' one of these protected fields is removed when subsetting columns an error
#' will be returned. The subsetting checks are carried out by
#' [validate_epiparam()].
#'
#' Data can be added to `<epiparam>` objects by using [bind_epiparam()], this
#' can add information from `<epidist>`, `<vb_epdist>`, `<epiparam>`, lists
#' of `<epdist>` objects, or data frames with the correct columns to an
#' existing `<epiparam>` object.
#'
#' @inheritParams epidist
#'
#' @return An `<epiparam>` object.
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
epiparam <- function(epi_dist = c(
                       "all",
                       "incubation_period",
                       "onset_to_hospitalisation",
                       "onset_to_death",
                       "serial_interval",
                       "generation_time",
                       "offspring_distribution"
                     )) {
  # check input
  epi_dist <- match.arg(arg = epi_dist, several.ok = FALSE)

  # create epiparam object
  epiparam <- new_epiparam(epi_dist = epi_dist)

  # validate epiparam object
  validate_epiparam(epiparam)

  # return epiparam object
  epiparam
}

#' Validator for `<epiparam>` class
#'
#' @param epiparam An `<epiparam>` object.
#' @param reconstruct A boolean `logical` determining whether the validation
#' should be class specific. When `TRUE` the input object must be of type
#' `<epiparam>` (default), when `FALSE` the input object can be of another
#' class, e.g. data frame. This argument is used in reconstruction operations
#' see [`epiparam_reconstruct()`].
#'
#' @return Invisibly returns an `<epiparam>`. Called for side-effects
#' (errors when invalid `<epiparam>` object is provided).
validate_epiparam <- function(epiparam, reconstruct = FALSE) {
  if (!is_epiparam(epiparam) && isFALSE(reconstruct)) {
    stop("Object should be of class epiparam", call. = FALSE)
  }

  col_type <- vapply(epiparam, class, FUN.VALUE = character(1))
  # check for class invariants
  stopifnot(
    "epiparam object does not contain the correct columns" =
      epiparam_fields() %in% colnames(epiparam),
    "incorrect data type in character fields" =
      all(
        "character" ==
          col_type[epiparam_col_type(epiparam, col_type = "character")]
      ),
    "incorrect data type in numeric fields" =
      all(
        col_type[epiparam_col_type(epiparam, col_type = "numeric")] %in%
          c("numeric", "integer")
      ),
    "incorrect data type in boolean logical fields" =
      all(
        "logical" == col_type[epiparam_col_type(epiparam, col_type = "logical")]
      ),
    "year needs to be greater than 0" =
      all(epiparam$year > 0 | is.na(epiparam$year))
  )

  check_limits <- apply(epiparam,
    MARGIN = 2, FUN = function(x) { # nolint
      vapply(x, function(y) {
        length(y) == 2 && is.numeric(y)
      }, FUN.VALUE = logical(1))
    },
    simplify = FALSE
  )

  check_limits <- all(unlist(
    check_limits[grep(pattern = "_limits$", x = names(check_limits))]
  ))

  if (!check_limits) {
    stop("incorrect data type in CI limits fields", call. = FALSE)
  }

  invisible(epiparam)
}

#' Print method for `<epiparam>` class
#'
#' @param x An `<epiparam>` object.
#' @inheritParams print.epidist
#'
#' @return Invisibly returns an `<epiparam>`. Called for side-effects.
#' @export
#'
#' @examples
#' epiparam <- epiparam()
#' epiparam
print.epiparam <- function(x, ...) {
  format(x, ...)
}

#' Format method for `<epiparam>` class
#'
#' @inheritParams print.epiparam
#'
#' @return Invisibly returns an `<epiparam>`. Called for printing side-effects.
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

#' Check object is an `<epiparam>`
#'
#' @inheritParams is_epidist
#'
#' @return A boolean `logical`, `TRUE` if the object is an `<epiparam>` and
#' `FALSE` if not.
#' @export
#'
#' @examples
#' eparam <- epiparam()
#'
#' is_epiparam(eparam)
is_epiparam <- function(x) {
  inherits(x, "epiparam")
}

#' Summary method for `<epiparam>` class
#'
#' @param object An `<epiparam>` object.
#' @inheritParams is_parameterised
#'
#' @return data frame of information
#' @export
#'
#' @examples
#' x <- epiparam()
#' summary(x)
summary.epiparam <- function(object, ...) {
  chkDots(...)
  num_entries <- nrow(object)
  num_diseases <- length(unique(object$disease))
  num_delay_dist <- sum(
    object$epi_distribution %in% c(
      "incubation_period", "generation_time",
      "serial_interval", "onset_to_death"
    )
  )
  num_offspring_dist <- sum(
    object$epi_distribution %in% "offspring_distribution"
  )
  num_studies <- length(unique(object$DOI))
  num_cont_dist <- nrow(object) - sum(object$discretised)
  num_disc_dist <- sum(object$discetised)
  num_vector_borne <- sum(object$extrinsic)
  # return epiparam summary
  list(
    num_entries = num_entries,
    num_diseases = num_diseases,
    num_delay_dist = num_delay_dist,
    num_offspring_dist = num_offspring_dist,
    num_studies = num_studies,
    num_continuous_distributions = num_cont_dist,
    num_discrete_distributions = num_disc_dist,
    num_vector_borne_diseases = num_vector_borne
  )
}

#' [head()] and [tail()] methods for `<epiparam>` class
#'
#' @inheritParams print.epiparam
#'
#' @return Data frame
#' @export
#'
#' @importFrom utils head
#' @importFrom utils tail
#'
#' @examples
#' head(epiparam())
#' tail(epiparam())
head.epiparam <- function(x, ...) {
  utils::head(as.data.frame(x), ...)
}

#' @rdname head.epiparam
#' @export
tail.epiparam <- function(x, ...) {
  utils::tail(as.data.frame(x), ...)
}

#' State column names of an `<epiparam>` object
#'
#' @return `Character` vector.
#' @keywords internal
#' @noRd
epiparam_fields <- function() {
  c(
    "disease", "pathogen", "epi_distribution", "author", "title", "journal",
    "year", "sample_size", "region", "transmission_mode", "vector",
    "extrinsic", "prob_distribution", "inference_method", "mean",
    "mean_ci_limits", "mean_ci", "sd", "sd_ci_limits", "sd_ci", "quantile_2.5",
    "quantile_5", "quantile_25", "median", "median_ci_limits", "median_ci",
    "quantile_75", "quantile_87.5", "quantile_95", "quantile_97.5",
    "lower_range", "upper_range", "shape", "shape_ci_limits", "shape_ci",
    "scale", "scale_ci_limits", "scale_ci", "meanlog", "meanlog_ci_limits",
    "meanlog_ci", "sdlog", "sdlog_ci_limits", "sdlog_ci", "dispersion",
    "dispersion_ci_limits", "dispersion_ci", "precision",
    "precision_ci_limits", "precision_ci", "truncation", "discretised",
    "censored", "right_truncated", "phase_bias_adjusted", "notes", "PMID",
    "DOI"
  )
}

#' State which columns of `<epiparam>` object contain specified data type
#'
#' @return `Numeric` vector.
#' @keywords internal
#' @noRd
epiparam_col_type <- function(epiparam,
                              col_type = c("numeric", "character", "logical")) {
  col_type <- match.arg(col_type)

  out <- switch(col_type,
    numeric = which(
      colnames(epiparam) %in% c(
        "year", "sample_size", "mean", "mean_ci", "sd", "sd_ci", "quantile_2.5",
        "quantile_5", "quantile_25", "median", "median_ci", "quantile_75",
        "quantile_87.5", "quantile_95", "quantile_97.5", "lower_range",
        "upper_range", "shape", "shape_ci", "scale", "scale_ci", "meanlog",
        "meanlog_ci", "sdlog", "sdlog_ci", "dispersion", "dispersion_ci",
        "precision", "precision_ci", "truncation", "PMID"
      )
    ),
    character = which(
      colnames(epiparam) %in% c(
        "disease", "pathogen", "epi_distribution", "author", "title", "journal",
        "region", "transmission_mode", "vector", "prob_distribution",
        "inference_method", "notes", "DOI"
      )
    ),
    logical = which(
      colnames(epiparam) %in% c(
        "extrinsic", "discretised", "censored", "right_truncated",
        "phase_bias_adjusted"
      )
    )
  )
  out
}
