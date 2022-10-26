# list_distributions works for incubation, params = FALSE

    Code
      list_distributions(delay_dist = "incubation", parameters = FALSE)
    Output
                  pathogen_id        study_id year size distribution
      1            adenovirus    Lessler_etal 2009   14        lnorm
      3                 ebola        WHO_team 2014  500        gamma
      5             human_CoV    Lessler_etal 2009   13        lnorm
      6  influenza_A_seasonal    Lessler_etal 2009  122        lnorm
      7  influenza_B_seasonal    Lessler_etal 2009   76        lnorm
      8       influenza_H1N1p      Ghani_etal 2009   16        gamma
      9       influenza_H1N1p      Tuite_etal 2010  316        lnorm
      13       influenza_H5N1    Cowling_etal 2013   27      weibull
      11       influenza_H7N9    Cowling_etal 2013   32      weibull
      15              marburg          Pavlin 2014   18        gamma
      16              measles    Lessler_etal 2009   56        lnorm
      17             MERS_CoV     Assiri_etal 2013   23        lnorm
      20             MERS_CoV Cauchemez_et_al 2014    7        lnorm
      21            monkeypox           Nolen 2016   16        lnorm
      22            monkeypox  Thornhill_etal 2022   23        lnorm
      24        parainfluenza    Lessler_etal 2009   11        lnorm
      25           rhinovirus    Lessler_etal 2009   28        lnorm
      26                  RSV    Lessler_etal 2009   24        lnorm
      27             SARS_CoV   Donnelly_etal 2003   57        gamma
      29             SARS_CoV    Lessler_etal 2009  157        lnorm
      33  SARS_CoV_2_wildtype    McAloon_etal 2020 1269        lnorm

