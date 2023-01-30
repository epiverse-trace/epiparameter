#' Creates an `epidist` object directly from the epiparameter library (database)
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
epidist_db <- function(disease,
                       epi_dist = c("incubation_period",
                                    "onset_to_admission",
                                    "onset_to_death",
                                    "serial_interval",
                                    "generation_time",
                                    "offspring_distribution"),
                       author = NULL) {

  epi_dist <- match.arg(arg = epi_dist, several.ok = FALSE)

  # read in database
  eparam <- epiparam(epi_dist = epi_dist)

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
    eparam <- eparam[eparam$sample_size == max(eparam$sample_size), ]
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

  # return epidist (or list of epidist)
  edist
}
