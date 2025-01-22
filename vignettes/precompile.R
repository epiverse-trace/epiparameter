# Pre-compiled vignettes that take a long time to render
knitr::knit(
  # _ prefix stops pkgdown from re-rendering the original
  # https://pkgdown.r-lib.org/reference/build_articles.html
  input = file.path("vignettes", "articles", "_extract-bias.Rmd.orig"),
  output = file.path("vignettes", "articles", "extract-bias.Rmd")
)

# run from package root directory
figures <- file.path(list.files(path = ".", pattern = "^plot-.*\\.png$"))
cp <- file.copy(
  from = file.path(".", figures),
  to = file.path("vignettes", "articles"),
  overwrite = TRUE
)
if (all(cp)) {
  unlink(figures)
} else {
  print("Article figures did not copy, please inspect manually.")
}
