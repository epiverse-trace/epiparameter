# A minimal grEPI record. With the default arguments it takes the
# point-estimate branch of .grepi_to_epiparameter(); supplying
# `distribution_type` and the `type*`/`value*` pairs exercises the
# parameterised-distribution branch instead. grEPI no longer supplies the
# `*_IsValueAvailable` flags, so the fixture omits them deliberately:
# parameterisation is determined from the values.
grepi_record <- function(unique_id_type = "Digital Object Identifier (DOI)",
                         unique_id = "10.1234/example.doi",
                         distribution_type = NA_character_,
                         type1 = NA_character_,
                         value1 = NA_real_,
                         type2 = NA_character_,
                         value2 = NA_real_,
                         point_value = 5,
                         range_lower = NA_real_,
                         range_upper = NA_real_,
                         point_inverse = NA,
                         range_inverse = NA) {
  list(
    disease = "Test Disease",
    pathogen_species = "Test Pathogen",
    parameter_subtype = NA_character_,
    parameter_type = "Serial interval",
    distribution_type = distribution_type,
    epiParameter_Distribution_Parameter1_Value_Type = type1,
    epiParameter_Distribution_Parameter1_Value = value1,
    epiParameter_Distribution_Parameter2_Value_Type = type2,
    epiParameter_Distribution_Parameter2_Value = value2,
    epiParameter_Estimate_Point_Value = point_value,
    epiParameter_Estimate_Range_Lower_Bound_Value = range_lower,
    epiParameter_Estimate_Range_Upper_Bound_Value = range_upper,
    epiParameter_Estimate_PointIsInverseValue = point_inverse,
    epiParameter_Estimate_Range_Lower_Bound_IsInverseValue = range_inverse,
    epiParameter_Estimate_Range_Upper_Bound_IsInverseValue = range_inverse,
    epiParameter_Estimate_Value_Type = "Mean",
    estimate_unit = "Days",
    epi_Parameter_Population_Sample_Size = 100,
    inference_method = "MLE",
    epi_Parameter_Population_Country_list = list(
      list(country_Name = "Testland")
    ),
    epi_Parameter_Method_Inference_DataIsCensored_Left = NA,
    epi_Parameter_Method_Inference_DataIsCensored_Right = NA,
    epi_Parameter_Method_Inference_DataIsCensored_Interval = NA,
    epi_Parameter_Method_Inference_DataIsTruncated_Right = NA,
    epi_Parameter_Method_Inference_DataIsBiasAdjusted = NA,
    epi_Parameter_DataSource_Name = "Test Source",
    epi_Parameter_DataSource_Location = "Test Location",
    epi_Parameter_Data_ExtractedBy_OrganizationGroup_Name = "Test Org",
    epi_Parameter_DataSource_Primary_Import_Comment = "Test comment",
    epi_Parameter_DataSource_Primary_ImportedFrom_Project = "Test project",
    article_Authors = list("Smith, John"),
    article_Publication_Year = 2020,
    article_Title = "A test title",
    literature_Source_Name = "Test Journal",
    article_Unique_Identifier_Type = unique_id_type,
    article_Unique_Identifier = unique_id,
    grEPI_ID = "TEST-1"
  )
}

test_that(".grepi_to_epiparameter() reads the DOI from
           article_Unique_Identifier when typed as a DOI", {
  x <- grepi_record()
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_s3_class(ep, "epiparameter")
  expect_identical(ep$citation$doi, "10.1234/example.doi")
})

test_that(".grepi_to_epiparameter() drops the DOI when
           article_Unique_Identifier_Type is not a DOI", {
  x <- grepi_record(
    unique_id_type = "PubMed ID",
    unique_id = "12345678"
  )
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_null(ep$citation$doi)
})

test_that(".grepi_to_epiparameter() drops the DOI when the
           article_Unique_Identifier fields are absent
           (pre-v3.0.1 grEPI shape)", {
  x <- grepi_record()
  x$article_Unique_Identifier_Type <- NULL
  x$article_Unique_Identifier <- NULL
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_null(ep$citation$doi)
})


test_that(".grepi_to_epiparameter() parameterises from the distribution
           parameter values, without the removed *_IsValueAvailable flags", {
  ep <- suppressMessages(
    .grepi_to_epiparameter(
      grepi_record(distribution_type = "Gamma", type1 = "Shape",
                       value1 = 2, type2 = "Scale", value2 = 3)
    )
  )

  expect_true(is_parameterised(ep))
  expect_identical(family(ep), "gamma")
  expect_identical(get_parameters(ep), c(shape = 2, scale = 3))
})

test_that(".grepi_to_epiparameter() does not parameterise when a distribution
           parameter value is missing", {
  x <- grepi_record(distribution_type = "Gamma", type1 = "Shape",
                    value1 = 2, type2 = "Scale", value2 = NA_real_)
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_false(is_parameterised(ep))
})

