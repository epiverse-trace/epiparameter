#' Subset method for `<epiparam>` class
#'
#' @description If the subsetting invalidates the `<epiparam>` object (defined
#' by its invariants, and encoded in [validate_epiparam()]) the subsetting
#' will return a data frame with a message to console stating the class of the
#' object has been converted to `data.frame` with the other attributes of the
#' class preserved.
#'
#' @inheritParams validate_epiparam
#' @inheritParams base::subset
#'
#' @return An `epiparam` object or a `data.frame`
#' @export
`[.epiparam` <- function(epiparam, ...) {
  out <- NextMethod()
  epiparam_reconstruct(out, epiparam)
}

#' Set names for `<epiparam>` class
#'
#' @description If the modifying the names invalidates the `<epiparam>` object
#' (defined by its invariants, and encoded in [validate_epiparam()]) the
#' subsetting will return a data frame with a message to console stating the
#' class of the object has been converted to data frame with the other
#' attributes of the class preserved.
#'
#' @inheritParams base::names
#'
#' @return An `epiparam` object or a `data.frame`
#' @export
`names<-.epiparam` <- function(x, value) {
  out <- NextMethod()
  epiparam_reconstruct(out, x)
}

#' Set accessor for `epiparam` class
#'
#' @param x An `epiparam` object
#' @inheritParams base::Extract
#'
#' @return An `epiparam` object or a `data.frame`
#' @export
`$<-.epiparam` <- function(x, name, value) {
  out <- NextMethod()
  epiparam_reconstruct(out, x)
}

#' Decide whether `<epiparam>` object can be reconstructed from input
#'
#' @description Uses [epiparam_can_reconstruct()] to determine whether the
#' data input can be reconstructed in a valid `<epiparam>` object. If it can
#' not, it is returned as a data frame.
#'
#' @param x A `data.frame` or subclass of `data.frame` (e.g. `<tibble>` or
#' `<epiparam>`).
#' @param to The reference object, in this case an `<epiparam>` object.
#'
#' @return An `<epiparam>` object (if the input is valid) or a `data.frame`.
#' @keywords internal
epiparam_reconstruct <- function(x, to) {
  if (epiparam_can_reconstruct(x)) {
    df_reconstruct(x, to)
  } else {
    x <- as.data.frame(x)
    message("Removing crucial column in `<epiparam>` returning `<data.frame>`")
    x
  }
}

#' Check whether the `<epiparam>` object is valid
#'
#' @description This is a wrapper for [validate_epiparam()] in a [tryCatch()]
#' in order to not error if the input object is invalid and returns `TRUE` or
#' `FALSE` on if the object is valid. If the object is valid it can be
#' "reconstructed" and not downgraded to a `data.frame`.
#'
#' @inheritParams epiparam_reconstruct
#'
#' @return A boolean `logical`.
#' @keywords internal
epiparam_can_reconstruct <- function(x) {
  # check whether input is valid, ignoring its class
  out <- tryCatch(
    {
      validate_epiparam(x, reconstruct = TRUE)
    },
    error = function(cnd) FALSE
  )

  # return boolean
  !isFALSE(out)
}

#' Transplant the attributes of one input (`to`) to the other input (`x`)
#'
#' @inheritParams epiparam_reconstruct
#'
#' @inherit epiparam return
#' @keywords internal
df_reconstruct <- function(x, to) {
  attrs <- attributes(to)
  attrs$names <- names(x)
  attrs$row.names <- .row_names_info(x, type = 0L)
  attributes(x) <- attrs
  x
}

#' @exportS3Method dplyr::dplyr_reconstruct
dplyr_reconstruct.epiparam <- function(data, template) {
  epiparam_reconstruct(data, template)
}
