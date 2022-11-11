# list_distributions works for all, params = FALSE

    Code
      list_distributions(delay_dist = "all", parameters = FALSE)
    Output
                  pathogen_id            type_id                 study_id year size
      1            adenovirus    generation_time                 Guo_etal 2020  375
      2            adenovirus         incubation             Lessler_etal 2009   14
      3                 ebola         incubation                 WHO_team 2014  500
      4                 ebola     onset_to_death      Ebola_outbreak_team 2018   14
      5                 ebola    serial_interval        WHO_response_team 2014   92
      6             human_CoV         incubation             Lessler_etal 2009   13
      7  influenza_A_seasonal         incubation             Lessler_etal 2009  122
      8  influenza_A_seasonal    Serial_interval                Levy_etal 2013  111
      9  influenza_B_seasonal         incubation             Lessler_etal 2009   76
      10 influenza_B_seasonal    Serial_interval                Levy_etal 2013   44
      11      influenza_H1N1p         incubation               Ghani_etal 2009   16
      12      influenza_H1N1p         incubation               Tuite_etal 2010  316
      13      influenza_H1N1p onset_to_admission                Jain_etal 2009  272
      14      influenza_H1N1p    Serial_interval                Levy_etal 2013  125
      15       influenza_H5N1         incubation             Cowling_etal 2013   27
      16       influenza_H5N1 onset_to_admission             Cowling_etal 2013   43
      17       influenza_H7N9         incubation             Cowling_etal 2013   32
      18       influenza_H7N9 onset_to_admission             Cowling_etal 2013  123
      19              marburg         incubation                   Pavlin 2014   18
      20              measles         incubation Klinkenberg and Nishiura 2011  116
      21              measles         incubation             Lessler_etal 2009   56
      22             MERS_CoV         incubation              Assiri_etal 2013   23
      23             MERS_CoV         incubation          Cauchemez_et_al 2014    7
      24             MERS_CoV onset_to_admission              Assiri_etal 2013   23
      25             MERS_CoV    serial_interval              Assiri_etal 2013   23
      26            monkeypox         incubation                    Nolen 2016   16
      27            monkeypox         incubation           Thornhill_etal 2022   23
      28            monkeypox    serial_interval                    UKHSA 2022   17
      29        parainfluenza         incubation             Lessler_etal 2009   11
      30           rhinovirus         incubation             Lessler_etal 2009   28
      31                  RSV         incubation             Lessler_etal 2009   24
      32                  RSV    Serial_interval                Vink_etal 2014   59
      33             SARS_CoV         incubation            Donnelly_etal 2003   57
      34             SARS_CoV         incubation             Lessler_etal 2009  157
      35             SARS_CoV onset_to_admission            Donnelly_etal 2003   57
      36  SARS_CoV_2_wildtype    generation_time            Ferretti_etal 2020  191
      37  SARS_CoV_2_wildtype         incubation             McAloon_etal 2020 1269
      38  SARS_CoV_2_wildtype onset_to_admission              Linton_etal 2020  155
      39  SARS_CoV_2_wildtype     onset_to_death              Linton_etal 2020   39
      40  SARS_CoV_2_wildtype    serial_interval            Nishiura_etal 2020   28
      41  SARS_CoV_2_wildtype    serial_interval            Nishiura_etal 2020   18
         distribution
      1       weibull
      2         lnorm
      3         gamma
      4         gamma
      5         gamma
      6         lnorm
      7         lnorm
      8         lnorm
      9         lnorm
      10        lnorm
      11        gamma
      12        lnorm
      13        lnorm
      14        lnorm
      15      weibull
      16      weibull
      17      weibull
      18        gamma
      19        gamma
      20        lnorm
      21        lnorm
      22        lnorm
      23        lnorm
      24        lnorm
      25        lnorm
      26        lnorm
      27        lnorm
      28        gamma
      29        lnorm
      30        lnorm
      31        lnorm
      32        lnorm
      33        gamma
      34        lnorm
      35        gamma
      36      weibull
      37        lnorm
      38        lnorm
      39        lnorm
      40        lnorm
      41      weibull

