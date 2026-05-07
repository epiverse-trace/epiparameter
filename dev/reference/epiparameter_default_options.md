# Package options

Options to modify the printing of epiparameter objects. Currently
options are only used to modify the printing of the
`<multi_epiparameter>` class.

## Usage

``` r
epiparameter_default_options
```

## Format

An object of class `list` of length 3.

## Details

Options are set with [`options()`](https://rdrr.io/r/base/options.html)
and retrieved with [`getOption()`](https://rdrr.io/r/base/options.html).
The epiparameter options are stored as a single named list under the
`"epiparameter"` option. For example:

    options(epiparameter = list(print_max = 10, print_min = 5))

Options set before epiparameter is loaded (e.g. in the user's
`.Rprofile`) are honoured: when the package is attached, any
user-supplied values are merged with the package defaults, and only
fields the user has not specified are filled in with defaults. Options
can also be changed after the package is loaded and take effect
immediately.
