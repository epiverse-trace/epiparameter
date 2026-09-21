# Design Principles for {epiparameter}

This vignette outlines the design decisions that have been taken during
the development of the {epiparameter} R package, and provides some of
the reasoning, and possible pros and cons of each decision.

This document is primarily intended to be read by those interested in
understanding the code within the package and for potential package
contributors.

## Scope

The {epiparameter} R package has three components: a library of
epidemiological parameters, a class (i.e. data structure) for
representing a parameter, and helper functions for working with
parameters and distributions. What falls inside and outside the scope of
each is set out below.

The library is loaded from the
[{epiparameterDB}](https://CRAN.R-project.org/package=epiparameterDB) R
package rather than being stored here, so that the parameters can be
released under CC0; an package cannot be dual licensed.

### Library of epidemiological parameters

In scope:

- A relatively small set of parameters to develop and test the package
  against, and to draw on in examples, vignettes and tutorials.
- Parameters needed by {epiparameter}, other Epiverse-TRACE packages or
  tutorials that are not available from grEPI or {epireview}.
- Trialling new representations and features before they are adopted
  more widely.

Out of scope:

- Growing into a comprehensive repository of epidemiological parameters.
  That role belongs to grEPI and {epireview}, both of which can be read
  into `<epiparameter>` objects (see the [Epidemiological parameter data
  sources](https://epiverse-trace.github.io/epiparameter/dev/articles/data_sources.md)
  vignette).
- Individual-level data from which parameters were estimated.
- The methodology of systematic literature searching, extraction and
  review, which is carried out by the databases that curate parameters.

### The `<epiparameter>` class and methods

In scope:

- A single epidemiological parameter, reported by a single study, for a
  single disease. Delay distributions (e.g. incubation period, serial
  interval, onset-to-death) and offspring distributions were the
  original focus, and other parameters are also represented.
- A parameterised probability distribution, summary statistics, or both,
  supporting distribution families commonly used to represent
  epidemiological parameters. Distributions may be discretised,
  truncated, or offset to allow support below zero.
- The provenance and context of the estimate: its citation, the units,
  sample size, region, transmission mode, etc., and an assessment of
  whether the estimate accounts for censoring, truncation or phase bias.
- Methods giving the distribution functions of a parameterised
  `<epiparameter>` (e.g. the PDF or PMF, CDF, quantiles, random number
  generation and the mean).
- Methods for inspecting and displaying an `<epiparameter>`
  (e.g. [`print()`](https://rdrr.io/r/base/print.html) and
  [`plot()`](https://rdrr.io/r/graphics/plot.default.html)), the
  accessors
  [`get_parameters()`](https://epiverse-trace.github.io/epiparameter/dev/reference/get_parameters.md),
  and
  [`get_citation()`](https://epiverse-trace.github.io/epiparameter/dev/reference/get_citation.md),
  and coercion with
  [`as.data.frame()`](https://rdrr.io/r/base/as.data.frame.html) and
  [`as.function()`](https://rdrr.io/r/base/as.function.html).
- Methods that return another `<epiparameter>`:
  [`discretise()`](https://epiverse-trace.github.io/epiparameter/dev/reference/discretise.md)
  to discretise a continuous distribution, and
  [`aggregate()`](https://rdrr.io/r/stats/aggregate.html) to combine a
  `<multi_epiparameter>` into a single `<epiparameter>` holding a
  mixture distribution.

Out of scope:

- The individual-level data the estimate was derived from.
- Separate classes for particular kinds of parameter. A `<vb_epidist>`
  class for vector-borne parameters was introduced and later removed
  (#359).

### Helper functions

Helper functions are those that work with epidemiological parameters and
distributions (not including `<epiparameter>` class methods).

In scope:

- Converting between the parameters of a distribution and its summary
  statistics with
  [`convert_params_to_summary_stats()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_params_to_summary_stats.md)
  and
  [`convert_summary_stats_to_params()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_summary_stats_to_params.md),
  and extracting parameters from reported summary statistics such as
  percentiles or a median and range with
  [`extract_param()`](https://epiverse-trace.github.io/epiparameter/dev/reference/extract_param.md).
  Both are explained in the [Parameter extraction and conversion in
  {epiparameter}
  vignette](https://epiverse-trace.github.io/epiparameter/dev/articles/extract_convert.md).
- Reading parameters from the supported databases with
  [`epiparameter_db()`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter_db.md),
  and coercing objects from other packages into `<epiparameter>` objects
  with
  [`as_epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/as_epiparameter.md).
- Constructing the components of an `<epiparameter>` with the
  `create_*()` helpers, and summarising a set of parameters in tabular
  form with
  [`parameter_tbl()`](https://epiverse-trace.github.io/epiparameter/dev/reference/parameter_tbl.md).

Out of scope:

- Estimating epidemiological parameters from data. Fitting a
  distribution to individual-level data – for example observed delays in
  a line list – requires accounting for interval censoring, right
  truncation and epidemic phase bias, and is the domain of specialist
  packages such as
  [{primarycensored}](https://primarycensored.epinowcast.org/),
  [{epidist}](https://epidist.epinowcast.org/) and
  [{EpiNow2}](https://epiforecasts.io/EpiNow2/).
  [`extract_param()`](https://epiverse-trace.github.io/epiparameter/dev/reference/extract_param.md)
  does perform an optimisation to recover distribution parameters from
  reported summary statistics, and not from observed data. Parameters
  estimated elsewhere can be brought into the package by constructing an
  `<epiparameter>` object with
  [`epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter.md).
- Epidemiological analyses that use parameters as an input, such as
  estimating the reproduction number or simulating an outbreak. These
  are the domain of other packages, and examples of {epiparameter} used
  alongside them are published in the [Epiverse-TRACE how-to
  guides](https://epiverse-trace.github.io/howto/).

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

- Distribution names supplied by the user are standardised before they
  are matched, rather than being required to match exactly. Names are
  matched without regard to capitalisation, and the full name of a
  distribution is accepted alongside the name used by , so `"nbinom"`,
  `"negbinom"` and `"Negative binomial"` are equivalent. This is handled
  by
  [`.clean_distribution_name()`](https://epiverse-trace.github.io/epiparameter/dev/reference/dot-clean_distribution_name.md),
  which cleans the name with
  [`.clean_string()`](https://epiverse-trace.github.io/epiparameter/dev/reference/dot-clean_string.md)
  and then maps a recognised full name onto its name. It is used by both
  [`create_prob_distribution()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_prob_distribution.md)
  and the conversion functions, and new functions taking a distribution
  name from the user should use it too, so that the package behaves
  consistently wherever a distribution is named. The names accepted as
  aliases are those used by grEPI (see `R/grepi.R`), so that the package
  has a single vocabulary for distributions rather than one per data
  source. Internally the name is always the canonical form;
  standardising on input keeps the tolerance at the package boundary and
  leaves internal code able to match exactly.

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
see the [Epidemiological parameter data
sources](https://epiverse-trace.github.io/epiparameter/articles/data_sources.html)
vignette for where epidemiological parameters are curated and how each
source is read into the package.
