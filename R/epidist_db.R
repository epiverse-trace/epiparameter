#' Create an `epidist` object directly from the epiparameter library (database)
#'
#' @description This function can extract an `epidist` object directly from the
#' library of epidemiological parameters without having to read in an `epiparam`
#' object and pull out an `epidist` object from one of the entries. If a
#' distribution from a specific study is required, the `author` argument can
#' be specified. For now this must match the author entry in the database
#' exactly to be recognised.
#'
#' @details The current criteria for chosing a distribution when multiple
#' entries exist in the database for a given disease and epidemiological
#' distribution is to return the entry with the largest sample size.
#'
#' @param disease A character string specifying the disease
#' @param epi_dist A character string specifying the epidemiological
#' distribution
#' @param author The author of the study reporting the distribution
#'
#' @return An `epidist` object
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
#' eparam <- eparam[eparam$disease == "influenza", ]
#' # convert to `epidist`
#' edist2 <- as_epidist(eparam)
#' # check the two methods produce the same `epidist` object
#' identical(edist, edist2)
epidist_db <- function(disease,
                       epi_dist = c("incubation_period",
                                    "onset_to_hospitalisation",
                                    "onset_to_death",
                                    "serial_interval",
                                    "generation_time",
                                    "offspring_distribution"),
                       author = NULL) {

  # check input
  checkmate::assert_string(disease)
  epi_dist <- match.arg(arg = epi_dist, several.ok = FALSE)

  # read in database
  eparam <- epiparam(epi_dist = epi_dist)

  if (is.na(pmatch(disease, eparam$disease))) {
    stop(epi_dist, " distribution not available for ", disease, call. = FALSE)
  }

  # match disease names against data
  disease <- match.arg(
    arg = disease,
    choices = unique(eparam$disease),
    several.ok = FALSE
  )

  # filter based on pathogen and delay distribution
  eparam <- eparam[eparam$disease == disease, ]

  # extract study or default to largest sample size
  if (is.null(author)) {
    eparam <- eparam[which.max(eparam$sample_size), ]
  } else {
    study <- match.arg(
      arg = author,
      choices = unique(eparam$author),
      several.ok = FALSE
    )
    eparam <- eparam[eparam$author == study, ]
  }

  # Throw warning if more than one row found and select first
  if (nrow(eparam) > 1) {
    warning("More than one study found. Selecting first one.
    Please report an issue with duplicated studies.")
    eparam <- eparam[1, ]
  }

  # convert epiparam to epidist
  edist <- as_epidist(x = eparam)

  # return epidist
  edist
}
