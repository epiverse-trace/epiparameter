#' Constructor for `vb_epidist` class
#'
#' @description Create an `vb_epidist` object by binding two `epidist` objects
#' and assigning the `vb_epidist` class. Not extra checks are made as these
#' take place in the `epidist` helper function.
#'
#' @inheritParams vb_epidist
#'
#' @return `vb_epidist` object
#' @keywords internal
new_vb_epidist <- function(intrinsic_epidist,
                           extrinsic_epidist) {

  # return vb_epidist object
  structure(
    list(
      intrinsic = intrinsic_epidist,
      extrinsic = extrinsic_epidist),
    class = "vb_epidist"
  )
}

#' Create a `vb_epidist` object
#'
#' @param intrinsic_epidist An `epidist` object
#' @param extrinsic_epidist An `epidist` object
#'
#' @description The `vb_epidist` class is an extension of the `epidist` class
#' (although not a subclass of `epidist`). It is is used to store
#' epidemiological parameters for vector-borne diseases. It has the same
#' methods (`print()`, `format()`, `plot()`, `generate()`, `cdf()`, `density()`,
#' `quantile()`) as the `epidist` class and therefore there are used
#' identically.
#'
#' @details The `epidist` objects should contain metadata (`epidist$metadata`)
#' indicating it is a vector-borne disease
#' (`epidist$metadata$transmission_mode == "vector_borne"`) and the extrinsic
#' distribution should indicate in the metadata that it is the extrinsic
#' distribution (`epidist$metadata$extrinsic` is TRUE). If these two aspects
#' are not given the construction of the class will throw a warning.
#'
#' @seealso [`epidist()`]
#'
#' @return `vb_epidist` object
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
#'   extrinsic_epidist =  epidist(
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

#' `vb_epidist` class validator
#'
#' @param vb_epidist A `vb_epidist` object
#'
#' @return Invisibly returns a [`vb_epidist`]. Called for side-effects (errors
#' when invalid `vb_epidist` object is provided).
#' @export
validate_vb_epidist <- function(vb_epidist) {

  if (!is_vb_epidist(vb_epidist)) {
    stop("Object should be of class vb_epidist")
  }

  stopifnot(
    "diseases in intrinsic and extrinsic distribution are different" =
      identical(
        vb_epidist$intrinsic$disease$disease,
        vb_epidist$extrinsic$disease$disease
      ),
    "epi distribution in intrinsic and extrinsic distributions are different" =
      identical(
        vb_epidist$intrinsic$epi_dist,
        vb_epidist$extrinsic$epi_dist
      )
  )

  if (!(vb_epidist$intrinsic$metadata$transmission_mode == "vector_borne") ||
      !(vb_epidist$extrinsic$metadata$transmission_mode == "vector_borne")) {
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

#' Print method for vb_epidist class
#'
#' @param x vb_epidist object
#' @param ... further arguments passed to or from other methods
#'
#' @return Invisibly returns a [`vb_epidist`]. Called for printing
#' side-effects.
#' @export
#'
#' @examples
#' vb_epidist <- vb_epidist(
#'   intrinsic = epidist(
#'     disease = "ebola",
#'     epi_dist = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   ),
#'   extrinsic = epidist(
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

#' Format method for vb_epidist class
#'
#' @param x vb_epidist object
#' @param ... further arguments passed to or from other methods
#'
#' @return Invisibly returns a [`vb_epidist`] object. Usually called for
#' printing side-effects.
#' @export
#'
#' @examples
#' vb_epidist <- vb_epidist(
#'   intrinsic = epidist(
#'     disease = "ebola",
#'     epi_dist = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   ),
#'   extrinsic = epidist(
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

#' Checks whether the object is a `vb_epidist`
#'
#' @param x An R object
#'
#' @return A boolean logical, `TRUE` if the object is an `vb_epidist` and
#' `FALSE` if not
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

#' Plots an `vb_epidist` object,
#'
#' @description Plots a `vb_epidist` object by displaying the either the
#' probability mass function (PMF), (in the case of discrete distributions)
#' or probability density function (PDF) (in the case of continuous
#' distributions) and the cumulative distribution function (CDF), for both the
#' intrinsic and extrinsic distributions. This resulting in a 2x2 grid plot.
#'
#' @param x An `epidist` object
#' @param day_range A vector with the sequence of days to be plotted on the
#' x-axis of the distribution
#' @param ... Allow other graphical parameters
#'
#' @author Joshua W. Lambert
#' @export
#'
#' @examples
#' # plot vb_epidist
#' dengue_dist <- vb_epidist(
#'   intrinsic_epidist = epidist(
#'     disease = "dengue",
#'     epi_dist = "incubation",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1),
#'     metadata = create_epidist_metadata(
#'       transmission_mode = "vector_borne",
#'       extrinsic = FALSE
#'     )
#'   ),
#'   extrinsic_epidist = epidist(
#'     disease = "dengue",
#'     epi_dist = "incubation",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1),
#'     metadata = create_epidist_metadata(
#'       transmission_mode = "vector_borne",
#'       extrinsic = TRUE
#'     )
#'   )
#' )
#'
#' plot(dengue_dist, day_range = 0:10)
plot.vb_epidist <- function(x, day_range = 0:10, ...) {

  # check input
  validate_vb_epidist(x)
  checkmate::assert_numeric(day_range, min.len = 2)

  oldpar <- graphics::par(no.readonly = TRUE)
  on.exit(graphics::par(oldpar))

  # set plotting parameters to plot on a 2x2 grid
  graphics::par(mfrow = c(2, 2), mar = c(4, 3, 3, 1), oma = c(0, 0, 0, 0))

  plot(
    x$intrinsic,
    day_range = day_range,
    ...,
    vb = TRUE,
    title = "Intrinsic Distribution"
  )
  plot(
    x$extrinsic,
    day_range = day_range,
    ...,
    vb = TRUE,
    title = "Extrinsic Distribution"
  )
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
