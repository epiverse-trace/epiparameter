test_that("plot.multi_epiparameter works for parameterised <epiparameter>", {
  # plotting changes global state of graphics pars so they are restored
  op <- par(no.readonly = TRUE)
  ep <- epiparameter_db(disease = "Ebola", epi_name = "serial")
  expect_silent(plot(ep))
  f <- function() plot(ep)
  vdiffr::expect_doppelganger(
    title = "plot.multi_epiparameter",
    fig = f
  )
  # restore graphics pars
  par(op)
})

test_that("plot.multi_epiparameter removes unparameterised or discrete dists", {
  # plotting changes global state of graphics pars so they are restored
  op <- par(no.readonly = TRUE)
  ep <- epiparameter_db(disease = "SARS")
  expect_warning(
    plot(ep),
    regexp = "(epiparameter)*(discrete or unparameterised)*(cannot be plotted)"
  )
  # restore graphics pars
  par(op)
})