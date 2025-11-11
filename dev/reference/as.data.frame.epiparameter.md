# [`as.data.frame()`](https://rdrr.io/r/base/as.data.frame.html) method for `<epiparameter>` class

[`as.data.frame()`](https://rdrr.io/r/base/as.data.frame.html) method
for `<epiparameter>` class

## Usage

``` r
# S3 method for class 'epiparameter'
as.data.frame(x, ...)
```

## Arguments

- x:

  An `<epiparameter>` object.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Not used, extra arguments
  supplied will cause a warning.

## Value

A `<data.frame>` with a single row.

## Details

The `<data.frame>` returned will contain some atomic columns (i.e. one
object per row), and other columns that are lists (i.e. multiple objects
per row). The list columns can contain lists or S3 objects (e.g.
`<bibentry>` object in the `citation` column).

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
as.data.frame(ep)
#>    disease   pathogen                 epi_name prob_distribution  uncertainty
#> 1 COVID-19 SARS-CoV-2 onset to hospitalisation      lN(0.95,.... list(unc....
#>   summary_stats     citation     metadata method_assess
#> 1  9.7, c(5.... list(aut.... days, 15....  TRUE, TR....
#>                                                                                                                         notes
#> 1 This dataset includes only surviving patients. This method applies right-truncation but only fits a lognormal distribution.
```
