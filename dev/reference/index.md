# Package index

## epiparameter classes

### epiparameter object

Class constructor, validator, and methods

- [`epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter.md)
  :

  Create an `<epiparameter>` object

- [`discretise()`](https://epiverse-trace.github.io/epiparameter/dev/reference/discretise.md)
  [`discretize()`](https://epiverse-trace.github.io/epiparameter/dev/reference/discretise.md)
  :

  Discretises a continuous distribution in an `<epiparameter>` object

- [`as.data.frame(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/as.data.frame.epiparameter.md)
  :

  [`as.data.frame()`](https://rdrr.io/r/base/as.data.frame.html) method
  for `<epiparameter>` class

- [`as.function(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/as.function.epiparameter.md)
  :

  [`as.function()`](https://rdrr.io/r/base/as.function.html) method for
  `<epiparameter>` class

- [`c(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/c.epiparameter.md)
  [`c(`*`<multi_epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/c.epiparameter.md)
  :

  [`c()`](https://rdrr.io/r/base/c.html) method for `<epiparameter>`
  class

- [`family(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/family.epiparameter.md)
  :

  Family method for the `<epiparameter>` class

- [`format(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/format.epiparameter.md)
  :

  Format method for `<epiparameter>` class

- [`get_citation(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/get_citation.epiparameter.md)
  :

  Get citation from an `<epiparameter>` object

- [`get_parameters(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/get_parameters.epiparameter.md)
  [`get_parameters(`*`<multi_epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/get_parameters.epiparameter.md)
  :

  Get parameters from an `<epiparameter>` object

- [`is_parameterised()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_parameterised.md)
  [`is_parameterized()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_parameterised.md)
  :

  Check if `<epiparameter>` or list of `<epiparameter>` objects contains
  a distribution and distribution parameters

- [`lines(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/lines.epiparameter.md)
  :

  [`lines()`](https://rdrr.io/r/graphics/lines.html) method for
  `<epiparameter>` class

- [`mean(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/mean.epiparameter.md)
  :

  Mean method for `<epiparameter>` class

- [`plot(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/plot.epiparameter.md)
  :

  Plot method for `<epiparameter>` class

- [`print(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/print.epiparameter.md)
  :

  Print method for `<epiparameter>` class

- [`assert_epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/assert_epiparameter.md)
  :

  Assert an object is a valid `<epiparameter>` object

- [`test_epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/test_epiparameter.md)
  :

  Test whether an object is a valid `<epiparameter>` object

- [`aggregate(`*`<multi_epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/aggregate.multi_epiparameter.md)
  :

  Aggregate multiple `<epiparameter>` objects into a single
  `<epiparameter>` object.

- [`as.data.frame(`*`<multi_epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/as.data.frame.multi_epiparameter.md)
  :

  [`as.data.frame()`](https://rdrr.io/r/base/as.data.frame.html) method
  for `<multi_epiparameter>` class

- [`get_citation(`*`<multi_epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/get_citation.multi_epiparameter.md)
  :

  Get citation from a list of `<epiparameter>` objects

- [`plot(`*`<multi_epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/plot.multi_epiparameter.md)
  :

  [`plot()`](https://rdrr.io/r/graphics/plot.default.html) method for
  `<multi_epiparameter>` class

- [`print(`*`<multi_epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/print.multi_epiparameter.md)
  :

  Print method for `<multi_epiparameter>` class

## Accessors

Get data from epi classes

- [`get_citation()`](https://epiverse-trace.github.io/epiparameter/dev/reference/get_citation.md)
  : Get citation from an object
- [`get_parameters()`](https://epiverse-trace.github.io/epiparameter/dev/reference/get_parameters.md)
  : Get parameters from an object

## epiparameter helper functions

Functions to help construct `<epiparameter>` objects

- [`create_citation()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_citation.md)
  :

  Create a citation for an `<epiparameter>` object

- [`create_metadata()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_metadata.md)
  : Specify metadata associated with data set

- [`create_method_assess()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_method_assess.md)
  : Specify methodological aspects of distribution fitting

- [`create_prob_distribution()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_prob_distribution.md)
  : Create a distribution object

- [`create_region()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_region.md)
  : Specify the geography of the data entry

- [`create_summary_stats()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_summary_stats.md)
  : Specify reported summary statistics

- [`create_uncertainty()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_uncertainty.md)
  : Specify distribution parameter uncertainty

## epiparameter from {epiparameter} library

Retrieve `<epiparameter>` object directly from database

- [`epiparameter_db()`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter_db.md)
  :

  Create `<epiparameter>` object(s) directly from the epiparameter
  library (database)

## Coercion

Convert data from and to `<epiparameter>`

- [`as_epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/as_epiparameter.md)
  :

  Convert to an `<epiparameter>` object

- [`as_epiparameter(`*`<data.frame>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/as_epiparameter.data.frame.md)
  :

  Convert `<data.frame>` to an `<epiparameter>` object

## Explore epiparameters

Table of epi parameters

- [`parameter_tbl()`](https://epiverse-trace.github.io/epiparameter/dev/reference/parameter_tbl.md)
  : Table of epidemiological distributions

## Distribution functions

Functions for operating on `<epiparameter>` distributions

- [`density(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter_distribution_functions.md)
  [`cdf(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter_distribution_functions.md)
  [`quantile(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter_distribution_functions.md)
  [`generate(`*`<epiparameter>`*`)`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter_distribution_functions.md)
  :

  PDF, CDF, PMF, quantiles and random number generation for
  `<epiparameter>` objects

## Parameter extraction

Extract distribution parameters from summary statistics

- [`extract_param()`](https://epiverse-trace.github.io/epiparameter/dev/reference/extract_param.md)
  : Calculate the parameters of a parametric probability distribution
  from reported values of percentiles, or median and range

## Parameter conversion

Convert distribution parameter to summary statistics and vice versa

- [`convert_params_to_summary_stats()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_params_to_summary_stats.md)
  : Convert the parameter(s) of a distribution to summary statistics
- [`convert_summary_stats_to_params()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_summary_stats_to_params.md)
  : Convert the summary statistics of a distribution to parameters

## Epi object checking

Check an object is of a certain type or feature

- [`is_continuous()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_continuous.md)
  :

  Check if distribution in `<epiparameter>` is continuous

- [`is_epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_epiparameter.md)
  :

  Check object is an `<epiparameter>`

- [`is_epiparameter_params()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_epiparameter_params.md)
  : Check whether the vector of parameters for the probability
  distribution are in the set of possible parameters used in the
  epiparameter package

- [`is_parameterised()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_parameterised.md)
  [`is_parameterized()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_parameterised.md)
  :

  Check if `<epiparameter>` or list of `<epiparameter>` objects contains
  a distribution and distribution parameters

- [`is_truncated()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_truncated.md)
  :

  Check if distribution in `<epiparameter>` is truncated

## Utility function

- [`calc_disc_dist_quantile()`](https://epiverse-trace.github.io/epiparameter/dev/reference/calc_disc_dist_quantile.md)
  : Calculate the quantiles of a probability distribution based on the
  vector of probabilities and time data (e.g. time since infection)

## Package data

Data stored in the package

- [`epireview_core_cols`](https://epiverse-trace.github.io/epiparameter/dev/reference/epireview_core_cols.md)
  :

  A vector of `character` strings with the core column names of the
  epidemiological parameter data exported by the epireview R package.

## Options

- [`epiparameter_options`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter_options.md)
  : Package options
