# Get the underlying distributions names from a `<distribution>` object from the distributional package in R distribution naming convention.

Get the underlying distributions names from a `<distribution>` object
from the distributional package in R distribution naming convention.

## Usage

``` r
.distributional_family(x, base_dist = TRUE)
```

## Arguments

- x:

  An `<distribution>` object.

- base_dist:

  A boolean `logical` for whether to return the name of a transformed
  distribution (e.g. `"mixture"` or `"truncated"`) or the underlying
  distribution type (e.g. `"gamma"` or `"lnorm"`). Default is `TRUE`.

## Value

A `character` vector.

## Details

Get and standardise distribution name. For untransformed distributions
(e.g.
[`distributional::dist_gamma()`](https://pkg.mitchelloharawild.com/distributional/reference/dist_gamma.html))
it will return the distribution name. For transformed distributions
(e.g.
[`distributional::dist_mixture()`](https://pkg.mitchelloharawild.com/distributional/reference/dist_mixture.html))
it will get the name of the underlying distribution(s) by default
(`base_dist = TRUE`). Distribution names are returned in the R naming
style (e.g. lognormal is `"lnorm"`). When `base_dist = FALSE`
transformed distributions return the name of the transformation (e.g.
`"mixture"`).
