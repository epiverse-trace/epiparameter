# PDF, CDF, PMF, quantiles and random number generation for `<epiparameter>` objects

The `<epiparameter>` object holds a probability distribution which can
either be a continuous or discrete distribution. These are the density,
cumulative distribution, quantile and random number generation
functions. These operate on any distribution that can be included in an
`<epiparameter>` object.

## Usage

``` r
# S3 method for class 'epiparameter'
density(x, at, ...)

# S3 method for class 'epiparameter'
cdf(x, q, ..., log = FALSE)

# S3 method for class 'epiparameter'
quantile(x, p, ...)

# S3 method for class 'epiparameter'
generate(x, times, ...)
```

## Arguments

- x:

  An `<epiparameter>` object.

- at:

  The quantiles to evaluate at.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Extra arguments to be passed
  to the method.

- q:

  The quantiles to evaluate at.

- log:

  If `TRUE`, probabilities will be given as log probabilities.

- p:

  The probabilities to evaluate at.

- times:

  The number of random samples.

## Value

`numeric` vector.

## Examples

``` r
ep <- epiparameter(
  disease = "ebola",
  epi_name = "incubation_period",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  )
)
#> Citation cannot be created as author, year, journal or title is missing

# example of each distribution method for an `epiparameter` object
stats::density(ep, at = 1)
#> [1] 0.3678794
distributional::cdf(ep, q = 1)
#> [1] 0.6321206
stats::quantile(ep, p = 0.2)
#> [1] 0.2231436
distributional::generate(ep, times = 10)
#>  [1] 3.56720380 1.16790186 0.05745463 0.34040705 3.47156091 1.04366207
#>  [7] 3.02627506 0.36756952 0.09970044 0.78957870
```
