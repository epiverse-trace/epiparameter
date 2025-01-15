#' Plot method for `<epiparameter>` class
#'
#' @description Plot an `<epiparameter>` object by displaying the either the
#' probability mass function (PMF), (in the case of discrete distributions)
#' or probability density function (PDF) (in the case of continuous
#' distributions), or the cumulative distribution function (CDF).
#'
#' @details
#' By default if the `xlim` argument is not specified the distribution is
#' plotted between day 0 and the 99th quantile of the distribution.
#' Alternatively, a `numeric` vector of length 2 with the
#' first and last day to plot on the x-axis can be supplied to `xlim`
#' (through [...]).
#'
#'
#' @param x An `<epiparameter>` object.
#' @param cumulative A boolean `logical`, default is `FALSE`.
#' `cumulative = TRUE` plots the cumulative distribution function (CDF).
#' @inheritParams base::print
#'
#' @author Joshua W. Lambert
#' @inherit graphics::plot.formula return
#' @export
#'
#' @examples
#' # plot continuous epiparameter
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "incubation_period",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 2, scale = 1)
#'   )
#' )
#' plot(ep)
#'
#' # plot different day range (x-axis)
#' plot(ep, xlim = c(0, 10))
#'
#' # plot CDF
#' plot(ep, cumulative = TRUE)
#'
#' # plot discrete epiparameter
#' ep <- discretise(ep)
#' plot(ep)
plot.epiparameter <- function(x,
                              cumulative = FALSE,
                              uncertainty = FALSE,
                              uncertainty_type = c("lines", "ribbon"),
                              ...) {
  # check input
  assert_epiparameter(x)
  checkmate::assert_logical(cumulative, any.missing = FALSE, len = 1)
  uncertainty_type <- match.arg(uncertainty_type)

  stopifnot("<epiparameter> is unparameterised." = is_parameterised(x))

  if (!is_continuous(x) && uncertainty) {
    stop(
      "Plotting uncertainty is currently not supported for ",
      "discrete distributions.\n Set `uncertainty = FALSE`.",
      call. = FALSE
    )
  }

  # capture dots
  dots <- list(...)

  if (is_continuous(x)) {
    main <- "Probability Density Function"
  } else {
    main <- "Probability Mass Function"
  }

  # check if distribution parameters have uncertainty
  if (uncertainty && anyNA(unlist(x$uncertainty))) {
    uncertainty <- FALSE
    warning(
      "`uncertainty = TRUE` but the <epiparameter> does not include ",
      "parameter uncertainty",
      call. = FALSE
    )
  }

  if (is.null(dots$xlim)) {
    xlim <- seq(0, quantile(x, p = 0.99), length.out = 1000)
  } else {
    checkmate::assert_numeric(dots$xlim, len = 2)
    xlim <- seq(dots$xlim[1], dots$xlim[2], length.out = 1000)
  }

  xlab <- tools::toTitleCase(x$epi_name)
  units <- x$metadata$units
  no_units <- grepl(pattern = "(no)*(units)", x = units, ignore.case = TRUE) ||
    anyNA(units)
  if (!no_units) {
    xlab <- paste0(xlab, " ", "(", tools::toTitleCase(units), ")")
  }

  if (is_continuous(x)) {
    if (cumulative) {
      # plot CDF
      plot(
        x = xlim,
        y = cdf(x, q = xlim),
        ylab = "",
        xlab = xlab,
        type = "l",
        lwd = 2,
        pch = 16,
        ylim = c(0, 1),
        main = "Cumulative Distribution Function",
        ...
      )
    } else {
      # plot either PDF or PMF
      plot(
        x = xlim,
        y = density(x, at = xlim),
        ylab = "",
        xlab = xlab,
        type = "l",
        lwd = 2,
        pch = 16,
        main = main,
        ...
      )
    }
    if (uncertainty) {
      # extract n_sample rather than supplying dots to prevent multiple arg
      # matches with xlim
      n_samples <- ifelse(
        test = is.null(dots$n_samples),
        yes = 100,
        no = dots$n_samples
      )

      .plot_uncertainty(
        x = x,
        cumulative = cumulative,
        xlim = xlim,
        uncertainty_type = uncertainty_type,
        n_samples = n_samples
      )
    }
  } else {
    if (cumulative) {
      graphics::barplot(
        height = cdf(x, q = unique(round(xlim))),
        space = 0,
        names.arg = unique(round(xlim)),
        xlab = xlab,
        ylab = "",
        ylim = c(0, 1),
        main = "Cumulative Distribution Function",
        ...
      )
    } else {
      graphics::barplot(
        density(x, at = unique(round(xlim))),
        space = 0,
        names.arg = unique(round(xlim)),
        xlab = xlab,
        ylab = "",
        main = main,
        ...
      )
    }
  }
}

