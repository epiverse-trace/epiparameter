# Pre-compiled vignettes that take a long time to render
knitr::knit(
  # _ prefix stops pkgdown from re-rendering the original
  # https://pkgdown.r-lib.org/reference/build_articles.html
  input = file.path("vignettes", "articles", "_extract-bias.Rmd.orig"),
  output = file.path("vignettes", "articles", "extract-bias.Rmd")
)

# run from package root directory
figures <- file.path(list.files(path = "figure", pattern = "^plot-.*\\.png$"))
if (!dir.exists(file.path("vignettes", "figure"))) {
  dir.create(file.path("vignettes", "figure"))
}
cp <- file.copy(
  from = file.path("figure", figures),
  to = file.path("vignettes", "figure"),
  overwrite = TRUE
)
if (all(cp)) {
  unlink(file.path("figure"), recursive = TRUE)
} else {
  print("Article figures did not copy, please inspect manually.")
}