# list_distributions works for all, params = TRUE

    Code
      list_distributions(delay_dist = "all", parameters = TRUE)
    Output
                  pathogen_id            type_id                 study_id year size
      1            adenovirus    generation_time                 Guo_etal 2020  375
      2            adenovirus         incubation             Lessler_etal 2009   14
      3                 ebola         incubation                 WHO_team 2014  500
      4                 ebola     onset_to_death      Ebola_outbreak_team 2018   14
      5                 ebola    serial_interval        WHO_response_team 2014   92
      6             human_CoV         incubation             Lessler_etal 2009   13
      7  influenza_A_seasonal         incubation             Lessler_etal 2009  122
      8  influenza_A_seasonal    Serial_interval                Levy_etal 2013  111
      9  influenza_B_seasonal         incubation             Lessler_etal 2009   76
      10 influenza_B_seasonal    Serial_interval                Levy_etal 2013   44
      11      influenza_H1N1p         incubation               Ghani_etal 2009   16
      12      influenza_H1N1p         incubation               Tuite_etal 2010  316
      13      influenza_H1N1p onset_to_admission                Jain_etal 2009  272
      14      influenza_H1N1p    Serial_interval                Levy_etal 2013  125
      15       influenza_H5N1         incubation             Cowling_etal 2013   27
      16       influenza_H5N1 onset_to_admission             Cowling_etal 2013   43
      17       influenza_H7N9         incubation             Cowling_etal 2013   32
      18       influenza_H7N9 onset_to_admission             Cowling_etal 2013  123
      19              marburg         incubation                   Pavlin 2014   18
      20              measles         incubation Klinkenberg and Nishiura 2011  116
      21              measles         incubation             Lessler_etal 2009   56
      22             MERS_CoV         incubation              Assiri_etal 2013   23
      23             MERS_CoV         incubation          Cauchemez_et_al 2014    7
      24             MERS_CoV onset_to_admission              Assiri_etal 2013   23
      25             MERS_CoV    serial_interval              Assiri_etal 2013   23
      26            monkeypox         incubation                    Nolen 2016   16
      27            monkeypox         incubation           Thornhill_etal 2022   23
      28            monkeypox    serial_interval                    UKHSA 2022   17
      29        parainfluenza         incubation             Lessler_etal 2009   11
      30           rhinovirus         incubation             Lessler_etal 2009   28
      31                  RSV         incubation             Lessler_etal 2009   24
      32                  RSV    Serial_interval                Vink_etal 2014   59
      33             SARS_CoV         incubation            Donnelly_etal 2003   57
      34             SARS_CoV         incubation             Lessler_etal 2009  157
      35             SARS_CoV onset_to_admission            Donnelly_etal 2003   57
      36  SARS_CoV_2_wildtype    generation_time            Ferretti_etal 2020  191
      37  SARS_CoV_2_wildtype         incubation             McAloon_etal 2020 1269
      38  SARS_CoV_2_wildtype onset_to_admission              Linton_etal 2020  155
      39  SARS_CoV_2_wildtype     onset_to_death              Linton_etal 2020   39
      40  SARS_CoV_2_wildtype    serial_interval            Nishiura_etal 2020   28
      41  SARS_CoV_2_wildtype    serial_interval            Nishiura_etal 2020   18
         distribution  mean         sd quantile_025    median quantile_75
      1       weibull    NA         NA           NA  7.300000          NA
      2         lnorm    NA         NA           NA  5.600000    6.500000
      3         gamma  9.10  7.3000000           NA        NA          NA
      4         gamma  9.30  6.0000000           NA        NA          NA
      5         gamma 15.30  9.3000000           NA        NA          NA
      6         lnorm    NA         NA           NA  3.200000    3.500000
      7         lnorm    NA         NA           NA  1.400000    1.900000
      8         lnorm  3.48  1.8800000           NA  3.000000          NA
      9         lnorm    NA         NA           NA  0.600000    0.700000
      10        lnorm  3.72  1.9500000           NA  3.000000          NA
      11        gamma  2.05  0.4898979           NA        NA          NA
      12        lnorm  4.30         NA           NA  4.000000          NA
      13        lnorm    NA         NA           NA  3.000000          NA
      14        lnorm  3.08  1.3900000           NA  3.000000          NA
      15      weibull  3.30  1.5000000    0.6870932  3.088366    4.288508
      16      weibull    NA         NA    1.3678290  4.900000    6.770349
      17      weibull  3.10  1.4000000    0.6870932  2.887973    3.888880
      18        gamma    NA         NA    0.6172617  4.200000    6.170223
      19        gamma    NA         NA           NA  7.000000          NA
      20        lnorm 12.30  3.4800000           NA 12.000000          NA
      21        lnorm    NA         NA           NA 12.500000   14.400000
      22        lnorm    NA         NA           NA  5.200000          NA
      23        lnorm  5.50  2.5000000           NA        NA          NA
      24        lnorm    NA         NA           NA  5.000000          NA
      25        lnorm    NA         NA           NA  7.600000          NA
      26        lnorm  9.60         NA           NA  9.000000          NA
      27        lnorm    NA         NA           NA  7.000000          NA
      28        gamma  9.80  8.3000000           NA        NA          NA
      29        lnorm    NA         NA           NA  2.600000    3.200000
      30        lnorm    NA         NA           NA  1.900000    2.700000
      31        lnorm    NA         NA           NA  4.400000    5.100000
      32        lnorm  7.50  1.4400000           NA        NA          NA
      33        gamma  6.40  4.0800000           NA        NA          NA
      34        lnorm    NA         NA           NA  4.000000    5.900000
      35        gamma  4.85  3.4900000           NA        NA          NA
      36      weibull  5.00  1.9000000           NA  5.000000          NA
      37        lnorm    NA         NA           NA  5.100000          NA
      38        lnorm  9.70 35.2000000           NA  2.600000          NA
      39        lnorm 20.20 11.6000000           NA 17.100000          NA
      40        lnorm  4.70  2.9000000           NA  4.000000          NA
      41      weibull  4.80  2.3000000           NA  4.600000          NA
         quantile_875 quantile_95 quantile_975 lower_range upper_range     shape
      1            NA          NA           NA          NA          NA  3.480000
      2            NA          NA           NA          NA          NA        NA
      3            NA          NA           NA          NA          NA  1.553950
      4            NA          NA           NA           2          27  2.400000
      5            NA          NA           NA          NA          NA  2.706556
      6            NA          NA           NA          NA          NA        NA
      7            NA          NA           NA          NA          NA        NA
      8            NA          NA           NA          NA          NA        NA
      9            NA          NA           NA          NA          NA        NA
      10           NA          NA           NA          NA          NA        NA
      11           NA          NA           NA          NA          NA 17.503120
      12           NA          NA     6.600000          NA          NA        NA
      13           NA          NA           NA          NA          NA        NA
      14           NA          NA           NA          NA          NA        NA
      15           NA    5.989652     6.589681          NA          NA  2.185908
      16           NA   10.222554    11.423436          NA          NA  2.373396
      17           NA    5.489237     5.989652          NA          NA  2.309241
      18           NA    9.622302    10.823058          NA          NA  2.138094
      19           NA          NA           NA           2          13  1.946138
      20           NA          NA           NA          NA          NA        NA
      21           NA   17.700000           NA          NA          NA        NA
      22           NA   12.400000    14.700000          NA          NA        NA
      23           NA          NA           NA          NA          NA        NA
      24           NA          NA           NA           1          10        NA
      25           NA   19.400000    23.100000          NA          NA        NA
      26           13          NA           NA          NA          NA        NA
      27           NA          NA           NA           3          20        NA
      28           NA          NA           NA          NA          NA  1.394107
      29           NA          NA           NA          NA          NA        NA
      30           NA          NA           NA          NA          NA        NA
      31           NA          NA           NA          NA          NA        NA
      32           NA          NA           NA          NA          NA        NA
      33           NA   14.220000           NA          NA          NA  2.431210
      34           NA          NA           NA          NA          NA        NA
      35           NA          NA           NA          NA          NA  1.929655
      36           NA          NA           NA          NA          NA  2.826000
      37           NA   11.700000           NA          NA          NA        NA
      38           NA   35.100000           NA          NA          NA        NA
      39           NA   39.900000           NA          NA          NA        NA
      40           NA          NA           NA          NA          NA        NA
      41           NA          NA           NA          NA          NA  2.203394
             scale    meanlog     sdlog extracted     discretised phase_bias_adjusted
      1  8.1900000         NA        NA                        no                  no
      2         NA  1.7227644 0.2209673       yes              no                  no
      3  5.8560440         NA        NA       yes            <NA>                <NA>
      4  3.3330000         NA        NA        no              no                  no
      5  5.6529410         NA        NA       yes            <NA>                <NA>
      6         NA  1.1631463 0.1328705       yes              no                  no
      7         NA  0.3364708 0.4527634       yes              no                  no
      8         NA  1.1189950 0.5060376       yes not yet checked     not yet checked
      9         NA -0.5108280 0.2285515       yes              no                  no
      10        NA  1.1923370 0.4927197       yes not yet checked     not yet checked
      11 0.1171220         NA        NA       yes            <NA>                <NA>
      12        NA  1.3862944 0.2554986       yes            <NA>                <NA>
      13        NA  1.0986120 2.9115800       yes            <NA>                <NA>
      14        NA  1.0322420 0.4305527       yes not yet checked     not yet checked
      15 3.6932670         NA        NA       yes              no                  no
      16 6.4388430         NA        NA       yes              no                  no
      17 3.3759410         NA        NA       yes              no                  no
      18 2.1533140         NA        NA       yes              no                  no
      19 0.5324265         NA        NA       yes              no                  no
      20        NA         NA        NA                                          <NA>
      21        NA  2.5257260 0.2097952       yes              no                  no
      22        NA  1.6486586 0.5283368       yes            <NA>                <NA>
      23        NA  1.6108401 0.4333775       yes            <NA>                <NA>
      24        NA  1.6089493 0.6103889       yes            <NA>                <NA>
      25        NA  2.0200000 0.5600000       yes            <NA>                <NA>
      26        NA  2.1783545 0.3360684       yes              no                <NA>
      27        NA  1.9460783 0.4934628       yes              no                  no
      28 7.0295920         NA        NA       yes              no                 yes
      29        NA  0.9555123 0.3078528       yes              no                  no
      30        NA  0.6418529 0.5209872       yes              no                  no
      31        NA  1.4816021 0.2188927       yes              no                  no
      32        NA  1.9968030 0.1902650       yes not yet checked     not yet checked
      33 2.6200900         NA        NA       yes              no                  no
      34        NA  1.3862935 0.5762278       yes              no                  no
      35 2.5134020         NA        NA       yes            <NA>                <NA>
      36 5.6650000         NA        NA       yes              no                 yes
      37        NA  1.6300000 0.5000000        no              no                  no
      38        NA  0.9466094 1.6281993       yes              no                 yes
      39        NA  2.8631790 0.5338606       yes              no                 yes
      40        NA  1.3862620 0.5679803       yes              no                 yes
      41 5.4198750         NA        NA       yes              no                 yes
                                                                                                                 notes
      1                                                                    Extracted using the parametric distribution
      2                                                                                                           <NA>
      3                                                                               Extracted using single exposures
      4  the mean, sd, shape and scale are taken from the paper, the conversion between the two does not match exactly
      5                                                                                                           <NA>
      6                                                                                                           <NA>
      7                                                                                                           <NA>
      8                                                                                 Extracted from seasonal A H3N2
      9                                                                                                           <NA>
      10                                                                                                          <NA>
      11                                                                                                          <NA>
      12                                                                                                          <NA>
      13                                                              Extracted using range 0 to 18, lognormal assumed
      14                                                                                                          <NA>
      15                                                                  extraction used quantile_025 and quantile_75
      16                                                                  extraction used quantile_025 and quantile_95
      17                                                                  extraction used quantile_025 and quantile_75
      18                                                                  extraction used quantile_025 and quantile_75
      19                                                                                  gamma assumed, range 2 to 13
      20                                  estimates from data reported by Goodwall 1931 "Incubation period of measles"
      21                                                                                                          <NA>
      22                                                                   extracted using quantile_5 and quantile_975
      23                                                                                                          <NA>
      24                                                                                                          <NA>
      25                                                                                                          <NA>
      26                                                                 Extracted taking c(6,13) as central 75% range
      27                                                               Extracted from range 3 to 21, lognormal assumed
      28                                                                    Extracted from mean and SD, assuming gamma
      29                                                                                                          <NA>
      30                                                                                                          <NA>
      31                                                                                                          <NA>
      32                                                                                                          <NA>
      33                                                                                                          <NA>
      34                                                                                                          <NA>
      35                                                                                              Feb-26 to Mar-25
      36                                                                                           20/1/2020-21/3/2020
      37                                                                                                          <NA>
      38                                                                                           For living patients
      39                                                                                                          <NA>
      40                                                                          Extracted using reported mean and sd
      41            Extracted using mean and sd reported from a subset of the data for certain infector-infectee pairs
             PMID
      1  32479490
      2  19393959
      3  25564903
      4  30047375
      5  25564903
      6  19393959
      7  19393959
      8  23629874
      9  19393959
      10 23629874
      11 20029668
      12 19959592
      13 19815859
      14 23629874
      15 23803488
      16 23803488
      17 23803488
      18 23803488
      19 25495697
      20 21704640
      21 19393959
      22 23782161
      23 24239323
      24 23782161
      25 23782161
      26 27191380
      27 35866746
      28       NA
      29 19393959
      30 19393959
      31 19393959
      32 25294601
      33 12781533
      34 19393959
      35 12781533
      36 32234805
      37 32801208
      38 32079150
      39 32079150
      40 32145466
      41 32145466
                                                                                                                                                             DOI
      1                                                                                                                             10.1371/journal.pone.0232948
      2                                                                                                                            10.1016/S1473-3099(09)70069-6
      3                                                                                                                                    10.1056/nejmoa1411100
      4                                                                                                                            10.1016/S0140-6736(18)31387-4
      5                                                                                                                                    10.1056/nejmoa1411100
      6                                                                                                                            10.1016/S1473-3099(09)70069-6
      7                                                                                                                            10.1016/S1473-3099(09)70069-6
      8                                                                                                                                   10.1093%2Faje%2Fkws403
      9                                                                                                                            10.1016/S1473-3099(09)70069-6
      10                                                                                                                                  10.1093%2Faje%2Fkws404
      11                                                                                                                                10.1371/currents.RRN1130
      12                                                                                                                                     10.1503/cmaj.091807
      13                                                                                                                                   10.1056/NEJMoa0906695
      14                                                                                                                                  10.1093%2Faje%2Fkws402
      15                                                                                                                           10.1016/S0140-6736(13)61171-X
      16                                                                                                                           10.1016/S0140-6736(13)61171-X
      17                                                                                                                           10.1016/S0140-6736(13)61171-X
      18                                                                                                                           10.1016/S0140-6736(13)61171-X
      19                                                                                                                         10.1186/1756-0500-7-906        
      20                                                                                                                              10.1016/j.jtbi.2011.06.015
      21                                                                                                                           10.1016/S1473-3099(09)70069-6
      22                                                                                                                                   10.1056/NEJMoa1306742
      23                                                                                                                           10.1016/S1473-3099(13)70304-9
      24                                                                                                                                   10.1056/NEJMoa1306742
      25                                                                                                                                   10.1056/NEJMoa1306742
      26                                                                                                                                  10.3201/eid2206.150579
      27                                                                                                                                   10.1056/NEJMoa2207323
      28 https://www.gov.uk/government/publications/monkeypox-outbreak-technical-briefings/investigation-into-monkeypox-outbreak-in-england-technical-briefing-1
      29                                                                                                                           10.1016/S1473-3099(09)70069-6
      30                                                                                                                           10.1016/S1473-3099(09)70069-6
      31                                                                                                                           10.1016/S1473-3099(09)70069-6
      32                                                                                                                                      10.1093/aje/kwu209
      33                                                                                                                           10.1016/S0140-6736(03)13410-1
      34                                                                                                                           10.1016/S1473-3099(09)70069-6
      35                                                                                                                           10.1016/S0140-6736(03)13410-1
      36                                                                                                                                 10.1126/science.abb6936
      37                                                                                                                             10.1136/bmjopen-2020-039652
      38                                                                                                                                      10.3390/jcm9020538
      39                                                                                                                                      10.3390/jcm9020538
      40                                                                                                                              10.1016/j.ijid.2020.02.060
      41                                                                                                                              10.1016/j.ijid.2020.02.060
               added_by
      1   Carmen Tamayo
      2  Adam Kucharski
      3  Adam Kucharski
      4  Joshua Lambert
      5  Adam Kucharski
      6  Adam Kucharski
      7  Adam Kucharski
      8   Carmen Tamayo
      9  Adam Kucharski
      10  Carmen Tamayo
      11 Adam Kucharski
      12 Adam Kucharski
      13 Adam Kucharski
      14  Carmen Tamayo
      15 Adam Kucharski
      16 Adam Kucharski
      17 Adam Kucharski
      18 Adam Kucharski
      19 Adam Kucharski
      20  Alexis Robert
      21 Adam Kucharski
      22 Adam Kucharski
      23 Adam Kucharski
      24 Adam Kucharski
      25 Adam Kucharski
      26       Seb Funk
      27 Adam Kucharski
      28       Seb Funk
      29 Adam Kucharski
      30 Adam Kucharski
      31 Adam Kucharski
      32  Carmen Tamayo
      33 Adam Kucharski
      34 Adam Kucharski
      35 Adam Kucharski
      36   Rachael Pung
      37 Adam Kucharski
      38 Adam Kucharski
      39 Adam Kucharski
      40 Joshua Lambert
      41 Joshua Lambert

