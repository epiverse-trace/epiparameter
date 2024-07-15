# epiparameter (development version)

# epiparameter 0.2.0

The second release of the {epiparameter} R package focuses on interoperability with the [{epireview} R package](https://mrc-ide.github.io/epireview/). Several functions have been refactored and enhanced.

This release benefited from feedback from the participants of an [EpiParameter Community workshop hosted by the World Health Organisation](https://who-collaboratory.github.io/collaboratory-epiparameter-community/#/pages/news).

## New features

* The `as_epidist()` S3 generic has been added to the package for the coercion of other R objects into `<epidist>` objects. The `as_epidist.data.frame()` method is added, as well as the internal functions `is_epireview()` which determines if a `<data.frame>` is from {epireview}, and `epireview_to_epidist()` performs the conversion  (#298, #334 & #335)

* The `epireview_core_cols.rda` data is added to the package. This is used to determine whether the input to `as_epidist.data.frame()` is a parameter table from {epireview} as these objects do not have a recognisable class attribute (#298).

* A new website only vignette (i.e. [article](https://r-pkgs.org/vignettes.html#sec-vignettes-article)) `data_from_epireview.Rmd` is added that explains how to use `as_epidist()` with data from {epireview} (#298 & #335).

* A new vignette `database.Rmd` is added to the package to provide a web interface to the {epiparameter} library of epidemiological parameters. Contributed by @sbfnk (#311).

* The plotting method for `<epidist>` objects (`plot.epidist()`) has been improved to better differentiate continuous from discrete or discretised distributions (#315). 

* `epidist_db(..., single_epidist = TRUE)` now prioritises parameter entries that account for right truncation (#323).

* `create_epidist_prob_dist()` (previously named `create_prob_dist()`) is now exported and enables more control of discretisation settings by allowing arguments to be passed to `distcrete::distcrete()` via `...` (#324).

* The `<multi_epidist>` print method (`print.multi_epidist()`) has been improved to provides object information in the print header, the first few elements of the list or all elements if list is short, and some extra links and advice in the print footer. The design of the print method follows the design pattern of [{pillar}](https://pillar.r-lib.org/index.html) (#326).

* `<epidist>` objects and functions that work with `<epidist>` objects now work with exponential distributions (#333).

* The package now has an explicit data license: [CC0](https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt) in the `LICENSE` file.

## Breaking changes

* `list_distributions()` has been replaced by `parameter_tbl()` which enhances the printing by leveraging {pillar} (#321).

* The `<vb_epidist>` plotting method (`plot.vb_epidist()`) has been removed from the package. This provided minimal functionality and was unnecessarily complicating the function signature of `plot.epidist()` (#315).

## Bug fixes

* DOI and PMID are lowercase throughout the package to resolve issues with older versions of R (see issue #301) (#317).

## Deprecated and defunct

* None

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
