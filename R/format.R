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
#'   epi_name = "incubation_period",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#' format(epiparameter)
format.epiparameter <- function(x, ...) {
  writeLines(
    c(
      sprintf(tr_("Disease: %s"), x$disease),
      sprintf(tr_("Pathogen: %s"), x$pathogen),
      sprintf(tr_("Epi Parameter: %s"), .clean_string(x$epi_name)),
      # aggregated <epiparameter> with repeated cits only are to be printed once
      sprintf(tr_("Study: %s"), format(unique(x$citation)))
    )
  )

  if (is.object(x$prob_distribution)) {
    dist_string <- ifelse(
      test = inherits(x$prob_distribution, "distcrete"),
      yes = tr_("Distribution: discrete %s (%s)"),
      no = tr_("Distribution: %s (%s)")
    )
    fam <- family(x)
    # isTRUE to control for family returning NA for unparameterised
    if (isTRUE(fam == "mixture")) {
      fam <- paste(
        fam,
        toString(.distributional_family(x$prob_distribution)),
        sep = ": "
      )
    }
    writeLines(sprintf(dist_string, fam, x$metadata$units))
  } else if (is.character(x$prob_distribution)) {
    writeLines(sprintf("Distribution: %s", family(x)))
  } else {
    writeLines(tr_("Parameters: <no parameters>"))
  }

  # print summary stats if unparameterised and available
  if (!is_parameterised(x) && length(x$summary_stats) > 0) {
    .format_ss(x, pattern = "mean")
    .format_ss(x, pattern = "median")
    .format_ss(x, pattern = "range")
  }

  if (is.object(x$prob_distribution)) {
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
    if (attr(x$prob_distribution, "offset") != 0) {
      writeLines(sprintf("Offset: %s", attr(x$prob_distribution, "offset")))
    }
  }

  invisible(x)
}

.format_ss <- function(x, pattern) {
  # ensure character string is lowercase to match list names
  pattern <- tolower(pattern)
  idx <- grep(pattern = pattern, x = names(x$summary_stats), fixed = TRUE)
  if (length(idx) > 0) {
    ss <- x$summary_stats[idx]
    if (pattern == "range") {
      fmt_ss <- paste0(
        tools::toTitleCase(pattern), ": ", paste0("[", toString(ss), "]")
      )
    } else {
      fmt_ss <- paste0(tools::toTitleCase(pattern), ": ", ss[[pattern]])
    }
    has_ci <- any(grepl(pattern = "_ci", x = names(ss), fixed = TRUE))
    if (has_ci) {
      ci <- paste0(pattern, "_ci")
      ci_limits <- paste0(ci, "_limits")
      fmt_ss <- paste0(
        fmt_ss, " [", ss[[ci]], "% CI: ", toString(ss[[ci_limits]]), "]"
      )
    }
    fmt_ss <- paste0(fmt_ss, " (", x$metadata$units, ")")
    writeLines(fmt_ss)
  }
  invisible(x)
}