# list_distributions works for incubation, params = FALSE

    Code
      list_distributions(delay_dist = "incubation", parameters = FALSE)
    Output
                  pathogen_id    type_id                 study_id year size
      1            adenovirus incubation             Lessler_etal 2009   14
      2                 ebola incubation                 WHO_team 2014  500
      3             human_CoV incubation             Lessler_etal 2009   13
      4  influenza_A_seasonal incubation             Lessler_etal 2009  122
      5  influenza_B_seasonal incubation             Lessler_etal 2009   76
      6       influenza_H1N1p incubation               Ghani_etal 2009   16
      7       influenza_H1N1p incubation               Tuite_etal 2010  316
      8        influenza_H5N1 incubation             Cowling_etal 2013   27
      9        influenza_H7N9 incubation             Cowling_etal 2013   32
      10              marburg incubation                   Pavlin 2014   18
      11              measles incubation Klinkenberg and Nishiura 2011  116
      12              measles incubation             Lessler_etal 2009   56
      13             MERS_CoV incubation              Assiri_etal 2013   23
      14             MERS_CoV incubation          Cauchemez_et_al 2014    7
      15            monkeypox incubation                    Nolen 2016   16
      16            monkeypox incubation           Thornhill_etal 2022   23
      17        parainfluenza incubation             Lessler_etal 2009   11
      18           rhinovirus incubation             Lessler_etal 2009   28
      19                  RSV incubation             Lessler_etal 2009   24
      20             SARS_CoV incubation            Donnelly_etal 2003   57
      21             SARS_CoV incubation             Lessler_etal 2009  157
      22  SARS_CoV_2_wildtype incubation             McAloon_etal 2020 1269
         distribution
      1         lnorm
      2         gamma
      3         lnorm
      4         lnorm
      5         lnorm
      6         gamma
      7         lnorm
      8       weibull
      9       weibull
      10        gamma
      11        lnorm
      12        lnorm
      13        lnorm
      14        lnorm
      15        lnorm
      16        lnorm
      17        lnorm
      18        lnorm
      19        lnorm
      20        gamma
      21        lnorm
      22        lnorm

