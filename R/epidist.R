#' Constructor for epidist class
#'
#' @description Creates an epidist object. The
#' constructor will search whether parameters of the probability distribution
#' are supplied and if not look to see whether they can be inferred/extracted/
#' converted from summary statistics provided. It will also convert the
#' probability distribution (`prob_dist`) and its parameters
#' (`prob_dist_params`) into an S3 class, either a `distribution` object from
#' `{distributional}` when `discretise = FALSE`, or a `distcrete` object from
#' `{distcrete}` when `discretise = TRUE`.
#'
#' @param disease A list contains the `$disease` a character string of the
#' infectious disease specified in the study, and the `$pathogen` a character
#' string. If the pathogen is unknown it can be given as `NULL`.
#' @param prob_dist A character string specifying the probability
#' distribution
#' @param prob_dist_params A named vector of probability distribution
#' parameters
#' @inheritParams epidist
#'
#' @return epidist object
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

  check_epidist_uncertainty(
    prob_dist_params = prob_dist_params,
    uncertainty = uncertainty
  )

  # calculate parameters if not provided
  if (all(is.na(prob_dist_params)) && auto_calc_params) {
    # calculate parameters if not provided
    prob_dist_params <- calc_dist_params(
        prob_dist = prob_dist,
        prob_dist_params = prob_dist_params,
        summary_stats = summary_stats,
        sample_size = metadata$sample_size
      )
  }

  # standardise distribution parameter names
  class(prob_dist_params) <- prob_dist
  prob_dist_params <- clean_epidist_params(
    prob_dist_params = prob_dist_params
  )

  check_epidist_params(
    prob_dist = prob_dist,
    prob_dist_params = prob_dist_params
  )

  # create a S3 object holding the probability distribution
  prob_dist <- create_prob_dist(
    prob_dist = prob_dist,
    prob_dist_params = prob_dist_params,
    discretise = discretise,
    truncation = truncation
  )

  # calculate distribution quantiles and add to epidist
  quants <- c(0.025, 0.05, 0.25, 0.5, 0.75, 0.875, 0.95, 0.975)
  if (isTRUE(discretise)) {
    quantiles <- prob_dist$q(quants)
  } else {
    quantiles <- stats::quantile(prob_dist, quants)[[1]]
  }
  names(quantiles) <- c(
    "q_025",	"q_05",	"q_25",	"q_50", "q_75", "q_875", "q_95", "q_975"
  )
  summary_stats$quantiles <- quantiles

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
    class = "epidist"
  )
}

#' Create an `epidist` object
#'
#' @description The `epidist` class is used to store epidemiological parameters
#' for a single disease. These epidemiological parameters cover a variety of
#' aspects including delay distributions (e.g. incubation periods and serial
#' intervals, among others) and offspring distributions.
#'
#' The `epidist` object is the functional unit provided by `{epiparameter}` to
#' plug into epidemiological pipelines. Obtaining an `epidist` object can be
#' achieved in two main ways. 1) The epidemiological distribution is stored in
#' the `{epiparameter}` library and can be accessed by [`epiparam()`] and
#' [`as_epidist()`]. 2) the alternative method is when you have information
#' (e.g. disease and distribution parameter estimates) and would like to input
#' this into an `epidist` object in order to work in existing analysis
#' pipelines. This is where the `epidist()` function can be used to fill out
#' each field for which information is known.
#'
#' @param disease A character string with name of the infectious disease
#' @param pathogen A character string with the name of the causative agent of
#' disease, or NULL if not known
#' @param epi_dist A character string with the name of the
#' epidemiological distribution type
#' @param prob_distribution A character string specifying the probability
#' distribution
#' @param prob_distribution_params A named vector of probability distribution
#' parameters
#' @param uncertainty A list of named vectors with the uncertainty around
#' the probability distribution parameters. If uncertainty around the parameter
#' estimates is unknown use `create_epidist_uncertainty()` (which is the
#' argument default) to create a list wiht the correct names with missing
#' values.
#' @param summary_stats A list of summary statistics, use
#' [`create_epidist_summary_stats()`] to create list. This list can include
#' summary statistics about the inferred distribution such as it's mean and
#' standard deviation, quantiles of the distribution, or information about the
#' data used to fit the distribution such as lower and upper range. The summary
#' statistics can also include uncertainty around metrics such as confidence
#' interval around mean and standard deviation.
#' @param auto_calc_params A boolean logical determining whether to try and
#' calculate the probability distribution parameters from summary statistics if
#' distribution parameters are not provided. Default is `TRUE`. In the case when
#' sufficient summary statistics are provided and the parameter(s) of the
#' distribution are not, the [`calc_dist_params()`] function is called to
#' calculate the parameters and add them to the `epidist` object created.
#' @param citation A character string with the citation of the source of the
#' data or the paper that inferred the distribution parameters, use
#' `create_epidist_citation()` to create citation.
#' @param metadata A list of metadata, this can include: sample size, whether
#' the disease is vector-borne, etc. It is assumed that the disease is not
#' vector-borne and that the distribution is intrinsic (e.g. not an extrinsic
#' delay distribution such as extrinsic incubation period) unless
#' `vector_borne = TRUE` is contained in the metadata. Use
#' `create_epidist_metadata()` to create metadata.
#' @param method_assess A list of methodological aspects used when fitting
#' the distribution, use `create_epidist_method_assess()` to create method
#' assessment.
#' @param discretise A boolean logical whether the distribution is discretised.
#' Default is FALSE which assumes a continuous probability distribution
#' @param truncation A numeric specifying the truncation point if the inferred
#' distribution was truncated, NA if not or unknown.
#' @param notes A character string with any additional information about the
#' data, inference method or disease.
#'
#' @return An `epidist` object
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
#'     author = "Smith_etal",
#'     year = 2010,
#'     DOI = "10.19832/j.1366-9516.2012.09147.x"
#'   ),
#'   metadata = create_epidist_metadata(
#'     sample_size = 10,
#'     region = "UK",
#'     vector_borne = FALSE,
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
  checkmate::assert_string(disease, na.ok = FALSE, null.ok = FALSE)
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
    types = c("list", "double", "null"),
    names = "unique"
  )
  checkmate::assert_string(citation)
  checkmate::assert_list(metadata)
  checkmate::assert_list(method_assess)
  checkmate::assert_number(truncation, na.ok = TRUE)
  checkmate::assert_logical(discretise)
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

