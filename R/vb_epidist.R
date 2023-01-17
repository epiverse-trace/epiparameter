#' Constructor for vb_epidist class
#'
#' @description Create an vb_epidist object by binding two `epidist` objects
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

#' Create an `vb_epidist` object
#'
#' @param intrinsic_epidist An `epidist` object
#' @param extrinsic_epidist An `epidist` object
#'
#' @description The `vb_epidist` class is an extension of the `epidist` class
#' (although not a subclass of `epidist`). It is is used to store
#' epidemiological parameters for vector-borne diseasese. It has the same
#' methods (`print()`, `format()`, `plot()`, `generate()`, `cdf()`, `density()`,
#' `quantile()`) as the `epidist` class and therefore there are used
#' identically.
#'
#' @details The `epidist` objects should contain metadata (`epidist$metadata`)
#' indicating it is a vector-borne disease
#' (`epidist$metadata$vector_borne` is TRUE) and the extrinsic distribution
#' should indicate in the metadata that it is the extrinsic distribution
#' (`epidist$metadata$extrinsic` is TRUE). If these two aspects are not given
#' the construction of the class will throw a warning.
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
#'     epi_distribution = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1),
#'     metadata = create_epidist_metadata(
#'       vector_borne = TRUE,
#'       extrinsic = FALSE
#'     )
#'   ),
#'   extrinsic_epidist =  epidist(
#'     disease = "dengue",
#'     pathogen = "dengue_virus",
#'     epi_distribution = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 2, scale = 2),
#'     metadata = create_epidist_metadata(
#'       vector_borne = TRUE,
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
#' @param vb_epdist A `vb_epidist` object
#'
#' @return Nothing, errors when invalid `epidist` object is provided
#' @export
validate_vb_epidist <- function(vb_epidist) {

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

  if (!isTRUE(vb_epidist$intrinsic$metadata$vector_borne) ||
      !isTRUE(vb_epidist$extrinsic$metadata$vector_borne)) {
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
#'
#' @return Nothing (prints output)
#' @export
#'
#' @examples
#' vb_epidist <- vb_epidist(
#'   intrinsic = epidist(
#'     disease = "ebola",
#'     epi_distribution = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   ),
#'   extrinsic = epidist(
#'     disease = "ebola",
#'     epi_distribution = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#' vb_epidist
print.vb_epidist <- function(x) {
  format(x)
}

#' Format method for vb_epidist class
#'
#' @param x vb_epidist object
#'
#' @return Nothing (prints output)
#' @export
#'
#' @examples
#' vb_epidist <- vb_epidist(
#'   intrinsic = epidist(
#'     disease = "ebola",
#'     epi_distribution = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   ),
#'   extrinsic = epidist(
#'     disease = "ebola",
#'     epi_distribution = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#' format(vb_epidist)
format.vb_epidist <- function(x) {

  # use epidist printing function
  print(x$intrinsic, header = TRUE, vb = "\n <Intrinsic Distribution> \n")
  print(x$extrinsic, header = FALSE, vb = "\n <Extrinsic Distribution> \n")

  invisible(x)
}

#' @inheritParams density.epidist
#' @param at The quantiles to evaluate at
#' @rdname epidist_distribution_functions
#' @return List of two elements each with a numeric vector
#' @export
density.vb_epidist <- function(x, at, ...) {
  # call epidist density method
  list(
    instrinsic = density(x$intrinsic, at = at, ...),
    extrinsic = density(x$extrinsic, at = at, ...)
  )
}

#' @inheritParams density.epidist
#' @param q The quantiles to evaluate at
#' @rdname epidist_distribution_functions
#' @return List of two elements each with a numeric vector
#' @export
cdf.vb_epidist <- function(x, q, ...) {
  # call epidist density method
  list(
    instrinsic = cdf(x$intrinsic, q = q, ...),
    extrinsic = cdf(x$extrinsic, q = q, ...)
  )
}

#' @inheritParams density.epidist
#' @param p The probabilities to evaluate at
#' @rdname epidist_distribution_functions
#' @return List of two elements each with a numeric vector
#' @export
quantile.vb_epidist <- function(x, p, ...) {
  # call epidist quantile method
  list(
    instrinsic = quantile(x$intrinsic, p = p, ...),
    extrinsic = quantile(x$extrinsic, p = p, ...)
  )
}

#' @inheritParams density.epidist
#' @param time The number of random samples
#' @rdname epidist_distribution_functions
#' @return List of two elements each with a numeric vector
#' @export
generate.vb_epidist <- function(x, times, ...) {
  # call epidist generate method
  list(
    instrinsic = generate(x$intrinsic, times = times, ...),
    extrinsic = generate(x$extrinsic, times = times, ...)
  )
}

#' Constructor for vb_epidist class
#'
#' @description Create an vb_epidist object by binding two `epidist` objects
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

#' Create an `vb_epidist` object
#'
#' @param intrinsic_epidist An `epidist` object
#' @param extrinsic_epidist An `epidist` object
#'
#' @description The `vb_epidist` class is an extension of the `epidist` class
#' (although not a subclass of `epidist`). It is is used to store
#' epidemiological parameters for vector-borne diseasese. It has the same
#' methods (`print()`, `format()`, `plot()`, `generate()`, `cdf()`, `density()`,
#' `quantile()`) as the `epidist` class and therefore there are used
#' identically.
#'
#' @details The `epidist` objects should contain metadata (`epidist$metadata`)
#' indicating it is a vector-borne disease
#' (`epidist$metadata$vector_borne` is TRUE) and the extrinsic distribution
#' should indicate in the metadata that it is the extrinsic distribution
#' (`epidist$metadata$extrinsic` is TRUE). If these two aspects are not given
#' the construction of the class will throw a warning.
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
#'     epi_distribution = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1),
#'     metadata = create_epidist_metadata(
#'       vector_borne = TRUE,
#'       extrinsic = FALSE
#'     )
#'   ),
#'   extrinsic_epidist =  epidist(
#'     disease = "dengue",
#'     pathogen = "dengue_virus",
#'     epi_distribution = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 2, scale = 2),
#'     metadata = create_epidist_metadata(
#'       vector_borne = TRUE,
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
#' @param vb_epdist A `vb_epidist` object
#'
#' @return Nothing, errors when invalid `epidist` object is provided
#' @export
validate_vb_epidist <- function(vb_epidist) {

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

  if (!isTRUE(vb_epidist$intrinsic$metadata$vector_borne) ||
      !isTRUE(vb_epidist$extrinsic$metadata$vector_borne)) {
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
#'
#' @return Nothing (prints output)
#' @export
#'
#' @examples
#' vb_epidist <- vb_epidist(
#'   intrinsic = epidist(
#'     disease = "ebola",
#'     epi_distribution = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   ),
#'   extrinsic = epidist(
#'     disease = "ebola",
#'     epi_distribution = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#' vb_epidist
print.vb_epidist <- function(x) {
  format(x)
}

#' Format method for vb_epidist class
#'
#' @param x vb_epidist object
#'
#' @return Nothing (prints output)
#' @export
#'
#' @examples
#' vb_epidist <- vb_epidist(
#'   intrinsic = epidist(
#'     disease = "ebola",
#'     epi_distribution = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   ),
#'   extrinsic = epidist(
#'     disease = "ebola",
#'     epi_distribution = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#' format(vb_epidist)
format.vb_epidist <- function(x) {

  # use epidist printing function
  print(x$intrinsic, header = TRUE, vb = "\n <Intrinsic Distribution> \n")
  print(x$extrinsic, header = FALSE, vb = "\n <Extrinsic Distribution> \n")

  invisible(x)
}

#' @inheritParams density.epidist
#' @param at The quantiles to evaluate at
#' @rdname epidist_distribution_functions
#' @return List of two elements each with a numeric vector
#' @export
density.vb_epidist <- function(x, at, ...) {
  # call epidist density method
  list(
    instrinsic = density(x$intrinsic, at = at, ...),
    extrinsic = density(x$extrinsic, at = at, ...)
  )
}

#' @inheritParams density.epidist
#' @param q The quantiles to evaluate at
#' @rdname epidist_distribution_functions
#' @return List of two elements each with a numeric vector
#' @export
cdf.vb_epidist <- function(x, q, ...) {
  # call epidist density method
  list(
    instrinsic = cdf(x$intrinsic, q = q, ...),
    extrinsic = cdf(x$extrinsic, q = q, ...)
  )
}

#' @inheritParams density.epidist
#' @param p The probabilities to evaluate at
#' @rdname epidist_distribution_functions
#' @return List of two elements each with a numeric vector
#' @export
quantile.vb_epidist <- function(x, p, ...) {
  # call epidist quantile method
  list(
    instrinsic = quantile(x$intrinsic, p = p, ...),
    extrinsic = quantile(x$extrinsic, p = p, ...)
  )
}

#' @inheritParams density.epidist
#' @param time The number of random samples
#' @rdname epidist_distribution_functions
#' @return List of two elements each with a numeric vector
#' @export
generate.vb_epidist <- function(x, times, ...) {
  # call epidist generate method
  list(
    instrinsic = generate(x$intrinsic, times = times, ...),
    extrinsic = generate(x$extrinsic, times = times, ...)
  )
}