# list_distributions works for incubation, params = TRUE

    Code
      list_distributions(delay_dist = "incubation", parameters = TRUE)
    Output
                  pathogen_id    type_id                 study_id year size
      1            adenovirus incubation             Lessler_etal 2009   14
      2                 ebola incubation                 WHO_team 2014  500
      3             human_CoV incubation             Lessler_etal 2009   13
      4  influenza_A_seasonal incubation             Lessler_etal 2009  122
      5  influenza_B_seasonal incubation             Lessler_etal 2009   76
      6       influenza_H1N1p incubation               Ghani_etal 2009   16
      7       influenza_H1N1p incubation               Tuite_etal 2010  316
      8        influenza_H5N1 incubation             Cowling_etal 2013   27
      9        influenza_H7N9 incubation             Cowling_etal 2013   32
      10              marburg incubation                   Pavlin 2014   18
      11              measles incubation Klinkenberg and Nishiura 2011  116
      12              measles incubation             Lessler_etal 2009   56
      13             MERS_CoV incubation              Assiri_etal 2013   23
      14             MERS_CoV incubation          Cauchemez_et_al 2014    7
      15            monkeypox incubation                    Nolen 2016   16
      16            monkeypox incubation           Thornhill_etal 2022   23
      17        parainfluenza incubation             Lessler_etal 2009   11
      18           rhinovirus incubation             Lessler_etal 2009   28
      19                  RSV incubation             Lessler_etal 2009   24
      20             SARS_CoV incubation            Donnelly_etal 2003   57
      21             SARS_CoV incubation             Lessler_etal 2009  157
      22  SARS_CoV_2_wildtype incubation             McAloon_etal 2020 1269
         distribution  mean        sd quantile_025    median quantile_75 quantile_875
      1         lnorm    NA        NA           NA  5.600000    6.500000           NA
      2         gamma  9.10 7.3000000           NA        NA          NA           NA
      3         lnorm    NA        NA           NA  3.200000    3.500000           NA
      4         lnorm    NA        NA           NA  1.400000    1.900000           NA
      5         lnorm    NA        NA           NA  0.600000    0.700000           NA
      6         gamma  2.05 0.4898979           NA        NA          NA           NA
      7         lnorm  4.30        NA           NA  4.000000          NA           NA
      8       weibull  3.30 1.5000000    0.6870932  3.088366    4.288508           NA
      9       weibull  3.10 1.4000000    0.6870932  2.887973    3.888880           NA
      10        gamma    NA        NA           NA  7.000000          NA           NA
      11        lnorm 12.30 3.4800000           NA 12.000000          NA           NA
      12        lnorm    NA        NA           NA 12.500000   14.400000           NA
      13        lnorm    NA        NA           NA  5.200000          NA           NA
      14        lnorm  5.50 2.5000000           NA        NA          NA           NA
      15        lnorm  9.60        NA           NA  9.000000          NA           13
      16        lnorm    NA        NA           NA  7.000000          NA           NA
      17        lnorm    NA        NA           NA  2.600000    3.200000           NA
      18        lnorm    NA        NA           NA  1.900000    2.700000           NA
      19        lnorm    NA        NA           NA  4.400000    5.100000           NA
      20        gamma  6.40 4.0800000           NA        NA          NA           NA
      21        lnorm    NA        NA           NA  4.000000    5.900000           NA
      22        lnorm    NA        NA           NA  5.100000          NA           NA
         quantile_95 quantile_975 lower_range upper_range     shape     scale
      1           NA           NA          NA          NA        NA        NA
      2           NA           NA          NA          NA  1.553950 5.8560440
      3           NA           NA          NA          NA        NA        NA
      4           NA           NA          NA          NA        NA        NA
      5           NA           NA          NA          NA        NA        NA
      6           NA           NA          NA          NA 17.503120 0.1171220
      7           NA     6.600000          NA          NA        NA        NA
      8     5.989652     6.589681          NA          NA  2.185908 3.6932670
      9     5.489237     5.989652          NA          NA  2.309241 3.3759410
      10          NA           NA           2          13  1.946138 0.5324265
      11          NA           NA          NA          NA        NA        NA
      12   17.700000           NA          NA          NA        NA        NA
      13   12.400000    14.700000          NA          NA        NA        NA
      14          NA           NA          NA          NA        NA        NA
      15          NA           NA          NA          NA        NA        NA
      16          NA           NA           3          20        NA        NA
      17          NA           NA          NA          NA        NA        NA
      18          NA           NA          NA          NA        NA        NA
      19          NA           NA          NA          NA        NA        NA
      20   14.220000           NA          NA          NA  2.431210 2.6200900
      21          NA           NA          NA          NA        NA        NA
      22   11.700000           NA          NA          NA        NA        NA
            meanlog     sdlog extracted discretised phase_bias_adjusted
      1   1.7227644 0.2209673       yes          no                  no
      2          NA        NA       yes        <NA>                <NA>
      3   1.1631463 0.1328705       yes          no                  no
      4   0.3364708 0.4527634       yes          no                  no
      5  -0.5108280 0.2285515       yes          no                  no
      6          NA        NA       yes        <NA>                <NA>
      7   1.3862944 0.2554986       yes        <NA>                <NA>
      8          NA        NA       yes          no                  no
      9          NA        NA       yes          no                  no
      10         NA        NA       yes          no                  no
      11         NA        NA                                      <NA>
      12  2.5257260 0.2097952       yes          no                  no
      13  1.6486586 0.5283368       yes        <NA>                <NA>
      14  1.6108401 0.4333775       yes        <NA>                <NA>
      15  2.1783545 0.3360684       yes          no                <NA>
      16  1.9460783 0.4934628       yes          no                  no
      17  0.9555123 0.3078528       yes          no                  no
      18  0.6418529 0.5209872       yes          no                  no
      19  1.4816021 0.2188927       yes          no                  no
      20         NA        NA       yes          no                  no
      21  1.3862935 0.5762278       yes          no                  no
      22  1.6300000 0.5000000        no          no                  no
                                                                                notes
      1                                                                          <NA>
      2                                              Extracted using single exposures
      3                                                                          <NA>
      4                                                                          <NA>
      5                                                                          <NA>
      6                                                                          <NA>
      7                                                                          <NA>
      8                                  extraction used quantile_025 and quantile_75
      9                                  extraction used quantile_025 and quantile_75
      10                                                 gamma assumed, range 2 to 13
      11 estimates from data reported by Goodwall 1931 "Incubation period of measles"
      12                                                                         <NA>
      13                                  extracted using quantile_5 and quantile_975
      14                                                                         <NA>
      15                                Extracted taking c(6,13) as central 75% range
      16                              Extracted from range 3 to 21, lognormal assumed
      17                                                                         <NA>
      18                                                                         <NA>
      19                                                                         <NA>
      20                                                                         <NA>
      21                                                                         <NA>
      22                                                                         <NA>
             PMID                             DOI       added_by
      1  19393959   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      2  25564903           10.1056/nejmoa1411100 Adam Kucharski
      3  19393959   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      4  19393959   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      5  19393959   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      6  20029668        10.1371/currents.RRN1130 Adam Kucharski
      7  19959592             10.1503/cmaj.091807 Adam Kucharski
      8  23803488   10.1016/S0140-6736(13)61171-X Adam Kucharski
      9  23803488   10.1016/S0140-6736(13)61171-X Adam Kucharski
      10 25495697 10.1186/1756-0500-7-906         Adam Kucharski
      11 21704640      10.1016/j.jtbi.2011.06.015  Alexis Robert
      12 19393959   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      13 23782161           10.1056/NEJMoa1306742 Adam Kucharski
      14 24239323   10.1016/S1473-3099(13)70304-9 Adam Kucharski
      15 27191380          10.3201/eid2206.150579       Seb Funk
      16 35866746           10.1056/NEJMoa2207323 Adam Kucharski
      17 19393959   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      18 19393959   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      19 19393959   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      20 12781533   10.1016/S0140-6736(03)13410-1 Adam Kucharski
      21 19393959   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      22 32801208     10.1136/bmjopen-2020-039652 Adam Kucharski

