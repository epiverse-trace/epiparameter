# Calculate the parameters of a probability distribution from a list of summary statistics

If parameters of a probability distribution are not provided (e.g. when
describing the distribution in the literature) and instead summary
statistics of a distribution are provided, the parameters can usually be
calculated from the summary statistics.

This function can provide a convenient wrapper around
[`convert_summary_stats_to_params()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_summary_stats_to_params.md)
and
[`extract_param()`](https://epiverse-trace.github.io/epiparameter/dev/reference/extract_param.md)
when it is not known which summary statistics can be used to calculate
the parameters of a distribution.

## Usage

``` r
.calc_dist_params(prob_distribution, summary_stats, sample_size)
```

## Arguments

- prob_distribution:

  An S3 class containing the probability distribution or a character
  string if the parameters of the probability distribution are unknown
  but the name of the distribution is known, or `NA` if the distribution
  name and parameters are unknown. Use
  [`create_prob_distribution()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_prob_distribution.md)
  to create `prob_distribution`.

- summary_stats:

  A list of summary statistics, use
  [`create_summary_stats()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_summary_stats.md)
  to create list. This list can include summary statistics about the
  inferred distribution such as it's mean and standard deviation,
  quantiles of the distribution, or information about the data used to
  fit the distribution such as lower and upper range. The summary
  statistics can also include uncertainty around metrics such as
  confidence interval around mean and standard deviation.

- sample_size:

  The sample size of the data. Only needed when falling back on using
  the median-range extraction calculation.

## Value

A named `numeric` vector with parameters.

## Details

The hierarchy of methods is:

1.  Conversion is prioritised if the mean and standard deviation are
    available as these are mostly analytical conversions (except for one
    of the Weibull conversions).

2.  Next method if possible is extraction from percentiles. This method
    requires a lower percentile (between(0-50\]) and an upper percentile
    (between (50-100)). If multiple percentiles in each of these ranges
    is provided the lowest value is used for the calculation.

3.  The last method is the extraction using a median and range of the
    data.
