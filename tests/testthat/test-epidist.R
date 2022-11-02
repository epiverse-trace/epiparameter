test_that("epidist works with valid input", {
  ebola_dist <- epidist(pathogen = "ebola", delay_dist = "incubation")
  expect_s3_class(ebola_dist, class = "epidist")
  expect_length(ebola_dist, 7)
  expect_equal(
    names(ebola_dist),
    c("pathogen", "dist", "delay_dist", "param", "pmf", "pdf", "cdf")
  )
  expect_type(ebola_dist$pathogen, "character")
  expect_type(ebola_dist$dist, "character")
  expect_type(ebola_dist$delay_dist, "character")
  expect_vector(ebola_dist$param, ptype = numeric(), size = 2)
  expect_type(ebola_dist$pmf, "closure")
  expect_type(ebola_dist$pdf, "closure")
  expect_type(ebola_dist$cdf, "closure")
})

test_that("epidist prob functions work", {
  marburg_dist <- epidist(pathogen = "marburg", delay_dist = "incubation")
  expect_equal(marburg_dist$pmf(5), 0.000641548322219965)
  expect_equal(marburg_dist$pdf(5), 0.00133380313883437)
  expect_equal(marburg_dist$cdf(5), 0.999218672257759)
})

test_that("epidist works with specific study", {
  mers_dist1 <- epidist(pathogen = "MERS_CoV", delay_dist = "incubation")
  mers_dist2 <- epidist(
    pathogen = "MERS_CoV",
    delay_dist = "incubation",
    study = "Cauchemez_et_al"
  )
  expect_false(identical(mers_dist1, mers_dist2))
  expect_s3_class(mers_dist2, class = "epidist")
  expect_length(mers_dist2, 7)
  expect_equal(
    names(mers_dist2),
    c("pathogen", "dist", "delay_dist", "param", "pmf", "pdf", "cdf")
  )
})

test_that("epidist works with lognorm dist", {
  adenovirus_dist <- epidist(pathogen = "adenovirus", delay_dist = "incubation")
  expect_s3_class(adenovirus_dist, "epidist")
  expect_equal(adenovirus_dist$pmf(5), 0.318548590046)
  expect_equal(adenovirus_dist$pdf(5), 0.316588858382)
  expect_equal(adenovirus_dist$cdf(5), 0.304022826688)
})

test_that("epidist.print works as expected", {
   expect_snapshot(epidist(pathogen = "RSV", delay_dist = "incubation"))
})

test_that("epidist.plot does not produce an error", {
  expect_silent(plot(epidist(pathogen = "ebola", delay_dist = "incubation")))

  f <- function() plot(epidist(pathogen = "ebola",  delay_dist = "incubation"))
  vdiffr::expect_doppelganger(
    title = "epidist.plot",
    fig = f
  )
})

test_that("epidist.plot works with non-default day_range", {
  expect_silent(
    plot(epidist(
      pathogen = "ebola",
      delay_dist = "incubation"
    ),
    day_range = 0:20
    )
  )

  f <- function() {
    plot(
      epidist(pathogen = "ebola",  delay_dist = "incubation"),
      day_range = 0:20
    )
  }
  vdiffr::expect_doppelganger(
    title = "epidist.plot non-default range",
    fig = f
  )
})
