# Get parameters from an object

Extract the parameters stored in an R object.

## Usage

``` r
get_parameters(x, ...)
```

## Arguments

- x:

  an object used to select a method.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Extra arguments to be passed
  to the method.

## Value

A named vector of parameters or `NA` when the `<epiparameter>` object is
unparameterised, or a list where each element is a named vectors or
`NA`.
