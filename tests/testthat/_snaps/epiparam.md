# epiparam print & format method works as expected

    Code
      epiparam()
    Output
      Epiparam object
      Number of distributions in library: 54
      Number of diseases: 21
      Number of delay distributions: 45
      Number of offspring distributions: 9
      Number of studies in library: 24
      <Head of library>
            disease  epi_distribution prob_distribution
      1  adenovirus incubation_period         lognormal
      2 chikungunya incubation_period         lognormal
      3      dengue incubation_period         lognormal
      4      dengue incubation_period         lognormal
      5      dengue incubation_period         lognormal
      6      dengue incubation_period         lognormal
      <48 more rows & 53 more cols not shown>

---

    Code
      print(epiparam())
    Output
      Epiparam object
      Number of distributions in library: 54
      Number of diseases: 21
      Number of delay distributions: 45
      Number of offspring distributions: 9
      Number of studies in library: 24
      <Head of library>
            disease  epi_distribution prob_distribution
      1  adenovirus incubation_period         lognormal
      2 chikungunya incubation_period         lognormal
      3      dengue incubation_period         lognormal
      4      dengue incubation_period         lognormal
      5      dengue incubation_period         lognormal
      6      dengue incubation_period         lognormal
      <48 more rows & 53 more cols not shown>

---

    Code
      format(epiparam())
    Output
      Epiparam object
      Number of distributions in library: 54
      Number of diseases: 21
      Number of delay distributions: 45
      Number of offspring distributions: 9
      Number of studies in library: 24
      <Head of library>
            disease  epi_distribution prob_distribution
      1  adenovirus incubation_period         lognormal
      2 chikungunya incubation_period         lognormal
      3      dengue incubation_period         lognormal
      4      dengue incubation_period         lognormal
      5      dengue incubation_period         lognormal
      6      dengue incubation_period         lognormal
      <48 more rows & 53 more cols not shown>

