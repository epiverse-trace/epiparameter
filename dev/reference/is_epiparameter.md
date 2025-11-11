# Check object is an `<epiparameter>`

Check object is an `<epiparameter>`

## Usage

``` r
is_epiparameter(x)
```

## Arguments

- x:

  An R object.

## Value

A boolean logical, `TRUE` if the object is an `<epiparameter>` and
`FALSE` if not.

## Examples

``` r
ep <- epiparameter(
  disease = "ebola",
  epi_name = "serial_interval",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  )
)
#> Citation cannot be created as author, year, journal or title is missing

is_epiparameter(ep)
#> [1] TRUE

false_ep <- list(
  disease = "ebola",
  epi_name = "serial_interval",
  prob_distribution = "gamma",
  prob_distribution_params = c(shape = 1, scale = 1)
)

is_epiparameter(false_ep)
#> [1] FALSE
```
