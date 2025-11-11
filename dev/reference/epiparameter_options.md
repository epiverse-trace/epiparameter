# Package options

Options to modify the printing of epiparameter objects. Currently
options are only used to modify the printing of the
`<multi_epiparameter>` class.

## Usage

``` r
epiparameter_options
```

## Format

An object of class `list` of length 2.

## Details

Options are set with [`options()`](https://rdrr.io/r/base/options.html)
and retrieved with [`getOption()`](https://rdrr.io/r/base/options.html).

If options are changed the epiparameter package will need to be reloaded
for new options to be taken into account. Options can be set in the
`.Rprofile` to persist across R sessions.
