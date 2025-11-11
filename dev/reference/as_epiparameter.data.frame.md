# Convert `<data.frame>` to an `<epiparameter>` object

Convert the tabular information in `<data.frame>` to an
`<epiparameter>`. If the information in the `<data.frame>` cannot be
converted into an `<epiparameter>` the function will error.

## Usage

``` r
# S3 method for class 'data.frame'
as_epiparameter(x, ...)
```

## Arguments

- x:

  A `<data.frame>`.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Not used, extra arguments
  supplied will cause a warning.

## Value

An `<epiparameter>` object or list of `<epiparameter>` objects.

## Examples

``` r
ep <- epiparameter_db(single_epiparameter = TRUE)
#> Using Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.. 
#> To retrieve the citation use the 'get_citation' function
df <- as.data.frame(ep)
ep <- as_epiparameter(df)
```
