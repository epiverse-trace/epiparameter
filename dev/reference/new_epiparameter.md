# Constructor for `<epiparameter>` class

Create an `<epiparameter>` object. The constructor will search whether
parameters of the probability distribution are supplied and if not look
to see whether they can be inferred/extracted/ converted from summary
statistics provided. It will also convert the probability distribution
(`prob_dist`) and its parameters (`prob_dist_params`) into an S3 class,
either a `distribution` object from `{distributional}` when
`discretise = FALSE`, or a `distcrete` object from `{distcrete}` when
`discretise = TRUE`.

## Usage

``` r
new_epiparameter(
  disease = character(),
  pathogen = character(),
  epi_name = character(),
  prob_distribution = list(),
  uncertainty = list(),
  summary_stats = list(),
  citation = character(),
  metadata = list(),
  method_assess = list(),
  notes = character(),
  auto_calc_params = logical(),
  ...
)
```

## Arguments

- disease:

  A `character` string with name of the infectious disease.

- pathogen:

  A `character` string with the name of the causative agent of disease,
  or `NA` if not known.

- epi_name:

  A `character` string with the name of the epidemiological parameter
  type.

- prob_distribution:

  An S3 class containing the probability distribution or a character
  string if the parameters of the probability distribution are unknown
  but the name of the distribution is known, or `NA` if the distribution
  name and parameters are unknown. Use
  [`create_prob_distribution()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_prob_distribution.md)
  to create `prob_distribution`.

- uncertainty:

  A list of named vectors with the uncertainty around the probability
  distribution parameters. If uncertainty around the parameter estimates
  is unknown use
  [`create_uncertainty()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_uncertainty.md)
  (which is the argument default) to create a list with the correct
  names with missing values.

- summary_stats:

  A list of summary statistics, use
  [`create_summary_stats()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_summary_stats.md)
  to create list. This list can include summary statistics about the
  inferred distribution such as it's mean and standard deviation,
  quantiles of the distribution, or information about the data used to
  fit the distribution such as lower and upper range. The summary
  statistics can also include uncertainty around metrics such as
  confidence interval around mean and standard deviation.

- citation:

  A `<bibentry>` with the citation of the source of the data or the
  paper that inferred the distribution parameters, use
  [`create_citation()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_citation.md)
  to create citation.

- metadata:

  A list of metadata, this can include: units, sample size, the
  transmission mode of the disease (e.g. is it vector-borne or directly
  transmitted), etc. It is assumed that the disease is not vector-borne
  and that the distribution is intrinsic (e.g. not an extrinsic delay
  distribution such as extrinsic incubation period) unless
  `transmission_mode = "vector_borne"` is contained in the metadata. Use
  [`create_metadata()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_metadata.md)
  to create metadata.

- method_assess:

  A list of methodological aspects used when fitting the distribution,
  use
  [`create_method_assess()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_method_assess.md)
  to create method assessment.

- notes:

  A `character` string with any additional information about the data,
  inference method or disease.

- auto_calc_params:

  A boolean `logical` determining whether to try and calculate the
  probability distribution parameters from summary statistics if
  distribution parameters are not provided. Default is `TRUE`. In the
  case when sufficient summary statistics are provided and the
  parameter(s) of the distribution are not, the
  [`.calc_dist_params()`](https://epiverse-trace.github.io/epiparameter/dev/reference/dot-calc_dist_params.md)
  function is called to calculate the parameters and add them to the
  `epiparameter` object created.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Extra arguments to be passed
  to internal functions.

  This is most commonly used to pass arguments to
  [`distcrete::distcrete()`](https://rdrr.io/pkg/distcrete/man/distcrete.html)
  that construct the discretised distribution S3 object. To see which
  arguments can be adjusted for discretised distributions see
  [`distcrete::distcrete()`](https://rdrr.io/pkg/distcrete/man/distcrete.html).

## Value

An `<epiparameter>` object.