#' `epidist` class validator
#'
#' @param epidist An `epidist` object
#'
#' @return Nothing, errors when invalid `epidist` object is provided
#' @export
validate_epidist <- function(epidist) {

  if (!is_epidist(epidist)) {
    stop("Object should be of class epidist")
  }

  # check for class invariants
  stopifnot(
    "epidist object does not contain the correct attributes" =
      c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
        "citation", "metadata", "method_assess", "notes") %in%
      attributes(epidist)$names,
    "Epidist must contains a disease (single character string)" =
      is.character(epidist$disease$disease) &&
      length(epidist$disease$disease) == 1,
    "Epidist must contain an epidemiological distribution" =
      is.character(epidist$epi_dist) && length(epidist$epi_dist) == 1
  )

  invisible(epidist)
}

#' Print method for epidist class
#'
#' @param x epidist object
#' @param header Boolean logical determining whether the header (first part) of
#' the print method is printed. This is used internally for plotting the
#' vb_epidist class
#' @param vb A character string containing whether it is the intrinsic
#' (`"Intrinsic"`) or extrinsic (`"Extrinsic"`) distribution for vector-borne
#' diseases
#' @param ... further arguments passed to or from other methods
#'
#' @return Nothing (prints output)
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

#' Format method for epidist class
#'
#' @param x epidist object
#' @param header Boolean logical determining whether the header (first part) of
#' the print method is printed. This is used internally for plotting the
#' vb_epidist class
#' @param vb Either NULL (default) or a character string of either "Intrinsic"
#' or "Extrinsic" which is used internally for plotting the vb_epidist class
#' @param ... further arguments passed to or from other methods
#'
#' @return Nothing (prints output)
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

  epi_dist <- clean_epidist_name(x$epi_dist)
  if (header) {
    writeLines(
      c(
        sprintf("Disease: %s", x$disease$disease),
        sprintf("Pathogen: %s", x$disease$pathogen),
        sprintf("Epi Distribution: %s", epi_dist),
        sprintf("Study: %s", x$citation)
      )
    )
  }

  if (!is.null(vb)) {
    writeLines(sprintf(vb))
  }

  if (inherits(x$prob_dist, "distcrete")) {
    writeLines(
      c(
        sprintf("Distribution: discrete %s", x$prob_dist$name),
        sprintf("Parameters:"),
        sprintf(
          "  %s: %s",
          names(x$prob_dist$parameters),
          as.character(x$prob_dist$parameters)
        )
      )
    )
  } else {
    writeLines(
      c(
        sprintf("Distribution: %s", stats::family(x$prob_dist)),
        sprintf("Parameters:"),
        sprintf(
          "  %s: %s",
          names(unlist(distributional::parameters(x$prob_dist))),
          as.character(unlist(distributional::parameters(x$prob_dist)))
        )
      )
    )
  }
  invisible(x)
}