test_that(".grepi_to_epiparameter() does not parameterise when the
           distribution parameter fields are absent", {
  x <- grepi_record(distribution_type = "Gamma", type1 = "Shape",
                    value1 = 2, type2 = "Scale", value2 = 3)
  x$epiParameter_Distribution_Parameter1_Value <- NULL
  x$epiParameter_Distribution_Parameter2_Value <- NULL
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_false(is_parameterised(ep))
})

test_that(".grepi_to_epiparameter() carries a mean and standard deviation as
           summary statistics, keeping the distribution family", {
  x <- grepi_record(distribution_type = "Gamma", type1 = "Mean",
                    value1 = 5, type2 = "Mean sd", value2 = 2)
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_false(is_parameterised(ep))
  expect_identical(family(ep), "gamma")
  expect_identical(ep$summary_stats$mean, 5)
  expect_identical(ep$summary_stats$sd, 2)
})

test_that(".grepi_to_epiparameter() converts a lognormal reported as mean and
           variance to meanlog and sdlog", {
  x <- grepi_record(distribution_type = "Log-normal", type1 = "Mean",
                    value1 = 5, type2 = "Variance", value2 = 4)
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_true(is_parameterised(ep))
  expect_identical(family(ep), "lnorm")
  expect_named(get_parameters(ep), c("meanlog", "sdlog"))
  expect_equal(
    get_parameters(ep),
    c(meanlog = 1.535228, sdlog = 0.3852532),
    tolerance = 1e-6
  )
})

test_that(".grepi_to_epiparameter() keeps the mean and standard deviation as
           parameters for a normal distribution", {
  x <- grepi_record(distribution_type = "Normal", type1 = "Mean",
                    value1 = 5, type2 = "Standard deviation (Sd)",
                    value2 = 2)
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_true(is_parameterised(ep))
  expect_identical(family(ep), "norm")
  expect_identical(get_parameters(ep), c(mean = 5, sd = 2))
})

test_that(".grepi_to_epiparameter() records the distribution family when grEPI
           declares one but supplies no parameter values", {
  for (grepi_dist in c("Negative binomial", "Poisson")) {
    x <- grepi_record(distribution_type = grepi_dist)
    ep <- suppressMessages(.grepi_to_epiparameter(x))

    expect_false(is_parameterised(ep))
    expect_identical(
      family(ep),
      unname(c("Negative binomial" = "nbinom", Poisson = "pois")[grepi_dist])
    )
  }
})

test_that(".grepi_to_epiparameter() does not record a distribution family that
           is unsupported by {epiparameter}", {
  x <- grepi_record(distribution_type = "Beta-binomial")
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_false(is_parameterised(ep))
  expect_identical(family(ep), NA_character_)
})

test_that(".grepi_to_epiparameter() converts a point estimate identified by its
           point value, without the removed epiParameter_Estimate_IsPoint
           flag", {
  x <- grepi_record(point_value = 5)
  expect_null(x$epiParameter_Estimate_IsPoint)
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_s3_class(ep, "epiparameter")
  expect_false(is_parameterised(ep))
  expect_identical(ep$summary_stats$mean, 5)
})

test_that(".grepi_to_epiparameter() keeps the range of a point estimate", {
  x <- grepi_record(point_value = 5, range_lower = 3, range_upper = 8)
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_identical(ep$summary_stats$mean, 5)
  expect_identical(ep$summary_stats$range, c(3, 8))
})

test_that(".grepi_to_epiparameter() converts a range-only record to a reported
           interval", {
  x <- grepi_record(point_value = NA_real_, range_lower = 3, range_upper = 8)
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_s3_class(ep, "epiparameter")
  expect_false(is_parameterised(ep))
  expect_identical(ep$summary_stats$reported_interval, c(3, 8))
  expect_null(ep$summary_stats$mean)
  expect_output(print(ep), "Reported Interval: [3, 8]", fixed = TRUE)
})

test_that(".grepi_to_epiparameter() records the estimate value type in the notes
           of a range-only record when it is Mean, Median or SD", {
  value_types <- c("Mean", "Median", "Standard deviation (SD)")
  for (value_type in value_types) {
    x <- grepi_record(point_value = NA_real_, range_lower = 3, range_upper = 8)
    x$epiParameter_Estimate_Value_Type <- value_type
    ep <- suppressMessages(.grepi_to_epiparameter(x))

    expect_match(
      ep$notes,
      paste0("Estimate value type: ", value_type, "."),
      fixed = TRUE
    )
  }
  for (value_type in c("Unspecified", NA_character_)) {
    x <- grepi_record(point_value = NA_real_, range_lower = 3, range_upper = 8)
    x$epiParameter_Estimate_Value_Type <- value_type
    ep <- suppressMessages(.grepi_to_epiparameter(x))

    expect_no_match(ep$notes, "Estimate value type")
  }
})

test_that(".grepi_to_epiparameter() does not add the estimate value type to the
           notes of a point estimate", {
  ep <- suppressMessages(.grepi_to_epiparameter(grepi_record()))

  expect_no_match(ep$notes, "Estimate value type")
})

test_that(".grepi_to_epiparameter() orders the bounds of a range-only record
           entered in descending order", {
  x <- grepi_record(point_value = NA_real_, range_lower = 0.11,
                    range_upper = 0.07)
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_identical(ep$summary_stats$reported_interval, c(0.07, 0.11))
})