.plot_uncertainty <- function(x,
                              cumulative,
                              xlim,
                              uncertainty_type,
                              n_samples) {
  # calculate the density for the confidence intervals
  par1 <- stats::runif(
    n = n_samples,
    min = min(x$uncertainty[[1]]$ci_limits),
    max = max(x$uncertainty[[1]]$ci_limits)
  )
  par2 <- stats::runif(
    n = n_samples,
    min = min(x$uncertainty[[2]]$ci_limits),
    max = max(x$uncertainty[[2]]$ci_limits)
  )

  # create either density or cdf function
  dist_func <- paste0(ifelse(test = cumulative, yes = "p", no = "d"), family(x))

  if (uncertainty_type == "lines") {
    for (i in seq_len(n_samples)) {
      ylim <- do.call(dist_func, list(xlim, par1[i], par2[i]))
      lines(
        x = xlim,
        y = ylim,
        col = grDevices::rgb(red = 0.1, green = 0.1, blue = 0.1, alpha = 0.25)
      )
    }
  } else {
    # compute PDFs for all parameter samples
    pdf_matrix <- sapply(seq_len(n_samples), function(i) {
      do.call(dist_func, list(xlim, par1[i], par2[i]))
    })
    # compute the 95% credible interval for the densities
    lower_bound <- apply(pdf_matrix, 1, min)
    upper_bound <- apply(pdf_matrix, 1, max)
    # TODO: check whether this should be min/max or upper/lower quantile
    #lower_bound <- apply(pdf_matrix, 1, quantile, probs = 0.025)
    #upper_bound <- apply(pdf_matrix, 1, quantile, probs = 0.975)
    # plot ribbon
    polygon(
      c(xlim, rev(xlim)),
      c(upper_bound, rev(lower_bound)),
      col = grDevices::rgb(0, 0, 1, 0.2),
      border = NA
    )
  }
}

#' [lines()] method for `<epiparameter>` class
#'
#' @inheritParams plot.epiparameter
#' @inheritParams base::plot
#'
#' @inherit graphics::plot.formula return
#' @importFrom graphics lines
#' @export
#'
#' @examples
#' ebola_si <- epiparameter_db(disease = "Ebola", epi_name = "serial")
#' plot(ebola_si[[1]])
#' lines(ebola_si[[2]])
lines.epiparameter <- function(x, cumulative = FALSE, ...) {
  # check input
  assert_epiparameter(x)
  checkmate::assert_logical(cumulative, any.missing = FALSE, len = 1)

  # capture dots
  dots <- list(...)

  if (is.null(dots$xlim)) {
    xlim <- seq(0, quantile(x, p = 0.99), length.out = 1000)
  } else {
    checkmate::assert_numeric(dots$xlim, len = 2)
    xlim <- seq(dots$xlim[1], dots$xlim[2], length.out = 1000)
  }

  if (!is_continuous(x)) {
    stop(
      "Can only plot a line for a parameterised <epiparameter> object ",
      "with a continuous distribution.",
      call. = FALSE)
  }

  if (cumulative) {
    # plot CDF
    lines(
      x = xlim,
      y = cdf(x, q = xlim),
      lwd = 2,
      pch = 16,
      ...
    )
  } else {
    # plot either PDF or PMF
    lines(
      x = xlim,
      y = density(x, at = xlim),
      lwd = 2,
      pch = 16,
      ...
    )
  }
}

