#' Internal constructor for `<dist>` class
#'
#' @details
#' Called by exported distribution constructors such as [Gamma()] and
#' [LogNormal()].
#'
#' @return A `<dist>` object.
#' @keywords internal
#' @noRd
.dist <- function(name, ...) {
  d <- match.fun(paste0("d", name))
  p <- match.fun(paste0("p", name))
  q <- match.fun(paste0("q", name))
  r <- match.fun(paste0("r", name))

  structure(
    list(
      name = name,
      parameters = list(...),
      d = function(x) d(x, ...),
      p = function(q) p(q, ...),
      q = function(p) q(p, ...),
      r = function(n) r(n, ...)
    ),
    class = "dist"
  )
}

#' This function can probably be deleted at some point as [.dist()] is internal
#' and there should be no point in
#' @export
print.dist <- function(x, ...) {
  print_param(x)
  invisible(x)
}

print_dist <- function(x, param = FALSE, ...) {
  if (param) {
    print_param(x)
  } else {
    if (length(x$parameters) == 0) {
      param_str <- "  <with no parameters>"
    } else {
      param_str <- sprintf("    %s: %s", names(x$parameters), x$parameters)
    }
    writeLines(
      c(
        sprintf("<dist> object"),
        sprintf("  name: %s", x$name),
        sprintf("  parameters:"),
        param_str
      )
    )
  }
  invisible(x)
}

print_param <- function(x) {
  if (.is_dirac(x)) {
    cat(x$parameters[[1]])
  } else {
    writeLines(
      sprintf("%s(%s, %s)", x$name, x$parameters[[1]], x$parameters[[2]])
    )
  }
}

#' Constructor for `<gamma_dist>` object
#'
#' @details
#' Parameterising the gamma distribution with mean and standard deviation does
#' not allow specifying parameter uncertainty. If `mean` or `sd` are specified
#' as anything other than a single `numeric` the function will error.
#'
#' @inheritParams stats::dgamma
#'
#' @return A `<gamma_dist>` object.
#' @export
Gamma <- function(shape, rate = 1, scale = 1/rate, log = FALSE, ..., mean, sd) {
  browser()
  if (!missing(mean) && !missing(sd)) {
    checkmate::assert_number(mean)
    checkmate::assert_number(sd)
    params <- convert_summary_stats_to_params(
      distribution = "gamma",
      mean = mean,
      sd = sd
    )
    shape <- params$shape
    scale <- params$scale
  }

  if (!inherits(shape, "dist")) {
    shape = .dist(name = "norm", mean = shape, sd = 0)
  }
  if (!inherits(scale, "dist")) {
    scale = .dist(name = "norm", mean = scale, sd = 0)
  }
  structure(
    list(
      shape = shape,
      scale = scale
    ),
    class = c("gamma_dist", "virtual_dist")
  )
}

#' Constructor for `<lnorm_dist>` object
#'
#' @inheritParams stats::dlnorm
#'
#' @return A `<lnorm_dist>` object.
#' @export
Lnorm <- function(meanlog = 0, sdlog = 1, log = FALSE, ..., mean, sd) {
  if (!missing(mean) && !missing(sd)) {
    checkmate::assert_number(mean)
    checkmate::assert_number(sd)
    params <- convert_summary_stats_to_params(
      distribution = "lnorm",
      mean = mean,
      sd = sd
    )
    meanlog <- params$meanlog
    sdlog <- params$sdlog
  }
  if (!inherits(meanlog, "dist")) {
    meanlog = .dist(name = "norm", mean = meanlog, sd = 0)
  }
  if (!inherits(sdlog, "dist")) {
    sdlog = .dist(name = "norm", mean = sdlog, sd = 0)
  }
  structure(
    list(
      meanlog = meanlog,
      sdlog = sdlog
    ),
    class = c("lnorm_dist", "virtual_dist")
  )
}

#' @export
print.virtual_dist <- function(x, param = FALSE, ...) {
  if (param) {
    lapply(x, function(y) {
      print_param(y)
      cat("\n")
    })
  } else {
    writeLines(
      c(
        sprintf("<%s distribution>", .get_dist_name(x)),
        sprintf("\t parameters:")
      )
    )
    # assumes 2 param distribution
    # TODO: generalise to n parameter distributions
    cat("\t", names(x)[1], "\t")
    print(x[[1]], param = T)
    cat("\n \t", names(x)[2], "\t")
    print(x[[2]], param = T)
  }
  invisible(x)
}

#' @importFrom distributional generate
#' @export
generate.virtual_dist <- function(x, times, ...) {
  r <- match.fun(paste0("r", .get_dist_name(x)))
  r(n = times, x[[1]]$r(1), x[[2]]$r(1), ...)
}

.is_dirac <- function(x) {
  checkmate::assert_class(x, classes = "dist")
  var(x$r(100)) == 0
}

.get_dist_name <- function(x) {
  checkmate::assert_class(x, classes = "virtual_dist")
  strsplit(class(x)[1], split = "_")[[1]][1]
}
