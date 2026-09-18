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
                         value2 = NA_real_) {
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
    epiParameter_Estimate_IsPoint = TRUE,
    epiParameter_Estimate_Point_Value = 5,
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