#' [plot()] method for `<multi_epiparameter>` class
#'
#' @description Plots a list of `<epiparameter>` objects by overlaying their
#' distributions.
#'
#' @details
#' Unparameterised and discrete `<epiparameter>` objects
#' are not plotted (see [is_parameterised()] and [is_continuous()]).
#'
#' @param x A `<multi_epiparameter>` object.
#' @inheritParams plot.epiparameter
#' @inheritParams base::print
#'
#' @author Joshua W. Lambert
#' @inherit graphics::plot.formula return
#' @export
#'
#' @examples
#' ebola_si <- epiparameter_db(disease = "Ebola", epi_name = "serial")
#' plot(ebola_si)
plot.multi_epiparameter <- function(x,
                                    cumulative = FALSE,
                                    ...) {
  # check input
  vapply(x, assert_epiparameter, FUN.VALUE = x[[1]])
  checkmate::assert_logical(cumulative, any.missing = FALSE, len = 1)

  # capture dots
  dots <- list(...)

  is_discrete <- !vapply(x, is_continuous, FUN.VALUE = logical(1))
  is_unparam <- !is_parameterised(x)

  # error if all <epiparameter> are discrete or unparameterised
  if (all(is_discrete)) {
    stop(
      "Plotting a list of <epiparameter> objects (<multi_epiparameter>) ",
      "currently does not support plotting discrete distributions.",
      call. = FALSE
    )
  }
  if (all(is_unparam)) {
    stop(
      "All <epiparameter> objects in the list are unparameterised ",
      "and thus cannot be plotted. See `?is_parameterised()`.",
      call. = FALSE
    )
  }

  # discard and warn if any <epiparameter> are discrete or unparameterised
  if (any(is_discrete) || any(is_unparam)) {
    rm_idx <- is_discrete | is_unparam
    x <- x[!rm_idx]
    # reclass <multi_epiparameter> as subsetting unclasses
    class(x) <- "multi_epiparameter"
    rm_idx <- as.character(which(rm_idx))
    warning(
      cli::pluralize(
        "<epiparameter> object{?s} {rm_idx} in the list {?is/are} discrete ",
        "or unparameterised so cannot be plotted."
      ),
      call. = FALSE
    )
  }

  # find the maximum x and y coordinates for all distributions are visible
  if (is.null(dots$xlim)) {
    max_xlim <- max(vapply(x, quantile, FUN.VALUE = numeric(1), p = 0.99))
    xlim <- c(0, max_xlim) # TODO: what about negative values e.g. norm
    dist_eval <- seq(0, max_xlim, length.out = 1000)
  } else {
    checkmate::assert_numeric(dots$xlim, len = 2)
    dist_eval <- seq(dots$xlim[1], dots$xlim[2], length.out = 1000)
  }

  if (is.null(dots$ylim)) {
    if (cumulative) {
      ylim <- c(0, 1)
    } else {
      ylims <- vapply(
        x,
        density,
        FUN.VALUE = numeric(length(dist_eval)),
        at = dist_eval
      )
      # max of finite values as cannot plot Inf (e.g. exp dist that go to Inf)
      max_ylim <- max(ylims[is.finite(ylims)])

      ylim <- c(0, max_ylim)
    }
  } else {
    checkmate::assert_numeric(dots$ylim, len = 2)
  }

  # create graphics device
  plot(x[[1]], xlim = xlim, ylim = ylim, ...)
  # layer curves onto existing graphics device
  lapply(x, lines)
  invisible()
}
