# Get parameters from an `<epiparameter>` object

Extract the parameters of the distribution stored in an `<epiparameter>`
object.

## Usage

``` r
# S3 method for class 'epiparameter'
get_parameters(x, ...)

# S3 method for class 'multi_epiparameter'
get_parameters(x, ...)
```

## Arguments

- x:

  An `<epiparameter>` object.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Not used, extra arguments
  supplied will cause a warning.

## Value

A named vector of parameters or `NA` when the `<epiparameter>` object is
unparameterised.

## Details

The `<epiparameter>` object can be unparameterised in which it lacks a
probability distribution or parameters of a probability distribution, in
this case the `get_parameters.epiparameter()` method will return `NA`.

## Examples

``` r
ep <- epiparameter_db(
  disease = "COVID-19",
  epi_name = "serial interval",
  single_epiparameter = TRUE
)
#> Using Nishiura H, Linton N, Akhmetzhanov A (2020). “Serial interval of novel
#> coronavirus (COVID-19) infections.” _International Journal of
#> Infectious Diseases_. doi:10.1016/j.ijid.2020.02.060
#> <https://doi.org/10.1016/j.ijid.2020.02.060>.. 
#> To retrieve the citation use the 'get_citation' function
get_parameters(ep)
#>   meanlog     sdlog 
#> 1.3862617 0.5679803 
```
