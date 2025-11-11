# Create a distribution object

Creates an S3 class holding the distribution and parameters from the
probability distribution name, its parameters and distribution
truncation and discretisation.

The class holding the distribution depends on whether it is a
discretised distribution. For continuous and discrete distributions S3
classes from the distributional package are used, for discretised
continuous distributions the an S3 class from the distcrete package is
used.

For details on the properties of the distribution classes from each
respective package see their documentation (either `?distributional` or
`?distcrete`)

## Usage

``` r
create_prob_distribution(
  prob_distribution,
  prob_distribution_params,
  discretise = FALSE,
  truncation = NA,
  ...
)
```

## Arguments

- prob_distribution:

  A `character` string specifying the probability distribution. This
  should match the R naming convention of probability distributions
  (e.g. lognormal is `lnorm`, negative binomial is `nbinom`, and
  geometric is `geom`).

- prob_distribution_params:

  A named vector of probability distribution parameters.

- discretise:

  A boolean `logical` whether the distribution is discretised. Default
  is `FALSE` which assumes a continuous probability distribution.

- truncation:

  A `numeric` specifying the truncation point if the inferred
  distribution was truncated, `NA` if not or unknown.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Extra arguments to be passed
  to distributional or distcrete functions that construct the S3
  distribution objects. To see which arguments can be adjusted for
  discretised distributions see
  [`distcrete::distcrete()`](https://rdrr.io/pkg/distcrete/man/distcrete.html),
  for other distributions see the `?distributional` documentation and
  find the specific distribution constructor function, e.g. for the
  Gamma distribution see
  [`distributional::dist_gamma()`](https://pkg.mitchelloharawild.com/distributional/reference/dist_gamma.html).

## Value

An S3 class containing the probability distribution or a `character`
string if the parameters of the probability distribution are unknown.

## Details

Truncation is enabled only for continuous distributions as there is no
truncation implemented in distcrete.

By default the discretisation of continuous distributions uses a
discretisation interval (`interval`) of 1. If the unit of the
distribution is days, then this will be discretised by day. The endpoint
weighting (`w`) for the discretisation is 1. `w` can be `[0,1]`. For
more information please see
[`distcrete::distcrete()`](https://rdrr.io/pkg/distcrete/man/distcrete.html).

## Examples

``` r
# example with continuous distribution without truncation
create_prob_distribution(
  prob_distribution = "gamma",
  prob_distribution_params = c(shape = 1, scale = 1),
  discretise = FALSE,
  truncation = NA
)
#> <distribution[1]>
#> [1] Γ(1, 1)

# example with continuous distribution with truncation
create_prob_distribution(
  prob_distribution = "gamma",
  prob_distribution_params = c(shape = 1, scale = 1),
  discretise = FALSE,
  truncation = 10
)
#> <distribution[1]>
#> [1] Γ(1, 1)[-Inf,10]

# example with discrete distribution
create_prob_distribution(
  prob_distribution = "gamma",
  prob_distribution_params = c(shape = 1, scale = 1),
  discretise = TRUE,
  truncation = NA
)
#> A discrete distribution
#>   name: gamma
#>   parameters:
#>     shape: 1
#>     scale: 1

# example passing extra arguments to distcrete
create_prob_distribution(
  prob_distribution = "gamma",
  prob_distribution_params = c(shape = 1, scale = 1),
  discretise = TRUE,
  truncation = NA,
  w = 0.5
)
#> A discrete distribution
#>   name: gamma
#>   parameters:
#>     shape: 1
#>     scale: 1
```
