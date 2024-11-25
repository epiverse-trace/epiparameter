#' Constructor for `<epiparameter>` class
#'
#' @description Create an `<epiparameter>` object. The
#' constructor will search whether parameters of the probability distribution
#' are supplied and if not look to see whether they can be inferred/extracted/
#' converted from summary statistics provided. It will also convert the
#' probability distribution (`prob_dist`) and its parameters
#' (`prob_dist_params`) into an S3 class, either a `distribution` object from
#' `{distributional}` when `discretise = FALSE`, or a `distcrete` object from
#' `{distcrete}` when `discretise = TRUE`.
#'
#' @inheritParams epiparameter
#'
#' @inherit epiparameter return
#' @keywords internal
new_epiparameter <- function(disease = character(),
                             pathogen = character(),
                             epi_name = character(),
                             prob_distribution = list(),
                             uncertainty = list(),
                             summary_stats = list(),
                             citation = character(),
                             metadata = list(),
                             method_assess = list(),
                             notes = character(),
                             auto_calc_params = logical(),
                             ...) {
  if (auto_calc_params && is.character(prob_distribution)) {
    # calculate parameters if not provided
    prob_distribution_params <- .calc_dist_params(
      prob_distribution = prob_distribution,
      summary_stats = summary_stats,
      sample_size = metadata$sample_size
    )
    if (!anyNA(prob_distribution_params)) {
      prob_distribution <- create_prob_distribution(
        prob_distribution = prob_distribution,
        prob_distribution_params = prob_distribution_params,
        ...
      )
      message(
        "Parameterising the probability distribution with the summary ",
        "statistics.\n Probability distribution is assumed not to be ",
        "discretised or truncated."
      )
    }
    if (!inherits(prob_distribution, c("distribution", "distcrete"))) {
      message("Unparameterised <epiparameter> object")
    }
  }

  if (grepl(pattern = "offspring|risk", x = epi_name)) {
    method_assess <- paste(
      "There is currently no method assessment for", epi_name,
      "in {epiparameter}."
    )
  }

  if (is.null(notes)) {
    notes <- "No additional notes"
  }

  # create and return epiparameter class
  structure(
    list(
      disease = disease,
      pathogen = pathogen,
      epi_name = epi_name,
      prob_distribution = prob_distribution,
      uncertainty = uncertainty,
      summary_stats = summary_stats,
      citation = citation,
      metadata = metadata,
      method_assess = method_assess,
      notes = notes
    ),
    class = "epiparameter",
    .epiparameter_namespace = .epiparameter_namespace
  )
}

# Load {epiparameter} namespace when using <epiparameter>
# (incl. serialised objects)
.epiparameter_namespace <- function() NULL

