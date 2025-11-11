# Mean method for `<epiparameter>` class

Mean method for `<epiparameter>` class

## Usage

``` r
# S3 method for class 'epiparameter'
mean(x, ...)
```

## Arguments

- x:

  An `<epiparameter>` object.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Not used, extra arguments
  supplied will cause a warning.

## Value

A `numeric` mean of a distribution or `NA`.

## Examples

``` r
ep <- epiparameter_db(
  disease = "COVID-19",
  epi_name = "incubation period",
  single_epiparameter = TRUE
)
#> Using Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.. 
#> To retrieve the citation use the 'get_citation' function
mean(ep)
#> [1] 5.6
```