# list_distributions works for onset_to_admission, params = FALSE

    Code
      list_distributions(delay_dist = "onset_to_admission", parameters = FALSE)
    Output
                pathogen_id            type_id      study_id year size distribution
      1     influenza_H1N1p onset_to_admission     Jain_etal 2009  272        lnorm
      2      influenza_H5N1 onset_to_admission  Cowling_etal 2013   43      weibull
      3      influenza_H7N9 onset_to_admission  Cowling_etal 2013  123        gamma
      4            MERS_CoV onset_to_admission   Assiri_etal 2013   23        lnorm
      5            SARS_CoV onset_to_admission Donnelly_etal 2003   57        gamma
      6 SARS_CoV_2_wildtype onset_to_admission   Linton_etal 2020  155        lnorm

# list_distributions works for onset_to_admission, params = TRUE

    Code
      list_distributions(delay_dist = "onset_to_admission", parameters = TRUE)
    Output
                pathogen_id            type_id      study_id year size distribution
      1     influenza_H1N1p onset_to_admission     Jain_etal 2009  272        lnorm
      2      influenza_H5N1 onset_to_admission  Cowling_etal 2013   43      weibull
      3      influenza_H7N9 onset_to_admission  Cowling_etal 2013  123        gamma
      4            MERS_CoV onset_to_admission   Assiri_etal 2013   23        lnorm
      5            SARS_CoV onset_to_admission Donnelly_etal 2003   57        gamma
      6 SARS_CoV_2_wildtype onset_to_admission   Linton_etal 2020  155        lnorm
        mean    sd quantile_025 median quantile_75 quantile_875 quantile_95
      1   NA    NA           NA    3.0          NA           NA          NA
      2   NA    NA    1.3678290    4.9    6.770349           NA   10.222554
      3   NA    NA    0.6172617    4.2    6.170223           NA    9.622302
      4   NA    NA           NA    5.0          NA           NA          NA
      5 4.85  3.49           NA     NA          NA           NA          NA
      6 9.70 35.20           NA    2.6          NA           NA   35.100000
        quantile_975 lower_range upper_range    shape    scale   meanlog     sdlog
      1           NA          NA          NA       NA       NA 1.0986120 2.9115800
      2     11.42344          NA          NA 2.373396 6.438843        NA        NA
      3     10.82306          NA          NA 2.138094 2.153314        NA        NA
      4           NA           1          10       NA       NA 1.6089493 0.6103889
      5           NA          NA          NA 1.929655 2.513402        NA        NA
      6           NA          NA          NA       NA       NA 0.9466094 1.6281993
        extracted discretised phase_bias_adjusted
      1       yes        <NA>                <NA>
      2       yes          no                  no
      3       yes          no                  no
      4       yes        <NA>                <NA>
      5       yes        <NA>                <NA>
      6       yes          no                 yes
                                                   notes     PMID
      1 Extracted using range 0 to 18, lognormal assumed 19815859
      2     extraction used quantile_025 and quantile_95 23803488
      3     extraction used quantile_025 and quantile_75 23803488
      4                                             <NA> 23782161
      5                                 Feb-26 to Mar-25 12781533
      6                              For living patients 32079150
                                  DOI       added_by
      1         10.1056/NEJMoa0906695 Adam Kucharski
      2 10.1016/S0140-6736(13)61171-X Adam Kucharski
      3 10.1016/S0140-6736(13)61171-X Adam Kucharski
      4         10.1056/NEJMoa1306742 Adam Kucharski
      5 10.1016/S0140-6736(03)13410-1 Adam Kucharski
      6            10.3390/jcm9020538 Adam Kucharski

