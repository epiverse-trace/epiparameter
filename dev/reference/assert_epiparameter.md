# Assert an object is a valid `<epiparameter>` object

Assert an object is a valid `<epiparameter>` object

## Usage

``` r
assert_epiparameter(x)
```

## Arguments

- x:

  An R object.

## Value

Invisibly returns an `<epiparameter>`. Called for side-effects (errors
when invalid `<epiparameter>` object is provided).

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
assert_epiparameter(ep)

# example with invalid <epiparameter>
ep$disease <- NULL
try(assert_epiparameter(ep))
#> Error : <epiparameter> is invalid due to:
#>   - <epiparameter> must contain $disease.
#>   - <epiparameter> must contain one disease.
#> 
```
