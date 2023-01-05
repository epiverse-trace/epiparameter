#' epiparam constructor
#'
#' @description The constructor reads the data stored internally in the package
#' and subsets by epidemiological distribution (epi_dist) or specifies what are
#' considered important information (subset_params)
#'
#' @return epiparam object
#' @keywords internal
#'
#' @examples
#' obj <- new_epiparam()
new_epiparam <- function(epi_dist = character(),
                         subset_params = logical()) {

  # check input
  checkmate::assert_character(epi_dist, len = 1)
  checkmate::assert_logical(subset_params)

  # Extract relevant values
  params <- utils::read.csv(system.file(
    "extdata",
    "parameters.csv",
    package = "epiparameter",
    mustWork = TRUE
  ))

  # order params by pathogen, delay dist and study
  params <- params[order(
    tolower(params$disease),
    tolower(params$epi_distribution),
    tolower(params$author),
    method = "radix"
  ), ]

  if (epi_dist != "all") {
    # filter by delay distribution
    params <- params[params$type_id == epi_dist, ]
  }

  if (subset_params) {
    # return only the important columns
    params <- params[, c(
      "disease", "epi_distribution", "author", "year", "sample_size", "prob_distribution"
    )]
  }

  # reset indexing of rows
  rownames(params) <- NULL

  structure(params, class = c("epiparam", "data.frame"))

}

epiparam <- function(epi_dist = c("all",
                                  "incubation",
                                  "onset_to_admission",
                                  "onset_to_death",
                                  "serial_interval",
                                  "generation_time"),
                     subset_params = FALSE) {

  # check input
  epi_dist <- match.arg(arg = epi_dist, several.ok = FALSE)
  checkmate::assert_logical(subset_params)

  # create epiparam object
  epiparam <- new_epiparam(epi_dist = epi_dist, subset_params = subset_params)

  # validate epiparam object
  validate_epiparam(epiparam)

  # return epiparam object
  epiparam
}

validate_epiparam <- function(x) {
  if (!inherits(x, "epiparam")) {
    stop("Object should be of class epiparam")
  }
  invisible(x)
}