# list_distributions works for onset_to_death, params = FALSE

    Code
      list_distributions(delay_dist = "onset_to_death", parameters = FALSE)
    Output
                pathogen_id        type_id            study_id year size distribution
      1               ebola onset_to_death Ebola_outbreak_team 2018   14        gamma
      2 SARS_CoV_2_wildtype onset_to_death         Linton_etal 2020   39        lnorm

# list_distributions works for onset_to_death, params = TRUE

    Code
      list_distributions(delay_dist = "onset_to_death", parameters = TRUE)
    Output
                pathogen_id        type_id            study_id year size distribution
      1               ebola onset_to_death Ebola_outbreak_team 2018   14        gamma
      2 SARS_CoV_2_wildtype onset_to_death         Linton_etal 2020   39        lnorm
        mean   sd quantile_025 median quantile_75 quantile_875 quantile_95
      1  9.3  6.0           NA     NA          NA           NA          NA
      2 20.2 11.6           NA   17.1          NA           NA        39.9
        quantile_975 lower_range upper_range shape scale  meanlog     sdlog extracted
      1           NA           2          27   2.4 3.333       NA        NA        no
      2           NA          NA          NA    NA    NA 2.863179 0.5338606       yes
        discretised phase_bias_adjusted
      1          no                  no
      2          no                 yes
                                                                                                                notes
      1 the mean, sd, shape and scale are taken from the paper, the conversion between the two does not match exactly
      2                                                                                                          <NA>
            PMID                           DOI       added_by
      1 30047375 10.1016/S0140-6736(18)31387-4 Joshua Lambert
      2 32079150            10.3390/jcm9020538 Adam Kucharski