# epiparam head & tails methods works as expected

    Code
      head(epiparam())
    Output
            disease          pathogen  epi_distribution         author year
      1  adenovirus        adenovirus incubation_period   Lessler_etal 2009
      2 chikungunya chikungunya virus incubation_period   Rudolph_etal 2014
      3      dengue      dengue virus incubation_period Chan_Johansson 2012
      4      dengue      dengue virus incubation_period Chan_Johansson 2012
      5      dengue      dengue virus incubation_period Chan_Johansson 2012
      6      dengue      dengue virus incubation_period   Rudolph_etal 2014
        sample_size region vector_borne                             vector extrinsic
      1          14    USA        FALSE                               <NA>     FALSE
      2          21  Mixed         TRUE                   Aedes albopictus     FALSE
      3         146  Mixed         TRUE Aedes aegypti and Aedes albopictus      TRUE
      4         146  Mixed         TRUE Aedes aegypti and Aedes albopictus      TRUE
      5         153  Mixed         TRUE Aedes aegypti and Aedes albopictus     FALSE
      6         169  Mixed         TRUE Aedes aegypti and Aedes albopictus     FALSE
        prob_distribution inference_method  mean mean_ci_limits mean_ci   sd
      1         lognormal              mle    NA         NA, NA      NA   NA
      2         lognormal              mle    NA         NA, NA      NA   NA
      3         lognormal         bayesian 15.00         10, 20      95   NA
      4         lognormal         bayesian  6.50       4.8, 8.8      95   NA
      5         lognormal         bayesian  5.97       5.5, 6.4      95 1.64
      6         lognormal              mle    NA         NA, NA      NA   NA
        sd_ci_limits sd_ci quantile_025 quantile_05 quantile_25 median
      1       NA, NA    NA           NA          NA         4.8    5.6
      2       NA, NA    NA           NA          NA         2.9    3.0
      3       NA, NA    NA          5.0          NA          NA     NA
      4       NA, NA    NA          2.4          NA          NA     NA
      5       NA, NA    NA          3.4          NA          NA     NA
      6       NA, NA    NA           NA          NA         4.5    5.6
        median_ci_limits median_ci quantile_75 quantile_875 quantile_95 quantile_975
      1         4.8, 6.3        95         6.5           NA          NA           NA
      2         0.5, 3.1        95         3.0           NA          NA           NA
      3           NA, NA        NA          NA           NA          NA           33
      4           NA, NA        NA          NA           NA          NA           15
      5           NA, NA        NA          NA           NA          NA           10
      6         5.3, 6.0        95         7.1           NA          NA           NA
        lower_range upper_range shape shape_ci_limits shape_ci scale scale_ci_limits
      1          NA          NA    NA          NA, NA       NA    NA          NA, NA
      2          NA          NA    NA          NA, NA       NA    NA          NA, NA
      3          NA          NA    NA          NA, NA       NA    NA          NA, NA
      4          NA          NA    NA          NA, NA       NA    NA          NA, NA
      5          NA          NA    NA          NA, NA       NA    NA          NA, NA
      6          NA          NA    NA          NA, NA       NA    NA          NA, NA
        scale_ci meanlog meanlog_ci_limits meanlog_ci sdlog sdlog_ci_limits sdlog_ci
      1       NA      NA            NA, NA         NA    NA          NA, NA       NA
      2       NA      NA            NA, NA         NA    NA          NA, NA       NA
      3       NA      NA            NA, NA         NA    NA          NA, NA       NA
      4       NA      NA            NA, NA         NA    NA          NA, NA       NA
      5       NA    1.75            NA, NA         NA  0.27          NA, NA       NA
      6       NA      NA            NA, NA         NA    NA          NA, NA       NA
        dispersion dispersion_ci_limits dispersion_ci precision precision_ci_limits
      1       1.26           1.13, 1.38            95        NA              NA, NA
      2       1.04           1.04, 1.08            95        NA              NA, NA
      3         NA               NA, NA            NA        NA              NA, NA
      4         NA               NA, NA            NA       4.9            2.8, 7.5
      5         NA               NA, NA            NA      13.7          10.9, 16.9
      6       1.41           1.34, 1.50            95        NA              NA, NA
        precision_ci truncation discretised censored right_truncated
      1           NA         NA       FALSE     TRUE           FALSE
      2           NA         NA       FALSE     TRUE           FALSE
      3           NA         NA       FALSE     TRUE           FALSE
      4           95         NA       FALSE     TRUE           FALSE
      5           95         NA       FALSE     TRUE           FALSE
      6           NA         NA       FALSE     TRUE           FALSE
        phase_bias_adjusted
      1               FALSE
      2               FALSE
      3               FALSE
      4               FALSE
      5               FALSE
      6               FALSE
                                                                                                                                                                                                                                                                                                                                    notes
      1 Analysis on data from Commission on Acute Respiratory Disease. Experimental transmission of minor respiratory illness to human volunteers by filter-passing agents. I. Demonstration of two types of illness characterized by long and short incubation periods and diff erent clinical features. J Clin Invest 1947; 26: 957–82.
      2                                                                                                                                                                                                                                           Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      3                                                                                                                                                                                                                                                                        Extrinsic incubation period for data at 25 degrees celcius
      4                                                                                                                                                                                                                                                                        Extrinsic incubation period for data at 30 degrees celcius
      5                                                                                                                                                                                                                              Standard deviation, meanlog and sdlog is taken from Siraj et al. 2017 <10.1371/journal.pntd.0005797>
      6                                                                                                                                                                                                                                           Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
            PMID                           DOI
      1 19393959 10.1016/S1473-3099(09)70069-6
      2 24639305         10.4269/ajtmh.13-0403
      3 23226436  10.1371/journal.pone.0050972
      4 23226436  10.1371/journal.pone.0050972
      5 23226436  10.1371/journal.pone.0050972
      6 24639305         10.4269/ajtmh.13-0403

