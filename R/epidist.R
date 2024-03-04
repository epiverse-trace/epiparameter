#' Constructor for `<epidist>` class
#'
#' @description Create an `<epidist>` object. The
#' constructor will search whether parameters of the probability distribution
#' are supplied and if not look to see whether they can be inferred/extracted/
#' converted from summary statistics provided. It will also convert the
#' probability distribution (`prob_dist`) and its parameters
#' (`prob_dist_params`) into an S3 class, either a `distribution` object from
#' `{distributional}` when `discretise = FALSE`, or a `distcrete` object from
#' `{distcrete}` when `discretise = TRUE`.
#'
#' @param disease A list containing the `$disease` a `character` string of the
#' infectious disease specified in the study, and the `$pathogen` a `character`
#' string. If the pathogen is unknown it can be given as `NULL`.
#' @param prob_dist A character string specifying the probability
#' distribution. This should match the R naming convention of probability
#' distributions (e.g. lognormal is lnorm, negative binomial is nbinom, and
#' geometric is geom).
#' @param prob_dist_params A named vector of probability distribution
#' parameters.
#' @inheritParams epidist
#'
#' @inherit epidist return
#' @keywords internal
#'
#' @examples
#' epiparameter:::new_epidist(
#'   disease = list(disease = "ebola", pathogen = "ebola_virus"),
#'   epi_dist = "incubation_period",
#'   prob_dist = "gamma",
#'   prob_dist_params = c(shape = 1, scale = 1),
#'   uncertainty = create_epidist_uncertainty(),
#'   summary_stats = create_epidist_summary_stats(),
#'   auto_calc_params = TRUE,
#'   citation = create_epidist_citation(),
#'   metadata = create_epidist_metadata(),
#'   method_assess = create_epidist_method_assess(),
#'   discretise = FALSE,
#'   truncation = NA,
#'   notes = "No notes"
#' )
new_epidist <- function(disease = list(),
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
                        notes = character()) {
  # check ci has been given for each param and param and uncertainty names match
  stopifnot(
    "uncertainty must be provided for each parameter" =
      anyNA(uncertainty) ||
        length(prob_dist_params) == length(uncertainty),
    "parameters and uncertainty must be named and match" =
      anyNA(uncertainty) ||
        identical(names(prob_dist_params), names(uncertainty))
  )

  # include mean in prob_dist_params
  if (!is.null(summary_stats$mean) && !is.na(summary_stats$mean)) {
    prob_dist_params <- c(
      prob_dist_params[!is.na(prob_dist_params)],
      mean = summary_stats$mean
    )
  }

  if (is_epidist_params(prob_dist, prob_dist_params)) {
    # standardise common distribution parameters
    class(prob_dist_params) <- prob_dist
    prob_dist_params <- clean_epidist_params(
      prob_dist_params = prob_dist_params
    )
  } else if (auto_calc_params) {
    # calculate parameters if not provided
    prob_dist_params <- calc_dist_params(
      prob_dist = prob_dist,
      prob_dist_params = prob_dist_params,
      summary_stats = summary_stats,
      sample_size = metadata$sample_size
    )
  }

  if (anyNA(prob_dist_params)) {
    message("Unparameterised <epidist> object")
  } else {
    # create a S3 object holding the probability distribution
    prob_dist <- create_prob_dist(
      prob_dist = prob_dist,
      prob_dist_params = prob_dist_params,
      discretise = discretise,
      truncation = truncation
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

  # create and return epidist class
  structure(
    list(
      disease = disease,
      epi_dist = epi_dist,
      prob_dist = prob_dist,
      uncertainty = uncertainty,
      summary_stats = summary_stats,
      citation = citation,
      metadata = metadata,
      method_assess = method_assess,
      notes = notes
    ),
    class = "epidist",
    .epiparameter_namespace = .epiparameter_namespace
  )
}

# Load {epiparameter} namespace when using <epidist> (incl. serialised objects)
.epiparameter_namespace <- function() NULL

#' Create an `<epidist>` object
#'
#' @description The `<epidist>` class is used to store epidemiological
#' parameters for a single disease. These epidemiological parameters cover a
#' variety of aspects including delay distributions (e.g. incubation periods
#' and serial intervals, among others) and offspring distributions.
#'
#' The `<epidist>` object is the functional unit provided by `{epiparameter}` to
#' plug into epidemiological pipelines. Obtaining an `<epidist>` object can be
#' achieved in two main ways:
#' 1. The epidemiological distribution is stored in
#' the `{epiparameter}` library and can be accessed by [epidist_db()].
#' 2. The alternative method is when you have information
#' (e.g. disease and distribution parameter estimates) and would like to input
#' this into an `<epidist>` object in order to work in existing analysis
#' pipelines. This is where the `epidist()` function can be used to fill out
#' each field for which information is known.
#'
#' @details Accepted `<epidist>` distribution parameterisations are:
#' - Gamma must be either 'shape' and 'scale' or 'shape' and 'rate'
#' - Weibull must be 'shape' and 'scale'
#' - Lognormal must be 'meanlog' and 'sdlog' or 'mu' and 'sigma'
#' - Negative Binomial must be either 'mean' and 'dispersion' or 'n' and 'p'
#' - Geometric must be either 'mean' or 'prob'
#' - Poisson must be 'mean'
#'
#' @param disease A `character` string with name of the infectious disease.
#' @param pathogen A `character` string with the name of the causative agent of
#' disease, or NULL if not known.
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
#' estimates is unknown use [create_epidist_uncertainty()] (which is the
#' argument default) to create a list with the correct names with missing
#' values.
#' @param summary_stats A list of summary statistics, use
#' [create_epidist_summary_stats()] to create list. This list can include
#' summary statistics about the inferred distribution such as it's mean and
#' standard deviation, quantiles of the distribution, or information about the
#' data used to fit the distribution such as lower and upper range. The summary
#' statistics can also include uncertainty around metrics such as confidence
#' interval around mean and standard deviation.
#' @param auto_calc_params A boolean `logical` determining whether to try and
#' calculate the probability distribution parameters from summary statistics if
#' distribution parameters are not provided. Default is `TRUE`. In the case when
#' sufficient summary statistics are provided and the parameter(s) of the
#' distribution are not, the [calc_dist_params()] function is called to
#' calculate the parameters and add them to the `epidist` object created.
#' @param citation A `character` string with the citation of the source of the
#' data or the paper that inferred the distribution parameters, use
#' `create_epidist_citation()` to create citation.
#' @param metadata A list of metadata, this can include: sample size, the
#' transmission mode of the disease (e.g. is it vector-borne or directly
#' transmitted), etc. It is assumed that the disease is not
#' vector-borne and that the distribution is intrinsic (e.g. not an extrinsic
#' delay distribution such as extrinsic incubation period) unless
#' `transmission_mode = "vector_borne"` is contained in the metadata. Use
#' `create_epidist_metadata()` to create metadata.
#' @param method_assess A list of methodological aspects used when fitting
#' the distribution, use `create_epidist_method_assess()` to create method
#' assessment.
#' @param discretise A boolean `logical` whether the distribution is
#' discretised.
#' Default is FALSE which assumes a continuous probability distribution
#' @param truncation A `numeric` specifying the truncation point if the inferred
#' distribution was truncated, `NA` if not or unknown.
#' @param notes A `character` string with any additional information about the
#' data, inference method or disease.
#'
#' @return An `<epidist>` object.
#' @export
#'
#' @examples
#' # minimal input required for `epidist`
#' ebola_incubation <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#'
#' # minimal input required for discrete `epidist`
#' ebola_incubation <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1),
#'   discretise = TRUE
#' )
#'
#' # example with more fields filled in
#' ebola_incubation <- epidist(
#'   disease = "ebola",
#'   pathogen = "ebola_virus",
#'   epi_dist = "incubation",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1),
#'   uncertainty = create_epidist_uncertainty(),
#'   summary_stats = create_epidist_summary_stats(
#'     mean = 2,
#'     sd = 1
#'   ),
#'   citation = create_epidist_citation(
#'     author = person(given = "John", family = "Smith"),
#'     year = 2002,
#'     title = "COVID-19 incubation period",
#'     journal = "Epi Journal",
#'     DOI = "10.19832/j.1366-9516.2012.09147.x"
#'   ),
#'   metadata = create_epidist_metadata(
#'     sample_size = 10,
#'     region = "UK",
#'     transmission_mode = "natural_human_to_human",
#'     inference_method = "MLE"
#'   ),
#'   method_assess = create_epidist_method_assess(
#'     censored = TRUE
#'   ),
#'   discretise = FALSE,
#'   truncation = NA,
#'   notes = "No notes"
#' )
epidist <- function(disease,
                    pathogen = NA_character_,
                    epi_dist,
                    prob_distribution = NA_character_,
                    prob_distribution_params = NA_real_,
                    uncertainty = create_epidist_uncertainty(),
                    summary_stats = create_epidist_summary_stats(),
                    auto_calc_params = TRUE,
                    citation = create_epidist_citation(),
                    metadata = create_epidist_metadata(),
                    method_assess = create_epidist_method_assess(),
                    discretise = FALSE,
                    truncation = NA_real_,
                    notes = NULL) {
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

  # call epidist constructor
  epidist <- new_epidist(
    disease = list(
      disease = disease,
      pathogen = pathogen
    ),
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
    notes = notes
  )

  # call epidist validator
  validate_epidist(epidist = epidist)

  # return epidist object
  epidist
}

#' Validator for `<epidist>` class
#'
#' @param epidist An `<epidist>` object
#'
#' @return Invisibly returns an `<epidist>`. Called for side-effects (errors
#' when invalid `<epidist>` object is provided).
#'
#' @export
validate_epidist <- function(epidist) {
  if (!is_epidist(epidist)) {
    stop("Object should be of class epidist", call. = FALSE)
  }

  # check for class invariants
  stopifnot(
    "epidist object does not contain the correct attributes" =
      c(
        "disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
        "citation", "metadata", "method_assess", "notes"
      ) %in%
        attributes(epidist)$names,
    "epidist must contain a disease (single character string)" =
    checkmate::test_string(epidist$disease$disease),
    "epidist must contain an epidemiological distribution" =
      checkmate::test_string(epidist$epi_dist),
    "epidist must contain a <distribution> or <distcrete> distribution or NA" =
    checkmate::test_multi_class(
      epidist$prob_dist, classes = c("distribution", "distcrete")
    ) || checkmate::test_string(epidist$prob_dist, na.ok = TRUE),
    "epidisit must contain uncertainty, summary stats and metadata" =
      all(
        is.list(epidist$uncertainty),
        is.list(epidist$summary_stats),
        is.list(epidist$metadata)
      ),
    "epidist must contain a citation" =
      inherits(epidist$citation, "bibentry"),
    "epidist notes must be a character string" =
      checkmate::test_string(epidist$notes)
  )

  invisible(epidist)
}

#' Print method for `<epidist>` class
#'
#' @param x An `<epidist>` object.
#' @param header Boolean `logical` determining whether the header (first part)
#' of the print method is printed. This is used internally for plotting the
#' `<vb_epidist>` class.
#' @param vb A `character` string containing whether it is the intrinsic
#' (`"Intrinsic"`) or extrinsic (`"Extrinsic"`) distribution for vector-borne
#' diseases.
#' @param ... [dots] Extra arguments to be passed to the method.
#'
#' @return Invisibly returns an `<epidist>`. Called for side-effects.
#' @export
#'
#' @examples
#' epidist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#' epidist
print.epidist <- function(x, header = TRUE, vb = NULL, ...) {
  format(x, header = header, vb = vb, ...)
}

#' Format method for `<epidist>` class
#'
#' @inheritParams print.epidist
#' @param header Boolean logical determining whether the header (first part) of
#' the print method is printed. This is used internally for plotting the
#' vb_epidist class
#' @param vb Either NULL (default) or a character string of either "Intrinsic"
#' or "Extrinsic" which is used internally for plotting the vb_epidist class
#'
#' @return Invisibly returns an `<epidist>`. Called for printing side-effects.
#' @export
#'
#' @examples
#' epidist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#' format(epidist)
format.epidist <- function(x, header = TRUE, vb = NULL, ...) {
  if (header) {
    writeLines(
      c(
        sprintf("Disease: %s", x$disease$disease),
        sprintf("Pathogen: %s", x$disease$pathogen),
        sprintf("Epi Distribution: %s", .clean_string(x$epi_dist)),
        sprintf("Study: %s", format(x$citation))
      )
    )
  }

  if (!is.null(vb)) {
    writeLines(sprintf(vb))
  }

  if (is.object(x$prob_dist) || is.character(x$prob_dist)) {
    dist_string <- ifelse(
      test = inherits(x$prob_dist, "distcrete"),
      yes = "Distribution: discrete %s",
      no = "Distribution: %s"
    )
    writeLines(sprintf(dist_string, family(x)))
  } else {
    writeLines(sprintf("Parameters: <no parameters>"))
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
        sprintf("Parameters:"),
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

#' Plot method for `<epidist>` class
#'
#' @description Plot an `<epidist>` object by displaying the either the
#' probability mass function (PMF), (in the case of discrete distributions)
#' or probability density function (PDF) (in the case of continuous
#' distributions) and the cumulative distribution function (CDF). Resulting in
#' a 1x2 grid plot.
#'
#' @param x An `<epidist>` object.
#' @param day_range A vector with the sequence of days to be plotted on the
#' x-axis of the distribution.
#' @param vb A boolean logical determining whether the `epidist` being plotted
#' has come from a `vb_epidist` object.
#' @param title Either a character string or `NULL`. If not null the character
#' string will be printed as a title to the plot.
#' @inheritParams base::print
#'
#' @author Joshua W. Lambert
#' @export
#'
#' @examples
#' # plot continuous epidist
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 2, scale = 1)
#' )
#'
#' plot(edist, day_range = 0:10)

#' # plot discrete epidist
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 2, scale = 1),
#'   discretise = TRUE
#' )
#'
#' plot(edist, day_range = 0:10)
plot.epidist <- function(x, day_range = 0:10, ..., vb = FALSE, title = NULL) {
  # check input
  validate_epidist(x)
  checkmate::assert_numeric(day_range, min.len = 2)

  if (isFALSE(vb)) {
    oldpar <- graphics::par(no.readonly = TRUE)
    on.exit(graphics::par(oldpar))
    # set plotting parameters to plot on a 2x2 grid
    graphics::par(mfrow = c(1, 2), mar = c(4, 3, 3, 1), oma = c(0, 0, 0, 0))
  }

  if (inherits(x$prob_dist, "distcrete")) {
    main <- "Probability Mass Function"
  } else {
    main <- "Probability Density Function"
  }

  # plot either PDF or PMF
  plot(
    day_range,
    stats::density(x, at = day_range),
    ylab = "",
    xlab = "Time since infection",
    type = "b",
    pch = 16,
    main = main,
    ...
  )

  # plot CDF
  plot(
    day_range,
    distributional::cdf(x, q = day_range),
    ylab = "",
    xlab = "Time since infection",
    type = "b",
    pch = 16,
    ylim = c(0, 1),
    main = "Cumulative Distribution Function",
    ...
  )

  if (!is.null(title)) {
    if (grepl(pattern = "intrinsic", x = title, ignore.case = TRUE)) {
      line <- -1
    } else {
      line <- -15
    }
    # add a plot title
    graphics::title(title, outer = TRUE, line = line)
  }
}

#' Check object is an `<epidist>`
#'
#' @param x An \R object.
#'
#' @return A boolean logical, `TRUE` if the object is an `<epidist>` and `FALSE`
#' if not.
#' @export
#'
#' @examples
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "serial_interval",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#'
#' is_epidist(edist)
#'
#' false_edist <- list(
#'   disease = "ebola",
#'   epi_dist = "serial_interval",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#'
#' is_epidist(false_edist)
is_epidist <- function(x) {
  inherits(x, "epidist")
}

#' PDF, CDF, PMF, quantiles and random number generation for `<epidist>` and
#' `<vb_epidist>` objects
#'
#' @description The `<epidist>` object holds a probability distribution which
#' can either be a continuous or discrete distribution. These are the density,
#' cumulative distribution, quantile and random number generation functions.
#' These operate on any distribution that can be included in an `<epidist>`
#' object.
#'
#' @param x An `<epidist>` or `<vb_epidist>` object.
#' @param at The quantiles to evaluate at.
#' @param q The quantiles to evaluate at.
#' @param p The probabilities to evaluate at.
#' @param times The number of random samples.
#' @inheritParams print.epidist
#' @inheritParams distributional::cdf
#'
#' @return If an `<epidist>` object is given a numeric vector is returned, if an
#' `<vb_epidist>` object is given a list of two elements each with a numeric
#' vector is returned.
#'
#' @name epidist_distribution_functions
#' @keywords epidist_distribution_functions
#'
#' @examples
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#'
#' # example of each distribution method for an `epidist` object
#' stats::density(edist, at = 1)
#' distributional::cdf(edist, q = 1)
#' stats::quantile(edist, p = 0.2)
#' distributional::generate(edist, times = 10)
#'
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
#' # example of each distribution method for an `vb_epidist` object
#' stats::density(vb_edist, at = 1)
#' distributional::cdf(vb_edist, q = 1)
#' stats::quantile(vb_edist, p = 0.2)
#' distributional::generate(vb_edist, times = 10)
NULL

#' @rdname epidist_distribution_functions
#' @importFrom stats density
#' @export
density.epidist <- function(x, at, ...) {
  if (isFALSE(is_parameterised(x))) {
    stop("<epidist> is unparameterised", call. = FALSE)
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

#' @rdname epidist_distribution_functions
#' @importFrom distributional cdf
#' @export
cdf.epidist <- function(x, q, ..., log = FALSE) {
  if (isFALSE(is_parameterised(x))) {
    stop("<epidist> is unparameterised", call. = FALSE)
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

#' @rdname epidist_distribution_functions
#' @importFrom stats quantile
#' @export
quantile.epidist <- function(x, p, ...) {
  if (isFALSE(is_parameterised(x))) {
    stop("<epidist> is unparameterised", call. = FALSE)
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

#' @rdname epidist_distribution_functions
#' @importFrom distributional generate
#' @export
generate.epidist <- function(x, times, ...) {
  if (isFALSE(is_parameterised(x))) {
    stop("<epidist> is unparameterised", call. = FALSE)
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

#' Discretises a continuous distribution in an `<epidist>` object
#'
#' @details Converts the S3 distribution object in an `<epidist>` from
#' continuous (using an object from the `{distributional}` package) to a
#' discretised distribution (using an object from the `{distcrete}` package).
#'
#' @inheritParams print.epidist
#' @param ... [dots] Extra arguments to be passed to the method.
#'
#' @inherit epidist return
#' @export
#'
#' @examples
#' ebola_incubation <- epidist(
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
discretise.epidist <- function(x, ...) {
  # check if distribution is already discretised if so return early
  if (inherits(x$prob_dist, "distcrete")) {
    message("Distribution in `epidist` is already discretised")
    return(x)
  } else {
    # extract prob dist and prob dist parameters from epidist
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
    class(prob_dist_params) <- prob_dist
    prob_dist_params <- clean_epidist_params(
      prob_dist_params = prob_dist_params
    )

    # create a new discretised probability distribution
    x$prob_dist <- create_prob_dist(
      prob_dist = prob_dist,
      prob_dist_params = prob_dist_params,
      discretise = TRUE,
      truncation = NA
    )
  }

  # return epidist
  x
}

#' @rdname discretise
#' @export
discretise.default <- function(x, ...) {
  stop("No discretise method defined for class ", class(x))
}

#' Family method for the `<epidist>` class
#'
#' @description The [family()] function is used to extract the distribution
#' names from objects from `{distributional}` and `{distcrete}`. This method
#' provides the same interface for `<epidist>` objects to give consistent
#' output irrespective of the internal distribution class.
#'
#' @param object An `<epidist>` object.
#' @inheritParams stats::family
#'
#' @return A character string with the name of the distribution, or `NA` when
#' the `<epidist>` object is unparameterised.
#' @importFrom stats family
#' @export
#'
#' @examples
#' # example with continuous distribution
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#' family(edist)
#'
#' # example with discretised distribution
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "lnorm",
#'   prob_distribution_params = c(meanlog = 1, sdlog = 1),
#'   discretise = TRUE
#' )
#' family(edist)
family.epidist <- function(object, ...) {
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
    prob_dist
  )

  # return prob dist
  prob_dist
}

#' Check if distribution in `<epidist>` is truncated
#'
#' @details The `<epidist>` class can hold probability distribution objects
#' from the `{distributional}` package or the `{distcrete}` package,
#' however, only distribution objects from `{distributional}` can be truncated.
#' If a `<epidist>` object has a `<distcrete>` object `is_truncated` will
#' return `FALSE` by default.
#'
#' @inheritParams print.epidist
#'
#' @return A boolean `logical`.
#' @export
#'
#' @examples
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "lnorm",
#'   prob_distribution_params = c(meanlog = 1, sdlog = 1)
#' )
#' is_truncated(edist)
#'
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "lnorm",
#'   prob_distribution_params = c(meanlog = 1, sdlog = 1),
#'   truncation = 10
#' )
#' is_truncated(edist)
is_truncated <- function(x) {
  stopifnot(
    "is_truncated only works for `<epidist> objects`" =
      is_epidist(x)
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

#' Mean method for `<epidist>` class
#'
#' @inheritParams print.epidist
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @return A `numeric` mean of a distribution or `NA`.
#' @export
#'
#' @examples
#' edist <- epidist_db(
#'   disease = "COVID-19",
#'   epi_dist = "incubation period",
#'   single_epidist = TRUE
#' )
#' mean(edist)
mean.epidist <- function(x, ...) {
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

#' `as.function()` method for `<epidist>` class
#'
#' @description Converts an `<epidist>` object to a distribution function
#' (see [epidist_distribution_functions]), either probability density/mass
#' function, (`density`), cumulative distribution function (`cdf`), random
#' number generator (`generate`), or quantile (`quantile`).
#'
#' @details The function returned takes a single required argument `x`.
#'
#' @inheritParams print.epidist
#' @inheritParams base::as.function
#' @param func_type A single `character` string specifying which distribution to
#' convert `<epidist>` object into. Default is `"density"`. Other options are
#' `"cdf"`, `"generate"`, or `"quantile"`.
#'
#' @return A [function] object.
#' @export
as.function.epidist <- function(x,
                                func_type = c(
                                  "density", "cdf", "generate", "quantile"
                                ),
                                ...) {
  chkDots(...)
  func_type <- match.arg(func_type)
  if (!is_parameterised(x)) {
    stop(
      "Cannot convert unparameterised <epidist> to distribution function",
      call. = FALSE
    )
  }
  epidist <- x
  x <- switch(func_type,
    density = function(x) density(x = epidist, at = x),
    cdf = function(x) epiparameter::cdf(x = epidist, q = x),
    generate = function(x) epiparameter::generate(x = epidist, times = x),
    quantile = function(x) quantile(x = epidist, p = x)
  )

  # return distribution function
  x
}
