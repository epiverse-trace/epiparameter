# This unexported function adds a custom item to `usethis::use_release_issue()`
release_bullets <- function() { # nocov start

  c(
    "Run `goodpractice::gp()`",
    "Review [WORDLIST](https://docs.cran.dev/spelling#wordlist)",
    "Check if `# nolint` comments are still needed with recent lintr releases",
    "All contributors to this release are acknowledged in some way",
    "Run data-raw/parameters.R script to update sysdata", # nolint nonportable_path_linter
    "Run vignettes/precompile.R to regenerate `extract-bias.Rmd` vignette" # nolint nonportable_path_linter
  )

} # nocov end
