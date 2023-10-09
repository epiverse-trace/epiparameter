# epiparameter 0.1.0

Initial release of {epiparameter}, an R package to work with epidemiological parameters and distributions, and contains a library of epidemiological parameters.

## New features

* A library of epidemiological parameters (`parameters.json`) stored as internal data (inst/extdata).
* Distribution parameter conversion and extraction functions (`convert_params_to_summary_stats()` & `convert_summary_stats_to_params()`, and `extract_param()`).
* S3 classes to work with parameters `<epidist>`, `<epiparam>` and `<vb_epidist>`. These classes are accompanied by S3 methods to aid users easily work with these data structures. These include printing, plotting, and distribution functions for PDF/PMF, CDF, random number generation and distribution quantiles. Each class has a constructor and a validator. 
* The package contains a few utility functions.
* Four vignettes are included in this initial release. One as an introduction to the package (`epiparameter.Rmd`), one as an tutorial on converting and extracting parameters (`extract_convert.Rmd`), one on the protocol used to collect entries for the library of epidemiological parameters (`data_protocol.Rmd`) and a supplementary vignette which quantifies the bias from using the parameter extraction (`extract_param()`) from {epiparameter} (`extract-bias.Rmd`).
* Unit tests and documentation files.
* Continuous integration workflows for R package checks, rendering the README.md, calculating test coverage, deploying the pkgdown website, updates the package citation, and validating the parameter library JSON file.

## Breaking changes

* None

## Bug fixes

* None

## Deprecated and defunct

* None
