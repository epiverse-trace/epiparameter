# Table of epidemiological distributions

This function subsets the epidemiological parameter library to return
only the chosen epidemiological distribution. The results are returned
as a data frame containing the disease, epidemiological distribution,
probability distribution, author of the study, and the year of
publication.

## Usage

``` r
parameter_tbl(
  multi_epiparameter,
  disease = "all",
  pathogen = "all",
  epi_name = "all"
)
```

## Arguments

- multi_epiparameter:

  Either an `<epiparameter>` object or a list of `<epiparameter>`
  objects.

- disease:

  A `character` string with name of the infectious disease.

- pathogen:

  A `character` string with the name of the causative agent of disease,
  or `NA` if not known.

- epi_name:

  A `character` string with the name of the epidemiological parameter
  type.

## Value

A `<parameter_tbl>` object which is a subclass of `<data.frame>`.

## Author

Joshua W. Lambert, Adam Kucharski

## Examples

``` r
epiparameter_list <- epiparameter_db(disease = "COVID-19")
#> Returning 27 results that match the criteria (22 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function
parameter_tbl(multi_epiparameter = epiparameter_list)
#> # Parameter table:
#> # A data frame:    27 × 7
#>    disease  pathogen   epi_name       prob_distribution author  year sample_size
#>    <chr>    <chr>      <chr>          <chr>             <chr>  <dbl>       <dbl>
#>  1 COVID-19 SARS-CoV-2 incubation pe… NA                Men e…  2020          59
#>  2 COVID-19 SARS-CoV-2 incubation pe… NA                Rai e…  2022        6241
#>  3 COVID-19 SARS-CoV-2 incubation pe… NA                Alene…  2021        1453
#>  4 COVID-19 SARS-CoV-2 serial interv… NA                Alene…  2021        3924
#>  5 COVID-19 SARS-CoV-2 serial interv… lnorm             Nishi…  2020          28
#>  6 COVID-19 SARS-CoV-2 serial interv… weibull           Nishi…  2020          18
#>  7 COVID-19 SARS-CoV-2 incubation pe… weibull           Yang …  2020         178
#>  8 COVID-19 SARS-CoV-2 serial interv… norm              Yang …  2020         131
#>  9 COVID-19 SARS-CoV-2 incubation pe… NA                Elias…  2021       28675
#> 10 COVID-19 SARS-CoV-2 incubation pe… weibull           Bui e…  2020          19
#> # ℹ 17 more rows

# example filtering an existing list to incubation periods
epiparameter_list <- epiparameter_db(disease = "COVID-19")
#> Returning 27 results that match the criteria (22 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function
parameter_tbl(
  multi_epiparameter = epiparameter_list,
  epi_name = "incubation period"
)
#> # Parameter table:
#> # A data frame:    15 × 7
#>    disease  pathogen   epi_name       prob_distribution author  year sample_size
#>    <chr>    <chr>      <chr>          <chr>             <chr>  <dbl>       <dbl>
#>  1 COVID-19 SARS-CoV-2 incubation pe… NA                Men e…  2020          59
#>  2 COVID-19 SARS-CoV-2 incubation pe… NA                Rai e…  2022        6241
#>  3 COVID-19 SARS-CoV-2 incubation pe… NA                Alene…  2021        1453
#>  4 COVID-19 SARS-CoV-2 incubation pe… weibull           Yang …  2020         178
#>  5 COVID-19 SARS-CoV-2 incubation pe… NA                Elias…  2021       28675
#>  6 COVID-19 SARS-CoV-2 incubation pe… weibull           Bui e…  2020          19
#>  7 COVID-19 SARS-CoV-2 incubation pe… lnorm             McAlo…  2020        1357
#>  8 COVID-19 SARS-CoV-2 incubation pe… lnorm             McAlo…  2020        1269
#>  9 COVID-19 SARS-CoV-2 incubation pe… lnorm             Linto…  2020          52
#> 10 COVID-19 SARS-CoV-2 incubation pe… lnorm             Linto…  2020         158
#> 11 COVID-19 SARS-CoV-2 incubation pe… lnorm             Linto…  2020          52
#> 12 COVID-19 SARS-CoV-2 incubation pe… lnorm             Lauer…  2020         181
#> 13 COVID-19 SARS-CoV-2 incubation pe… lnorm             Lauer…  2020          99
#> 14 COVID-19 SARS-CoV-2 incubation pe… lnorm             Lauer…  2020         108
#> 15 COVID-19 SARS-CoV-2 incubation pe… lnorm             Lauer…  2020          73
```
