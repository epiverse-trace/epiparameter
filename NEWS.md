# epiparameter 0.4.1

# epiparameter 0.4.0

The fourth minor release of the {epiparameter} focuses on splitting the code and data, with the data being moved into a separate R package: [{epiparameterDB}](https://CRAN.R-project.org/package=epiparameterDB). There are also some minor additional improvements focusing on printing and plotting.

## New features

* The library of epidemiological parameters (`parameters.json`) has been removed from the {epiparameter} package and moved to the {epiparameterDB} R package which is taken on as a dependency. The {epiparameter} package is licensed solely as MIT with dual licensing with CC0 removed (#415). 
* The data dictionary (`data_dictionary.json`) and JSON validation workflow (`validate-json.yaml`) have been removed from the package (#415).
* The library of epidemiological parameters is cached (using [{cachem}](https://CRAN.R-project.org/package=cachem)) on loading the package to reduce the runtime of `epiparameter_db()` (#417).
* The `print()` and `format()` methods for the `<epiparameter>` class have been improved to show the units of parameter estimates, as well as summary statistics, if available, for unparameterised `<epiparameter>` objects (#419).
* `on.exit()` is no longer called in plotting functions to allow user-specified graphical parameters to not be overwritten (#420).
* A `plot()` method for the `<multi_epiparameter>` class is added. This enables a list of `<epiparameter>` objects with continuous distributions to be compared on a single plot (#425).
* A `lines()` method for the `<epiparameter>` class is added (#425).

## Breaking changes

* None

## Bug fixes

* A bug in `is_continuous()` causing it to incorrectly returning `FALSE` for `<epiparameter>` objects with normal distributions is fixed (#422).

## Deprecated and defunct

* None

# epiparameter 0.3.0

The third minor release of the {epiparameter} R package contains a range of updates and improvements to the package. The principal aim of this release is to simplify, clarify and enhance the classes and class methods when working with epidemiological parameters in R. 

The are a large number of ***breaking changes*** in this release, primarily functions and function arguments being renamed or restructured, see the _Breaking changes_ section for an overview.

## New features

* The library of epidemiological parameters has been updated to include 3 new Chikungunya parameter entries. The Mpox parameters previously missing from the Guzzetta et al. entry have been added (#346 & #374).
* A `c()` method has been added for `<epiparameter>` and `<multi_epiparameter>` objects (#368).
* An `aggregate()` method has been added for `<multi_epiparameter>` to enable consensus distributions to be built utilising the mixture distribution class from [{distributional}](https://CRAN.R-project.org/package=distributional) (#388).
* Infrastructure has been added to the package to allow translations of messages/warnings/errors printed to the console. (@Bisaloo, #367).
* `convert_summary_stats_to_params()` can now convert from median and dispersion for a lognormal distribution (#378).
* The `data_dictionary.json` has been enhanced to improve validation of the library of epidemiological parameters (`parameters.json`) (#379).
* An interactive network showing all of the `<epiparameter>` S3 methods has been added to the `design_principles.Rmd` vignette (#383).
* The `data_from_epireview.Rmd` article has been improved and updated with new changes from {epireview} (@CarmenTamayo & @cm401 & @kellymccain28, #305 & #373).
* Parameter units have been added to every entry in the {epiparameter} library (`parameters.json`) and to the `$metadata` element in `<epiparameter>` objects. The `create_metadata()` function now has a `units` argument to construct metadata lists (#391).
* Improved `database.Rmd` vignette by adding a short citation to the reference column (@jamesmbaazam, #348).
* The `family()` method for `<epiparameter>` has been improved to allow access to distribution names for transformed (e.g. `mixture` and `truncated` distributions) and untransformed (e.g. `gamma` and `lognormal`) distributions with a new argument `base_dist` and a new internal function `.distributional_family()` (#398).
* `as_epiparameter()` can now work with the SARS parameters from {epireview} (#407).

## Breaking changes

* The `<epidist>` class has been renamed `<epiparameter>` to avoid confusion with the similar R package [{epidist}](https://github.com/epinowcast/epidist) (#360).
* Many functions that used `epidist` in their names have been renamed to use `epiparameter` due to the renaming of the class (#360).
* The function signatures of `epiparameter()` and `new_epiparameter()` functions (previously `epidist()` and `new_epidist()`) have been updated to collapse the `prob_dist`, `prob_dist_params`, `discretise` and `truncation` arguments into `prob_distribution`, which accepts the output of `create_prob_distribution()` (#381).
* The `epi_dist` argument has been renamed `epi_name`. This is to clarify that {epiparameter} can work with epidemiological parameters that take a variety of forms (e.g. point estimates, ranges, probability distributions, etc.) (#390).
* The `<vb_epidist>` class and it's methods have been removed from the package. It was not being used and was increasing the complexity and maintenance load of the package (#359).
* `create_prob_dist()` has been renamed to `create_prob_distribution()` (#381).
* `validate_epiparameter()` (previously `validate_epidist()`) has been renamed `assert_epiparameter()`, and `test_epiparameter()` has been added, with the aim to harmonise design with [{contactmatrix}](https://github.com/socialcontactdata/contactmatrix) and the messages and errors have been improved (#366 & #402).
* The minimum version of R required by the package is now 4.1.0 due to the use of the base R pipe (`|>`) in dependencies, and the R-CMD-check workflow on GitHub actions now explicitly runs on the minimum version of R stated in the `DESCRIPTION` (#384 & #405). 

## Bug fixes

* Epidemiological parameter entries in the library stored with lognormal distributions, parameterised as median and dispersion are now converted to meanlog and sdlog correctly when creating an `<epiparameter>` (when `auto_calc_params = TRUE`) (#381).

## Deprecated and defunct

* `epidist_db()` has been deprecated. It is replaced by `epiparameter_db()` (#360 & #399).

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
