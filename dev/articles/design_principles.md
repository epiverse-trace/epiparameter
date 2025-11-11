# Design Principles for {epiparameter}

This vignette outlines the design decisions that have been taken during
the development of the {epiparameter} R package, and provides some of
the reasoning, and possible pros and cons of each decision.

This document is primarily intended to be read by those interested in
understanding the code within the package and for potential package
contributors.

## Scope

The {epiparameter} R package is a library of epidemiological parameters,
and provides a class (i.e. data structure) and helper functions for
working with epidemiological parameters and distributions. The
`<epiparameter>` class is the main functional object for working with
epidemiological parameters and can hold information on delay
distributions (e.g. incubation period, serial interval, onset-to-death
distribution) and offspring distributions. The class has a number of
methods, including allowing the user to easily calculate the PDF, CDF,
and quantile, generate random numbers, calculate the distribution mean,
and plot the distribution. An `<epiparameter>` object can be created
with the constructor function
[`epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter.md),
and if uncertain whether an object is an `<epiparameter>`, it can be
validated with
[`assert_epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/assert_epiparameter.md).

The package also converts distribution parameters to summary statistics,
and vice versa. This is achieved either by conversion or extraction and
both of these methods and the functions used are explained in the
[Parameter extraction and conversion in {epiparameter}
vignette](https://epiverse-trace.github.io/epiparameter/dev/articles/extract_convert.md).

## Output

The output of the
[`epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter.md)
constructor function is an `<epiparameter>` object. This is a list of
nine elements, where each element is either a single type
(e.g. `character`), a non-nested `list` or another class. Classes as
`<epiparameter>` elements are used when there is existing well developed
infrastructure for handling certain data types. The `$prod_dist` element
uses a distribution class – if there is a parameterised distribution
available – using either the `<distribution>` class from
{distributional} or the `<distcrete>` class from {distcrete}. The
`$citation` is handled using the `<bibentry>` class from the {utils}
package (included as part of the base R recommended packages).

Other functions return the simplest type possible, this may be an atomic
vector (including single element vectors), or un-nested lists.

## Package architecture

Much of the {epiparameter} package is centred around the
`<epiparameter>` class. Here is a diagram showing the class with it’s S3
methods (the diagram below is interactive so can adjusted if labels are
overlapping).

    #> This diagram is out of date, as new methods have been added to the package which are not included.

## Design decisions

- The `<epiparameter>` class is designed to be a core unit for working
  with epidemiological parameters. It is designed in parallel to other
  epidemiological data structures such as a the `<contactmatrix>` class
  from the [{contactmatrix} R
  package](https://socialcontactdata.github.io/contactmatrix/index.html).
  The design principles of the `<epiparameter>` class are aligned with
  the [`<contactmatrix>` design
  principles](https://socialcontactdata.github.io/contactmatrix/articles/design-principles.html).
  These include:

  - A `new_*<class>()` constructor
  - Two validation functions
    - `assert_<class>()`
    - `test_<class>()`
  - An `is_<class>()` checker to determine if an object is of a given
    class (without checking the validity of class)
  - Coercion generic `as_<class>()`.

- The conversion functions (`convert_*`) are S3 generic functions with
  methods provided by {epiparameter} for `character` and
  `<epiparameter>` input. This follows the design pattern of other
  packages, such as [{dplyr}](https://dplyr.tidyverse.org/), which
  export their key data transformation functions as S3 generics to allow
  other developers to extend the conversions to other data objects.

- The conversion functions are designed to have a single function
  exported to the user for summary statistics to parameters, and another
  function exported for parameters to summary statistics. These
  functions use a [`switch()`](https://rdrr.io/r/base/switch.html) to
  dispatch to the internal conversion functions. This provides a minimal
  number of conversion functions in the package namespace compared to
  exporting a conversion function for every distribution.

- If there are a large number of entries returned when reading
  epidemiological parameters from the library using the
  [`epiparameter_db()`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter_db.md)
  function, it can flood the console, due to the default `list` printing
  in R. This is the reasoning for the `<multi_epiparameter>` object
  which is a minimal class to enable cleaner and more descriptive
  printing for a large list of `<epiparameter>` objects. The
  [`print.multi_epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/print.multi_epiparameter.md)
  prints a header with metadata on the number of `<epiparameter>`
  objects and number of diseases and epidemiological distributions in
  the list. It also lists all the diseases and epidemiological
  parameters returned. The footer of the
  [`print()`](https://rdrr.io/r/base/print.html) function states the
  number of `<epiparameter>` objects not shown, guides to use
  `print(n = ...)` and
  [`parameter_tbl()`](https://epiverse-trace.github.io/epiparameter/dev/reference/parameter_tbl.md)
  and a link to the online database vignette (`database.Rmd`).
  Information in the header and footer considered metadata or advice is
  prefixed with `#`.

- The package uses S3 classes and S3 dispatch for exported functions,
  and [`switch()`](https://rdrr.io/r/base/switch.html) and
  [`do.call()`](https://rdrr.io/r/base/do.call.html) for dispatching to
  internal functions. This is because it is easier to develop and debug
  internal functions that do not use S3 dispatch and avoids having to
  ensure that S3 methods are registered. Examples of S3 dispatch for
  exported functions are
  [`get_parameters()`](https://epiverse-trace.github.io/epiparameter/dev/reference/get_parameters.md)
  and
  [`convert_summary_stats_to_params()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_summary_stats_to_params.md).
  Examples of internal dispatch using
  [`switch()`](https://rdrr.io/r/base/switch.html) and
  [`do.call()`](https://rdrr.io/r/base/do.call.html) are
  `clean_params()` and
  [`convert_params_to_summary_stats.character()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_params_to_summary_stats.md).

- The function naming convention is for internal functions to have a dot
  (.) prefix
  (e.g. [`.convert_params_lnorm()`](https://epiverse-trace.github.io/epiparameter/dev/reference/dot-convert_params_lnorm.md)).
  The only function that breaks with this convention is
  [`new_epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/new_epiparameter.md)
  as advanced users of the package may want to call in the internal
  low-level constructor, and adding a dot prefix to this function may
  make it harder for users to find.

## Dependencies

The aim is to restrict the number of dependencies to a minimal required
set for ease of maintenance. The current hard dependencies are:

- [{checkmate}](https://CRAN.R-project.org/package=checkmate)
- [{distributional}](https://CRAN.R-project.org/package=distributional)
- [{distcrete}](https://CRAN.R-project.org/package=distcrete)
- {stats}
- {utils}

{stats} and {utils} are distributed with the R language so are viewed as
a lightweight dependencies, that should already be installed on a user’s
machine if they have R. {checkmate} is an input checking package widely
used across Epiverse-TRACE packages. {distributional} and {distcrete}
are used to import S3 classes for handling and working with
distributions. Both are required as only {distcrete} can handle
discretised distributions.

Currently {epiparameter} deviates from the [Epiverse policy on the
number of previous R versions it
supports](https://epiverse-trace.github.io/blueprints/dependencies.html#base-r-support-schedule).
The {epiparameter} package requires R version \>= 4.1.0 which only
includes the current version and the last three minor R versions rather
than the policy of four minor versions, as of September 2024. The
reasons for this change is to enable usage of the base R pipe (`|>`).

## Contribute

In addition to the [package contributing
guide](https://github.com/epiverse-trace/.github/blob/main/CONTRIBUTING.md),
please refer to the [{epiparameter} specific contributing guidelines for
adding epidemiological parameter to the package
library](https://epiverse-trace.github.io/epiparameter/articles/data_protocol.html#contributing-to-the-package).
