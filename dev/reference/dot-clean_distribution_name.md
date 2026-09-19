# Standardise a probability distribution name

Converts a probability distribution name to the name used by R, so that
distributions can be given with any capitalisation and by their full
name as well as the R name. For example, `"Negative binomial"`,
`"negbinom"` and `"nbinom"` all give `"nbinom"`.

## Usage

``` r
.clean_distribution_name(x)
```

## Arguments

- x:

  A `character` string with the name of a probability distribution.

## Value

A `character` string.

## Details

Names are cleaned with
[`.clean_string()`](https://epiverse-trace.github.io/epiparameter/dev/reference/dot-clean_string.md)
before being matched, so capitalisation, surrounding whitespace, and
underscores or hyphens in place of spaces are all accepted. Names that
are not recognised as an alias are returned cleaned but otherwise
unchanged, leaving them to be validated by the calling function.
