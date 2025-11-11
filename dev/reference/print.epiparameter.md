# Print method for `<epiparameter>` class

Print method for `<epiparameter>` class

## Usage

``` r
# S3 method for class 'epiparameter'
print(x, ...)
```

## Arguments

- x:

  An `<epiparameter>` object.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Extra arguments to be passed
  to the method.

## Value

Invisibly returns an `<epiparameter>`. Called for side-effects.

## Examples

``` r
epiparameter <- epiparameter(
  disease = "ebola",
  epi_name = "incubation_period",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  )
)
#> Citation cannot be created as author, year, journal or title is missing
epiparameter
#> Disease: ebola
#> Pathogen: NA
#> Epi Parameter: incubation period
#> Study: (????). “No citation.”
#> Distribution: gamma (NA)
#> Parameters:
#>   shape: 1.000
#>   scale: 1.000
```