#' Create an `<epiparameter>` object
#'
#' @description The `<epiparameter>` class is used to store epidemiological
#' parameters for a single disease. These epidemiological parameters cover a
#' variety of aspects including delay distributions (e.g. incubation periods
#' and serial intervals, among others) and offspring distributions.
#'
#' The `<epiparameter>` object is the functional unit provided by
#' `{epiparameter}` to plug into epidemiological pipelines. Obtaining an
#' `<epiparameter>` object can be achieved in two main ways:
#' 1. The epidemiological distribution is stored in
#' the `{epiparameter}` library and can be accessed by [epiparameter_db()].
#' 2. The alternative method is when you have information
#' (e.g. disease and distribution parameter estimates) and would like to input
#' this into an `<epiparameter>` object in order to work in existing analysis
#' pipelines. This is where the `epiparameter()` function can be used to fill
#' out each field for which information is known.
#'
#' @details Accepted `<epiparameter>` distribution parameterisations are:
#' - Gamma must be either 'shape' and 'scale' or 'shape' and 'rate'
#' - Weibull must be 'shape' and 'scale'
#' - Lognormal must be 'meanlog' and 'sdlog' or 'mu' and 'sigma'
#' - Negative Binomial must be either 'mean' and 'dispersion' or 'n' and 'p'
#' - Geometric must be either 'mean' or 'prob'
#' - Poisson must be 'mean'
#'
#' @param disease A `character` string with name of the infectious disease.
#' @param pathogen A `character` string with the name of the causative agent of
#' disease, or `NA` if not known.
#' @param epi_name A `character` string with the name of the
#' epidemiological parameter type.
#' @param prob_distribution An S3 class containing the probability
#' distribution or a character string if the parameters of the probability
#' distribution are unknown but the name of the distribution is known, or `NA`
#' if the distribution name and parameters are unknown. Use
#' [create_prob_distribution()] to create `prob_distribution`.
#' @param uncertainty A list of named vectors with the uncertainty around
#' the probability distribution parameters. If uncertainty around the parameter
#' estimates is unknown use [create_uncertainty()] (which is the
#' argument default) to create a list with the correct names with missing
#' values.
#' @param summary_stats A list of summary statistics, use
#' [create_summary_stats()] to create list. This list can include
#' summary statistics about the inferred distribution such as it's mean and
#' standard deviation, quantiles of the distribution, or information about the
#' data used to fit the distribution such as lower and upper range. The summary
#' statistics can also include uncertainty around metrics such as confidence
#' interval around mean and standard deviation.
#' @param auto_calc_params A boolean `logical` determining whether to try and
#' calculate the probability distribution parameters from summary statistics if
#' distribution parameters are not provided. Default is `TRUE`. In the case when
#' sufficient summary statistics are provided and the parameter(s) of the
#' distribution are not, the [.calc_dist_params()] function is called to
#' calculate the parameters and add them to the `epiparameter` object created.
#' @param citation A `<bibentry>` with the citation of the source of the
#' data or the paper that inferred the distribution parameters, use
#' [create_citation()] to create citation.
#' @param metadata A list of metadata, this can include: units, sample size,
#' the transmission mode of the disease (e.g. is it vector-borne or directly
#' transmitted), etc. It is assumed that the disease is not
#' vector-borne and that the distribution is intrinsic (e.g. not an extrinsic
#' delay distribution such as extrinsic incubation period) unless
#' `transmission_mode = "vector_borne"` is contained in the metadata. Use
#' [create_metadata()] to create metadata.
#' @param method_assess A list of methodological aspects used when fitting
#' the distribution, use [create_method_assess()] to create method
#' assessment.
#' @param notes A `character` string with any additional information about the
#' data, inference method or disease.
#' @param ... [dots] Extra arguments to be passed to internal functions.
#'
#' This is most commonly used to pass arguments to [distcrete::distcrete()]
#' that construct the discretised distribution S3 object. To see which
#' arguments can be adjusted for discretised distributions see
#' [distcrete::distcrete()].
#'
#' @return An `<epiparameter>` object.
#' @export
#'
#' @examples
#' # minimal input required for `epiparameter`
#' ebola_incubation <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "incubation_period",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#'
#' # minimal input required for discrete `epiparameter`
#' ebola_incubation <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "incubation_period",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1),
#'     discretise = TRUE
#'   )
#' )
#'
#' # example with more fields filled in
#' ebola_incubation <- epiparameter(
#'   disease = "ebola",
#'   pathogen = "ebola_virus",
#'   epi_name = "incubation",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1),
#'     discretise = FALSE,
#'     truncation = NA
#'   ),
#'   uncertainty = list(
#'     shape = create_uncertainty(),
#'     scale = create_uncertainty()
#'   ),
#'   summary_stats = create_summary_stats(mean = 2, sd = 1),
#'   citation = create_citation(
#'     author = person(given = "John", family = "Smith"),
#'     year = 2002,
#'     title = "COVID-19 incubation period",
#'     journal = "Epi Journal",
#'     doi = "10.19832/j.1366-9516.2012.09147.x"
#'   ),
#'   metadata = create_metadata(
#'     units = "days",
#'     sample_size = 10,
#'     region = "UK",
#'     transmission_mode = "natural_human_to_human",
#'     inference_method = "MLE"
#'   ),
#'   method_assess = create_method_assess(
#'     censored = TRUE
#'   ),
#'   notes = "No notes"
#' )
epiparameter <- function(disease,
                         pathogen = NA_character_,
                         epi_name,
                         prob_distribution = create_prob_distribution(
                           prob_distribution = NA_character_
                         ),
                         uncertainty = create_uncertainty(),
                         summary_stats = create_summary_stats(),
                         citation = create_citation(),
                         metadata = create_metadata(),
                         method_assess = create_method_assess(),
                         notes = NULL,
                         auto_calc_params = TRUE,
                         ...) {
  # check input
  checkmate::assert_string(disease)
  checkmate::assert_character(pathogen)
  checkmate::assert_string(epi_name)
  stopifnot(
    "Probability distribution must be a distribution object or a character" =
      !inherits(prob_distribution, c("distribution", "distcrete")) ||
      !is.character(prob_distribution)
  )
  checkmate::assert_list(uncertainty, names = "unique")
  checkmate::assert_list(
    summary_stats,
    types = c("numeric", "logical"),
    names = "unique",
    null.ok = TRUE
  )
  checkmate::assert_class(citation, classes = "bibentry")
  checkmate::assert_list(metadata)
  checkmate::assert_list(method_assess)
  checkmate::assert_character(notes, null.ok = TRUE)

  # call epiparameter constructor
  epiparameter <- new_epiparameter(
    disease = disease,
    pathogen = pathogen,
    epi_name = epi_name,
    prob_distribution = prob_distribution,
    uncertainty = uncertainty,
    summary_stats = summary_stats,
    auto_calc_params = auto_calc_params,
    citation = citation,
    metadata = metadata,
    method_assess = method_assess,
    notes = notes,
    ...
  )

  # uncertainty is checked after new_epiparameter to use <epiparameter> methods
  epiparameter$uncertainty <- .clean_uncertainty(
    epiparameter,
    prob_distribution = prob_distribution,
    uncertainty_missing = missing(uncertainty)
  )

  param_names <- names(get_parameters(epiparameter)) %||% NA_character_

  stopifnot(
    "uncertainty must be provided for each parameter" =
      length(param_names) == length(epiparameter$uncertainty),
    "parameters and uncertainty must be named and match" =
      identical(param_names, names(epiparameter$uncertainty)) ||
      is.na(param_names)
  )

  # call epiparameter validator
  assert_epiparameter(epiparameter)

  # return epiparameter object
  epiparameter
}

