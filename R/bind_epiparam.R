#' Binds any epi data class in \pkg{epiparameter} ([`epidist`], [`vb_epidist`],
#' [`epiparam`]) or data frame to an [`epiparam`] object.
#'
#' @details The [`epiparam`] class holds the library of epidemiological
#' parameters that is stored in the \pkg{epiparameter} R package and can be
#' manipulated. The [bind_epiparam()] function allows users to add entries to
#' the library by binding them to the bottom of an existing [`epiparam`] object
#' loaded in R.
#'
#' @param epiparam An `epiparam` object
#' @param epi_obj Either an `epidist`, `vb_epidist`, `epiparam` or list of
#' `epidist` objects. It can also be a data frame as long as the columns conform
#' to the columsn of an `epiparam` object.
#'
#' @return An `epiparam` object
#' @export
#'
#' @examples
#' eparam <- epiparam()
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "lnorm",
#'   prob_distribution_params = c(meanlog = 1, sdlog = 1)
#' )
#' bind_epiparam(eparam, edist)
bind_epiparam <- function(epiparam, epi_obj) {

  # check input
  validate_epiparam(epiparam)
  if (is_epidist(epi_obj)) {
    validate_epidist(epi_obj)
  } else if (inherits(epi_obj, "list")) {
    lapply(epi_obj, validate_epidist)
  } else if (is_vb_epidist(epi_obj)) {
    validate_vb_epidist(epi_obj)
  } else if (is_epiparam(epi_obj)) {
    validate_epiparam(epi_obj)
    # epiparam objects can be directly binded
    out <- rbind(epiparam, epi_obj)
    # validate new epiparam object
    validate_epiparam(out)
    return(out)
  } else if (is.data.frame(epi_obj)) {
    stopifnot(
      "data frame provided must have the same column names as epiparam" =
      setequal(colnames(epi_obj), colnames(epiparam))
    )
    # data frames can be directly binded
    out <- rbind(epiparam, epi_obj)
    # validate new epiparam object
    validate_epiparam(out)
    return(out)
  } else {
    stop(
      "Only epidist, vb_epidist or epiparam can bind to epiparam",
      call. = FALSE
    )
  }

  # convert epidist to epiparam object
  eparam <- as_epiparam(x = epi_obj)

  # bind epidist to epi
  out <- rbind(epiparam, eparam)

  # validate new epiparam object
  validate_epiparam(out)

  # return new epiparam object
  out
}
