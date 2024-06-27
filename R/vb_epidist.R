#' Constructor for `<vb_epidist>` class
#'
#' @description Create an `<vb_epidist>` object by binding two
#' `<epidist>` objects and assigning the `<vb_epidist>` class.
#'
#' @inheritParams vb_epidist
#'
#' @return `<vb_epidist>` object
#' @keywords internal
new_vb_epidist <- function(intrinsic_epidist,
                           extrinsic_epidist) {
  # input checking is done in epidist()

  # return vb_epidist object
  structure(
    list(
      intrinsic = intrinsic_epidist,
      extrinsic = extrinsic_epidist
    ),
    class = "vb_epidist"
  )
}

#' Create a `<vb_epidist>` object
#'
#' @param intrinsic_epidist An `<epidist>` object.
#' @param extrinsic_epidist An `<epidist>` object.
#'
#' @description The `<vb_epidist>` class is an extension of the
#' `<epidist>` class (although not a subclass of `<epidist>`). It is is
#' used to store epidemiological parameters for vector-borne diseases.
#' It has the same methods (`print()`, `format()`, `plot()`, `generate()`,
#' `cdf()`, `density()`, `quantile()`) as the `<epidist>` class and
#' therefore they are used identically.
#'
#' @details The `<epidist>` objects should contain metadata
#' (`epidist$metadata`) indicating it is a vector-borne disease
#' (`epidist$metadata$transmission_mode = "vector_borne"`) and the extrinsic
#' distribution should indicate in the metadata that it is the extrinsic
#' distribution (`epidist$metadata$extrinsic = TRUE`). If these two aspects
#' are not given the construction of the class will throw a warning.
#'
#' @seealso [epidist()]
#'
#' @return `<vb_epidist>` object
#' @export
#'
#' @examples
#' vb <- vb_epidist(
#'   intrinsic_epidist = epidist(
#'     disease = "dengue",
#'     pathogen = "dengue_virus",
#'     epi_dist = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1),
#'     metadata = create_epidist_metadata(
#'       transmission_mode = "vector_borne",
#'       extrinsic = FALSE
#'     )
#'   ),
#'   extrinsic_epidist = epidist(
#'     disease = "dengue",
#'     pathogen = "dengue_virus",
#'     epi_dist = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 2, scale = 2),
#'     metadata = create_epidist_metadata(
#'       transmission_mode = "vector_borne",
#'       extrinsic = TRUE
#'     )
#'   )
#' )
vb_epidist <- function(intrinsic_epidist,
                       extrinsic_epidist) {
  # check input
  validate_epidist(intrinsic_epidist)
  validate_epidist(extrinsic_epidist)

  # call vb_epidist constructor
  vb_epidist <- new_vb_epidist(
    intrinsic_epidist = intrinsic_epidist,
    extrinsic_epidist = extrinsic_epidist
  )

  # call epidist validator
  validate_vb_epidist(vb_epidist)

  # return vb_epidist object
  vb_epidist
}

#' Validator for `<vb_epidist>` class
#'
#' @param vb_epidist A `<vb_epidist>` object
#'
#' @return Invisibly returns a `<vb_epidist>`. Called for side-effects (errors
#' when invalid `<vb_epidist>` object is provided).
#' @export
validate_vb_epidist <- function(vb_epidist) {
  if (!is_vb_epidist(vb_epidist)) {
    stop("Object should be of class vb_epidist", call. = FALSE)
  }

  stopifnot(
    "diseases in intrinsic and extrinsic distribution are different" =
      identical(
        vb_epidist$intrinsic$disease,
        vb_epidist$extrinsic$disease
      ),
    "epi distribution in intrinsic and extrinsic distributions are different" =
      identical(
        vb_epidist$intrinsic$epi_dist,
        vb_epidist$extrinsic$epi_dist
      )
  )

  intrinsic_vb <- grepl(
    pattern = "vector_borne",
    x = vb_epidist$intrinsic$metadata$transmission_mode,
    ignore.case = TRUE
  )
  extrinsic_vb <- grepl(
    pattern = "vector_borne",
    x = vb_epidist$extrinsic$metadata$transmission_mode,
    ignore.case = TRUE
  )
  if (isFALSE(intrinsic_vb) || isFALSE(extrinsic_vb)) {
    warning(
      "Distributions in vb_epidist class are not vector-borne. Check metadata",
      call. = FALSE
    )
  }

  if (isTRUE(vb_epidist$intrinsic$metadata$extrinsic)) {
    warning(
      "The intrinsic distribution is specified extrinsic. Check metadata",
      call. = FALSE
    )
  }

  if (!isTRUE(vb_epidist$extrinsic$metadata$extrinsic)) {
    warning(
      "The extrinsic distribution is not specified extrinsic. Check metadata",
      call. = FALSE
    )
  }

  lapply(vb_epidist, validate_epidist)

  invisible(vb_epidist)
}