# list_distributions works for incubation, params = TRUE

    Code
      list_distributions(delay_dist = "incubation", parameters = TRUE)
    Output
                  pathogen_id    type_id        study_id year size distribution mean
      1            adenovirus incubation    Lessler_etal 2009   14        lnorm   NA
      3                 ebola incubation        WHO_team 2014  500        gamma 9.10
      5             human_CoV incubation    Lessler_etal 2009   13        lnorm   NA
      6  influenza_A_seasonal incubation    Lessler_etal 2009  122        lnorm   NA
      7  influenza_B_seasonal incubation    Lessler_etal 2009   76        lnorm   NA
      8       influenza_H1N1p incubation      Ghani_etal 2009   16        gamma 2.05
      9       influenza_H1N1p incubation      Tuite_etal 2010  316        lnorm 4.30
      13       influenza_H5N1 incubation    Cowling_etal 2013   27      weibull 3.30
      11       influenza_H7N9 incubation    Cowling_etal 2013   32      weibull 3.10
      15              marburg incubation          Pavlin 2014   18        gamma   NA
      16              measles incubation    Lessler_etal 2009   56        lnorm   NA
      17             MERS_CoV incubation     Assiri_etal 2013   23        lnorm   NA
      20             MERS_CoV incubation Cauchemez_et_al 2014    7        lnorm 5.50
      21            monkeypox incubation           Nolen 2016   16        lnorm 9.60
      22            monkeypox incubation  Thornhill_etal 2022   23        lnorm   NA
      24        parainfluenza incubation    Lessler_etal 2009   11        lnorm   NA
      25           rhinovirus incubation    Lessler_etal 2009   28        lnorm   NA
      26                  RSV incubation    Lessler_etal 2009   24        lnorm   NA
      27             SARS_CoV incubation   Donnelly_etal 2003   57        gamma 6.40
      29             SARS_CoV incubation    Lessler_etal 2009  157        lnorm   NA
      33  SARS_CoV_2_wildtype incubation    McAloon_etal 2020 1269        lnorm   NA
                sd quantile_025    median quantile_75 quantile_875 quantile_95
      1         NA           NA  5.600000    6.500000           NA          NA
      3  7.3000000           NA        NA          NA           NA          NA
      5         NA           NA  3.200000    3.500000           NA          NA
      6         NA           NA  1.400000    1.900000           NA          NA
      7         NA           NA  0.600000    0.700000           NA          NA
      8  0.4898979           NA        NA          NA           NA          NA
      9         NA           NA  4.000000          NA           NA          NA
      13 1.5000000    0.6870932  3.088366    4.288508           NA    5.989652
      11 1.4000000    0.6870932  2.887973    3.888880           NA    5.489237
      15        NA           NA  7.000000          NA           NA          NA
      16        NA           NA 12.500000   14.400000           NA   17.700000
      17        NA           NA  5.200000          NA           NA   12.400000
      20 2.5000000           NA        NA          NA           NA          NA
      21        NA           NA  9.000000          NA           13          NA
      22        NA           NA  7.000000          NA           NA          NA
      24        NA           NA  2.600000    3.200000           NA          NA
      25        NA           NA  1.900000    2.700000           NA          NA
      26        NA           NA  4.400000    5.100000           NA          NA
      27 4.0800000           NA        NA          NA           NA   14.220000
      29        NA           NA  4.000000    5.900000           NA          NA
      33        NA           NA  5.100000          NA           NA   11.700000
         quantile_975 lower_range upper_range     shape     scale    meanlog
      1            NA          NA          NA        NA        NA  1.7227644
      3            NA          NA          NA  1.553950 5.8560440         NA
      5            NA          NA          NA        NA        NA  1.1631463
      6            NA          NA          NA        NA        NA  0.3364708
      7            NA          NA          NA        NA        NA -0.5108280
      8            NA          NA          NA 17.503120 0.1171220         NA
      9      6.600000          NA          NA        NA        NA  1.3862944
      13     6.589681          NA          NA  2.185908 3.6932670         NA
      11     5.989652          NA          NA  2.309241 3.3759410         NA
      15           NA           2          13  1.946138 0.5324265         NA
      16           NA          NA          NA        NA        NA  2.5257260
      17    14.700000          NA          NA        NA        NA  1.6486586
      20           NA          NA          NA        NA        NA  1.6108401
      21           NA          NA          NA        NA        NA  2.1783545
      22           NA          NA          NA        NA        NA         NA
      24           NA          NA          NA        NA        NA  0.9555123
      25           NA          NA          NA        NA        NA  0.6418529
      26           NA          NA          NA        NA        NA  1.4816021
      27           NA          NA          NA  2.431210 2.6200900         NA
      29           NA          NA          NA        NA        NA  1.3862935
      33           NA          NA          NA        NA        NA  1.6300000
             sdlog extracted discretised phase_bias_adjusted
      1  0.2209673       yes          no                  no
      3         NA       yes        <NA>                <NA>
      5  0.1328705       yes          no                  no
      6  0.4527634       yes          no                  no
      7  0.2285515       yes          no                  no
      8         NA       yes        <NA>                <NA>
      9  0.2554986       yes        <NA>                <NA>
      13        NA       yes          no                  no
      11        NA       yes          no                  no
      15        NA       yes          no                  no
      16 0.2097952       yes          no                  no
      17 0.5283368       yes        <NA>                <NA>
      20 0.4333775       yes        <NA>                <NA>
      21 0.3360684       yes          no                <NA>
      22        NA       yes          no                  no
      24 0.3078528       yes          no                  no
      25 0.5209872       yes          no                  no
      26 0.2188927       yes          no                  no
      27        NA       yes          no                  no
      29 0.5762278       yes          no                  no
      33 0.5000000        no          no                  no
                                                   notes     PMID
      1                                             <NA> 19393959
      3                 Extracted using single exposures 25564903
      5                                             <NA> 19393959
      6                                             <NA> 19393959
      7                                             <NA> 19393959
      8                                             <NA> 20029668
      9                                             <NA> 19959592
      13    extraction used quantile_025 and quantile_75 23803488
      11    extraction used quantile_025 and quantile_75 23803488
      15                    gamma assumed, range 2 to 13 25495697
      16                                            <NA> 19393959
      17     extracted using quantile_5 and quantile_975 23782161
      20                                            <NA> 24239323
      21   Extracted taking c(6,13) as central 75% range 27191380
      22 Extracted from range 3 to 21, lognormal assumed 35866746
      24                                            <NA> 19393959
      25                                            <NA> 19393959
      26                                            <NA> 19393959
      27                                            <NA> 12781533
      29                                            <NA> 19393959
      33                                            <NA> 32801208
                                     DOI       added_by
      1    10.1016/S1473-3099(09)70069-6 Adam Kucharski
      3            10.1056/nejmoa1411100 Adam Kucharski
      5    10.1016/S1473-3099(09)70069-6 Adam Kucharski
      6    10.1016/S1473-3099(09)70069-6 Adam Kucharski
      7    10.1016/S1473-3099(09)70069-6 Adam Kucharski
      8         10.1371/currents.RRN1130 Adam Kucharski
      9              10.1503/cmaj.091807 Adam Kucharski
      13   10.1016/S0140-6736(13)61171-X Adam Kucharski
      11   10.1016/S0140-6736(13)61171-X Adam Kucharski
      15 10.1186/1756-0500-7-906         Adam Kucharski
      16   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      17           10.1056/NEJMoa1306742 Adam Kucharski
      20   10.1016/S1473-3099(13)70304-9 Adam Kucharski
      21          10.3201/eid2206.150579       Seb Funk
      22           10.1056/NEJMoa2207323               
      24   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      25   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      26   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      27   10.1016/S0140-6736(03)13410-1 Adam Kucharski
      29   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      33     10.1136/bmjopen-2020-039652 Adam Kucharski

