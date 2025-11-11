# Standardise distribution parameters

`.clean_params()` dispatches to a distribution specific parameter
cleaning function depending on `prob_dist`. For example
`prob_dist = "gamma"` will call `.clean_params_gamma()`.

## Usage

``` r
.clean_params(prob_distribution, prob_distribution_params)

.clean_params_gamma(prob_dist_params)

.clean_params_lnorm(prob_dist_params)

.clean_params_nbinom(prob_dist_params)

.clean_params_geom(prob_dist_params)

.clean_params_pois(prob_dist_params)

.clean_params_norm(prob_dist_params)

.clean_params_exp(prob_dist_params)
```

## Arguments

- prob_distribution:

  A `character` string specifying the probability distribution. This
  should match the R naming convention of probability distributions
  (e.g. lognormal is `lnorm`, negative binomial is `nbinom`, and
  geometric is `geom`).

- prob_distribution_params:

  A named vector of probability distribution parameters.

## Value

Named `numeric` vector of parameters.

## Details

Calling
[`is_epiparameter_params()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_epiparameter_params.md)
at the start of `.clean_params()` ensures that if the parameterisation
is incorrect that it will error early and dispatch to the distribution
specific cleaning functions (e.g. `.clean_params_gamma()`). This means
that the distribution specific parameter cleaning functions do not need
to check and error for incorrect parameterisation.
