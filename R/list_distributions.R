#' List epidemiological distributions stored in an `epiparam` object
#'
#' @description This function subsets an `epiparam` object to return only the
#' chosen epidemiological distribution. The results are returned as a data
#' frame to better see all of the returned distributions.
#'
#' By default the resulting data frame is subset to only return the disease,
#' epidemiological distribution, probability distribution, author of the study
#' and the year of publication as well as the sample size of the study. If the
#' all columns of the database are required set `subset_db = FALSE`.
#'
#' @param epiparam An `epiparam` object.
#' @param epi_dist A character defining parameter to be listed:
#' `"incubation"`, `"onset_to_hospitalisation"`, `"onset_to_death"`, or
#' `"serial_interval"`. `"incubation_period"` is the default `epi_dist` so if no
#' `epi_dist` is specified the incubation periods will be returned.
#' @param subset_db A boolean logical that determines whether a subset, defaults
#' is TRUE.
#'
#' @keywords distributions
#' @author Adam Kucharski, Joshua W. Lambert
#' @export
#' @examples
#' eparam <- epiparam()
#' list_distributions(epiparam = eparam, epi_dist = "incubation_period")
#' # the default for list_distributions() without any arguments is to return the
#' # incubation period
#' list_distributions(epiparam = eparam)
#' # this same process can be achieved when loading the library
#' eparam <- epiparam(epi_dist = "incubation_period")
#'
#' # filtering for onset to death
#' list_distributions(epiparam = eparam, epi_dist = "onset_to_death")
list_distributions <- function(epiparam,
                               epi_dist = c(
                                 "incubation_period",
                                 "onset_to_hospitalisation",
                                 "onset_to_death",
                                 "serial_interval",
                                 "generation_time",
                                 "offspring_distribution"
                               ),
                               subset_db = TRUE) {
  # check input
  validate_epiparam(epiparam)
  epi_dist <- match.arg(arg = epi_dist, several.ok = FALSE)
  checkmate::assert_logical(subset_db)

  # subset to chosen distribution
  epiparam <- epiparam[epiparam$epi_distribution == epi_dist, ]

  # strip epiparam class to return data frame
  class(epiparam) <- "data.frame"

  if (isTRUE(subset_db)) {
    epiparam <- epiparam[, c(
      "disease", "epi_distribution", "prob_distribution", "author", "year",
      "sample_size"
    )]
  }

  # reset indexing of rows
  rownames(epiparam) <- NULL

  # return epiparam data frame
  epiparam
}