#' Assert an object is a valid `<epiparameter>` object
#'
#' @param x An \R object.
#'
#' @return Invisibly returns an `<epiparameter>`. Called for side-effects
#' (errors when invalid `<epiparameter>` object is provided).
#'
#' @export
#'
#' @examples
#' ep <- epiparameter_db(single_epiparameter = TRUE)
#' assert_epiparameter(ep)
#'
#' # example with invalid <epiparameter>
#' ep$disease <- NULL
#' try(assert_epiparameter(ep))
assert_epiparameter <- function(x) {
  msg <- .validate_epiparameter(x)
  if (length(msg) > 0) {
    stop(
      "<epiparameter> is invalid due to:\n", sprintf("  - %s\n", msg),
      call. = FALSE
    )
  }
  invisible(x)
}

#' Test whether an object is a valid `<epiparameter>` object
#'
#' @param x An \R object.
#'
#' @return A boolean `logical` whether the object is a valid `<epiparameter>`
#' object (prints message when invalid `<epiparameter>` object is provided).
#' @export
#'
#' @examples
#' ep <- epiparameter_db(single_epiparameter = TRUE)
#' test_epiparameter(ep)
#'
#' # example with invalid <epiparameter>
#' ep$disease <- NULL
#' test_epiparameter(ep)
test_epiparameter <- function(x) {
  msg <- .validate_epiparameter(x)
  if (length(msg) > 0) {
    message("<epiparameter> is invalid due to:\n", sprintf("  - %s\n", msg))
    return(FALSE)
  }
  return(TRUE)
}

