# Discretises a continuous distribution in an `<epiparameter>` object

Discretises a continuous distribution in an `<epiparameter>` object

## Usage

``` r
discretise(x, ...)

discretize(x, ...)

# S3 method for class 'epiparameter'
discretise(x, ...)

# Default S3 method
discretise(x, ...)
```

## Arguments

- x:

  An `<epiparameter>` object.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Extra arguments to be passed
  to the method.

## Value

An `<epiparameter>` object.

## Details

Converts the S3 distribution object in an `<epiparameter>` from
continuous (using an object from the `{distributional}` package) to a
discretised distribution (using an object from the `{distcrete}`
package).

## Examples

``` r
ebola_incubation <- epiparameter(
  disease = "ebola",
  epi_name = "incubation_period",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  )
)
#> Citation cannot be created as author, year, journal or title is missing
discretise(ebola_incubation)
#> Disease: ebola
#> Pathogen: NA
#> Epi Parameter: incubation period
#> Study: (????). “No citation.”
#> Distribution: discrete gamma (NA)
#> Parameters:
#>   shape: 1.000
#>   scale: 1.000
```
