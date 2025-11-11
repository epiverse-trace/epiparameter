# Convert summary statistics to parameters of the geometric distribution

Convert summary statistics of the geometric distribution the parameter
(`prob`) of the geometric distribution.

## Usage

``` r
.convert_summary_stats_geom(...)
```

## Arguments

- ...:

  \<[`dynamic-dots`](https://rlang.r-lib.org/reference/dyn-dots.html)\>
  `Numeric` named summary statistics used to convert to parameter(s). An
  example is the `mean` and `sd` summary statistics for the lognormal
  (`lnorm`) distribution.

## Value

A list of one element, the probability parameter.

## Details

This conversion function assumes that distribution represents the number
of failures before the first success (supported for zero). This is the
same form as used by base R and
[`distributional::dist_geometric()`](https://pkg.mitchelloharawild.com/distributional/reference/dist_geometric.html).