test_that(".grepi_to_epiparameter() inverts and orders the bounds of a range-only
           record flagged as an inverse value", {
  x <- grepi_record(point_value = NA_real_, range_lower = 0.7,
                    range_upper = 0.11, range_inverse = TRUE)
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_equal(
    ep$summary_stats$reported_interval,
    c(1 / 0.7, 1 / 0.11)
  )
})

test_that(".grepi_to_epiparameter() records the distribution family of a
           range-only record when grEPI declares one", {
  x <- grepi_record(distribution_type = "Gamma", point_value = NA_real_,
                    range_lower = 3, range_upper = 8)
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_false(is_parameterised(ep))
  expect_identical(family(ep), "gamma")
  expect_identical(ep$summary_stats$reported_interval, c(3, 8))
})

test_that(".grepi_to_epiparameter() skips a record with neither a point value
           nor a complete range", {
  skipped <- list(
    grepi_record(point_value = NA_real_),
    grepi_record(point_value = NA_real_, range_lower = 3),
    grepi_record(point_value = NA_real_, range_upper = 8)
  )
  for (x in skipped) {
    expect_warning(
      ep <- suppressMessages(.grepi_to_epiparameter(x)),
      regexp = "neither a point estimate nor a range"
    )
    expect_null(ep)
  }
})

test_that(".grepi_to_epiparameter() skips a record when the point value and
           range fields are absent", {
  x <- grepi_record()
  x$epiParameter_Estimate_Point_Value <- NULL
  x$epiParameter_Estimate_Range_Lower_Bound_Value <- NULL
  x$epiParameter_Estimate_Range_Upper_Bound_Value <- NULL

  expect_warning(
    ep <- suppressMessages(.grepi_to_epiparameter(x)),
    regexp = "neither a point estimate nor a range"
  )
  expect_null(ep)
})

test_that(".grepi_to_epiparameter() inverts a point value flagged as an
           inverse value", {
  x <- grepi_record(point_value = 0.2, point_inverse = TRUE)
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_equal(ep$summary_stats$mean, 5)
})

test_that(".grepi_to_epiparameter() does not invert a point value that is not
           flagged as an inverse value", {
  for (flag in list(FALSE, NA)) {
    x <- grepi_record(point_value = 0.2, point_inverse = flag)
    ep <- suppressMessages(.grepi_to_epiparameter(x))

    expect_identical(ep$summary_stats$mean, 0.2)
  }
  # inverse flags are absent from grEPI responses that pre-date them
  x <- grepi_record(point_value = 0.2)
  x$epiParameter_Estimate_PointIsInverseValue <- NULL
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_identical(ep$summary_stats$mean, 0.2)
})

test_that(".grepi_to_epiparameter() inverts and orders the range bounds of a
           point estimate flagged as an inverse value", {
  x <- grepi_record(
    point_value = 0.5, range_lower = 0.25, range_upper = 0.5,
    point_inverse = TRUE, range_inverse = TRUE
  )
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_equal(ep$summary_stats$mean, 2)
  expect_equal(ep$summary_stats$range, c(2, 4))
})

test_that(".grepi_to_epiparameter() orders range bounds entered in descending
           order", {
  x <- grepi_record(point_value = 5, range_lower = 0.11, range_upper = 0.07)
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_identical(ep$summary_stats$range, c(0.07, 0.11))
})

test_that(".grepi_to_epiparameter() inverts the confidence interval limits of a
           point estimate flagged as an inverse value", {
  x <- grepi_record(point_value = 0.5, point_inverse = TRUE)
  x$epiParameter_Uncertainty_Value_Type <- "Confidence interval"
  x$epiParameter_Uncertainty_Range_Lower_Bound_Value <- 0.25
  x$epiParameter_Uncertainty_Range_Upper_Bound_Value <- 1
  x$epiParameter_Uncertainty_Range_Lower_Bound_IsInverseValue <- TRUE
  x$epiParameter_Uncertainty_Range_Upper_Bound_IsInverseValue <- TRUE
  ep <- suppressMessages(.grepi_to_epiparameter(x))

  expect_equal(ep$summary_stats$mean, 2)
  expect_equal(ep$summary_stats$mean_ci_limits, c(1, 4))
})

test_that(".grepi_invert() inverts only when flagged and handles zero", {
  expect_identical(.grepi_invert(4, TRUE), 0.25)
  expect_identical(.grepi_invert(4, FALSE), 4)
  expect_identical(.grepi_invert(4, NA), 4)
  expect_identical(.grepi_invert(4, NULL), 4)
  expect_identical(.grepi_invert(NA_real_, TRUE), NA_real_)
  expect_identical(.grepi_invert(0, TRUE), NA_real_)
})

test_that(".grepi_bounds() returns NA for absent bounds without ordering", {
  x <- list(epiParameter_Estimate_Range_Lower_Bound_Value = 3)

  expect_identical(
    .grepi_bounds(x, "epiParameter_Estimate_Range"),
    c(3, NA_real_)
  )
})
