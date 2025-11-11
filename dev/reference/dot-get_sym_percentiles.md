# Get the lower and upper percentiles with a preference for symmetrical percentiles

Get the lower and upper percentiles with a preference for symmetrical
percentiles

## Usage

``` r
.get_sym_percentiles(percentiles)
```

## Arguments

- percentiles:

  A named vector of percentiles. The names are in the correct format to
  be converted to their numeric value using
  [`as.numeric()`](https://rdrr.io/r/base/numeric.html).

## Value

A named `numeric` vector of two elements with the lower (first element)
and upper (second element) percentiles.
