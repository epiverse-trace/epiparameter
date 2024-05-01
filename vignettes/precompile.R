# Pre-compiled vignettes that take a long time to render
# Must manually move image files from epiparameter/ to epiparameter/vignettes/
# after knit
knitr::knit(
  input = file.path("vignettes", "extract-bias.Rmd.orig"),
  output = file.path("vignettes", "extract-bias.Rmd")
)