# list_distributions works for onset_to_admission, params = FALSE

    Code
      list_distributions(delay_dist = "onset_to_admission", parameters = FALSE)
    Output
                 pathogen_id      study_id year size distribution
      10     influenza_H1N1p     Jain_etal 2009  272        lnorm
      14      influenza_H5N1  Cowling_etal 2013   43      weibull
      12      influenza_H7N9  Cowling_etal 2013  123        gamma
      18            MERS_CoV   Assiri_etal 2013   23        lnorm
      28            SARS_CoV Donnelly_etal 2003   57        gamma
      31 SARS_CoV_2_wildtype   Linton_etal 2020  155        lnorm

# list_distributions works for onset_to_admission, params = TRUE

    Code
      list_distributions(delay_dist = "onset_to_admission", parameters = TRUE)
    Output
                 pathogen_id            type_id      study_id year size distribution
      10     influenza_H1N1p onset_to_admission     Jain_etal 2009  272        lnorm
      14      influenza_H5N1 onset_to_admission  Cowling_etal 2013   43      weibull
      12      influenza_H7N9 onset_to_admission  Cowling_etal 2013  123        gamma
      18            MERS_CoV onset_to_admission   Assiri_etal 2013   23        lnorm
      28            SARS_CoV onset_to_admission Donnelly_etal 2003   57        gamma
      31 SARS_CoV_2_wildtype onset_to_admission   Linton_etal 2020  155        lnorm
         mean    sd quantile_025 median quantile_75 quantile_875 quantile_95
      10   NA    NA           NA    3.0          NA           NA          NA
      14   NA    NA    1.3678290    4.9    6.770349           NA   10.222554
      12   NA    NA    0.6172617    4.2    6.170223           NA    9.622302
      18   NA    NA           NA    5.0          NA           NA          NA
      28 4.85  3.49           NA     NA          NA           NA          NA
      31 9.70 35.20           NA    2.6          NA           NA   35.100000
         quantile_975 lower_range upper_range    shape    scale   meanlog     sdlog
      10           NA          NA          NA       NA       NA 1.0986120 2.9115800
      14     11.42344          NA          NA 2.373396 6.438843        NA        NA
      12     10.82306          NA          NA 2.138094 2.153314        NA        NA
      18           NA           1          10       NA       NA 1.6089493 0.6103889
      28           NA          NA          NA 1.929655 2.513402        NA        NA
      31           NA          NA          NA       NA       NA 0.9466094 1.6281993
         extracted discretised phase_bias_adjusted
      10       yes        <NA>                <NA>
      14       yes          no                  no
      12       yes          no                  no
      18       yes        <NA>                <NA>
      28       yes        <NA>                <NA>
      31       yes          no                 yes
                                                    notes     PMID
      10 Extracted using range 0 to 18, lognormal assumed 19815859
      14     extraction used quantile_025 and quantile_95 23803488
      12     extraction used quantile_025 and quantile_75 23803488
      18                                             <NA> 23782161
      28                                 Feb-26 to Mar-25 12781533
      31                              For living patients 32079150
                                   DOI       added_by
      10         10.1056/NEJMoa0906695 Adam Kucharski
      14 10.1016/S0140-6736(13)61171-X Adam Kucharski
      12 10.1016/S0140-6736(13)61171-X Adam Kucharski
      18         10.1056/NEJMoa1306742 Adam Kucharski
      28 10.1016/S0140-6736(03)13410-1 Adam Kucharski
      31            10.3390/jcm9020538 Adam Kucharski

