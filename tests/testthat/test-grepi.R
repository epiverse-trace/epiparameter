# A minimal grEPI record that takes the point-estimate branch of
# .grepi_to_epiparameter(), so the fixture stays independent of the
# parameterised-distribution logic. `unique_id_type`/`unique_id` are the
# fields under test.
grepi_record <- function(unique_id_type = "Digital Object Identifier (DOI)",
                         unique_id = "10.1234/example.doi") {
  list(
    disease_Name_Preferred = "Test Disease",
    pathogen_Species_Name_Preferred = "Test Pathogen",
    epiParameter_Estimate_Subtype = NA_character_,
    epiParameter_Estimate_Type = "Serial interval",
    epiParameter_Distribution_Type = NA_character_,
    epiParameter_Estimate_IsPoint = TRUE,
    epiParameter_Estimate_Point_Value = 5,
    epiParameter_Estimate_Value_Type = "Mean",
    epiParameter_Estimate_Unit = "Days",
    epi_Parameter_Population_Sample_Size = 100,
    epi_Parameter_Method_Inference = "MLE",
    epi_Parameter_Population_Country_list = list(
      list(country_Name = "Testland")
    ),
    epi_Parameter_Method_Inference_DataIsCensored = NA,
    epi_Parameter_Method_Inference_DataIsTruncated = NA,
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
  ep <- suppressMessages(epiparameter:::.grepi_to_epiparameter(x))

  expect_s3_class(ep, "epiparameter")
  expect_identical(ep$citation$doi, "10.1234/example.doi")
})

test_that(".grepi_to_epiparameter() drops the DOI when
           article_Unique_Identifier_Type is not a DOI", {
  x <- grepi_record(
    unique_id_type = "PubMed ID",
    unique_id = "12345678"
  )
  ep <- suppressMessages(epiparameter:::.grepi_to_epiparameter(x))

  expect_null(ep$citation$doi)
})

test_that(".grepi_to_epiparameter() drops the DOI when the
           article_Unique_Identifier fields are absent
           (pre-v3.0.1 grEPI shape)", {
  x <- grepi_record()
  x$article_Unique_Identifier_Type <- NULL
  x$article_Unique_Identifier <- NULL
  ep <- suppressMessages(epiparameter:::.grepi_to_epiparameter(x))

  expect_null(ep$citation$doi)
})