#' Check if `<epiparameter>` is valid and return messages for each invalidation.
#' Called by either [test_epiparameter()] or [assert_epiparameter()].
#'
#' @param x An `<epiparameter>` object.
#'
#' @return A `character` string.
#' @keywords internal
#' @noRd
.validate_epiparameter <- function(x) {
  msg <- character(0)
  if (!is_epiparameter(x)) {
    msg <- c(msg, "Object should be of class <epiparameter>.")
  }
  list_names <- c(
    "disease", "pathogen", "epi_name", "prob_distribution", "uncertainty",
    "summary_stats", "citation", "metadata", "method_assess", "notes"
  )
  missing_list_names <- list_names[!list_names %in% attributes(x)$names]
  if (length(missing_list_names) > 0) {
    msg <- c(
      msg,
      paste0(
        "<epiparameter> must contain ",
        toString(paste0("$", missing_list_names)), "."
      )
    )
  }
  # $ operator will error if x is not a list so following checks are conditional
  if (is.list(x)) {
    if (!checkmate::test_string(x$disease)) {
      msg <- c(
        msg,
        "<epiparameter> must contain one disease."
      )
    }
    if (!checkmate::test_string(x$epi_name)) {
      msg <- c(
        msg, "<epiparameter> must contain one epidemiological parameter."
      )
    }
    if (!(checkmate::test_multi_class(
      x$prob_distribution, classes = c("distribution", "distcrete")
    ) || checkmate::test_string(x$prob_distribution, na.ok = TRUE))) {
      msg <- c(
        msg,
        paste(
          "<epiparameter> $prob_distribution must contain a <distribution>",
          "or <distcrete> or character or NA."
        )
      )
    }
    if (!all(
      is.list(x$uncertainty), is.list(x$summary_stats), is.list(x$metadata)
    )) {
      msg <- c(
        msg,
        paste(
          "<epiparameter> must contain $uncertainty, $summary_stats and ",
          "$metadata elements."
        )
      )
    }
    if (!inherits(x$citation, "bibentry")) {
      msg <- c(msg, "<epiparameter> $citation must be a <bibentry> object.")
    }
    if (!checkmate::test_string(x$notes)) {
      msg <- c(msg, "<epiparameter> $notes must be a character string.")
    }
  }
  return(msg)
}

#' Check object is an `<epiparameter>`
#'
#' @param x An \R object.
#'
#' @return A boolean logical, `TRUE` if the object is an `<epiparameter>`
#' and `FALSE` if not.
#' @export
#'
#' @examples
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "serial_interval",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#'
#' is_epiparameter(ep)
#'
#' false_ep <- list(
#'   disease = "ebola",
#'   epi_name = "serial_interval",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#'
#' is_epiparameter(false_ep)
is_epiparameter <- function(x) {
  inherits(x, "epiparameter")
}

#' PDF, CDF, PMF, quantiles and random number generation for `<epiparameter>`
#' objects
#'
#' @description The `<epiparameter>` object holds a probability distribution
#' which can either be a continuous or discrete distribution. These are the
#' density, cumulative distribution, quantile and random number generation
#' functions. These operate on any distribution that can be included in an
#' `<epiparameter>` object.
#'
#' @param x An `<epiparameter>` object.
#' @param at The quantiles to evaluate at.
#' @param q The quantiles to evaluate at.
#' @param p The probabilities to evaluate at.
#' @param times The number of random samples.
#' @inheritParams print.epiparameter
#' @inheritParams distributional::cdf
#'
#' @return `numeric` vector.
#'
#' @name epiparameter_distribution_functions
#' @keywords epiparameter_distribution_functions
#'
#' @examples
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "incubation_period",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#'
#' # example of each distribution method for an `epiparameter` object
#' stats::density(ep, at = 1)
#' distributional::cdf(ep, q = 1)
#' stats::quantile(ep, p = 0.2)
#' distributional::generate(ep, times = 10)
NULL