# list_distributions works for serial_interval, params = FALSE

    Code
      list_distributions(delay_dist = "serial_interval", parameters = FALSE)
    Output
                pathogen_id         type_id          study_id year size distribution
      1               ebola serial_interval WHO_response_team 2014   92        gamma
      2            MERS_CoV serial_interval       Assiri_etal 2013   23        lnorm
      3           monkeypox serial_interval             UKHSA 2022   17        gamma
      4 SARS_CoV_2_wildtype serial_interval     Nishiura_etal 2020   28        lnorm
      5 SARS_CoV_2_wildtype serial_interval     Nishiura_etal 2020   18      weibull

# list_distributions works for serial_interval, params = TRUE

    Code
      list_distributions(delay_dist = "serial_interval", parameters = TRUE)
    Output
                pathogen_id         type_id          study_id year size distribution
      1               ebola serial_interval WHO_response_team 2014   92        gamma
      2            MERS_CoV serial_interval       Assiri_etal 2013   23        lnorm
      3           monkeypox serial_interval             UKHSA 2022   17        gamma
      4 SARS_CoV_2_wildtype serial_interval     Nishiura_etal 2020   28        lnorm
      5 SARS_CoV_2_wildtype serial_interval     Nishiura_etal 2020   18      weibull
        mean  sd quantile_025 median quantile_75 quantile_875 quantile_95
      1 15.3 9.3           NA     NA          NA           NA          NA
      2   NA  NA           NA    7.6          NA           NA        19.4
      3  9.8 8.3           NA     NA          NA           NA          NA
      4  4.7 2.9           NA    4.0          NA           NA          NA
      5  4.8 2.3           NA    4.6          NA           NA          NA
        quantile_975 lower_range upper_range    shape    scale  meanlog     sdlog
      1           NA          NA          NA 2.706556 5.652941       NA        NA
      2         23.1          NA          NA       NA       NA 2.020000 0.5600000
      3           NA          NA          NA 1.394107 7.029592       NA        NA
      4           NA          NA          NA       NA       NA 1.386262 0.5679803
      5           NA          NA          NA 2.203394 5.419875       NA        NA
        extracted discretised phase_bias_adjusted
      1       yes        <NA>                <NA>
      2       yes        <NA>                <NA>
      3       yes          no                 yes
      4       yes          no                 yes
      5       yes          no                 yes
                                                                                                     notes
      1                                                                                               <NA>
      2                                                                                               <NA>
      3                                                         Extracted from mean and SD, assuming gamma
      4                                                               Extracted using reported mean and sd
      5 Extracted using mean and sd reported from a subset of the data for certain infector-infectee pairs
            PMID
      1 25564903
      2 23782161
      3       NA
      4 32145466
      5 32145466
                                                                                                                                                            DOI
      1                                                                                                                                   10.1056/nejmoa1411100
      2                                                                                                                                   10.1056/NEJMoa1306742
      3 https://www.gov.uk/government/publications/monkeypox-outbreak-technical-briefings/investigation-into-monkeypox-outbreak-in-england-technical-briefing-1
      4                                                                                                                              10.1016/j.ijid.2020.02.060
      5                                                                                                                              10.1016/j.ijid.2020.02.060
              added_by
      1 Adam Kucharski
      2 Adam Kucharski
      3       Seb Funk
      4 Joshua Lambert
      5 Joshua Lambert