#' Print method for `<vb_epidist>` class
#'
#' @param x A `<vb_epidist>` object.
#' @inheritParams print.epidist
#'
#' @return Invisibly returns a `<vb_epidist>`. Called for printing
#' side-effects.
#' @export
#'
#' @examples
#' vb_epidist <- vb_epidist(
#'   intrinsic_epidist = epidist(
#'     disease = "ebola",
#'     epi_dist = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   ),
#'   extrinsic_epidist = epidist(
#'     disease = "ebola",
#'     epi_dist = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#' vb_epidist
print.vb_epidist <- function(x, ...) {
  format(x, ...)
}

#' Format method for `<vb_epidist>` class
#'
#' @inheritParams print.vb_epidist
#'
#' @inherit print.vb_epidist return
#' @export
#'
#' @examples
#' vb_epidist <- vb_epidist(
#'   intrinsic_epidist = epidist(
#'     disease = "ebola",
#'     epi_dist = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   ),
#'   extrinsic_epidist = epidist(
#'     disease = "ebola",
#'     epi_dist = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#' format(vb_epidist)
format.vb_epidist <- function(x, ...) {
  # use epidist printing function
  print(x$intrinsic, header = TRUE, vb = "\n <Intrinsic Distribution> \n", ...)
  print(x$extrinsic, header = FALSE, vb = "\n <Extrinsic Distribution> \n", ...)

  invisible(x)
}

#' Check object is a `<vb_epidist>`
#'
#' @inheritParams is_epidist
#'
#' @return A boolean `logical`, `TRUE` if the object is a `<vb_epidist>` and
#' `FALSE` if not.
#' @export
#'
#' @examples
#' vb_edist <- vb_epidist(
#'   intrinsic_epidist = epidist(
#'     disease = "dengue",
#'     epi_dist = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1),
#'     metadata = create_epidist_metadata(transmission_mode = "vector_borne")
#'   ),
#'   extrinsic_epidist = epidist(
#'     disease = "dengue",
#'     epi_dist = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1),
#'     metadata = create_epidist_metadata(
#'       transmission_mode = "vector_borne",
#'       extrinsic = TRUE
#'     )
#'   )
#' )
#'
#' is_vb_epidist(vb_edist)
is_vb_epidist <- function(x) {
  inherits(x, "vb_epidist")
}

#' @rdname epidist_distribution_functions
#' @export
density.vb_epidist <- function(x, at, ...) {
  # call epidist density method
  list(
    intrinsic = stats::density(x$intrinsic, at = at, ...),
    extrinsic = stats::density(x$extrinsic, at = at, ...)
  )
}

#' @rdname epidist_distribution_functions
#' @export
cdf.vb_epidist <- function(x, q, ...) {
  # call epidist density method
  list(
    intrinsic = distributional::cdf(x$intrinsic, q = q, ...),
    extrinsic = distributional::cdf(x$extrinsic, q = q, ...)
  )
}

#' @rdname epidist_distribution_functions
#' @export
quantile.vb_epidist <- function(x, p, ...) {
  # call epidist quantile method
  list(
    intrinsic = quantile(x$intrinsic, p = p, ...),
    extrinsic = quantile(x$extrinsic, p = p, ...)
  )
}

#' @rdname epidist_distribution_functions
#' @export
generate.vb_epidist <- function(x, times, ...) {
  # call epidist generate method
  list(
    intrinsic = distributional::generate(x$intrinsic, times = times, ...),
    extrinsic = distributional::generate(x$extrinsic, times = times, ...)
  )
}