---

    Code
      tail(epiparam())
    Output
                    disease             pathogen  epi_distribution       author year
      49    west nile fever            West Nile incubation_period Rudolph_etal 2014
      50    west nile fever            West Nile incubation_period Rudolph_etal 2014
      51    west nile fever            West Nile incubation_period Rudolph_etal 2014
      52       yellow fever yellow fever viruses incubation_period Rudolph_etal 2014
      53       yellow fever yellow fever viruses incubation_period Rudolph_etal 2014
      54 zika virus disease                 zika incubation_period Lessler_etal 2016
         sample_size region vector_borne                             vector extrinsic
      49          18  Mixed         TRUE                           mosquito     FALSE
      50           8  Mixed         TRUE                           mosquito     FALSE
      51           6  Mixed         TRUE                           mosquito     FALSE
      52          91  Mixed         TRUE                           mosquito     FALSE
      53          80  Mixed         TRUE                           mosquito     FALSE
      54          25  Mixed         TRUE Aedes aegypti and Aedes albopictus     FALSE
         prob_distribution inference_method mean mean_ci_limits mean_ci sd
      49         lognormal              mle   NA         NA, NA      NA NA
      50         lognormal              mle   NA         NA, NA      NA NA
      51         lognormal              mle   NA         NA, NA      NA NA
      52         lognormal              mle   NA         NA, NA      NA NA
      53         lognormal              mle   NA         NA, NA      NA NA
      54         lognormal         bayesian   NA         NA, NA      NA NA
         sd_ci_limits sd_ci quantile_025 quantile_05 quantile_25 median
      49       NA, NA    NA           NA         1.0         1.7    2.6
      50       NA, NA    NA           NA          NA         2.8    2.9
      51       NA, NA    NA           NA          NA         8.7   10.8
      52       NA, NA    NA           NA         1.9         3.2    4.4
      53       NA, NA    NA           NA         1.9         3.1    4.4
      54       NA, NA    NA           NA         3.2         4.6    5.9
         median_ci_limits median_ci quantile_75 quantile_875 quantile_95 quantile_975
      49         1.6, 3.5        95         3.8           NA         7.0           NA
      50         0.5, 3.1        95         3.0           NA          NA           NA
      51        8.4, 14.2        95        13.3           NA          NA           NA
      52             4, 5        95         6.3           NA        10.3           NA
      53         3.9, 5.0        95         6.2           NA        10.3           NA
      54         4.4, 7.6        95         7.6           NA        11.2           NA
         lower_range upper_range shape shape_ci_limits shape_ci scale scale_ci_limits
      49          NA          NA    NA          NA, NA       NA    NA          NA, NA
      50          NA          NA    NA          NA, NA       NA    NA          NA, NA
      51          NA          NA    NA          NA, NA       NA    NA          NA, NA
      52          NA          NA    NA          NA, NA       NA    NA          NA, NA
      53          NA          NA    NA          NA, NA       NA    NA          NA, NA
      54          NA          NA    NA          NA, NA       NA    NA          NA, NA
         scale_ci meanlog meanlog_ci_limits meanlog_ci sdlog sdlog_ci_limits sdlog_ci
      49       NA      NA            NA, NA         NA    NA          NA, NA       NA
      50       NA      NA            NA, NA         NA    NA          NA, NA       NA
      51       NA      NA            NA, NA         NA    NA          NA, NA       NA
      52       NA      NA            NA, NA         NA    NA          NA, NA       NA
      53       NA      NA            NA, NA         NA    NA          NA, NA       NA
      54       NA      NA            NA, NA         NA    NA          NA, NA       NA
         dispersion dispersion_ci_limits dispersion_ci precision precision_ci_limits
      49       1.82           1.27, 2.67            95        NA              NA, NA
      50       1.04           1.04, 1.29            95        NA              NA, NA
      51       1.35           1.12, 1.47            95        NA              NA, NA
      52       1.66           1.48, 1.82            95        NA              NA, NA
      53       1.67           1.47, 1.84            95        NA              NA, NA
      54       1.50             1.2, 1.9            95        NA              NA, NA
         precision_ci truncation discretised censored right_truncated
      49           NA         NA       FALSE     TRUE           FALSE
      50           NA         NA       FALSE     TRUE           FALSE
      51           NA         NA       FALSE     TRUE           FALSE
      52           NA         NA       FALSE     TRUE           FALSE
      53           NA         NA       FALSE     TRUE           FALSE
      54           NA         NA       FALSE     TRUE           FALSE
         phase_bias_adjusted
      49               FALSE
      50               FALSE
      51               FALSE
      52               FALSE
      53               FALSE
      54               FALSE
                                                                                                                                                                              notes
      49                                                                                    Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      50          Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      51 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only tramsission by transplant or transfusion
      52                                                                                    Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      53          Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      54                                                                                   Pooled analysis on several data sets, see Lessler et al. 2016 for references of datasets
             PMID                   DOI
      49 24639305 10.4269/ajtmh.13-0403
      50 24639305 10.4269/ajtmh.13-0403
      51 24639305 10.4269/ajtmh.13-0403
      52 24639305 10.4269/ajtmh.13-0403
      53 24639305 10.4269/ajtmh.13-0403
      54 27821887 10.2471/BLT.16.174540

