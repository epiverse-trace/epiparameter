
<!-- README.md is generated from README.Rmd. Please edit that file -->

# epiparameter

<!-- badges: start -->

[![R-CMD-check](https://github.com/epiverse-trace/epiparameter/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/epiverse-trace/epiparameter/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/epiverse-trace/epiparameter/branch/main/graph/badge.svg)](https://app.codecov.io/gh/epiverse-trace/epiparameter?branch=main)
<!-- badges: end -->

`R` package with epidemiological parameter distributions for infectious
diseases. Eventually it will include a range of pathogens and natural
history processes, as well as functions to extract parameters from
reported statistics.

## Installation

The easiest way to install the development version of `epiparameter` is
to use the `devtools` package:

``` r
# install.packages("devtools")
library(devtools)
install_github("epiverse-trace/epiparameter")
library(epiparameter)
```

## Quick start

To view the available distributions, then define the desired function,
e.g. to extract and plot the daily probability mass function for the
incubation period of influenza H7N9:

``` r
# View available distributions
epiparameter::list_distributions(type="incubation")
#>             pathogen_ID        study_ID year size distribution
#> 1            adenovirus    Lessler_etal 2009   14        lnorm
#> 2                 ebola        WHO_team 2014  500        gamma
#> 3             human_CoV    Lessler_etal 2009   13        lnorm
#> 4  influenza_A_seasonal    Lessler_etal 2009  122        lnorm
#> 5  influenza_B_seasonal    Lessler_etal 2009   76        lnorm
#> 6       influenza_H1N1p      Ghani_etal 2009   16        gamma
#> 7       influenza_H1N1p      Tuite_etal 2010  316        lnorm
#> 8        influenza_H7N9    Cowling_etal 2013   32        gamma
#> 9               marburg    Martini_etal 1973    5        gamma
#> 10              measles    Lessler_etal 2009   56        lnorm
#> 11             MERS_CoV Cauchemez_et_al 2014    7        lnorm
#> 12             MERS_CoV     Assiri_etal 2013   23        lnorm
#> 13        parainfluenza    Lessler_etal 2009   11        lnorm
#> 14           rhinovirus    Lessler_etal 2009   28        lnorm
#> 15                  RSV    Lessler_etal 2009   24        lnorm
#> 16             SARS_CoV   Donnelly_etal 2003   57        gamma
#> 17             SARS_CoV    Lessler_etal 2009  157        lnorm
#> 18  SARS_CoV_2_wildtype    McAloon_etal 2020 1269        lnorm
#> 19            monkeypox           Nolen 2016   16        lnorm

# Extract incubation period distribution
incubation_H7N9 <- epiparameter::epidist(pathogen="influenza_H7N9",type="incubation")

# Plot probability mass function
plot(0:10,incubation_H7N9$pmf(0:10),xlab="time since infection")
```

<img src="man/figures/README-example-1.png" width="100%" />
