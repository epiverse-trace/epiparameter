# Create an `<epiparameter>` object

The `<epiparameter>` class is used to store epidemiological parameters
for a single disease. These epidemiological parameters cover a variety
of aspects including delay distributions (e.g. incubation periods and
serial intervals, among others) and offspring distributions.

The `<epiparameter>` object is the functional unit provided by
`{epiparameter}` to plug into epidemiological pipelines. Obtaining an
`<epiparameter>` object can be achieved in two main ways:

1.  The epidemiological distribution is stored in the `{epiparameter}`
    library and can be accessed by
    [`epiparameter_db()`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter_db.md).

2.  The alternative method is when you have information (e.g. disease
    and distribution parameter estimates) and would like to input this
    into an `<epiparameter>` object in order to work in existing
    analysis pipelines. This is where the `epiparameter()` function can
    be used to fill out each field for which information is known.

## Usage

``` r
epiparameter(
  disease,
  pathogen = NA_character_,
  epi_name,
  prob_distribution = create_prob_distribution(prob_distribution = NA_character_),
  uncertainty = create_uncertainty(),
  summary_stats = create_summary_stats(),
  citation = create_citation(),
  metadata = create_metadata(),
  method_assess = create_method_assess(),
  notes = NULL,
  auto_calc_params = TRUE,
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

## Details

Accepted `<epiparameter>` distribution parameterisations are:

- Gamma must be either 'shape' and 'scale' or 'shape' and 'rate'

- Weibull must be 'shape' and 'scale'

- Lognormal must be 'meanlog' and 'sdlog' or 'mu' and 'sigma'

- Negative Binomial must be either 'mean' and 'dispersion' or 'n' and
  'p'

- Geometric must be either 'mean' or 'prob'

- Poisson must be 'mean'

## Examples

``` r
# minimal input required for `epiparameter`
ebola_incubation <- epiparameter(
  disease = "ebola",
  epi_name = "incubation_period",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  )
)
#> Citation cannot be created as author, year, journal or title is missing

# minimal input required for discrete `epiparameter`
ebola_incubation <- epiparameter(
  disease = "ebola",
  epi_name = "incubation_period",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = TRUE
  )
)
#> Citation cannot be created as author, year, journal or title is missing

# example with more fields filled in
ebola_incubation <- epiparameter(
  disease = "ebola",
  pathogen = "ebola_virus",
  epi_name = "incubation",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = FALSE,
    truncation = NA
  ),
  uncertainty = list(
    shape = create_uncertainty(),
    scale = create_uncertainty()
  ),
  summary_stats = create_summary_stats(mean = 2, sd = 1),
  citation = create_citation(
    author = person(given = "John", family = "Smith"),
    year = 2002,
    title = "COVID-19 incubation period",
    journal = "Epi Journal",
    doi = "10.19832/j.1366-9516.2012.09147.x"
  ),
  metadata = create_metadata(
    units = "days",
    sample_size = 10,
    region = "UK",
    transmission_mode = "natural_human_to_human",
    inference_method = "MLE"
  ),
  method_assess = create_method_assess(
    censored = TRUE
  ),
  notes = "No notes"
)
#> Using Smith J (2002). “COVID-19 incubation period.” _Epi Journal_.
#> doi:10.19832/j.1366-9516.2012.09147.x
#> <https://doi.org/10.19832/j.1366-9516.2012.09147.x>. 
#> To retrieve the citation use the 'get_citation' function
```
