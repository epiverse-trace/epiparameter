
<!-- README.md is generated from README.Rmd. Please edit that file -->

# epiparameter <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R-CMD-check](https://github.com/epiverse-trace/epiparameter/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/epiverse-trace/epiparameter/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/epiverse-trace/epiparameter/branch/main/graph/badge.svg)](https://app.codecov.io/gh/epiverse-trace/epiparameter?branch=main)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

`{epiparameter}` is an `R` package that contains a library of
epidemiological parameters for infectious diseases and a set classes and
helper functions to be able to work with the data. It also includes
functions to extract and convert parameters from reported summary
statistics.

`{epiparameter}` is developed at the [Centre for the Mathematical
Modelling of Infectious
Diseases](https://www.lshtm.ac.uk/research/centres/centre-mathematical-modelling-infectious-diseases)
at the [London School of Hygiene and Tropical
Medicine](https://www.lshtm.ac.uk/) as part of
[Epiverse-TRACE](https://data.org/initiatives/epiverse/).

## Installation

The easiest way to install the development version of `{epiparameter}`
is to use the `{pak}` package:

``` r
# check whether {pak} is installed
if(!require("pak")) install.packages("pak")
pak::pak("epiverse-trace/epiparameter")
```

## Quick start

``` r
library(epiparameter)
```

To load the library of epidemiological parameters into `R`:

``` r
eparams <- epiparam()
eparams
#> Epiparam object
#> Number of distributions in library: 118
#> Number of diseases: 23
#> Number of delay distributions: 95
#> Number of offspring distributions: 10
#> Number of studies in library: 57
#> <Head of library>
#>       disease         epi_distribution prob_distribution
#> 1  Adenovirus        incubation_period             lnorm
#> 2 Chikungunya        incubation_period             lnorm
#> 3    COVID-19 hospitalisation_to_death           weibull
#> 4    COVID-19 hospitalisation_to_death             lnorm
#> 5    COVID-19        incubation_period              <NA>
#> 6    COVID-19        incubation_period           weibull
#> <112 more rows & 55 more cols not shown>
```

The library is an `<epiparam>` class, which underneath is a data frame.

Each entry of the library can be converted into an `<epidist>` object to
be used.

``` r
influenza_incubation <- as_epidist(eparams[12, ])
#> Using Linton, etal (2020). "Incubation Period and Other Epidemiological
#> Characteristics of 2019 Novel Coronavirus Infections with Right
#> Truncation: A Statistical Analysis of Publicly Available Case Data."
#> _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>. 
#> To retrieve the citation use the 'get_citation' function
influenza_incubation
#> Disease: COVID-19
#> Pathogen: SARS-CoV-2
#> Epi Distribution: incubation period
#> Study: Linton, etal (2020). "Incubation Period and Other Epidemiological
#> Characteristics of 2019 Novel Coronavirus Infections with Right
#> Truncation: A Statistical Analysis of Publicly Available Case Data."
#> _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.
#> Distribution: lnorm
#> Parameters:
#>   meanlog: 1.456
#>   sdlog: 0.555
```

The `<epidist>` object can be plotted.

``` r
plot(influenza_incubation)
```

<img src="man/figures/README-plot-epidist-1.png" width="75%" style="display: block; margin: auto;" />

### Parameter conversion and extraction

The parameters of a distribution can be converted to and from mean and
standard deviation. In `{epiparameter}` we implement this for a variety
of distributions:

- gamma
- lognormal
- Weibull
- negative binomial
- geometric

The parameters of a probability distribution can also be extracted from
other summary statistics, for example, percentiles of the distribution,
or the median and range of the data. This can be done for:

- gamma
- lognormal
- Weibull

## Contributing to library of epidemiological parameters

If you would like to contribute to the different epidemiological
parameters stored in the `{epiparameter}` package, you can access the
[google
sheet](https://docs.google.com/spreadsheets/d/1zVpaaKkQ7aeMdRN2r0p-W4d2TtccL5HcIOp_w-lfkEQ/edit?usp=sharing)
and add your data. This spreadsheet contains two example entries as a
guide to what fields can accept. See also the data dictionary (either
yaml or JSON files) in the `{epiparameter}` package (in inst/extdata)
for explanation of accepted entries for each column.

## Help

To report a bug please open an
[issue](https://github.com/epiverse-trace/epiparameter/issues/new/choose)

## Contribute

Contributions to `{epiparameter}` are welcomed. Please follow the
[package contributing
guide](https://github.com/epiverse-trace/epiparameter/blob/main/.github/CONTRIBUTING.md).

## Code of Conduct

Please note that the `{epiparameter}` project is released with a
[Contributor Code of
Conduct](https://github.com/epiverse-trace/.github/blob/main/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.

## Citing this package

``` r
citation("epiparameter")
#> To cite package 'epiparameter' in publications use:
#> 
#>   Lambert J, Kucharski A (2023). _epiparameter: Library of
#>   Epidemiological Parameters_.
#>   https://github.com/epiverse-trace/epiparameter,
#>   https://epiverse-trace.github.io/epiparameter/.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {epiparameter: Library of Epidemiological Parameters},
#>     author = {Joshua W. Lambert and Adam Kucharski},
#>     year = {2023},
#>     note = {https://github.com/epiverse-trace/epiparameter,
#> https://epiverse-trace.github.io/epiparameter/},
#>   }
```
