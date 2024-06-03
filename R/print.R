#' Print method for `<multi_epidist>` class
#'
#' @param x A `<multi_epidist>` object.
#' @param n A `numeric` specifying how many `<epidist>` objects to print. This
#' argument is passed to [head()] for `list` printing. Default is `NULL` and the
#' number of elements to print is controlled by package [options()].
#' @inheritParams print.epidist
#'
#' @return Invisibly returns a `<multi_epidist>`. Called for side-effects.
#' @export
print.multi_epidist <- function(x, ..., n = NULL) {
  chkDots(...)

  # determine how many <epidist> to print
  if (is.null(n)) {
    n <- getOption("epiparameter")$print_max
    if (length(x) > n) {
      n <- getOption("epiparameter")$print_min
    } else {
      n <- length(x)
    }
  }

  extra_n <- length(x) - n
  n_entries <- length(x) # nolint object_usage_linter used by cli {} syntax

  diseases <- vapply(x, "[[", FUN.VALUE = character(1), "disease")
  alpha_unique_diseases <- sort(unique(diseases))
  epi_dists <- vapply(
    x, "[[", FUN.VALUE = character(1), "epi_dist"
  )
  alpha_unique_epi_dists <- sort(unique(epi_dists))


  # header
  writeLines(
    pillar::style_subtle(
      paste0(
        "# List of <epidist> objects \n",
        "# A list:  ", cli::pluralize("{n_entries} element{?s}"),
        "\n"
      )
    )
  )
  writeLines(
    pillar::style_subtle(
      c(
        paste("Number of diseases:", length(alpha_unique_diseases)),
        paste(cli::symbol$pointer, alpha_unique_diseases, collapse = " "),
        "\n",
        paste(
          "Number of epi distributions:",
          length(alpha_unique_epi_dists)
        ),
        paste(cli::symbol$pointer, alpha_unique_epi_dists, collapse = " "),
        "\n"
      )
    )
  )

  # body
  print(utils::head(x, n = n))

  # footer
  footer <- ""
  if (extra_n >= 1) {
    footer <- paste0(
      "# ", cli::symbol$info, " ", extra_n, " more elements\n",
      "# ", cli::symbol$info, " Use `print(n = ...)` to see more elements.\n"
    )
  }

  writeLines(
    pillar::style_subtle(
      paste0(
        footer,
        "# ", cli::symbol$info,
        " Use `parameter_tbl()` to see a summary table of the parameters."
      )
    )
  )
  cli::cli_text(
    "Explore database online at {.url
    https://epiverse-trace.github.io/epiparameter/dev/articles/database.html}"
  )
  invisible(x)
}
