# Standardise distribution parameter uncertainty

Standardise distribution parameter uncertainty

## Usage

``` r
.clean_uncertainty(x, prob_distribution, uncertainty_missing)
```

## Arguments

- x:

  An `<epiparameter>` object.

- prob_distribution:

  An S3 class containing the probability distribution or a character
  string if the parameters of the probability distribution are unknown
  but the name of the distribution is known, or `NA` if the distribution
  name and parameters are unknown. Use
  [`create_prob_distribution()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_prob_distribution.md)
  to create `prob_distribution`.

- uncertainty_missing:

  A boolean `logical` as to whether `uncertainty` is missing (see
  [`missing()`](https://rdrr.io/r/base/missing.html)) from the parent
  function.

## Value

An uncertainty list for an `<epiparameter>` object.