#' PLots an `epidist` object
#'
#' @description Plots an `epidist` object by displaying the either the
#' probability mass function (PMF), (in the case of discrete distributions)
#' or probability density function (PDF) (in the case of continuous
#' distributions) and the cumulative distribution function (CDF). Resulting in
#' a 1x2 grid plot.
#'
#' @param x An `epidist` object
#' @param day_range A vector with the sequence of days to be plotted on the
#' x-axis of the distribution
#' @param ... Allow other graphical parameters
#' @param vb A boolean logical determining whether the `epidist` being plotted
#' has come from a `vb_epidist` object
#' @param title Either a character string or `NULL`. If not null the character
#' string will be printed as a title to the plot
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
    density(x, at = day_range),
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
    cdf(x, q = day_range),
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

#' Checks whether the object is an `epidist`
#'
#' @param x An R object
#'
#' @return A boolean logical, `TRUE` if the object is an `epidist` and `FALSE`
#' if not
#' @export
#'
#' @examples
#' edist <- epidist(
#' disease = "ebola",
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

#' PDF, CDF, PMF, quantiles and random number generation for `epidist` and
#' `vb_epidist` objects
#'
#' @description The epidist object holds a probability distribution which can
#' either be a continuous or discrete distribution. These are the density,
#' cumulative distribution, quantile and random number generation functions.
#' These operate on any distribution that can be included in an `epidist`
#' object.
#'
#' @param x An `epidist` or `vb_epidist` object
#' @param at The quantiles to evaluate at
#' @param q The quantiles to evaluate at
#' @param p The probabilities to evaluate at
#' @param times The number of random samples
#' @param ... further arguments passed to or from other methods
#'
#' @return If an `epidist` object is given a numeric vector is returned, if an
#' `vb_epidist` object is given a list of two elements each with a numeric
#' vector is returned
#'
#' @name epidist_distribution_functions
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
#' density(edist, at = 1)
#' cdf(edist, q = 1)
#' quantile(edist, p = 0.2)
#' generate(edist, times = 10)
#'
#' vb_edist <- vb_epidist(
#'   intrinsic_epidist = epidist(
#'     disease = "dengue",
#'     epi_dist = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1),
#'     metadata = create_epidist_metadata(vector_borne = TRUE)
#'   ),
#'   extrinsic_epidist = epidist(
#'     disease = "dengue",
#'     epi_dist = "incubation_period",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1),
#'     metadata = create_epidist_metadata(vector_borne = TRUE, extrinsic = TRUE)
#'   )
#' )
#'
#' # example of each distribution method for an `vb_epidist` object
#' density(vb_edist, at = 1)
#' cdf(vb_edist, q = 1)
#' quantile(vb_edist, p = 0.2)
#' generate(vb_edist, times = 10)
NULL

#' @rdname epidist_distribution_functions
#' @export

#' @export
density.epidist <- function(x, at, ...) {
  unlist <- length(x$prob_dist) == 1
  if (inherits(x$prob_dist, "distcrete")) {
    out <- x$prob_dist$d(at)
  } else {
    out <- stats::density(x$prob_dist, at = at)
  }
  out <- if (unlist) unlist(out, recursive = FALSE) else out
  out
}

#' @rdname epidist_distribution_functions
#' @export

#' @export
cdf.epidist <- function(x, q) {
  unlist <- length(x$prob_dist) == 1
  if (inherits(x$prob_dist, "distcrete")) {
    out <- x$prob_dist$p(q)
  } else {
    out <- distributional::cdf(x$prob_dist, q = q)
  }
  out <- if (unlist) unlist(out, recursive = FALSE) else out
  out
}

#' @rdname epidist_distribution_functions
#' @export

#' @export
quantile.epidist <- function(x, p, ...) {
  unlist <- length(x$prob_dist) == 1
  if (inherits(x$prob_dist, "distcrete")) {
    out <- x$prob_dist$q(p)
  } else {
    out <- stats::quantile(x$prob_dist, p = p)
  }
  out <- if (unlist) unlist(out, recursive = FALSE) else out
  out
}

#' @rdname epidist_distribution_functions
#' @export

#' @export
generate.epidist <- function(x, times) {

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
