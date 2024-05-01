# Pre-compiled vignettes that take a long time to render
# Must manually move image files from epiparameter/ to epiparameter/vignettes/
# after knit
knitr::knit(
  # _ prefix stops pkgdown from re-rendering the original
  # https://pkgdown.r-lib.org/reference/build_articles.html
  input = file.path("vignettes", "_extract-bias.Rmd.orig"),
  output = file.path("vignettes", "extract-bias.Rmd")
)