# list_distributions works for onset_to_death, params = FALSE

    Code
      list_distributions(delay_dist = "onset_to_death", parameters = FALSE)
    Output
                 pathogen_id            study_id year size distribution
      4                ebola Ebola_outbreak_team 2018   14        gamma
      32 SARS_CoV_2_wildtype         Linton_etal 2020   39        lnorm

# list_distributions works for onset_to_death, params = TRUE

    Code
      list_distributions(delay_dist = "onset_to_death", parameters = TRUE)
    Output
                 pathogen_id        type_id            study_id year size
      4                ebola onset_to_death Ebola_outbreak_team 2018   14
      32 SARS_CoV_2_wildtype onset_to_death         Linton_etal 2020   39
         distribution mean   sd quantile_025 median quantile_75 quantile_875
      4         gamma  9.3  6.0           NA     NA          NA           NA
      32        lnorm 20.2 11.6           NA   17.1          NA           NA
         quantile_95 quantile_975 lower_range upper_range shape scale  meanlog
      4           NA           NA           2          27   2.4 3.333       NA
      32        39.9           NA          NA          NA    NA    NA 2.863179
             sdlog extracted discretised phase_bias_adjusted
      4         NA        no          no                  no
      32 0.5338606       yes          no                 yes
                                                                                                                 notes
      4  the mean, sd, shape and scale are taken from the paper, the conversion between the two does not match exactly
      32                                                                                                          <NA>
             PMID                           DOI       added_by
      4  30047375 10.1016/S0140-6736(18)31387-4 Joshua Lambert
      32       NA                                             

# list_distributions works for serial_interval, params = FALSE

    Code
      list_distributions(delay_dist = "serial_interval", parameters = FALSE)
    Output
                 pathogen_id          study_id year size distribution
      2                ebola WHO_response_team 2014   92        gamma
      19            MERS_CoV       Assiri_etal 2013   23        lnorm
      23           monkeypox             UKHSA 2022   17        gamma
      34 SARS_CoV_2_wildtype     Nishiura_etal 2020   28        lnorm
      35 SARS_CoV_2_wildtype     Nishiura_etal 2020   18      weibull

