# Check if distribution in `<epiparameter>` is continuous

Check if distribution in `<epiparameter>` is continuous

## Usage

``` r
is_continuous(x)
```

## Arguments

- x:

  An `<epiparameter>` object.

## Value

A boolean `logical`.

## Details

The `<epiparameter>` class can hold `<distribution>` and `<distcrete>`
probability distribution objects from the distributional package and the
distcrete package, respectively. `<distribution>` objects can be
continuous or discrete distributions (e.g. gamma or negative binomial),
and all `<distcrete>` objects are discrete.

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
is_continuous(ep)
#> [1] TRUE
is_continuous(discretise(ep))
#> [1] FALSE

ep <- epiparameter(
  disease = "ebola",
  epi_name = "offspring distribution",
  prob_distribution = create_prob_distribution(
    prob_distribution = "nbinom",
    prob_distribution_params = c(mean = 2, dispersion = 0.5)
  )
)
#> Citation cannot be created as author, year, journal or title is missing
is_continuous(ep)
#> [1] FALSE
```