# list_distributions works for generation_time, params = FALSE

    Code
      list_distributions(delay_dist = "generation_time", parameters = FALSE)
    Output
                pathogen_id         type_id      study_id year size distribution
      1          adenovirus generation_time      Guo_etal 2020  375      weibull
      2 SARS_CoV_2_wildtype generation_time Ferretti_etal 2020  191      weibull

# list_distributions works for generation_time, params = TRUE

    Code
      list_distributions(delay_dist = "generation_time", parameters = TRUE)
    Output
                pathogen_id         type_id      study_id year size distribution mean
      1          adenovirus generation_time      Guo_etal 2020  375      weibull   NA
      2 SARS_CoV_2_wildtype generation_time Ferretti_etal 2020  191      weibull    5
         sd quantile_025 median quantile_75 quantile_875 quantile_95 quantile_975
      1  NA           NA    7.3          NA           NA          NA           NA
      2 1.9           NA    5.0          NA           NA          NA           NA
        lower_range upper_range shape scale meanlog sdlog extracted discretised
      1          NA          NA 3.480 8.190      NA    NA                    no
      2          NA          NA 2.826 5.665      NA    NA       yes          no
        phase_bias_adjusted                                       notes     PMID
      1                  no Extracted using the parametric distribution 32479490
      2                 yes                         20/1/2020-21/3/2020 32234805
                                 DOI      added_by
      1 10.1371/journal.pone.0232948 Carmen Tamayo
      2      10.1126/science.abb6936  Rachael Pung

