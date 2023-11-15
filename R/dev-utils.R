# This unexported function adds a custom item to `usethis::use_release_issue()`
release_bullets <- function() { # nocov start

  c(
    "Run `goodpractice::gp()`",
    "Review [WORDLIST](https://docs.cran.dev/spelling#wordlist)",
    "Update sysdata by running data-raw script"
  )

} # nocov end