# list_distributions works for serial_interval, params = TRUE

    Code
      list_distributions(delay_dist = "serial_interval", parameters = TRUE)
    Output
                 pathogen_id         type_id          study_id year size distribution
      2                ebola serial_interval WHO_response_team 2014   92        gamma
      19            MERS_CoV serial_interval       Assiri_etal 2013   23        lnorm
      23           monkeypox serial_interval             UKHSA 2022   17        gamma
      34 SARS_CoV_2_wildtype serial_interval     Nishiura_etal 2020   28        lnorm
      35 SARS_CoV_2_wildtype serial_interval     Nishiura_etal 2020   18      weibull
         mean  sd quantile_025 median quantile_75 quantile_875 quantile_95
      2  15.3 9.3           NA     NA          NA           NA          NA
      19   NA  NA           NA    7.6          NA           NA        19.4
      23  9.8 8.3           NA     NA          NA           NA          NA
      34  4.7 2.9           NA    4.0          NA           NA          NA
      35  4.8 2.3           NA    4.6          NA           NA          NA
         quantile_975 lower_range upper_range    shape    scale  meanlog     sdlog
      2            NA          NA          NA 2.706556 5.652941       NA        NA
      19         23.1          NA          NA       NA       NA 2.020000 0.5600000
      23           NA          NA          NA 1.394107 7.029592       NA        NA
      34           NA          NA          NA       NA       NA 1.386262 0.5679803
      35           NA          NA          NA 2.203394 5.419875       NA        NA
         extracted discretised phase_bias_adjusted
      2        yes        <NA>                <NA>
      19       yes        <NA>                <NA>
      23       yes          no                 yes
      34       yes          no                 yes
      35       yes          no                 yes
                                                                                                      notes
      2                                                                                                <NA>
      19                                                                                               <NA>
      23                                                         Extracted from mean and SD, assuming gamma
      34                                                               Extracted using reported mean and sd
      35 Extracted using mean and sd reported from a subset of the data for certain infector-infectee pairs
             PMID
      2  25564903
      19 23782161
      23       NA
      34 32145466
      35 32145466
                                                                                                                                                             DOI
      2                                                                                                                                    10.1056/nejmoa1411100
      19                                                                                                                                   10.1056/NEJMoa1306742
      23 https://www.gov.uk/government/publications/monkeypox-outbreak-technical-briefings/investigation-into-monkeypox-outbreak-in-england-technical-briefing-1
      34                                                                                                                              10.1016/j.ijid.2020.02.060
      35                                                                                                                              10.1016/j.ijid.2020.02.060
               added_by
      2  Adam Kucharski
      19 Adam Kucharski
      23       Seb Funk
      34 Joshua Lambert
      35 Joshua Lambert

# list_distributions works for generation_time, params = FALSE

    Code
      list_distributions(delay_dist = "generation_time", parameters = FALSE)
    Output
                 pathogen_id      study_id year size distribution
      36          adenovirus      Guo_etal 2020  375      weibull
      30 SARS_CoV_2_wildtype Ferretti_etal 2020  191      weibull

# list_distributions works for generation_time, params = TRUE

    Code
      list_distributions(delay_dist = "generation_time", parameters = TRUE)
    Output
                 pathogen_id         type_id      study_id year size distribution
      36          adenovirus generation_time      Guo_etal 2020  375      weibull
      30 SARS_CoV_2_wildtype generation_time Ferretti_etal 2020  191      weibull
         mean  sd quantile_025 median quantile_75 quantile_875 quantile_95
      36   NA  NA           NA    7.3          NA           NA          NA
      30    5 1.9           NA    5.0          NA           NA          NA
         quantile_975 lower_range upper_range shape scale meanlog sdlog extracted
      36           NA          NA          NA 3.480 8.190      NA    NA          
      30           NA          NA          NA 2.826 5.665      NA    NA       yes
         discretised phase_bias_adjusted                                       notes
      36          no                  no Extracted using the parametric distribution
      30          no                 yes                         20/1/2020-21/3/2020
             PMID                          DOI      added_by
      36 32479490 10.1371/journal.pone.0232948 Carmen Tamayo
      30 32234805      10.1126/science.abb6936  Rachael Pung