#' @rdname epiparameter_distribution_functions
#' @importFrom stats density
#' @export
density.epiparameter <- function(x, at, ...) {
  if (isFALSE(is_parameterised(x))) {
    stop("<epiparameter> is unparameterised", call. = FALSE)
  }
  if (inherits(x$prob_distribution, "distcrete")) {
    out <- x$prob_distribution$d(at)
  } else {
    out <- stats::density(x$prob_distribution, at = at)
  }
  if (is.atomic(out)) {
    return(out)
  }
  return(unlist(out, recursive = FALSE))
}

#' @importFrom distributional cdf
#' @export
distributional::cdf

#' @rdname epiparameter_distribution_functions
#' @importFrom distributional cdf
#' @export
cdf.epiparameter <- function(x, q, ..., log = FALSE) {
  if (isFALSE(is_parameterised(x))) {
    stop("<epiparameter> is unparameterised", call. = FALSE)
  }
  if (inherits(x$prob_distribution, "distcrete")) {
    out <- x$prob_distribution$p(q)
    if (log) out <- log(out)
  } else {
    out <- distributional::cdf(x$prob_distribution, q = q, ..., log = log)
  }
  if (is.atomic(out)) {
    return(out)
  }
  return(unlist(out, recursive = FALSE))
}

#' @rdname epiparameter_distribution_functions
#' @importFrom stats quantile
#' @export
quantile.epiparameter <- function(x, p, ...) {
  if (isFALSE(is_parameterised(x))) {
    stop("<epiparameter> is unparameterised", call. = FALSE)
  }
  if (inherits(x$prob_distribution, "distcrete")) {
    out <- x$prob_distribution$q(p)
  } else {
    out <- stats::quantile(x$prob_distribution, p = p)
  }
  if (is.atomic(out)) {
    return(out)
  }
  return(unlist(out, recursive = FALSE))
}

#' @importFrom distributional generate
#' @export
distributional::generate

#' @rdname epiparameter_distribution_functions
#' @importFrom distributional generate
#' @export
generate.epiparameter <- function(x, times, ...) {
  if (isFALSE(is_parameterised(x))) {
    stop("<epiparameter> is unparameterised", call. = FALSE)
  }
  # check times is a single number for consistent behaviour
  checkmate::assert_number(times)
  if (inherits(x$prob_distribution, "distcrete")) {
    unlist <- length(x$prob_distribution) == 1
    out <- x$prob_distribution$r(n = times)
    out <- if (unlist) unlist(out, recursive = FALSE) else out
  } else {
    recursive <- length(x$prob_distribution) == 1
    out <- distributional::generate(x$prob_distribution, times = times)
    out <- unlist(out, recursive = recursive)
  }
  out
}

#' Discretises a continuous distribution in an `<epiparameter>` object
#'
#' @details Converts the S3 distribution object in an `<epiparameter>` from
#' continuous (using an object from the `{distributional}` package) to a
#' discretised distribution (using an object from the `{distcrete}` package).
#'
#' @inheritParams print.epiparameter
#' @param ... [dots] Extra arguments to be passed to the method.
#'
#' @inherit epiparameter return
#' @export
#'
#' @examples
#' ebola_incubation <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "incubation_period",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#' discretise(ebola_incubation)
discretise <- function(x, ...) {
  UseMethod("discretise")
}

#' @rdname discretise
#' @export
discretize <- discretise

