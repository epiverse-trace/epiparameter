# Family method for the `<epiparameter>` class

The [`family()`](https://rdrr.io/r/stats/family.html) function is used
to extract the distribution names from objects from `{distributional}`
and `{distcrete}`. This method provides the same interface for
`<epiparameter>` objects to give consistent output irrespective of the
internal distribution class.

## Usage

``` r
# S3 method for class 'epiparameter'
family(object, ..., base_dist = FALSE)
```

## Arguments

- object:

  An `<epiparameter>` object.

- ...:

  further arguments passed to methods.

- base_dist:

  A boolean `logical` for whether to return the name of a transformed
  distribution (e.g. `"mixture"` or `"truncated"`) or the underlying
  distribution type (e.g. `"gamma"` or `"lnorm"`). Default is `FALSE`.

## Value

A character string with the name of the distribution, or `NA` when the
`<epiparameter>` object is unparameterised.

## Examples

``` r
# example with continuous distribution
ep <- epiparameter(
  disease = "ebola",
  epi_name = "incubation_period",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  )
)
#> Citation cannot be created as author, year, journal or title is missing
family(ep)
#> [1] "gamma"

# example with discretised distribution
ep <- epiparameter(
  disease = "ebola",
  epi_name = "incubation_period",
  prob_distribution = create_prob_distribution(
    prob_distribution = "lnorm",
    prob_distribution_params = c(meanlog = 1, sdlog = 1),
    discretise = TRUE
  )
)
#> Citation cannot be created as author, year, journal or title is missing
family(ep)
#> [1] "lnorm"
```
