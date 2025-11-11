# Check if distribution in `<epiparameter>` is truncated

Check if distribution in `<epiparameter>` is truncated

## Usage

``` r
is_truncated(x)
```

## Arguments

- x:

  An `<epiparameter>` object.

## Value

A boolean `logical`.

## Details

The `<epiparameter>` class can hold probability distribution objects
from the `{distributional}` package or the `{distcrete}` package,
however, only distribution objects from `{distributional}` can be
truncated. If a `<epiparameter>` object has a `<distcrete>` object
`is_truncated` will return `FALSE` by default.

## Examples

``` r
ep <- epiparameter(
  disease = "ebola",
  epi_name = "incubation_period",
  prob_distribution = create_prob_distribution(
    prob_distribution = "lnorm",
    prob_distribution_params = c(meanlog = 1, sdlog = 1)
  )
)
#> Citation cannot be created as author, year, journal or title is missing
is_truncated(ep)
#> [1] FALSE

ep <- epiparameter(
  disease = "ebola",
  epi_name = "incubation_period",
  prob_distribution = create_prob_distribution(
    prob_distribution = "lnorm",
    prob_distribution_params = c(meanlog = 1, sdlog = 1),
    truncation = 10
  )
)
#> Citation cannot be created as author, year, journal or title is missing
is_truncated(ep)
#> [1] TRUE
```
