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
#' @param prob_dist A character string specifying the probability
#' distribution. This should match the R naming convention of probability
#' distributions (e.g. lognormal is `lnorm`, negative binomial is `nbinom`, and
#' geometric is `geom`).
#' @param prob_dist_params A named vector of probability distribution
#' parameters.
#' @inheritParams epiparameter
#'
#' @inherit epiparameter return
#' @keywords internal
new_epiparameter <- function(disease = character(),
                             pathogen = character(),
                             epi_dist = character(),
                             prob_dist = list(),
                             prob_dist_params = numeric(),
                             uncertainty = list(),
                             summary_stats = list(),
                             auto_calc_params = logical(),
                             citation = character(),
                             metadata = list(),
                             method_assess = list(),
                             discretise = logical(),
                             truncation = numeric(),
                             notes = character(),
                             ...) {
  # check ci has been given for each param and param and uncertainty names match
  stopifnot(
    "uncertainty must be provided for each parameter" =
      anyNA(uncertainty) ||
      length(prob_dist_params) == length(uncertainty),
    "parameters and uncertainty must be named and match" =
      anyNA(uncertainty) ||
      identical(names(prob_dist_params), names(uncertainty))
  )

  # set string to lowercase for downstream case sensitive matching of prob_dist
  prob_dist <- ifelse(
    test = is.character(prob_dist),
    yes = .clean_string(prob_dist),
    no = prob_dist
  )

  # TODO: formalise if statement below or remove
  # include mean in prob_dist_params
  if (!is.null(summary_stats$mean) && !is.na(summary_stats$mean) &&
      prob_dist %in% c("nbinom", "geom", "pois", "norm")) {
    prob_dist_params["mean"] <- summary_stats$mean
  }

  if (is_epiparameter_params(prob_dist, prob_dist_params)) {
    # standardise common distribution parameters
    prob_dist_params <- .clean_params(
      prob_dist = prob_dist,
      prob_dist_params = prob_dist_params
    )
  } else if (auto_calc_params) {
    # calculate parameters if not provided
    prob_dist_params <- .calc_dist_params(
      prob_dist = prob_dist,
      prob_dist_params = prob_dist_params,
      summary_stats = summary_stats,
      sample_size = metadata$sample_size
    )
  }

  if (anyNA(prob_dist_params)) {
    message("Unparameterised <epiparameter> object")
  } else {
    # create a S3 object holding the probability distribution
    prob_dist <- create_prob_distribution(
      prob_distribution = prob_dist,
      prob_distribution_params = prob_dist_params,
      discretise = discretise,
      truncation = truncation,
      ...
    )
  }

  if (epi_dist == "offspring_distribution") {
    method_assess <- paste(
      "There is currently no method assessment for offspring distributions",
      "stored in epiparameter"
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
      epi_dist = epi_dist,
      prob_dist = prob_dist,
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
#' @param epi_dist A `character` string with the name of the
#' epidemiological distribution type.
#' @param prob_distribution A `character` string specifying the probability
#' distribution. This should match the \R naming convention of probability
#' distributions (e.g. lognormal is `lnorm`, negative binomial is `nbinom`, and
#' geometric is `geom`).
#' @param prob_distribution_params A named vector of probability distribution
#' parameters.
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
#' @param metadata A list of metadata, this can include: sample size, the
#' transmission mode of the disease (e.g. is it vector-borne or directly
#' transmitted), etc. It is assumed that the disease is not
#' vector-borne and that the distribution is intrinsic (e.g. not an extrinsic
#' delay distribution such as extrinsic incubation period) unless
#' `transmission_mode = "vector_borne"` is contained in the metadata. Use
#' [create_metadata()] to create metadata.
#' @param method_assess A list of methodological aspects used when fitting
#' the distribution, use [create_method_assess()] to create method
#' assessment.
#' @param discretise A boolean `logical` whether the distribution is
#' discretised.
#' Default is FALSE which assumes a continuous probability distribution
#' @param truncation A `numeric` specifying the truncation point if the inferred
#' distribution was truncated, `NA` if not or unknown.
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
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#'
#' # minimal input required for discrete `epiparameter`
#' ebola_incubation <- epiparameter(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1),
#'   discretise = TRUE
#' )
#'
#' # example with more fields filled in
#' ebola_incubation <- epiparameter(
#'   disease = "ebola",
#'   pathogen = "ebola_virus",
#'   epi_dist = "incubation",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1),
#'   uncertainty = create_uncertainty(),
#'   summary_stats = create_summary_stats(mean = 2, sd = 1),
#'   citation = create_citation(
#'     author = person(given = "John", family = "Smith"),
#'     year = 2002,
#'     title = "COVID-19 incubation period",
#'     journal = "Epi Journal",
#'     doi = "10.19832/j.1366-9516.2012.09147.x"
#'   ),
#'   metadata = create_metadata(
#'     sample_size = 10,
#'     region = "UK",
#'     transmission_mode = "natural_human_to_human",
#'     inference_method = "MLE"
#'   ),
#'   method_assess = create_method_assess(
#'     censored = TRUE
#'   ),
#'   discretise = FALSE,
#'   truncation = NA,
#'   notes = "No notes"
#' )
epiparameter <- function(disease,
                         pathogen = NA_character_,
                         epi_dist,
                         prob_distribution = NA_character_,
                         prob_distribution_params = NA_real_,
                         uncertainty = create_uncertainty(),
                         summary_stats = create_summary_stats(),
                         auto_calc_params = TRUE,
                         citation = create_citation(),
                         metadata = create_metadata(),
                         method_assess = create_method_assess(),
                         discretise = FALSE,
                         truncation = NA_real_,
                         notes = NULL,
                         ...) {
  # check input
  checkmate::assert_string(disease)
  checkmate::assert_character(pathogen)
  checkmate::assert_string(epi_dist)
  checkmate::assert_character(
    prob_distribution,
    min.chars = 1,
    min.len = 1,
    max.len = 2
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
  checkmate::assert_number(truncation, na.ok = TRUE)
  checkmate::assert_logical(discretise, len = 1)
  checkmate::assert_character(notes, null.ok = TRUE)

  # check whether ci has been provided for each parameter
  # check whether probability params are named or na
  stopifnot(
    "uncertainty must be provided for each parameter" =
      anyNA(uncertainty, recursive = TRUE) ||
        length(prob_distribution_params) == length(uncertainty),
    "probability distribution params must be a named vector or NA" =
      anyNA(prob_distribution_params, recursive = TRUE) ||
        !is.null(names(prob_distribution_params))
  )

  # call epiparameter constructor
  epiparameter <- new_epiparameter(
    disease = disease,
    pathogen = pathogen,
    epi_dist = epi_dist,
    prob_dist = prob_distribution,
    prob_dist_params = prob_distribution_params,
    uncertainty = uncertainty,
    summary_stats = summary_stats,
    auto_calc_params = auto_calc_params,
    citation = citation,
    metadata = metadata,
    method_assess = method_assess,
    discretise = discretise,
    truncation = truncation,
    notes = notes,
    ...
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
assert_epiparameter <- function(x) {
  if (!is_epiparameter(x)) {
    stop("Object should be of class epiparameter", call. = FALSE)
  }

  list_names <- c(
    "disease", "pathogen", "epi_dist", "prob_dist", "uncertainty",
    "summary_stats", "citation", "metadata", "method_assess", "notes"
  )
  missing_list_names <- list_names[!list_names %in% attributes(x)$names]
  if (length(missing_list_names) != 0) {
    stop(
      "Object is missing ", toString(missing_list_names), call. = FALSE
    )
  }

  # check for class invariants
  stopifnot(
    "epiparameter must contain a disease (single character string)" =
    checkmate::test_string(x$disease),
    "epiparameter must contain an epidemiological distribution" =
      checkmate::test_string(x$epi_dist),
    "epiparameter must contain a <distribution> or <distcrete> or NA" =
    checkmate::test_multi_class(
      x$prob_dist, classes = c("distribution", "distcrete")
    ) || checkmate::test_string(x$prob_dist, na.ok = TRUE),
    "epidisit must contain uncertainty, summary stats and metadata" =
      all(
        is.list(x$uncertainty), is.list(x$summary_stats), is.list(x$metadata)
      ),
    "epiparameter must contain a citation" =
      inherits(x$citation, "bibentry"),
    "epiparameter notes must be a character string" =
      checkmate::test_string(x$notes)
  )

  invisible(x)
}

#' Test whether an object is a valid `<epiparameter>` object
#'
#' @param x An \R object.
#'
#' @return A boolean `logical` whether the object is a valid `<epiparameter>`
#' object.
#' @export
test_epiparameter <- function(x) { # nolint cyclocomp_linter
  if (!is_epiparameter(x)) return(FALSE)

  list_names <- c(
    "disease", "pathogen", "epi_dist", "prob_dist", "uncertainty",
    "summary_stats", "citation", "metadata", "method_assess", "notes"
  )
  missing_list_names <- list_names[!list_names %in% attributes(x)$names]
  if (length(missing_list_names) != 0) return(FALSE)

  valid_elements <- checkmate::test_string(x$disease) &&
    checkmate::test_string(x$epi_dist) &&
    (checkmate::test_multi_class(
      x$prob_dist, classes = c("distribution", "distcrete")
    ) || checkmate::test_string(x$prob_dist, na.ok = TRUE)) &&
    all(
      is.list(x$uncertainty), is.list(x$summary_stats), is.list(x$metadata)
    ) &&
    inherits(x$citation, "bibentry") &&
    checkmate::test_string(x$notes)

  if (!valid_elements) return(FALSE)
  return(TRUE)
}

#' Print method for `<epiparameter>` class
#'
#' @param x An `<epiparameter>` object.
#' @param ... [dots] Extra arguments to be passed to the method.
#'
#' @return Invisibly returns an `<epiparameter>`. Called for side-effects.
#' @export
#'
#' @examples
#' epiparameter <- epiparameter(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#' epiparameter
print.epiparameter <- function(x, ...) {
  format(x, ...)
}

#' Format method for `<epiparameter>` class
#'
#' @inheritParams print.epiparameter
#'
#' @return Invisibly returns an `<epiparameter>`. Called for printing
#' side-effects.
#' @export
#'
#' @examples
#' epiparameter <- epiparameter(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#' format(epiparameter)
format.epiparameter <- function(x, ...) {
    writeLines(
      c(
        sprintf(tr_("Disease: %s"), x$disease),
        sprintf(tr_("Pathogen: %s"), x$pathogen),
        sprintf(tr_("Epi Distribution: %s"), .clean_string(x$epi_dist)),
        sprintf(tr_("Study: %s"), format(x$citation))
      )
    )

  if (is.object(x$prob_dist) || is.character(x$prob_dist)) {
    dist_string <- ifelse(
      test = inherits(x$prob_dist, "distcrete"),
      yes = tr_("Distribution: discrete %s"),
      no = tr_("Distribution: %s")
    )
    writeLines(sprintf(dist_string, family(x)))
  } else {
    writeLines(tr_("Parameters: <no parameters>"))
  }

  if (is.object(x$prob_dist)) {
    params <- get_parameters(x)

    # decide on parameter format from magnitude of number
    format_params <- ifelse(
      test = any(params > 9.999e-3 & params < 1e4),
      yes = "f",
      no = "g"
    )

    writeLines(
      c(
        sprintf(tr_("Parameters:")),
        sprintf(
          "  %s: %s",
          names(params),
          formatC(params, digits = 3, format = format_params)
        )
      )
    )
  }

  invisible(x)
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
#'   epi_dist = "serial_interval",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#'
#' is_epiparameter(ep)
#'
#' false_ep <- list(
#'   disease = "ebola",
#'   epi_dist = "serial_interval",
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
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
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
  unlist <- length(x$prob_dist) == 1
  if (inherits(x$prob_dist, "distcrete")) {
    out <- x$prob_dist$d(at)
  } else {
    out <- stats::density(x$prob_dist, at = at)
  }
  out <- if (unlist) unlist(out, recursive = FALSE) else out
  out
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
  unlist <- length(x$prob_dist) == 1
  if (inherits(x$prob_dist, "distcrete")) {
    out <- x$prob_dist$p(q)
    if (log) out <- log(out)
  } else {
    out <- distributional::cdf(x$prob_dist, q = q, ..., log = log)
  }
  out <- if (unlist) unlist(out, recursive = FALSE) else out
  out
}

#' @rdname epiparameter_distribution_functions
#' @importFrom stats quantile
#' @export
quantile.epiparameter <- function(x, p, ...) {
  if (isFALSE(is_parameterised(x))) {
    stop("<epiparameter> is unparameterised", call. = FALSE)
  }
  unlist <- length(x$prob_dist) == 1
  if (inherits(x$prob_dist, "distcrete")) {
    out <- x$prob_dist$q(p)
  } else {
    out <- stats::quantile(x$prob_dist, p = p)
  }
  out <- if (unlist) unlist(out, recursive = FALSE) else out
  out
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
  if (inherits(x$prob_dist, "distcrete")) {
    unlist <- length(x$prob_dist) == 1
    out <- x$prob_dist$r(n = times)
    out <- if (unlist) unlist(out, recursive = FALSE) else out
  } else {
    recursive <- length(x$prob_dist) == 1
    out <- distributional::generate(x$prob_dist, times = times)
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
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
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
  if (inherits(x$prob_dist, "distcrete")) {
    message("Distribution in `epiparameter` is already discretised")
    return(x)
  } else {
    # extract prob dist and prob dist parameters from epiparameter
    prob_dist <- family(x)
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

      # trunc dist family is truncated so get prob dist by unclassing dist and
      # extracting name
      list_dist <- unclass(x$prob_dist)
      prob_dist <- gsub(
        pattern = "dist_",
        replacement = "",
        x = class(list_dist[[1]][[1]])[1],
        fixed = TRUE
      )
    }

    # standardise distribution parameter names
    prob_dist_params <- .clean_params(
      prob_dist = prob_dist,
      prob_dist_params = prob_dist_params
    )

    # create a new discretised probability distribution
    x$prob_dist <- create_prob_distribution(
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
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#' family(ep)
#'
#' # example with discretised distribution
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "lnorm",
#'   prob_distribution_params = c(meanlog = 1, sdlog = 1),
#'   discretise = TRUE
#' )
#' family(ep)
family.epiparameter <- function(object, ...) {
  if (inherits(object$prob_dist, "distcrete")) {
    prob_dist <- object$prob_dist$name
  } else if (inherits(object$prob_dist, "distribution")) {
    if (is_truncated(object)) {
      prob_dist <- gsub(
        pattern = "dist_",
        replacement = "",
        x = class(unclass(unclass(object$prob_dist)[[1]])[[1]])[1],
        fixed = TRUE
      )
    } else {
      prob_dist <- stats::family(object$prob_dist)
    }
  } else if (is.character(object$prob_dist)) {
    prob_dist <- object$prob_dist
  } else {
    return(NA)
  }

  prob_dist <- switch(prob_dist,
    lognormal = "lnorm",
    negbin = "nbinom",
    geometric = "geom",
    poisson = "pois",
    normal = "norm",
    exponential = "exp",
    prob_dist
  )

  # return prob dist
  prob_dist
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
#'   epi_dist = "incubation_period",
#'   prob_distribution = "lnorm",
#'   prob_distribution_params = c(meanlog = 1, sdlog = 1)
#' )
#' is_truncated(ep)
#'
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "lnorm",
#'   prob_distribution_params = c(meanlog = 1, sdlog = 1),
#'   truncation = 10
#' )
#' is_truncated(ep)
is_truncated <- function(x) {
  stopifnot(
    "is_truncated only works for `<epiparameter> objects`" =
      is_epiparameter(x)
  )

  # distcrete distributions cannot be truncated
  if (inherits(x$prob_dist, "distcrete")) {
    return(FALSE)
  }

  # unparameterised objects cannot be truncated
  # dont use is_parameterised due to infinite recursion
  if (is.na(x$prob_dist) || is.character(x$prob_dist)) {
    return(FALSE)
  }

  # use stats::family instead of epiparameter::family to check truncated
  if (identical(stats::family(x$prob_dist), "truncated")) {
    return(TRUE)
  } else {
    return(FALSE)
  }
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
#'   epi_dist = "incubation_period",
#'   prob_distribution = "lnorm",
#'   prob_distribution_params = c(meanlog = 1, sdlog = 1)
#' )
#' is_continuous(ep)
#' is_continuous(discretise(ep))
#'
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_dist = "offspring distribution",
#'   prob_distribution = "nbinom",
#'   prob_distribution_params = c(mean = 2, dispersion = 0.5)
#' )
#' is_continuous(ep)
is_continuous <- function(x) {
  stopifnot(
    "is_truncated only works for `<epiparameter> objects`" =
      is_epiparameter(x)
  )
  family(x) %in% c("gamma", "lnorm", "weibull", "normal") &&
    !inherits(x$prob_dist, "distcrete")
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
#'   epi_dist = "incubation period",
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

#' @export
c.multi_epiparameter <- function(...) {
  c.epiparameter(...)
}