#' @rdname discretise
#' @export
discretise.epiparameter <- function(x, ...) {
  # check if distribution is already discretised if so return early
  if (inherits(x$prob_distribution, "distcrete")) {
    message("Distribution in `epiparameter` is already discretised")
    return(x)
  } else {
    # extract prob dist and prob dist parameters from epiparameter
    prob_dist <- family(x)
    if (prob_dist == "mixture") {
      warning(
        "<epiparameter> object with mixture distributions cannot be ",
        "discretised.\n Returning undiscretised <epiparameter>.",
        call. = FALSE
      )
      return(x)
    }
    prob_dist_params <- get_parameters(x)

    # if distribution is truncated take only parameters
    if (is_truncated(x)) {
      warning(
        "Discretising a truncated continuous distribution, ",
        "returning non-truncated discretised distribution",
        call. = FALSE
      )

      idx <- grep(
        pattern = "lower|upper",
        x = names(prob_dist_params),
        ignore.case = TRUE
      )
      prob_dist_params <- prob_dist_params[-idx]

      # get underlying distribution family that's truncated
      prob_dist <- .distributional_family(x$prob_distribution)
    }

    # standardise distribution parameter names
    prob_dist_params <- .clean_params(
      prob_distribution = prob_dist,
      prob_distribution_params = prob_dist_params
    )

    # create a new discretised probability distribution
    x$prob_distribution <- create_prob_distribution(
      prob_distribution = prob_dist,
      prob_distribution_params = prob_dist_params,
      discretise = TRUE,
      truncation = NA
    )
  }

  # return epiparameter
  x
}

#' @rdname discretise
#' @export
discretise.default <- function(x, ...) {
  stop("No discretise method defined for class ", class(x))
}

#' Family method for the `<epiparameter>` class
#'
#' @description The [family()] function is used to extract the distribution
#' names from objects from `{distributional}` and `{distcrete}`. This method
#' provides the same interface for `<epiparameter>` objects to give consistent
#' output irrespective of the internal distribution class.
#'
#' @param object An `<epiparameter>` object.
#' @inheritParams stats::family
#' @param base_dist A boolean `logical` for whether to return the name of a
#' transformed distribution (e.g. `"mixture"` or `"truncated"`) or the
#' underlying distribution type (e.g. `"gamma"` or `"lnorm"`). Default is
#' `FALSE`.
#'
#' @return A character string with the name of the distribution, or `NA` when
#' the `<epiparameter>` object is unparameterised.
#' @importFrom stats family
#' @export
#'
#' @examples
#' # example with continuous distribution
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "incubation_period",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#' family(ep)
#'
#' # example with discretised distribution
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "incubation_period",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "lnorm",
#'     prob_distribution_params = c(meanlog = 1, sdlog = 1),
#'     discretise = TRUE
#'   )
#' )
#' family(ep)
family.epiparameter <- function(object, ..., base_dist = FALSE) {
  checkmate::assert_logical(base_dist, any.missing = FALSE, len = 1)
  if (inherits(object$prob_distribution, "distcrete"))
    return(object$prob_distribution$name)

  if (inherits(object$prob_distribution, "distribution"))
    return(.distributional_family(object$prob_distribution, base_dist))

  if (is.character(object$prob_distribution))
    return(object$prob_distribution)

  # return NA when not <distcrete>, <distribution> or character
  return(NA)
}

#' Check if distribution in `<epiparameter>` is truncated
#'
#' @details The `<epiparameter>` class can hold probability distribution objects
#' from the `{distributional}` package or the `{distcrete}` package,
#' however, only distribution objects from `{distributional}` can be truncated.
#' If a `<epiparameter>` object has a `<distcrete>` object `is_truncated` will
#' return `FALSE` by default.
#'
#' @inheritParams print.epiparameter
#'
#' @return A boolean `logical`.
#' @export
#'
#' @examples
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "incubation_period",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "lnorm",
#'     prob_distribution_params = c(meanlog = 1, sdlog = 1)
#'   )
#' )
#' is_truncated(ep)
#'
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "incubation_period",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "lnorm",
#'     prob_distribution_params = c(meanlog = 1, sdlog = 1),
#'     truncation = 10
#'   )
#' )
#' is_truncated(ep)
is_truncated <- function(x) {
  stopifnot(
    "is_truncated only works for `<epiparameter> objects`" =
      is_epiparameter(x)
  )
  return(identical(family(x), "truncated"))
}

