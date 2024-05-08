# epiparameter (development version)

# epiparameter 0.1.0

Initial release of the {epiparameter} R package. {epiparameter} provides:

1. A library of epidemiological parameters extracted from the literature for a range of diseases.

2. Functions and classes (with class methods) to work with epidemiological parameters and distributions.

## New features

* A library of 122 epidemiological parameter set from the epidemiological literature. This is accessible from the package as system data (`sysdata.rda`, as `epiparameter::multi_epidist`) or as internal data (`inst/extdata/parameters.json`).
* The `epidist_db()` function loads epidemiological parameters from the library.
* Distribution parameter conversion and extraction functions (`convert_params_to_summary_stats()` & `convert_summary_stats_to_params()`, and `extract_param()`).
* An S3 class to work with epidemiological parameters `<epidist>`. This class has S3 methods to aid users easily work with these data structures. These include printing, plotting, and distribution functions for PDF/PMF, CDF, random number generation and distribution quantiles. The `<epidist>` class has a constructor function, a validator function, accessors (`get_*()`), checkers (`is_*()`). There is also a `<vb_epidist>` S3 class for vector-borne parameters, and an internal `<multi_epidist>` class for improved printing of lists of `<epidist>` objects.
* The package contains a few utility functions. `list_distributions()` is a helper function to provide information from a list of `<epidist>` objects in tabular form. `calc_disc_dist_quantile()` calculates the quantiles of a probability distribution based on the vector of probabilities and time data.
* Five vignettes are included in this initial release. One as an introduction to the package (`epiparameter.Rmd`), one as an tutorial on converting and extracting parameters (`extract_convert.Rmd`), one on the protocol used to collect entries for the library of epidemiological parameters (`data_protocol.Rmd`), a design vignette (`design_principles.Rmd`), and a supplementary vignette which quantifies the bias from using the parameter extraction (`extract_param()`) from {epiparameter} (`extract-bias.Rmd`).
* Unit tests and documentation files.
* Continuous integration workflows for R package checks, rendering the README.md, calculating test coverage, deploying the pkgdown website, updates the package citation, linting package code, checking package or system dependency changes, updating copyright year, and validating the parameter library JSON file.

## Breaking changes

* None

## Bug fixes

* None

## Deprecated and defunct

* None
