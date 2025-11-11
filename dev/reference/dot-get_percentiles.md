# Convert a vector of named percentiles into correct format and selects two values for parameter extraction

Parameters of a probability distribution can be extracted using the
values given at percentiles of the distribution and the percentiles
using
[`extract_param()`](https://epiverse-trace.github.io/epiparameter/dev/reference/extract_param.md).
`.get_percentiles()` takes a named vector of percentiles (names) and
values at those percentiles (elements in the vector) and selects two
values as lower and upper percentiles to be used in extraction. If a
lower and upper percentile are not available `NA` is returned.

It also formats the vector names so that they can be correctly converted
to numeric using [`as.numeric()`](https://rdrr.io/r/base/numeric.html).

## Usage

``` r
.get_percentiles(percentiles)
```

## Arguments

- percentiles:

  A named vector of values at percentiles with the names the
  percentiles. See Details for the accepted vector name format.

## Value

A named `numeric` vector of percentiles.

## Details

The name format is a character of the value of the percentile. Numbers
with decimal places should have the decimal point in the name. For
example the 5th and 95th percentile can be given as

    .get_percentiles(c("5" = 1, "95" = 10))

or the 2.5th and 97.5th percentile can be given as

    .get_percentiles(c("2.5" = 1, "97.5" = 10))