#' Check if distribution in `<epiparameter>` is continuous
#'
#' @details The `<epiparameter>` class can hold `<distribution>` and
#' `<distcrete>` probability distribution objects from the \pkg{distributional}
#' package and the \pkg{distcrete} package, respectively. `<distribution>`
#' objects can be continuous or discrete distributions (e.g. gamma or negative
#' binomial), and all `<distcrete>` objects are discrete.
#'
#' @inheritParams print.epiparameter
#'
#' @return A boolean `logical`.
#' @export
#'
#' @examples
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "incubation_period",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "lnorm",
#'     prob_distribution_params = c(meanlog = 1, sdlog = 1)
#'   )
#' )
#' is_continuous(ep)
#' is_continuous(discretise(ep))
#'
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "offspring distribution",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "nbinom",
#'     prob_distribution_params = c(mean = 2, dispersion = 0.5)
#'   )
#' )
#' is_continuous(ep)
is_continuous <- function(x) {
  stopifnot(
    "is_continuous only works for `<epiparameter> objects`" =
      is_epiparameter(x)
  )
  # get individual distributions out of mixture to check if continuous
  # isTRUE to control for family returning NA for unparameterised
  if (isTRUE(family(x) == "mixture")) {
    fam <- .distributional_family(x$prob_distribution)
  } else {
    fam <- family(x)
  }

  all(fam %in% c("gamma", "lnorm", "weibull", "normal")) &&
    !inherits(x$prob_distribution, "distcrete")
}

#' Mean method for `<epiparameter>` class
#'
#' @inheritParams print.epiparameter
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @return A `numeric` mean of a distribution or `NA`.
#' @export
#'
#' @examples
#' ep <- epiparameter_db(
#'   disease = "COVID-19",
#'   epi_name = "incubation period",
#'   single_epiparameter = TRUE
#' )
#' mean(ep)
mean.epiparameter <- function(x, ...) {
  chkDots(...)
  # extract mean if given
  if (utils::hasName(x$summary_stats, "mean")) {
    mean <- x$summary_stats$mean
  } else {
    return(NA_real_)
  }

  # if mean is not given try and convert from parameters
  if (is.na(mean) && is_parameterised(x)) {
    dist <- family(x)
    params <- get_parameters(x)
    args <- c(dist, as.list(params))
    summary_stats <- do.call(convert_params_to_summary_stats, args = args)
    mean <- summary_stats$mean
  }

  # return mean or NA
  mean
}

#' [c()] method for `<epiparameter>` class
#'
#' @param ... [dots] Objects to be concatenated.
#'
#' @return An `<epiparameter>` or list of `<epiparameter>` objects.
#' @export
#'
#' @examples
#' db <- epiparameter_db()
#'
#' # combine two <epiparameter> objects into a list
#' c(db[[1]], db[[2]])
#'
#' # combine a list of <epiparameter> objects and a single <epiparameter> object
#' c(db, db[[1]])
c.epiparameter <- function(...) {
  x <- list(...)
  if (!all(vapply(x, FUN = inherits, FUN.VALUE = logical(1),
                  what = c("epiparameter", "multi_epiparameter")))) {
    stop(
      "Can only combine <epiparameter> or <multi_epiparameter> objects",
      call. = FALSE
    )
  }

  # if <multi_epiparameter> are in `...` build the new unnested list of
  # <epiparameter> objects iteratively in order to preserve input order
  if (any(vapply(x, FUN = inherits, FUN.VALUE = logical(1),
                 what = "multi_epiparameter"))) {
    # list is not pre-allocated as it's easier to append arbitrary length
    # <multi_epiparameter> objects
    ep_list <- list()
    for (i in seq_along(x)) {
      if (is_epiparameter(x[[i]])) {
        ep_list <- c(ep_list, list(x[[i]]))
      } else {
        # unclass to prevent recursive dispatch
        ep_list <- c(ep_list, unclass(x[[i]]))
      }
    }
  } else {
    ep_list <- x
  }

  # for when `...` is a single <epiparameter>
  if (length(ep_list) == 1) {
    ep_list <- ep_list[[1]]
  } else {
    # will always be triggered if called from c.multi_epiparameter
    class(ep_list) <- "multi_epiparameter"
  }
  ep_list
}

#' @rdname c.epiparameter
#' @export
c.multi_epiparameter <- function(...) {
  c.epiparameter(...)
}
