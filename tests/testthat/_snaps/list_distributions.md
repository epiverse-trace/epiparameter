# list_distributions works as expected with defaults

    Code
      list_distributions(epiparam = eparam)
    Output
                       disease  epi_distribution prob_distribution
      1             Adenovirus incubation_period             lnorm
      2            Chikungunya incubation_period             lnorm
      3               COVID-19 incubation_period              <NA>
      4               COVID-19 incubation_period           weibull
      5               COVID-19 incubation_period              <NA>
      6               COVID-19 incubation_period             lnorm
      7               COVID-19 incubation_period             lnorm
      8               COVID-19 incubation_period             lnorm
      9               COVID-19 incubation_period             lnorm
      10              COVID-19 incubation_period             lnorm
      11              COVID-19 incubation_period             lnorm
      12              COVID-19 incubation_period             lnorm
      13              COVID-19 incubation_period             lnorm
      14              COVID-19 incubation_period             lnorm
      15              COVID-19 incubation_period              <NA>
      16              COVID-19 incubation_period              <NA>
      17                Dengue incubation_period             lnorm
      18                Dengue incubation_period             lnorm
      19                Dengue incubation_period             lnorm
      20                Dengue incubation_period             lnorm
      21                Dengue incubation_period             lnorm
      22   Ebola Virus Disease incubation_period             lnorm
      23   Ebola Virus Disease incubation_period             gamma
      24   Ebola Virus Disease incubation_period             gamma
      25   Ebola Virus Disease incubation_period             gamma
      26   Ebola Virus Disease incubation_period             gamma
      27     Human Coronavirus incubation_period             lnorm
      28             Influenza incubation_period             gamma
      29             Influenza incubation_period             lnorm
      30             Influenza incubation_period             lnorm
      31             Influenza incubation_period             lnorm
      32             Influenza incubation_period             lnorm
      33             Influenza incubation_period             gamma
      34             Influenza incubation_period           weibull
      35             Influenza incubation_period             lnorm
      36             Influenza incubation_period             lnorm
      37             Influenza incubation_period             lnorm
      38             Influenza incubation_period           weibull
      39             Influenza incubation_period             gamma
      40             Influenza incubation_period           weibull
      41             Influenza incubation_period           weibull
      42             Influenza incubation_period           weibull
      43 Japanese Encephalitis incubation_period             lnorm
      44 Marburg Virus Disease incubation_period              <NA>
      45 Marburg Virus Disease incubation_period              <NA>
      46               Measles incubation_period             lnorm
      47                  MERS incubation_period             lnorm
      48                  MERS incubation_period             gamma
      49                  Mpox incubation_period             lnorm
      50                  Mpox incubation_period             gamma
      51                  Mpox incubation_period             lnorm
      52                  Mpox incubation_period             lnorm
      53                  Mpox incubation_period             lnorm
      54                  Mpox incubation_period              <NA>
      55                  Mpox incubation_period              <NA>
      56                  Mpox incubation_period              <NA>
      57                  Mpox incubation_period              <NA>
      58                  Mpox incubation_period              <NA>
      59                  Mpox incubation_period              <NA>
      60         Parainfluenza incubation_period             lnorm
      61            Rhinovirus incubation_period             lnorm
      62     Rift Valley Fever incubation_period             lnorm
      63                   RSV incubation_period             lnorm
      64                   RSV incubation_period             lnorm
      65                   RSV incubation_period             lnorm
      66                  SARS incubation_period             lnorm
      67       West Nile Fever incubation_period             lnorm
      68       West Nile Fever incubation_period             lnorm
      69       West Nile Fever incubation_period             lnorm
      70          Yellow Fever incubation_period             lnorm
      71          Yellow Fever incubation_period             lnorm
      72    Zika Virus Disease incubation_period             lnorm
                          author year sample_size
      1             Lessler_etal 2009          14
      2             Rudolph_etal 2014          21
      3               Alene_etal 2021        1453
      4                 Bui_etal 2020          19
      5               Elias_etal 2021       28675
      6               Lauer_etal 2020         181
      7               Lauer_etal 2020          99
      8               Lauer_etal 2020         108
      9               Lauer_etal 2020          73
      10             Linton_etal 2020          52
      11             Linton_etal 2020         158
      12             Linton_etal 2020          52
      13            McAloon_etal 2020        1357
      14            McAloon_etal 2020        1269
      15                Men_etal 2020          59
      16                Rai_etal 2022        6241
      17          Chan_Johansson 2012         146
      18          Chan_Johansson 2012         146
      19          Chan_Johansson 2012         153
      20            Rudolph_etal 2014         169
      21            Rudolph_etal 2014         124
      22            Eichner_etal 2011         196
      23 WHO_Ebola_Response_Team 2015          49
      24 WHO_Ebola_Response_Team 2015         957
      25 WHO_Ebola_Response_Team 2015         792
      26  WHO_Ebola_ResponseTeam 2015        1798
      27            Lessler_etal 2009          13
      28              Ghani_etal 2009          16
      29            Lessler_etal 2009         151
      30            Lessler_etal 2009          90
      31            Lessler_etal 2009          78
      32            Lessler_etal 2009         124
      33          Nishiura_Inaba 2011          72
      34          Nishiura_Inaba 2011          72
      35              Reich_etal 2009         151
      36              Reich_etal 2009         151
      37              Tuite_etal 2010         316
      38          Virlogeux_etal 2015         229
      39          Virlogeux_etal 2015         229
      40          Virlogeux_etal 2016         395
      41          Virlogeux_etal 2016         173
      42          Virlogeux_etal 2016         222
      43            Rudolph_etal 2014           6
      44                  Pavlin 2014          76
      45                  Pavlin 2014          18
      46            Lessler_etal 2009          55
      47             Assiri_etal 2013          23
      48            Cowling_etal 2015         166
      49           Charniga_etal 2022          22
      50            Guzetta_etal 2022         255
      51           Madewell_etal 2022          35
      52           Madewell_etal 2022          36
      53              Miura_etal 2022          18
      54               Wang_etal 2022          16
      55               Wang_etal 2022          27
      56               Wang_etal 2022         114
      57                Wei_etal 2022          NA
      58                Wei_etal 2022          NA
      59                Wei_etal 2022          NA
      60            Lessler_etal 2009          11
      61            Lessler_etal 2009          28
      62            Rudolph_etal 2014          23
      63            Lessler_etal 2009          24
      64              Reich_etal 2009          24
      65              Reich_etal 2009          24
      66            Lessler_etal 2009         157
      67            Rudolph_etal 2014          18
      68            Rudolph_etal 2014           8
      69            Rudolph_etal 2014           6
      70            Rudolph_etal 2014          91
      71            Rudolph_etal 2014          80
      72            Lessler_etal 2016          25

# list_distributions works as expected with subset_db = FALSE

    Code
      list_distributions(epiparam = eparam, subset_db = FALSE)
    Output
                       disease                    pathogen  epi_distribution
      1             Adenovirus                  Adenovirus incubation_period
      2            Chikungunya           Chikungunya Virus incubation_period
      3               COVID-19                  SARS-CoV-2 incubation_period
      4               COVID-19                  SARS-CoV-2 incubation_period
      5               COVID-19                  SARS-CoV-2 incubation_period
      6               COVID-19                  SARS-CoV-2 incubation_period
      7               COVID-19                  SARS-CoV-2 incubation_period
      8               COVID-19                  SARS-CoV-2 incubation_period
      9               COVID-19                  SARS-CoV-2 incubation_period
      10              COVID-19                  SARS-CoV-2 incubation_period
      11              COVID-19                  SARS-CoV-2 incubation_period
      12              COVID-19                  SARS-CoV-2 incubation_period
      13              COVID-19                  SARS-CoV-2 incubation_period
      14              COVID-19                  SARS-CoV-2 incubation_period
      15              COVID-19                  SARS-CoV-2 incubation_period
      16              COVID-19                  SARS-CoV-2 incubation_period
      17                Dengue                Dengue Virus incubation_period
      18                Dengue                Dengue Virus incubation_period
      19                Dengue                Dengue Virus incubation_period
      20                Dengue                Dengue Virus incubation_period
      21                Dengue                Dengue Virus incubation_period
      22   Ebola Virus Disease   Ebola Virus-Zaire Subtype incubation_period
      23   Ebola Virus Disease                 Ebola Virus incubation_period
      24   Ebola Virus Disease                 Ebola Virus incubation_period
      25   Ebola Virus Disease                 Ebola Virus incubation_period
      26   Ebola Virus Disease                 Ebola Virus incubation_period
      27     Human Coronavirus                   Human_Cov incubation_period
      28             Influenza         Influenza-A-H1N1Pdm incubation_period
      29             Influenza                 Influenza-A incubation_period
      30             Influenza                 Influenza-A incubation_period
      31             Influenza                 Influenza-B incubation_period
      32             Influenza            Influenza-A-H1N1 incubation_period
      33             Influenza            Influenza-A-H1N1 incubation_period
      34             Influenza            Influenza-A-H1N1 incubation_period
      35             Influenza                 Influenza-A incubation_period
      36             Influenza                 Influenza-A incubation_period
      37             Influenza            Influenza-A-H1N1 incubation_period
      38             Influenza            Influenza-A-H7N9 incubation_period
      39             Influenza            Influenza-A-H7N9 incubation_period
      40             Influenza            Influenza-A-H7N9 incubation_period
      41             Influenza            Influenza-A-H7N9 incubation_period
      42             Influenza            Influenza-A-H7N9 incubation_period
      43 Japanese Encephalitis Japanese Encephalitis Virus incubation_period
      44 Marburg Virus Disease               Marburg Virus incubation_period
      45 Marburg Virus Disease               Marburg Virus incubation_period
      46               Measles               Measles Virus incubation_period
      47                  MERS                    MERS-Cov incubation_period
      48                  MERS                    MERS-Cov incubation_period
      49                  Mpox                  Mpox Virus incubation_period
      50                  Mpox                  Mpox Virus incubation_period
      51                  Mpox                  Mpox Virus incubation_period
      52                  Mpox                  Mpox Virus incubation_period
      53                  Mpox                  Mpox Virus incubation_period
      54                  Mpox          Mpox Virus Clade I incubation_period
      55                  Mpox        Mpox Virus Clade IIa incubation_period
      56                  Mpox        Mpox Virus Clade IIb incubation_period
      57                  Mpox                  Mpox Virus incubation_period
      58                  Mpox                  Mpox Virus incubation_period
      59                  Mpox                  Mpox Virus incubation_period
      60         Parainfluenza         Parainfluenza Virus incubation_period
      61            Rhinovirus                  Rhinovirus incubation_period
      62     Rift Valley Fever     Rift Valley Fever Virus incubation_period
      63                   RSV                         RSV incubation_period
      64                   RSV                         RSV incubation_period
      65                   RSV                         RSV incubation_period
      66                  SARS                  SARS-Cov-1 incubation_period
      67       West Nile Fever             West Nile Virus incubation_period
      68       West Nile Fever             West Nile Virus incubation_period
      69       West Nile Fever             West Nile Virus incubation_period
      70          Yellow Fever        Yellow Fever Viruses incubation_period
      71          Yellow Fever        Yellow Fever Viruses incubation_period
      72    Zika Virus Disease                  Zika Virus incubation_period
                          author
      1             Lessler_etal
      2             Rudolph_etal
      3               Alene_etal
      4                 Bui_etal
      5               Elias_etal
      6               Lauer_etal
      7               Lauer_etal
      8               Lauer_etal
      9               Lauer_etal
      10             Linton_etal
      11             Linton_etal
      12             Linton_etal
      13            McAloon_etal
      14            McAloon_etal
      15                Men_etal
      16                Rai_etal
      17          Chan_Johansson
      18          Chan_Johansson
      19          Chan_Johansson
      20            Rudolph_etal
      21            Rudolph_etal
      22            Eichner_etal
      23 WHO_Ebola_Response_Team
      24 WHO_Ebola_Response_Team
      25 WHO_Ebola_Response_Team
      26  WHO_Ebola_ResponseTeam
      27            Lessler_etal
      28              Ghani_etal
      29            Lessler_etal
      30            Lessler_etal
      31            Lessler_etal
      32            Lessler_etal
      33          Nishiura_Inaba
      34          Nishiura_Inaba
      35              Reich_etal
      36              Reich_etal
      37              Tuite_etal
      38          Virlogeux_etal
      39          Virlogeux_etal
      40          Virlogeux_etal
      41          Virlogeux_etal
      42          Virlogeux_etal
      43            Rudolph_etal
      44                  Pavlin
      45                  Pavlin
      46            Lessler_etal
      47             Assiri_etal
      48            Cowling_etal
      49           Charniga_etal
      50            Guzetta_etal
      51           Madewell_etal
      52           Madewell_etal
      53              Miura_etal
      54               Wang_etal
      55               Wang_etal
      56               Wang_etal
      57                Wei_etal
      58                Wei_etal
      59                Wei_etal
      60            Lessler_etal
      61            Lessler_etal
      62            Rudolph_etal
      63            Lessler_etal
      64              Reich_etal
      65              Reich_etal
      66            Lessler_etal
      67            Rudolph_etal
      68            Rudolph_etal
      69            Rudolph_etal
      70            Rudolph_etal
      71            Rudolph_etal
      72            Lessler_etal
                                                                                                                                                                                  title
      1                                                                                                   Incubation periods of acute respiratory viral infections: a systematic review
      2                                                                                                      Incubation periods of mosquito-borne viral infections: a systematic review
      3                                                                                        Serial interval and incubation period of COVID-19: a systematic review and meta-analysis
      4                                                                                                                      Estimation of the incubation period of COVID-19 in Vietnam
      5                                                                                                                              The incubation period of COVID-19: A meta-analysis
      6                                                 The Incubation Period of Coronavirus Disease 2019 (COVID-19) From Publicly Reported Confirmed Cases: Estimation and Application
      7                                                 The Incubation Period of Coronavirus Disease 2019 (COVID-19) From Publicly Reported Confirmed Cases: Estimation and Application
      8                                                 The Incubation Period of Coronavirus Disease 2019 (COVID-19) From Publicly Reported Confirmed Cases: Estimation and Application
      9                                                 The Incubation Period of Coronavirus Disease 2019 (COVID-19) From Publicly Reported Confirmed Cases: Estimation and Application
      10 Incubation Period and Other Epidemiological Characteristics of 2019 Novel Coronavirus Infections with Right Truncation: A Statistical Analysis of Publicly Available Case Data
      11 Incubation Period and Other Epidemiological Characteristics of 2019 Novel Coronavirus Infections with Right Truncation: A Statistical Analysis of Publicly Available Case Data
      12 Incubation Period and Other Epidemiological Characteristics of 2019 Novel Coronavirus Infections with Right Truncation: A Statistical Analysis of Publicly Available Case Data
      13                                                                           Incubation period of COVID-19: a rapid systematic review and meta-analysis of observational research
      14                                                                           Incubation period of COVID-19: a rapid systematic review and meta-analysis of observational research
      15                                                                                                                  Estimate the incubation period of coronavirus 2019 (COVID-19)
      16                                                                                                          Incubation period for COVID-19: a systematic review and meta-analysis
      17                                                                                                                                       The Incubation Periods of Dengue Viruses
      18                                                                                                                                       The Incubation Periods of Dengue Viruses
      19                                                                                                                                       The Incubation Periods of Dengue Viruses
      20                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      21                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      22                                                                                                                     Incubation period of ebola hemorrhagic virus subtype zaire
      23                                                                                                 West African Ebola Epidemic after One Year — Slowing but Not Yet under Control
      24                                                                                                 West African Ebola Epidemic after One Year — Slowing but Not Yet under Control
      25                                                                                                 West African Ebola Epidemic after One Year — Slowing but Not Yet under Control
      26                                                                                                 West African Ebola Epidemic after One Year — Slowing but Not Yet under Control
      27                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      28                                                                                                     The Early Transmission Dynamics of H1N1pdm Influenza in the United Kingdom
      29                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      30                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      31                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      32                                                                                                         Outbreak of 2009 Pandemic Influenza A (H1N1) at a New York City School
      33                     Estimation of the incubation period of influenza A (H1N1-2009) among imported cases: addressing censoring using outbreak data at the origin of importation
      34                     Estimation of the incubation period of influenza A (H1N1-2009) among imported cases: addressing censoring using outbreak data at the origin of importation
      35                                                                                                                    Estimating incubation period distributions with coarse data
      36                                                                                                                    Estimating incubation period distributions with coarse data
      37                                                                                       Estimated epidemiologic parameters and morbidity associated with pandemic H1N1 influenza
      38                                                                        Estimating the Distribution of the Incubation Periods of Human Avian Influenza A(H7N9) Virus Infections
      39                                                                        Estimating the Distribution of the Incubation Periods of Human Avian Influenza A(H7N9) Virus Infections
      40                                                                     Association between the Severity of Influenza A(H7N9) Virus Infections and Length of the Incubation Period
      41                                                                     Association between the Severity of Influenza A(H7N9) Virus Infections and Length of the Incubation Period
      42                                                                     Association between the Severity of Influenza A(H7N9) Virus Infections and Length of the Incubation Period
      43                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      44                                                                          Calculation of incubation period and serial interval from multiple outbreaks of Marburg virus disease
      45                                                                          Calculation of incubation period and serial interval from multiple outbreaks of Marburg virus disease
      46                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      47                                                                                                              Hospital Outbreak of Middle East Respiratory Syndrome Coronavirus
      48                                                                                   Preliminary epidemiological assessment of MERS-CoV outbreak in South Korea, May to June 2015
      49                                                                                    Estimating the incubation period of monkeypox virus during the 2022 multi-national outbreak
      50                                                                 Early Estimates of Monkeypox Incubation Period, Generation Time, and Reproduction Number, Italy, May-June 2022
      51                                                       Serial interval and incubation period estimates of monkeypox virus infection in 12 U.S. jurisdictions, May – August 2022
      52                                                       Serial interval and incubation period estimates of monkeypox virus infection in 12 U.S. jurisdictions, May – August 2023
      53                                                                                         Estimated incubation period for monkeypox cases confirmed in the Netherlands, May 2022
      54                                                                                                          Serial intervals and incubation periods of the monkeypox virus clades
      55                                                                                                          Serial intervals and incubation periods of the monkeypox virus clades
      56                                                                                                          Serial intervals and incubation periods of the monkeypox virus clades
      57                                                                                                                     Study and prediction of the 2022 global monkeypox epidemic
      58                                                                                                                     Study and prediction of the 2022 global monkeypox epidemic
      59                                                                                                                     Study and prediction of the 2022 global monkeypox epidemic
      60                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      61                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      62                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      63                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      64                                                                                                                    Estimating incubation period distributions with coarse data
      65                                                                                                                    Estimating incubation period distributions with coarse data
      66                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      67                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      68                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      69                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      70                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      71                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      72                                                                           Times to key events in Zika virus infection and implications for blood donation: a systematic review
                                                       journal year sample_size
      1                         The Lancet Infectious Diseases 2009          14
      2  The American Journal of Tropical Medicine and Hygiene 2014          21
      3                                BMC Infectious Diseases 2021        1453
      4                                               PLoS One 2020          19
      5           International Journal of Infectious Diseases 2021       28675
      6                            Annals of Internal Medicine 2020         181
      7                            Annals of Internal Medicine 2020          99
      8                            Annals of Internal Medicine 2020         108
      9                            Annals of Internal Medicine 2020          73
      10                          Journal of Clinical Medicine 2020          52
      11                          Journal of Clinical Medicine 2020         158
      12                          Journal of Clinical Medicine 2020          52
      13                                              BMJ Open 2020        1357
      14                                              BMJ Open 2020        1269
      15                                               medRxiv 2020          59
      16             Zeitschrift fur Gesundheitswissenschaften 2022        6241
      17                                              PLoS One 2012         146
      18                                              PLoS One 2012         146
      19                                              PLoS One 2012         153
      20 The American Journal of Tropical Medicine and Hygiene 2014         169
      21 The American Journal of Tropical Medicine and Hygiene 2014         124
      22         Osong Public Health and Research Perspectives 2011         196
      23                   The New England Journal of Medicine 2015          49
      24                   The New England Journal of Medicine 2015         957
      25                   The New England Journal of Medicine 2015         792
      26                   The New England Journal of Medicine 2015        1798
      27                        The Lancet Infectious Diseases 2009          13
      28                                         PLoS Currents 2009          16
      29                        The Lancet Infectious Diseases 2009         151
      30                        The Lancet Infectious Diseases 2009          90
      31                        The Lancet Infectious Diseases 2009          78
      32                   The New England Journal of Medicine 2009         124
      33                        Journal of Theoretical Biology 2011          72
      34                        Journal of Theoretical Biology 2011          72
      35                                Statistics in Medicine 2009         151
      36                                Statistics in Medicine 2009         151
      37                  Canadian Medical Association Journal 2010         316
      38                      American Journal of Epidemiology 2015         229
      39                      American Journal of Epidemiology 2015         229
      40                                              PLoS One 2016         395
      41                                              PLoS One 2016         173
      42                                              PLoS One 2016         222
      43 The American Journal of Tropical Medicine and Hygiene 2014           6
      44                                    BMC Research Notes 2014          76
      45                                    BMC Research Notes 2014          18
      46                        The Lancet Infectious Diseases 2009          55
      47                   The New England Journal of Medicine 2013          23
      48                                      Eurosurveillance 2015         166
      49                                               medRxiv 2022          22
      50                          Emerging Infectious Diseases 2022         255
      51                                               medRxiv 2022          35
      52                                               medRxiv 2022          36
      53                                      Eurosurveillance 2022          18
      54                            Journal of Travel Medicine 2022          16
      55                            Journal of Travel Medicine 2022          27
      56                            Journal of Travel Medicine 2022         114
      57                  Journal of Biosafety and Biosecurity 2022          NA
      58                  Journal of Biosafety and Biosecurity 2022          NA
      59                  Journal of Biosafety and Biosecurity 2022          NA
      60                        The Lancet Infectious Diseases 2009          11
      61                        The Lancet Infectious Diseases 2009          28
      62 The American Journal of Tropical Medicine and Hygiene 2014          23
      63                        The Lancet Infectious Diseases 2009          24
      64                                Statistics in Medicine 2009          24
      65                                Statistics in Medicine 2009          24
      66                        The Lancet Infectious Diseases 2009         157
      67 The American Journal of Tropical Medicine and Hygiene 2014          18
      68 The American Journal of Tropical Medicine and Hygiene 2014           8
      69 The American Journal of Tropical Medicine and Hygiene 2014           6
      70 The American Journal of Tropical Medicine and Hygiene 2014          91
      71 The American Journal of Tropical Medicine and Hygiene 2014          80
      72             Bulletin of the World Health Organization 2016          25
                                       region              transmission_mode
      1                                   USA                   experimental
      2                                 Mixed                   vector_borne
      3                                 Mixed natural_natural_human_to_human
      4                               Vietnam natural_natural_human_to_human
      5                                 Mixed natural_natural_human_to_human
      6                                 Mixed         natural_human_to_human
      7                                 Mixed         natural_human_to_human
      8                                 Mixed         natural_human_to_human
      9                                 China         natural_human_to_human
      10                                China natural_natural_human_to_human
      11                                China natural_natural_human_to_human
      12                                China         natural_human_to_human
      13                                Mixed natural_natural_human_to_human
      14                                Mixed natural_natural_human_to_human
      15                                China natural_natural_human_to_human
      16                                Mixed natural_natural_human_to_human
      17                                Mixed                   vector_borne
      18                                Mixed                   vector_borne
      19                                Mixed                   vector_borne
      20                                Mixed                       multiple
      21                                Mixed                   vector_borne
      22 Kikwit, Democratic Republic of Congo natural_natural_human_to_human
      23                               Guinea natural_natural_human_to_human
      24                              Liberia natural_natural_human_to_human
      25                         Sierra Leone natural_natural_human_to_human
      26                          West Africa natural_natural_human_to_human
      27                                   UK                   experimental
      28                                   UK                natural_unknown
      29                                Mixed                          mixed
      30                                Mixed                          mixed
      31                                  USA                   experimental
      32                        New York, USA                natural_unknown
      33                                Japan                natural_unknown
      34                                Japan                natural_unknown
      35                                Mixed                        unknown
      36                                Mixed                        unknown
      37                               Canada                natural_unknown
      38                                China                natural_unknown
      39                                China                natural_unknown
      40                                China                natural_unknown
      41                                China                natural_unknown
      42                                China                natural_unknown
      43                                Mixed                   vector_borne
      44                                Mixed                          mixed
      45                                Mixed                          mixed
      46                                Mixed                natural_unknown
      47                         Saudi Arabia natural_natural_human_to_human
      48                          South Korea                natural_unknown
      49                                  USA natural_natural_human_to_human
      50                                Italy natural_natural_human_to_human
      51                                  USA natural_natural_human_to_human
      52                                  USA natural_natural_human_to_human
      53                          Netherlands natural_natural_human_to_human
      54                                Congo                natural_unknown
      55                                  USA                natural_unknown
      56                                mixed                natural_unknown
      57                                  USA                natural_unknown
      58                               Europe                natural_unknown
      59                               Global                natural_unknown
      60                                Mixed                   experimental
      61                                  USA                   experimental
      62                                Mixed                   vector_borne
      63                                Mixed                          mixed
      64                                Mixed                        unknown
      65                                Mixed                        unknown
      66                                Mixed                natural_unknown
      67                                Mixed                       multiple
      68                                Mixed                   vector_borne
      69                                Mixed               organ_transplant
      70                                Mixed                       multiple
      71                                Mixed                   vector_borne
      72                                Mixed                   vector_borne
                                     vector extrinsic prob_distribution
      1                                <NA>     FALSE             lnorm
      2                    Aedes albopictus     FALSE             lnorm
      3                                <NA>     FALSE              <NA>
      4                                <NA>     FALSE           weibull
      5                                <NA>     FALSE              <NA>
      6                                <NA>     FALSE             lnorm
      7                                <NA>     FALSE             lnorm
      8                                <NA>     FALSE             lnorm
      9                                <NA>     FALSE             lnorm
      10                               <NA>     FALSE             lnorm
      11                               <NA>     FALSE             lnorm
      12                               <NA>     FALSE             lnorm
      13                               <NA>     FALSE             lnorm
      14                               <NA>     FALSE             lnorm
      15                               <NA>     FALSE              <NA>
      16                               <NA>     FALSE              <NA>
      17 Aedes aegypti and Aedes albopictus      TRUE             lnorm
      18 Aedes aegypti and Aedes albopictus      TRUE             lnorm
      19 Aedes aegypti and Aedes albopictus     FALSE             lnorm
      20                               <NA>     FALSE             lnorm
      21 Aedes aegypti and Aedes albopictus     FALSE             lnorm
      22                               <NA>     FALSE             lnorm
      23                               <NA>     FALSE             gamma
      24                               <NA>     FALSE             gamma
      25                               <NA>     FALSE             gamma
      26                               <NA>     FALSE             gamma
      27                               <NA>     FALSE             lnorm
      28                               <NA>     FALSE             gamma
      29                               <NA>     FALSE             lnorm
      30                               <NA>     FALSE             lnorm
      31                               <NA>     FALSE             lnorm
      32                               <NA>     FALSE             lnorm
      33                               <NA>     FALSE             gamma
      34                               <NA>     FALSE           weibull
      35                               <NA>     FALSE             lnorm
      36                               <NA>     FALSE             lnorm
      37                               <NA>     FALSE             lnorm
      38                               <NA>     FALSE           weibull
      39                               <NA>     FALSE             gamma
      40                               <NA>     FALSE           weibull
      41                               <NA>     FALSE           weibull
      42                               <NA>     FALSE           weibull
      43                           mosquito     FALSE             lnorm
      44                               <NA>     FALSE              <NA>
      45                               <NA>     FALSE              <NA>
      46                               <NA>     FALSE             lnorm
      47                               <NA>     FALSE             lnorm
      48                               <NA>     FALSE             gamma
      49                               <NA>     FALSE             lnorm
      50                               <NA>     FALSE             gamma
      51                               <NA>     FALSE             lnorm
      52                               <NA>     FALSE             lnorm
      53                               <NA>     FALSE             lnorm
      54                               <NA>     FALSE              <NA>
      55                               <NA>     FALSE              <NA>
      56                               <NA>     FALSE              <NA>
      57                               <NA>     FALSE              <NA>
      58                               <NA>     FALSE              <NA>
      59                               <NA>     FALSE              <NA>
      60                               <NA>     FALSE             lnorm
      61                               <NA>     FALSE             lnorm
      62                           mosquito     FALSE             lnorm
      63                               <NA>     FALSE             lnorm
      64                               <NA>     FALSE             lnorm
      65                               <NA>     FALSE             lnorm
      66                               <NA>     FALSE             lnorm
      67                               <NA>     FALSE             lnorm
      68                           mosquito     FALSE             lnorm
      69                               <NA>     FALSE             lnorm
      70                               <NA>     FALSE             lnorm
      71                           mosquito     FALSE             lnorm
      72 Aedes aegypti and Aedes albopictus     FALSE             lnorm
         inference_method  mean mean_ci_limits mean_ci    sd sd_ci_limits sd_ci
      1               mle    NA         NA, NA      NA    NA       NA, NA    NA
      2               mle    NA         NA, NA      NA    NA       NA, NA    NA
      3              <NA>  6.50       5.9, 7.1      95    NA       NA, NA    NA
      4          bayesian  6.40     4.89, 8.50      95  3.05   3.05, 5.30    95
      5              <NA>  6.38     5.79, 6.97      95    NA       NA, NA    NA
      6               mle  5.50         NA, NA      NA    NA       NA, NA    NA
      7               mle    NA         NA, NA      NA    NA       NA, NA    NA
      8               mle    NA         NA, NA      NA    NA       NA, NA    NA
      9               mle    NA         NA, NA      NA    NA       NA, NA    NA
      10         bayesian  5.00       4.2, 6.0      95  3.00     2.1, 4.5    95
      11         bayesian  5.60       5.0, 6.3      95  2.80     2.2, 3.6    95
      12         bayesian  5.60       4.4, 4.8      95  3.90     2.4, 6.9    95
      13              mle    NA         NA, NA      NA    NA       NA, NA    NA
      14              mle  5.80       5.0, 6.7      95    NA       NA, NA    NA
      15             <NA>  5.84     5.07, 6.55      95  2.98   2.31, 3.72    95
      16             <NA>  5.74     5.18, 6.30      95    NA       NA, NA    NA
      17         bayesian 15.00         10, 20      95    NA       NA, NA    NA
      18         bayesian  6.50       4.8, 8.8      95    NA       NA, NA    NA
      19         bayesian  5.97       5.5, 6.4      95  1.64       NA, NA    NA
      20              mle    NA         NA, NA      NA    NA       NA, NA    NA
      21              mle    NA         NA, NA      NA    NA       NA, NA    NA
      22              mle 12.70         NA, NA      NA  4.31       NA, NA    NA
      23              mle 12.60      9.1, 17.1      95 13.10    9.6, 19.6    95
      24              mle 10.00      9.6, 10.5      95  7.60     7.1, 8.1    95
      25              mle 10.40      9.8, 11.0      95  8.60     8.0, 9.3    95
      26              mle 10.30      9.9, 10.7      95  8.20     7.8, 8.6    95
      27         bayesian    NA         NA, NA      NA    NA       NA, NA    NA
      28              mle  2.05         NA, NA      NA  0.49       NA, NA    NA
      29              mle    NA         NA, NA      NA    NA       NA, NA    NA
      30              mle    NA         NA, NA      NA    NA       NA, NA    NA
      31              mle    NA         NA, NA      NA    NA       NA, NA    NA
      32              mle    NA         NA, NA      NA    NA       NA, NA    NA
      33              mle    NA         NA, NA      NA    NA       NA, NA    NA
      34              mle    NA         NA, NA      NA    NA       NA, NA    NA
      35              mle    NA         NA, NA      NA    NA       NA, NA    NA
      36              mle    NA         NA, NA      NA    NA       NA, NA    NA
      37             <NA>  4.30       2.6, 6.6      95    NA       NA, NA    NA
      38              mle  3.40       3.0, 3.7      95  1.70       NA, NA    NA
      39              mle  4.50      2.8, 16.2      95  3.30       NA, NA    NA
      40         bayesian  3.50       3.2, 3.8      95    NA       NA, NA    NA
      41         bayesian  3.70       3.4, 4.1      95    NA       NA, NA    NA
      42         bayesian  3.30       2.9, 3.6      95    NA       NA, NA    NA
      43              mle    NA         NA, NA      NA    NA       NA, NA    NA
      44             <NA>    NA         NA, NA      NA    NA       NA, NA    NA
      45             <NA>    NA         NA, NA      NA    NA       NA, NA    NA
      46              mle    NA         NA, NA      NA    NA       NA, NA    NA
      47              mle    NA         NA, NA      NA    NA       NA, NA    NA
      48         bayesian  6.70       6.1, 7.3      95    NA       NA, NA    NA
      49         bayesian  7.60       6.2, 9.7      95  1.80     1.6, 2.2    95
      50         bayesian  9.10      6.5, 10.9      95    NA       NA, NA    NA
      51         bayesian  7.50       6.0, 9.8      95  4.90     3.2, 8.8    95
      52         bayesian  5.60       4.3, 7.8      95  4.40     2.8, 8.7    95
      53         bayesian  9.00      6.6, 10.9      95    NA       NA, NA    NA
      54             <NA>    NA         NA, NA      NA    NA       NA, NA    NA
      55             <NA>    NA         NA, NA      NA    NA       NA, NA    NA
      56             <NA>    NA         NA, NA      NA    NA       NA, NA    NA
      57             <NA>  8.13      4.9, 19.5      95    NA       NA, NA    NA
      58             <NA>  8.08      4.8, 21.0      95    NA       NA, NA    NA
      59             <NA>  8.23      4.9, 21.4      95    NA       NA, NA    NA
      60              mle    NA         NA, NA      NA    NA       NA, NA    NA
      61              mle    NA         NA, NA      NA    NA       NA, NA    NA
      62              mle    NA         NA, NA      NA    NA       NA, NA    NA
      63              mle    NA         NA, NA      NA    NA       NA, NA    NA
      64              mle    NA         NA, NA      NA    NA       NA, NA    NA
      65              mle    NA         NA, NA      NA    NA       NA, NA    NA
      66              mle    NA         NA, NA      NA    NA       NA, NA    NA
      67              mle    NA         NA, NA      NA    NA       NA, NA    NA
      68              mle    NA         NA, NA      NA    NA       NA, NA    NA
      69              mle    NA         NA, NA      NA    NA       NA, NA    NA
      70              mle    NA         NA, NA      NA    NA       NA, NA    NA
      71              mle    NA         NA, NA      NA    NA       NA, NA    NA
      72         bayesian    NA         NA, NA      NA    NA       NA, NA    NA
         quantile_2.5 quantile_5 quantile_25 median median_ci_limits median_ci
      1            NA         NA        4.80   5.60         4.8, 6.3        95
      2            NA         NA        2.90   3.00         0.5, 3.1        95
      3            NA         NA          NA     NA           NA, NA        NA
      4          1.35       1.90          NA   6.10           NA, NA        NA
      5            NA         NA          NA     NA           NA, NA        NA
      6          2.20         NA          NA   5.10         4.5, 5.8        95
      7          2.60         NA          NA   5.70         4.9, 6.8        95
      8          2.10         NA          NA   5.50         4.4, 7.0        95
      9          2.50         NA          NA   4.80         4.2, 5.6        95
      10           NA       1.70          NA   4.30         3.5, 5.1        95
      11           NA       2.30          NA   5.00         4.4, 5.6        95
      12           NA       1.70          NA   4.60         3.7, 5.7        95
      13           NA         NA          NA     NA           NA, NA        NA
      14           NA         NA          NA   5.10         4.5, 5.8        95
      15         2.69         NA          NA   5.01             4, 6        95
      16           NA         NA          NA     NA           NA, NA        NA
      17         5.00         NA          NA     NA           NA, NA        NA
      18         2.40         NA          NA     NA           NA, NA        NA
      19         3.40         NA          NA     NA           NA, NA        NA
      20           NA         NA        4.50   5.60         5.3, 6.0        95
      21           NA         NA        4.30   5.30         5.0, 5.7        95
      22           NA         NA          NA     NA           NA, NA        NA
      23           NA         NA          NA     NA           NA, NA        NA
      24           NA         NA          NA     NA           NA, NA        NA
      25           NA         NA          NA     NA           NA, NA        NA
      26           NA         NA          NA     NA           NA, NA        NA
      27           NA         NA        2.90   3.20         2.8, 3.7        95
      28           NA         NA          NA     NA           NA, NA        NA
      29           NA       0.70        1.10   1.40         1.3, 1.5        95
      30           NA       1.40        1.70   1.90         1.8, 2.0        95
      31           NA       0.30        0.40   0.60         0.5, 0.6        95
      32           NA       0.90          NA   1.40         1.0, 1.8        95
      33           NA         NA          NA   1.51       1.47, 1.55        95
      34           NA         NA          NA   1.43       1.21, 1.65        95
      35           NA       0.73          NA   1.46       1.35, 1.57        95
      36           NA       0.73          NA   1.43       1.33, 1.54        95
      37           NA         NA          NA   4.00           NA, NA        NA
      38           NA         NA          NA     NA           NA, NA        NA
      39           NA         NA          NA     NA           NA, NA        NA
      40           NA         NA          NA     NA           NA, NA        NA
      41           NA         NA          NA     NA           NA, NA        NA
      42           NA         NA          NA     NA           NA, NA        NA
      43           NA         NA        8.10   8.40         5.1, 9.4        95
      44           NA         NA          NA     NA           NA, NA        NA
      45           NA         NA          NA   7.00           NA, NA        NA
      46           NA       8.90       10.90  12.50       11.8, 13.3        95
      47           NA       2.20          NA   5.20        1.9, 14.7        NA
      48           NA         NA          NA   6.30         5.7, 6.8        95
      49           NA         NA          NA   6.40         5.1, 7.9        95
      50           NA       2.00          NA     NA           NA, NA        NA
      51           NA         NA          NA     NA           NA, NA        NA
      52           NA         NA          NA     NA           NA, NA        NA
      53         3.60       4.20          NA   8.50        6.6, 10.9        95
      54           NA         NA        8.00   9.50           NA, NA        NA
      55           NA         NA       11.39  16.76           NA, NA        NA
      56           NA         NA          NA   8.26       7.55, 8.97        95
      57           NA         NA          NA     NA           NA, NA        NA
      58           NA         NA          NA     NA           NA, NA        NA
      59           NA         NA          NA     NA           NA, NA        NA
      60           NA         NA        2.10   2.60         2.1, 3.1        95
      61           NA       0.80        1.30   1.90         1.4, 2.4        95
      62           NA         NA        3.10   4.00         3.4, 4.9        95
      63           NA       3.10        3.80   4.40         3.9, 4.9        95
      64           NA       3.05          NA   4.41       3.90, 4.92        95
      65           NA       3.11          NA   4.41       3.89, 4.94        95
      66           NA       1.50        2.70   4.00         3.6, 4.4        95
      67           NA       1.00        1.70   2.60         1.6, 3.5        95
      68           NA         NA        2.80   2.90         0.5, 3.1        95
      69           NA         NA        8.70  10.80        8.4, 14.2        95
      70           NA       1.90        3.20   4.40             4, 5        95
      71           NA       1.90        3.10   4.40         3.9, 5.0        95
      72           NA       3.20        4.60   5.90         4.4, 7.6        95
         quantile_75 quantile_87.5 quantile_95 quantile_97.5 lower_range upper_range
      1         6.50            NA          NA            NA          NA          NA
      2         3.00            NA          NA            NA          NA          NA
      3           NA            NA          NA            NA          NA          NA
      4           NA            NA       11.90         13.04          NA          NA
      5           NA            NA          NA            NA          NA          NA
      6           NA            NA          NA         11.50          NA          NA
      7           NA            NA          NA         12.50          NA          NA
      8           NA            NA          NA         14.70          NA          NA
      9           NA            NA          NA          9.20          NA          NA
      10          NA            NA       10.60            NA          NA          NA
      11          NA            NA       10.80            NA          NA          NA
      12          NA            NA       12.30            NA          NA          NA
      13          NA            NA          NA            NA          NA          NA
      14          NA            NA       11.70            NA          NA          NA
      15          NA            NA          NA         12.89          NA          NA
      16          NA            NA          NA            NA          NA          NA
      17          NA            NA          NA         33.00          NA          NA
      18          NA            NA          NA         15.00          NA          NA
      19          NA            NA          NA         10.00          NA          NA
      20        7.10            NA          NA            NA          NA          NA
      21        6.60            NA          NA            NA          NA          NA
      22          NA            NA          NA            NA          NA          NA
      23          NA            NA          NA            NA          NA          NA
      24          NA            NA          NA            NA          NA          NA
      25          NA            NA          NA            NA          NA          NA
      26          NA            NA          NA            NA          NA          NA
      27        3.50            NA          NA            NA          NA          NA
      28          NA            NA          NA            NA          NA          NA
      29        1.90            NA        2.80            NA          NA          NA
      30        2.20            NA        2.70            NA          NA          NA
      31        0.70            NA        1.10            NA          NA          NA
      32          NA            NA        2.20            NA          NA          NA
      33          NA            NA        3.43            NA          NA          NA
      34          NA            NA        3.18            NA          NA          NA
      35          NA            NA        2.94            NA          NA          NA
      36          NA            NA        2.83            NA          NA          NA
      37          NA            NA          NA            NA          NA          NA
      38          NA            NA        6.50            NA          NA          NA
      39          NA            NA       11.00            NA          NA          NA
      40          NA            NA          NA            NA          NA          NA
      41          NA            NA          NA            NA          NA          NA
      42          NA            NA          NA            NA          NA          NA
      43        8.60            NA          NA            NA          NA          NA
      44          NA            NA          NA            NA           2          26
      45          NA            NA          NA            NA           2          13
      46       14.40            NA       17.70            NA          NA          NA
      47          NA            NA       12.40            NA          NA          NA
      48          NA            NA       12.10            NA          NA          NA
      49          NA            NA       17.10            NA          NA          NA
      50          NA            NA       20.00            NA          NA          NA
      51          NA            NA          NA            NA          NA          NA
      52          NA            NA          NA            NA          NA          NA
      53          NA            NA       17.30         19.90          NA          NA
      54       12.25            NA          NA            NA          NA          NA
      55       23.91            NA          NA            NA          NA          NA
      56          NA            NA          NA            NA          NA          NA
      57          NA            NA          NA            NA          NA          NA
      58          NA            NA          NA            NA          NA          NA
      59          NA            NA       20.00            NA          NA          NA
      60        3.20            NA          NA            NA          NA          NA
      61        2.70            NA        4.50            NA          NA          NA
      62        5.30            NA          NA            NA          NA          NA
      63        5.10            NA        6.30            NA          NA          NA
      64          NA            NA        6.39            NA          NA          NA
      65          NA            NA        6.26            NA          NA          NA
      66        5.90            NA       10.60            NA          NA          NA
      67        3.80            NA        7.00            NA          NA          NA
      68        3.00            NA          NA            NA          NA          NA
      69       13.30            NA          NA            NA          NA          NA
      70        6.30            NA       10.30            NA          NA          NA
      71        6.20            NA       10.30            NA          NA          NA
      72        7.60            NA       11.20            NA          NA          NA
         shape shape_ci_limits shape_ci scale scale_ci_limits scale_ci meanlog
      1     NA          NA, NA       NA    NA          NA, NA       NA      NA
      2     NA          NA, NA       NA    NA          NA, NA       NA      NA
      3     NA          NA, NA       NA    NA          NA, NA       NA      NA
      4     NA          NA, NA       NA    NA          NA, NA       NA      NA
      5     NA          NA, NA       NA    NA          NA, NA       NA      NA
      6     NA          NA, NA       NA    NA          NA, NA       NA      NA
      7     NA          NA, NA       NA    NA          NA, NA       NA      NA
      8     NA          NA, NA       NA    NA          NA, NA       NA      NA
      9     NA          NA, NA       NA    NA          NA, NA       NA      NA
      10    NA          NA, NA       NA    NA          NA, NA       NA      NA
      11    NA          NA, NA       NA    NA          NA, NA       NA      NA
      12    NA          NA, NA       NA    NA          NA, NA       NA      NA
      13    NA          NA, NA       NA    NA          NA, NA       NA    1.66
      14    NA          NA, NA       NA    NA          NA, NA       NA    1.63
      15    NA          NA, NA       NA    NA          NA, NA       NA      NA
      16    NA          NA, NA       NA    NA          NA, NA       NA      NA
      17    NA          NA, NA       NA    NA          NA, NA       NA      NA
      18    NA          NA, NA       NA    NA          NA, NA       NA      NA
      19    NA          NA, NA       NA    NA          NA, NA       NA    1.75
      20    NA          NA, NA       NA    NA          NA, NA       NA      NA
      21    NA          NA, NA       NA    NA          NA, NA       NA      NA
      22    NA          NA, NA       NA    NA          NA, NA       NA      NA
      23    NA          NA, NA       NA    NA          NA, NA       NA      NA
      24    NA          NA, NA       NA    NA          NA, NA       NA      NA
      25    NA          NA, NA       NA    NA          NA, NA       NA      NA
      26    NA          NA, NA       NA    NA          NA, NA       NA      NA
      27    NA          NA, NA       NA    NA          NA, NA       NA      NA
      28    NA          NA, NA       NA    NA          NA, NA       NA      NA
      29    NA          NA, NA       NA    NA          NA, NA       NA      NA
      30    NA          NA, NA       NA    NA          NA, NA       NA      NA
      31    NA          NA, NA       NA    NA          NA, NA       NA      NA
      32    NA          NA, NA       NA    NA          NA, NA       NA      NA
      33  3.27          NA, NA       NA  0.51          NA, NA       NA      NA
      34  1.74          NA, NA       NA  1.83          NA, NA       NA      NA
      35    NA          NA, NA       NA    NA          NA, NA       NA      NA
      36    NA          NA, NA       NA    NA          NA, NA       NA      NA
      37    NA          NA, NA       NA    NA          NA, NA       NA      NA
      38    NA          NA, NA       NA    NA          NA, NA       NA      NA
      39    NA          NA, NA       NA    NA          NA, NA       NA      NA
      40    NA          NA, NA       NA    NA          NA, NA       NA      NA
      41  2.30      1.80, 2.89       95  4.21      3.62, 4.85       95      NA
      42  2.03      1.62, 2.52       95  3.74      3.20, 4.36       95      NA
      43    NA          NA, NA       NA    NA          NA, NA       NA      NA
      44    NA          NA, NA       NA    NA          NA, NA       NA      NA
      45    NA          NA, NA       NA    NA          NA, NA       NA      NA
      46    NA          NA, NA       NA    NA          NA, NA       NA      NA
      47    NA          NA, NA       NA    NA          NA, NA       NA      NA
      48    NA          NA, NA       NA    NA          NA, NA       NA      NA
      49    NA          NA, NA       NA    NA          NA, NA       NA      NA
      50    NA          NA, NA       NA    NA          NA, NA       NA      NA
      51    NA          NA, NA       NA    NA          NA, NA       NA    1.80
      52    NA          NA, NA       NA    NA          NA, NA       NA    1.50
      53    NA          NA, NA       NA    NA          NA, NA       NA      NA
      54    NA          NA, NA       NA    NA          NA, NA       NA      NA
      55    NA          NA, NA       NA    NA          NA, NA       NA      NA
      56    NA          NA, NA       NA    NA          NA, NA       NA      NA
      57    NA          NA, NA       NA    NA          NA, NA       NA      NA
      58    NA          NA, NA       NA    NA          NA, NA       NA      NA
      59    NA          NA, NA       NA    NA          NA, NA       NA      NA
      60    NA          NA, NA       NA    NA          NA, NA       NA      NA
      61    NA          NA, NA       NA    NA          NA, NA       NA      NA
      62    NA          NA, NA       NA    NA          NA, NA       NA      NA
      63    NA          NA, NA       NA    NA          NA, NA       NA      NA
      64    NA          NA, NA       NA    NA          NA, NA       NA      NA
      65    NA          NA, NA       NA    NA          NA, NA       NA      NA
      66    NA          NA, NA       NA    NA          NA, NA       NA      NA
      67    NA          NA, NA       NA    NA          NA, NA       NA      NA
      68    NA          NA, NA       NA    NA          NA, NA       NA      NA
      69    NA          NA, NA       NA    NA          NA, NA       NA      NA
      70    NA          NA, NA       NA    NA          NA, NA       NA      NA
      71    NA          NA, NA       NA    NA          NA, NA       NA      NA
      72    NA          NA, NA       NA    NA          NA, NA       NA      NA
         meanlog_ci_limits meanlog_ci sdlog sdlog_ci_limits sdlog_ci dispersion
      1             NA, NA         NA    NA          NA, NA       NA       1.26
      2             NA, NA         NA    NA          NA, NA       NA       1.04
      3             NA, NA         NA    NA          NA, NA       NA         NA
      4             NA, NA         NA    NA          NA, NA       NA         NA
      5             NA, NA         NA    NA          NA, NA       NA         NA
      6             NA, NA         NA    NA          NA, NA       NA       1.52
      7             NA, NA         NA    NA          NA, NA       NA         NA
      8             NA, NA         NA    NA          NA, NA       NA         NA
      9             NA, NA         NA    NA          NA, NA       NA         NA
      10            NA, NA         NA    NA          NA, NA       NA         NA
      11            NA, NA         NA    NA          NA, NA       NA         NA
      12            NA, NA         NA    NA          NA, NA       NA         NA
      13        1.55, 1.76         95  0.48      0.42, 0.54       95         NA
      14        1.51, 1.75         95  0.50      0.46, 0.55       95         NA
      15            NA, NA         NA    NA          NA, NA       NA         NA
      16            NA, NA         NA    NA          NA, NA       NA         NA
      17            NA, NA         NA    NA          NA, NA       NA         NA
      18            NA, NA         NA    NA          NA, NA       NA         NA
      19            NA, NA         NA  0.27          NA, NA       NA         NA
      20            NA, NA         NA    NA          NA, NA       NA       1.41
      21            NA, NA         NA    NA          NA, NA       NA       1.37
      22            NA, NA         NA    NA          NA, NA       NA         NA
      23            NA, NA         NA    NA          NA, NA       NA         NA
      24            NA, NA         NA    NA          NA, NA       NA         NA
      25            NA, NA         NA    NA          NA, NA       NA         NA
      26            NA, NA         NA    NA          NA, NA       NA         NA
      27            NA, NA         NA    NA          NA, NA       NA       1.15
      28            NA, NA         NA    NA          NA, NA       NA         NA
      29            NA, NA         NA    NA          NA, NA       NA       1.51
      30            NA, NA         NA    NA          NA, NA       NA       1.23
      31            NA, NA         NA    NA          NA, NA       NA       1.51
      32            NA, NA         NA    NA          NA, NA       NA         NA
      33            NA, NA         NA    NA          NA, NA       NA         NA
      34            NA, NA         NA    NA          NA, NA       NA         NA
      35            NA, NA         NA    NA          NA, NA       NA       1.53
      36            NA, NA         NA    NA          NA, NA       NA       1.51
      37            NA, NA         NA    NA          NA, NA       NA         NA
      38            NA, NA         NA    NA          NA, NA       NA         NA
      39            NA, NA         NA    NA          NA, NA       NA         NA
      40            NA, NA         NA    NA          NA, NA       NA         NA
      41            NA, NA         NA    NA          NA, NA       NA         NA
      42            NA, NA         NA    NA          NA, NA       NA         NA
      43            NA, NA         NA    NA          NA, NA       NA       1.04
      44            NA, NA         NA    NA          NA, NA       NA         NA
      45            NA, NA         NA    NA          NA, NA       NA         NA
      46            NA, NA         NA    NA          NA, NA       NA       1.23
      47            NA, NA         NA    NA          NA, NA       NA         NA
      48            NA, NA         NA    NA          NA, NA       NA         NA
      49            NA, NA         NA    NA          NA, NA       NA         NA
      50            NA, NA         NA    NA          NA, NA       NA         NA
      51          1.6, 2.1         95  0.60        0.4, 0.8       95         NA
      52          1.2, 1.8         95  0.70        0.5, 1.0       95         NA
      53            NA, NA         NA    NA          NA, NA       NA         NA
      54            NA, NA         NA    NA          NA, NA       NA         NA
      55            NA, NA         NA    NA          NA, NA       NA         NA
      56            NA, NA         NA    NA          NA, NA       NA         NA
      57            NA, NA         NA    NA          NA, NA       NA         NA
      58            NA, NA         NA    NA          NA, NA       NA         NA
      59            NA, NA         NA    NA          NA, NA       NA         NA
      60            NA, NA         NA    NA          NA, NA       NA       1.35
      61            NA, NA         NA    NA          NA, NA       NA       1.68
      62            NA, NA         NA    NA          NA, NA       NA       1.50
      63            NA, NA         NA    NA          NA, NA       NA       1.24
      64            NA, NA         NA    NA          NA, NA       NA       1.25
      65            NA, NA         NA    NA          NA, NA       NA       1.24
      66            NA, NA         NA    NA          NA, NA       NA       1.81
      67            NA, NA         NA    NA          NA, NA       NA       1.82
      68            NA, NA         NA    NA          NA, NA       NA       1.04
      69            NA, NA         NA    NA          NA, NA       NA       1.35
      70            NA, NA         NA    NA          NA, NA       NA       1.66
      71            NA, NA         NA    NA          NA, NA       NA       1.67
      72            NA, NA         NA    NA          NA, NA       NA       1.50
         dispersion_ci_limits dispersion_ci precision precision_ci_limits
      1            1.13, 1.38            95        NA              NA, NA
      2            1.04, 1.08            95        NA              NA, NA
      3                NA, NA            NA        NA              NA, NA
      4                NA, NA            NA        NA              NA, NA
      5                NA, NA            NA        NA              NA, NA
      6            1.32, 1.72            95        NA              NA, NA
      7                NA, NA            NA        NA              NA, NA
      8                NA, NA            NA        NA              NA, NA
      9                NA, NA            NA        NA              NA, NA
      10               NA, NA            NA        NA              NA, NA
      11               NA, NA            NA        NA              NA, NA
      12               NA, NA            NA        NA              NA, NA
      13               NA, NA            NA        NA              NA, NA
      14               NA, NA            NA        NA              NA, NA
      15               NA, NA            NA        NA              NA, NA
      16               NA, NA            NA        NA              NA, NA
      17               NA, NA            NA        NA              NA, NA
      18               NA, NA            NA       4.9            2.8, 7.5
      19               NA, NA            NA      13.7          10.9, 16.9
      20           1.34, 1.50            95        NA              NA, NA
      21           1.27, 1.52            95        NA              NA, NA
      22               NA, NA            NA        NA              NA, NA
      23               NA, NA            NA        NA              NA, NA
      24               NA, NA            NA        NA              NA, NA
      25               NA, NA            NA        NA              NA, NA
      26               NA, NA            NA        NA              NA, NA
      27           1.07, 1.34            95        NA              NA, NA
      28               NA, NA            NA        NA              NA, NA
      29           1.43, 1.60            95        NA              NA, NA
      30           1.17, 1.29            95        NA              NA, NA
      31           1.37, 1.64            95        NA              NA, NA
      32               NA, NA            NA        NA              NA, NA
      33               NA, NA            NA        NA              NA, NA
      34               NA, NA            NA        NA              NA, NA
      35           1.44, 1.61            95        NA              NA, NA
      36           1.43, 1.60            95        NA              NA, NA
      37               NA, NA            NA        NA              NA, NA
      38               NA, NA            NA        NA              NA, NA
      39               NA, NA            NA        NA              NA, NA
      40               NA, NA            NA        NA              NA, NA
      41               NA, NA            NA        NA              NA, NA
      42               NA, NA            NA        NA              NA, NA
      43           1.04, 1.05            95        NA              NA, NA
      44               NA, NA            NA        NA              NA, NA
      45               NA, NA            NA        NA              NA, NA
      46           1.18, 1.28            95        NA              NA, NA
      47               NA, NA            NA        NA              NA, NA
      48               NA, NA            NA        NA              NA, NA
      49               NA, NA            NA        NA              NA, NA
      50               NA, NA            NA        NA              NA, NA
      51               NA, NA            NA        NA              NA, NA
      52               NA, NA            NA        NA              NA, NA
      53               NA, NA            NA        NA              NA, NA
      54               NA, NA            NA        NA              NA, NA
      55               NA, NA            NA        NA              NA, NA
      56               NA, NA            NA        NA              NA, NA
      57               NA, NA            NA        NA              NA, NA
      58               NA, NA            NA        NA              NA, NA
      59               NA, NA            NA        NA              NA, NA
      60           1.16, 1.55            95        NA              NA, NA
      61           1.36, 2.01            95        NA              NA, NA
      62           1.22, 1.82            95        NA              NA, NA
      63           1.13, 1.35            95        NA              NA, NA
      64           1.14, 1.36            95        NA              NA, NA
      65           1.12, 1.35            95        NA              NA, NA
      66           1.67, 1.95            95        NA              NA, NA
      67           1.27, 2.67            95        NA              NA, NA
      68           1.04, 1.29            95        NA              NA, NA
      69           1.12, 1.47            95        NA              NA, NA
      70           1.48, 1.82            95        NA              NA, NA
      71           1.47, 1.84            95        NA              NA, NA
      72             1.2, 1.9            95        NA              NA, NA
         precision_ci truncation discretised censored right_truncated
      1            NA         NA       FALSE     TRUE           FALSE
      2            NA         NA       FALSE     TRUE           FALSE
      3            NA         NA       FALSE    FALSE           FALSE
      4            NA         NA       FALSE     TRUE           FALSE
      5            NA         NA       FALSE    FALSE           FALSE
      6            NA         NA       FALSE     TRUE           FALSE
      7            NA         NA       FALSE     TRUE           FALSE
      8            NA         NA       FALSE     TRUE           FALSE
      9            NA         NA       FALSE     TRUE           FALSE
      10           NA         NA       FALSE     TRUE           FALSE
      11           NA         NA       FALSE     TRUE           FALSE
      12           NA         NA       FALSE     TRUE            TRUE
      13           NA         NA       FALSE    FALSE           FALSE
      14           NA         NA       FALSE    FALSE           FALSE
      15           NA         NA       FALSE    FALSE           FALSE
      16           NA         NA       FALSE    FALSE           FALSE
      17           NA         NA       FALSE     TRUE           FALSE
      18           95         NA       FALSE     TRUE           FALSE
      19           95         NA       FALSE     TRUE           FALSE
      20           NA         NA       FALSE     TRUE           FALSE
      21           NA         NA       FALSE     TRUE           FALSE
      22           NA         NA       FALSE    FALSE           FALSE
      23           NA         NA       FALSE     TRUE           FALSE
      24           NA         NA       FALSE     TRUE           FALSE
      25           NA         NA       FALSE     TRUE           FALSE
      26           NA         NA       FALSE     TRUE           FALSE
      27           NA         NA       FALSE     TRUE           FALSE
      28           NA         NA       FALSE     TRUE           FALSE
      29           NA         NA       FALSE     TRUE           FALSE
      30           NA         NA       FALSE     TRUE           FALSE
      31           NA         NA       FALSE     TRUE           FALSE
      32           NA         NA       FALSE     TRUE           FALSE
      33           NA         NA       FALSE     TRUE           FALSE
      34           NA         NA       FALSE     TRUE           FALSE
      35           NA         NA       FALSE     TRUE           FALSE
      36           NA         NA       FALSE     TRUE           FALSE
      37           NA         NA       FALSE    FALSE           FALSE
      38           NA         NA       FALSE     TRUE           FALSE
      39           NA         NA       FALSE     TRUE           FALSE
      40           NA         NA       FALSE     TRUE           FALSE
      41           NA         NA       FALSE     TRUE           FALSE
      42           NA         NA       FALSE     TRUE           FALSE
      43           NA         NA       FALSE     TRUE           FALSE
      44           NA         NA       FALSE    FALSE           FALSE
      45           NA         NA       FALSE    FALSE           FALSE
      46           NA         NA       FALSE     TRUE           FALSE
      47           NA         NA       FALSE     TRUE           FALSE
      48           NA         NA       FALSE     TRUE           FALSE
      49           NA         NA       FALSE     TRUE           FALSE
      50           NA         NA       FALSE    FALSE           FALSE
      51           NA         NA       FALSE    FALSE           FALSE
      52           NA         NA       FALSE    FALSE           FALSE
      53           NA         NA       FALSE    FALSE           FALSE
      54           NA         NA       FALSE    FALSE           FALSE
      55           NA         NA       FALSE    FALSE           FALSE
      56           NA         NA       FALSE    FALSE           FALSE
      57           NA         NA       FALSE    FALSE           FALSE
      58           NA         NA       FALSE    FALSE           FALSE
      59           NA         NA       FALSE    FALSE           FALSE
      60           NA         NA       FALSE     TRUE           FALSE
      61           NA         NA       FALSE     TRUE           FALSE
      62           NA         NA       FALSE     TRUE           FALSE
      63           NA         NA       FALSE     TRUE           FALSE
      64           NA         NA       FALSE     TRUE           FALSE
      65           NA         NA       FALSE     TRUE           FALSE
      66           NA         NA       FALSE     TRUE           FALSE
      67           NA         NA       FALSE     TRUE           FALSE
      68           NA         NA       FALSE     TRUE           FALSE
      69           NA         NA       FALSE     TRUE           FALSE
      70           NA         NA       FALSE     TRUE           FALSE
      71           NA         NA       FALSE     TRUE           FALSE
      72           NA         NA       FALSE     TRUE           FALSE
         phase_bias_adjusted
      1                FALSE
      2                FALSE
      3                FALSE
      4                FALSE
      5                FALSE
      6                 TRUE
      7                 TRUE
      8                 TRUE
      9                 TRUE
      10               FALSE
      11               FALSE
      12                TRUE
      13               FALSE
      14               FALSE
      15               FALSE
      16               FALSE
      17               FALSE
      18               FALSE
      19               FALSE
      20               FALSE
      21               FALSE
      22               FALSE
      23               FALSE
      24               FALSE
      25               FALSE
      26               FALSE
      27               FALSE
      28               FALSE
      29               FALSE
      30               FALSE
      31               FALSE
      32               FALSE
      33                TRUE
      34                TRUE
      35               FALSE
      36               FALSE
      37               FALSE
      38               FALSE
      39               FALSE
      40               FALSE
      41               FALSE
      42               FALSE
      43               FALSE
      44               FALSE
      45               FALSE
      46               FALSE
      47               FALSE
      48               FALSE
      49               FALSE
      50               FALSE
      51               FALSE
      52               FALSE
      53               FALSE
      54               FALSE
      55               FALSE
      56               FALSE
      57               FALSE
      58               FALSE
      59               FALSE
      60               FALSE
      61               FALSE
      62               FALSE
      63               FALSE
      64               FALSE
      65               FALSE
      66               FALSE
      67               FALSE
      68               FALSE
      69               FALSE
      70               FALSE
      71               FALSE
      72               FALSE
                                                                                                                                                                                                                                                                                                                                                                                                                                           notes
      1                                                                                                        Analysis on data from Commission on Acute Respiratory Disease. Experimental transmission of minor respiratory illness to human volunteers by filter-passing agents. I. Demonstration of two types of illness characterized by long and short incubation periods and diff erent clinical features. J Clin Invest 1947; 26: 957–82.
      2                                                                                                                                                                                                                                                                                                                                                  Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      3                                                                                                                                                                                                       This estimated mean incubation period is from a meta-analysis of 14 other incubation period estimates. Only the mean is reported and a distribution cannot be specified as the meta-mean is estimated from a random-effects model.
      4                                                                                                                                                                                                                                                                                                                                                                                                                      No additional notes
      5                                                                                                                                                                                                       This estimated mean incubation period is from a meta-analysis of 99 other incubation period estimates. Only the mean is reported and a distribution cannot be specified as the meta-mean is estimated from a random-effects model.
      6                                                                                                                                                                                                                                                                                                                                                                                                           This is the complete data set.
      7                                                                                                                                                                                                                                                                                 This is a subset of the data, including only those cases with a known onset of fever to be sure that the onset of symptoms is not from another pathogen.
      8                                                                                                                                                                                                                                                                                                                                          This is a subset of the data, including only cases that are detected outside of mainland China.
      9                                                                                                                                                                                                                                                                                                                                              This is a subset of the data, including only cases that are detected inside mainland China.
      10                                                                                                                                                                                                                                         This dataset excludes Wuhan residents (to have a more precise exposure interval). This method does not apply right-truncation, but does compare the gamma, weibull and lognormal distributions.
      11                                                                                                                                                                                                                                      This dataset includes Wuhan residents (which have a less precise exposure interval). This method does not apply right-truncation, but does compare the gamma, weibull and lognormal distributions.
      12                                                                                                                                                                                                                                                      This is excluding Wuhan residents from the dataset as this provides a more precise exposure interval. This method applies right-truncation but only fits a lognormal distribution.
      13                                                                                                                                                                                                                                           The incubation period parameters are estimated from a meta-analysis of other studies that estimated the incubation period using a lognormal distribution. This is the full set of data (N=9).
      14                                                                                                                                                                                The incubation period parameters are estimated from a meta-analysis of other studies that estimated the incubation period using a lognormal distribution. This is the data set with Backer removed as they did not have a defined exposure window (N=8).
      15                                                                                                                                                                                                                                                                                                          The estimate of the incubation period is from a non-parametric bootstrap approach that does not fit a parametric distribution.
      16                                                                                                                                                                                                      This estimated mean incubation period is from a meta-analysis of 15 other incubation period estimates. Only the mean is reported and a distribution cannot be specified as the meta-mean is estimated from a random-effects model.
      17                                                                                                                                                                                                                                                                                                                                                                              Extrinsic incubation period for data at 25 degrees celcius
      18                                                                                                                                                                                                                                                                                                                                                                              Extrinsic incubation period for data at 30 degrees celcius
      19                                                                                                                                                                                                                                                                                                                                    Standard deviation, meanlog and sdlog is taken from Siraj et al. 2017 <10.1371/journal.pntd.0005797>
      20                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      21                                                                                                                                                                                                                                                                       Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      22                                                                                                                                                                                                                                                 The paper reports lower and upper supported ranges for the mean and standard deviation but it is not clear if these are confidence intervals or not so are not included in the database
      23                                                                                                                                                                                                                     This data comes from the entire period of the Guinea ebola outbreak up to the point the paper was published (Dec 2013 - 25 Nov 2014). The methods fitting are reported in another paper: DOI: 10.1056/NEJMoa1411100
      24                                                                                                                                                                                                                    This data comes from the entire period of the Liberia ebola outbreak up to the point the paper was published (Dec 2013 - 25 Nov 2014). The methods fitting are reported in another paper: DOI: 10.1056/NEJMoa1411100
      25                                                                                                                                                                                                               This data comes from the entire period of the Seirra Leone ebola outbreak up to the point the paper was published (Dec 2013 - 25 Nov 2014). The methods fitting are reported in another paper: DOI: 10.1056/NEJMoa1411100
      26                                                                                                                                                                                  Data extracted from Appendix. This data comes from the entire period of the west africa ebola outbreak up to the point the paper was published (Dec 2013 - 25 Nov 2014). The methods fitting are reported in another paper: DOI: 10.1056/NEJMoa1411100
      27                                                                                                                                                                                                                                                                                         Analysis on data from  Bradburne AF, Bynoe ML, Tyrrell DA. Eff ects of a “new” human respiratory virus in volunteers. Br Med J 1967; 3: 767–69.
      28                                                                                                                                                                                                                                                                                                                                                                                                                     No additional notes
      29                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      30                                                                                                                                                                   These estimates for the incubation period of influenza A from Lessler et al. 2009 are different from the estimates from the complete data, as they remove Henle et al. 1945 J Immunol, as it is an outlier in the dataset (n=61). Values found at the bottom Table 3.
      31                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      32                                                                                                                                                                                                                                                                                                                                                                                                                    No additional notes.
      33                                                                                                                                                                                                                                                                                            Gamma and weibull distributions had equally good fit to the data. This entry is the gamma distribution. Gamma, exponential. Not open source.
      34                                                                                                                                                                                                                                                                                                          Gamma and weibull distributions had equally good fit to the data. This entry is the weibull distribution. Weibull, exponential
      35                                                                                                                                                                                                                                                                                                                                                   Data from Lessler et al 2009 using double interval-censored analysis. Not open source
      36                                                                                                                                                                                                                                                                                                                                                   Data from Lessler et al 2009 using single interval-censored analysis. Not open source
      37                                                                                                            The mid-point of the exposure time was used to approximate an exact exposure time instead of interval-censoring. This can lead to a possible bias (overestimation) in incubation times. It was ambiguously reported whether the mean is the mean of the distribution or the meanlog parameter of the lognormal distribution.
      38                                                                                                                                                                                                                                                                      This study used an original data set and a modified data set. This weibull distribution was fitted to the modified data set and it is recommended to use this one.
      39                                                                                                                                                                                                               This study used an original data set and a modified data set. This gamma distribution was fitted to the original data set and it is recommended to use the weibull distribution that was fitted to the modified data set.
      40                                                                                                                                                                                                        This study fit the weibull distribution to estimate the parameters for the complete data set, those who had a fatal outcome and those with a non-fatal outcome. This is the distribution fit to the complete unpartitioned data.
      41                                                                                                                                                                                                                 This study fit the weibull distribution to estimate the parameters for the complete data set, those who had a fatal outcome and those with a non-fatal outcome. This is the distribution fit to the fatal outcome data.
      42                                                                                                                                                                                                             This study fit the weibull distribution to estimate the parameters for the complete data set, those who had a fatal outcome and those with a non-fatal outcome. This is the distribution fit to the non-fatal outcome data.
      43                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      44 This paper did not fit a distribution to the incubation period data and only reported a lower and upper range of the data. This is present in the database as there are no other studies that report the incubation period for Marburg virus. There is another incubation period reported from the same paper for a subset of the data which report the median and interquartile range but again do not fit a distribution to the data.
      45                                                                                                        This paper did not fit a distribution to the incubation period data and only reported a median and range for a subset of the data. This is present in the database as there are no other studies that report the incubation period for Marburg virus. This paper also reports the maximum and minimum for the complete data set.
      46                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      47                                                                                                                                                                                            The sample size is not explicitly stated. The number of confirmed cases is 23 and there are 2 suspected cases, therefore it is not clear whether the 2 suspected cases were included in the estimation, the sample size is assumed to be 23.
      48                                                                                                                                                                                                                                                                                                                                                                                                                     No additional notes
      49                                                                                                                                                                                                                                                                                    Uses the methods described by Lessler (10.2471/BLT.16.174540) and Reich (10.1002/sim.3659). Estimated from time from exposure to first symptom onset
      50                                                                                                                                                                                                                                                                                                                                                                                                                     No additional notes
      51                                                                                                                                                                                                                                                                          Meanlog, sdlog, and fitted distribution from supplementary material. Uses cases from Charniga 2022 + extra cases. Incubation period as exposure to rash onset.
      52                                                                                                                                                                                                                                                                       Meanlog, sdlog, and fitted distribution from supplementary material. Uses cases from Charniga 2022 + extra cases. Incubation period as exposure to symptom onset.
      53                                                                                                                                                                                                                                                                                                                                                                                                                     No additional notes
      54                                                                                                                                                                                                                                                                                                                                                                                                                       Systematic review
      55                                                                                                                                                                                                                                                                                                                                                                                                                       Systematic review
      56                                                                                                                                                                                                                                                                                                                                                                                                                       Systematic review
      57                                                                                                                                                                                                                                                                                                                                        SEIR model from 10.1016/j.mbs.2008.06.005 where the IP is assumed to follow a gamma distribution
      58                                                                                                                                                                                                                                                                                                                                        SEIR model from 10.1016/j.mbs.2008.06.005 where the IP is assumed to follow a gamma distribution
      59                                                                                                                                                                                                                                                                                                                                        SEIR model from 10.1016/j.mbs.2008.06.005 where the IP is assumed to follow a gamma distribution
      60                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      61                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      62                                                                                                                                                                                                                                                                         Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. Of the 18 samples at least 17 of them are not trasmitted by mosquitoes
      63                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      64                                                                                                                                                                                                                                                                                                                                                   Data from Lessler et al 2009 using double interval-censored analysis. Not open source
      65                                                                                                                                                                                                                                                                                                                                                   Data from Lessler et al 2009 using single interval-censored analysis. Not open source
      66                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      67                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      68                                                                                                                                                                                                                                                                       Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      69                                                                                                                                                                                                                                                            Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only tramsission by transplant or transfusion. 
      70                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      71                                                                                                                                                                                                                                                                       Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      72                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2016 for references of datasets
             PMID                                     DOI
      1  19393959           10.1016/S1473-3099(09)70069-6
      2  24639305                   10.4269/ajtmh.13-0403
      3  33706702              10.1186/s12879-021-05950-x
      4  33362233            10.1371/journal.pone.0243889
      5  33548553              10.1016/j.ijid.2021.01.069
      6  32150748                        10.7326/M20-0504
      7  32150748                        10.7326/M20-0504
      8  32150748                        10.7326/M20-0504
      9  32150748                        10.7326/M20-0504
      10 32079150                      10.3390/jcm9020538
      11 32079150                      10.3390/jcm9020538
      12 32079150                      10.3390/jcm9020538
      13 32801208             10.1136/bmjopen-2020-039652
      14 32801208             10.1136/bmjopen-2020-039652
      15       NA             10.1101/2020.02.24.20027474
      16 33643779              10.1007/s10389-021-01478-1
      17 23226436            10.1371/journal.pone.0050972
      18 23226436            10.1371/journal.pone.0050972
      19 23226436            10.1371/journal.pone.0050972
      20 24639305                   10.4269/ajtmh.13-0403
      21 24639305                   10.4269/ajtmh.13-0403
      22 24159443              10.1016/j.phrp.2011.04.001
      23 25539446                    10.1056/NEJMc1414993
      24 25539446                    10.1056/NEJMc1414994
      25 25539446                    10.1056/NEJMc1414995
      26 25539446                    10.1056/NEJMc1414992
      27 19393959           10.1016/S1473-3099(09)70069-7
      28 20029668                10.1371/currents.RRN1130
      29 19393959           10.1016/S1473-3099(09)70069-9
      30 19393959          10.1016/S1473-3099(09)70069-10
      31 19393959          10.1016/S1473-3099(09)70069-11
      32 20042754                   10.1056/NEJMoa0906089
      33 21168422              10.1016/j.jtbi.2010.12.017
      34 21168422              10.1016/j.jtbi.2010.12.017
      35 19598148                        10.1002/sim.3659
      36 19598148                        10.1002/sim.3659
      37 19959592                     10.1503/cmaj.091807
      38 26409239                      10.1093/aje/kwv115
      39 26409239                      10.1093/aje/kwv115
      40 26885816            10.1371/journal.pone.0148506
      41 26885816            10.1371/journal.pone.0148506
      42 26885816            10.1371/journal.pone.0148506
      43 24639305                   10.4269/ajtmh.13-0403
      44 25495697                 10.1186/1756-0500-7-906
      45 25495697                 10.1186/1756-0500-7-906
      46 19393959          10.1016/S1473-3099(09)70069-12
      47 23782161                   10.1056/NEJMoa1306742
      48 26132767    10.2807/1560-7917.es2015.20.25.21163
      49       NA             10.1101/2022.06.22.22276713
      50 35994726                  10.3201/eid2810.221126
      51       NA             10.1101/2022.10.26.22281516
      52       NA             10.1101/2022.10.26.22281517
      53 35713026 10.2807/1560-7917.ES.2022.27.24.2200448
      54 36130210                     10.1093/jtm/taac107
      55 36130210                     10.1093/jtm/taac108
      56 36130210                     10.1093/jtm/taac109
      57 36573222              10.1016/j.jobb.2022.12.001
      58 36573222              10.1016/j.jobb.2022.12.002
      59 36573222              10.1016/j.jobb.2022.12.003
      60 19393959          10.1016/S1473-3099(09)70069-13
      61 19393959          10.1016/S1473-3099(09)70069-15
      62 24639305                   10.4269/ajtmh.13-0403
      63 19393959          10.1016/S1473-3099(09)70069-14
      64 19598148                        10.1002/sim.3659
      65 19598148                        10.1002/sim.3659
      66 19393959           10.1016/S1473-3099(09)70069-8
      67 24639305                   10.4269/ajtmh.13-0403
      68 24639305                   10.4269/ajtmh.13-0403
      69 24639305                   10.4269/ajtmh.13-0403
      70 24639305                   10.4269/ajtmh.13-0403
      71 24639305                   10.4269/ajtmh.13-0403
      72 27821887                   10.2471/BLT.16.174540

# list_distributions works for incubation period

    Code
      list_distributions(epiparam = eparam, epi_dist = "incubation_period")
    Output
                       disease  epi_distribution prob_distribution
      1             Adenovirus incubation_period             lnorm
      2            Chikungunya incubation_period             lnorm
      3               COVID-19 incubation_period              <NA>
      4               COVID-19 incubation_period           weibull
      5               COVID-19 incubation_period              <NA>
      6               COVID-19 incubation_period             lnorm
      7               COVID-19 incubation_period             lnorm
      8               COVID-19 incubation_period             lnorm
      9               COVID-19 incubation_period             lnorm
      10              COVID-19 incubation_period             lnorm
      11              COVID-19 incubation_period             lnorm
      12              COVID-19 incubation_period             lnorm
      13              COVID-19 incubation_period             lnorm
      14              COVID-19 incubation_period             lnorm
      15              COVID-19 incubation_period              <NA>
      16              COVID-19 incubation_period              <NA>
      17                Dengue incubation_period             lnorm
      18                Dengue incubation_period             lnorm
      19                Dengue incubation_period             lnorm
      20                Dengue incubation_period             lnorm
      21                Dengue incubation_period             lnorm
      22   Ebola Virus Disease incubation_period             lnorm
      23   Ebola Virus Disease incubation_period             gamma
      24   Ebola Virus Disease incubation_period             gamma
      25   Ebola Virus Disease incubation_period             gamma
      26   Ebola Virus Disease incubation_period             gamma
      27     Human Coronavirus incubation_period             lnorm
      28             Influenza incubation_period             gamma
      29             Influenza incubation_period             lnorm
      30             Influenza incubation_period             lnorm
      31             Influenza incubation_period             lnorm
      32             Influenza incubation_period             lnorm
      33             Influenza incubation_period             gamma
      34             Influenza incubation_period           weibull
      35             Influenza incubation_period             lnorm
      36             Influenza incubation_period             lnorm
      37             Influenza incubation_period             lnorm
      38             Influenza incubation_period           weibull
      39             Influenza incubation_period             gamma
      40             Influenza incubation_period           weibull
      41             Influenza incubation_period           weibull
      42             Influenza incubation_period           weibull
      43 Japanese Encephalitis incubation_period             lnorm
      44 Marburg Virus Disease incubation_period              <NA>
      45 Marburg Virus Disease incubation_period              <NA>
      46               Measles incubation_period             lnorm
      47                  MERS incubation_period             lnorm
      48                  MERS incubation_period             gamma
      49                  Mpox incubation_period             lnorm
      50                  Mpox incubation_period             gamma
      51                  Mpox incubation_period             lnorm
      52                  Mpox incubation_period             lnorm
      53                  Mpox incubation_period             lnorm
      54                  Mpox incubation_period              <NA>
      55                  Mpox incubation_period              <NA>
      56                  Mpox incubation_period              <NA>
      57                  Mpox incubation_period              <NA>
      58                  Mpox incubation_period              <NA>
      59                  Mpox incubation_period              <NA>
      60         Parainfluenza incubation_period             lnorm
      61            Rhinovirus incubation_period             lnorm
      62     Rift Valley Fever incubation_period             lnorm
      63                   RSV incubation_period             lnorm
      64                   RSV incubation_period             lnorm
      65                   RSV incubation_period             lnorm
      66                  SARS incubation_period             lnorm
      67       West Nile Fever incubation_period             lnorm
      68       West Nile Fever incubation_period             lnorm
      69       West Nile Fever incubation_period             lnorm
      70          Yellow Fever incubation_period             lnorm
      71          Yellow Fever incubation_period             lnorm
      72    Zika Virus Disease incubation_period             lnorm
                          author year sample_size
      1             Lessler_etal 2009          14
      2             Rudolph_etal 2014          21
      3               Alene_etal 2021        1453
      4                 Bui_etal 2020          19
      5               Elias_etal 2021       28675
      6               Lauer_etal 2020         181
      7               Lauer_etal 2020          99
      8               Lauer_etal 2020         108
      9               Lauer_etal 2020          73
      10             Linton_etal 2020          52
      11             Linton_etal 2020         158
      12             Linton_etal 2020          52
      13            McAloon_etal 2020        1357
      14            McAloon_etal 2020        1269
      15                Men_etal 2020          59
      16                Rai_etal 2022        6241
      17          Chan_Johansson 2012         146
      18          Chan_Johansson 2012         146
      19          Chan_Johansson 2012         153
      20            Rudolph_etal 2014         169
      21            Rudolph_etal 2014         124
      22            Eichner_etal 2011         196
      23 WHO_Ebola_Response_Team 2015          49
      24 WHO_Ebola_Response_Team 2015         957
      25 WHO_Ebola_Response_Team 2015         792
      26  WHO_Ebola_ResponseTeam 2015        1798
      27            Lessler_etal 2009          13
      28              Ghani_etal 2009          16
      29            Lessler_etal 2009         151
      30            Lessler_etal 2009          90
      31            Lessler_etal 2009          78
      32            Lessler_etal 2009         124
      33          Nishiura_Inaba 2011          72
      34          Nishiura_Inaba 2011          72
      35              Reich_etal 2009         151
      36              Reich_etal 2009         151
      37              Tuite_etal 2010         316
      38          Virlogeux_etal 2015         229
      39          Virlogeux_etal 2015         229
      40          Virlogeux_etal 2016         395
      41          Virlogeux_etal 2016         173
      42          Virlogeux_etal 2016         222
      43            Rudolph_etal 2014           6
      44                  Pavlin 2014          76
      45                  Pavlin 2014          18
      46            Lessler_etal 2009          55
      47             Assiri_etal 2013          23
      48            Cowling_etal 2015         166
      49           Charniga_etal 2022          22
      50            Guzetta_etal 2022         255
      51           Madewell_etal 2022          35
      52           Madewell_etal 2022          36
      53              Miura_etal 2022          18
      54               Wang_etal 2022          16
      55               Wang_etal 2022          27
      56               Wang_etal 2022         114
      57                Wei_etal 2022          NA
      58                Wei_etal 2022          NA
      59                Wei_etal 2022          NA
      60            Lessler_etal 2009          11
      61            Lessler_etal 2009          28
      62            Rudolph_etal 2014          23
      63            Lessler_etal 2009          24
      64              Reich_etal 2009          24
      65              Reich_etal 2009          24
      66            Lessler_etal 2009         157
      67            Rudolph_etal 2014          18
      68            Rudolph_etal 2014           8
      69            Rudolph_etal 2014           6
      70            Rudolph_etal 2014          91
      71            Rudolph_etal 2014          80
      72            Lessler_etal 2016          25

# list_distributions works for incubation, subset_db = FALSE

    Code
      list_distributions(epiparam = eparam, epi_dist = "incubation", subset_db = FALSE)
    Output
                       disease                    pathogen  epi_distribution
      1             Adenovirus                  Adenovirus incubation_period
      2            Chikungunya           Chikungunya Virus incubation_period
      3               COVID-19                  SARS-CoV-2 incubation_period
      4               COVID-19                  SARS-CoV-2 incubation_period
      5               COVID-19                  SARS-CoV-2 incubation_period
      6               COVID-19                  SARS-CoV-2 incubation_period
      7               COVID-19                  SARS-CoV-2 incubation_period
      8               COVID-19                  SARS-CoV-2 incubation_period
      9               COVID-19                  SARS-CoV-2 incubation_period
      10              COVID-19                  SARS-CoV-2 incubation_period
      11              COVID-19                  SARS-CoV-2 incubation_period
      12              COVID-19                  SARS-CoV-2 incubation_period
      13              COVID-19                  SARS-CoV-2 incubation_period
      14              COVID-19                  SARS-CoV-2 incubation_period
      15              COVID-19                  SARS-CoV-2 incubation_period
      16              COVID-19                  SARS-CoV-2 incubation_period
      17                Dengue                Dengue Virus incubation_period
      18                Dengue                Dengue Virus incubation_period
      19                Dengue                Dengue Virus incubation_period
      20                Dengue                Dengue Virus incubation_period
      21                Dengue                Dengue Virus incubation_period
      22   Ebola Virus Disease   Ebola Virus-Zaire Subtype incubation_period
      23   Ebola Virus Disease                 Ebola Virus incubation_period
      24   Ebola Virus Disease                 Ebola Virus incubation_period
      25   Ebola Virus Disease                 Ebola Virus incubation_period
      26   Ebola Virus Disease                 Ebola Virus incubation_period
      27     Human Coronavirus                   Human_Cov incubation_period
      28             Influenza         Influenza-A-H1N1Pdm incubation_period
      29             Influenza                 Influenza-A incubation_period
      30             Influenza                 Influenza-A incubation_period
      31             Influenza                 Influenza-B incubation_period
      32             Influenza            Influenza-A-H1N1 incubation_period
      33             Influenza            Influenza-A-H1N1 incubation_period
      34             Influenza            Influenza-A-H1N1 incubation_period
      35             Influenza                 Influenza-A incubation_period
      36             Influenza                 Influenza-A incubation_period
      37             Influenza            Influenza-A-H1N1 incubation_period
      38             Influenza            Influenza-A-H7N9 incubation_period
      39             Influenza            Influenza-A-H7N9 incubation_period
      40             Influenza            Influenza-A-H7N9 incubation_period
      41             Influenza            Influenza-A-H7N9 incubation_period
      42             Influenza            Influenza-A-H7N9 incubation_period
      43 Japanese Encephalitis Japanese Encephalitis Virus incubation_period
      44 Marburg Virus Disease               Marburg Virus incubation_period
      45 Marburg Virus Disease               Marburg Virus incubation_period
      46               Measles               Measles Virus incubation_period
      47                  MERS                    MERS-Cov incubation_period
      48                  MERS                    MERS-Cov incubation_period
      49                  Mpox                  Mpox Virus incubation_period
      50                  Mpox                  Mpox Virus incubation_period
      51                  Mpox                  Mpox Virus incubation_period
      52                  Mpox                  Mpox Virus incubation_period
      53                  Mpox                  Mpox Virus incubation_period
      54                  Mpox          Mpox Virus Clade I incubation_period
      55                  Mpox        Mpox Virus Clade IIa incubation_period
      56                  Mpox        Mpox Virus Clade IIb incubation_period
      57                  Mpox                  Mpox Virus incubation_period
      58                  Mpox                  Mpox Virus incubation_period
      59                  Mpox                  Mpox Virus incubation_period
      60         Parainfluenza         Parainfluenza Virus incubation_period
      61            Rhinovirus                  Rhinovirus incubation_period
      62     Rift Valley Fever     Rift Valley Fever Virus incubation_period
      63                   RSV                         RSV incubation_period
      64                   RSV                         RSV incubation_period
      65                   RSV                         RSV incubation_period
      66                  SARS                  SARS-Cov-1 incubation_period
      67       West Nile Fever             West Nile Virus incubation_period
      68       West Nile Fever             West Nile Virus incubation_period
      69       West Nile Fever             West Nile Virus incubation_period
      70          Yellow Fever        Yellow Fever Viruses incubation_period
      71          Yellow Fever        Yellow Fever Viruses incubation_period
      72    Zika Virus Disease                  Zika Virus incubation_period
                          author
      1             Lessler_etal
      2             Rudolph_etal
      3               Alene_etal
      4                 Bui_etal
      5               Elias_etal
      6               Lauer_etal
      7               Lauer_etal
      8               Lauer_etal
      9               Lauer_etal
      10             Linton_etal
      11             Linton_etal
      12             Linton_etal
      13            McAloon_etal
      14            McAloon_etal
      15                Men_etal
      16                Rai_etal
      17          Chan_Johansson
      18          Chan_Johansson
      19          Chan_Johansson
      20            Rudolph_etal
      21            Rudolph_etal
      22            Eichner_etal
      23 WHO_Ebola_Response_Team
      24 WHO_Ebola_Response_Team
      25 WHO_Ebola_Response_Team
      26  WHO_Ebola_ResponseTeam
      27            Lessler_etal
      28              Ghani_etal
      29            Lessler_etal
      30            Lessler_etal
      31            Lessler_etal
      32            Lessler_etal
      33          Nishiura_Inaba
      34          Nishiura_Inaba
      35              Reich_etal
      36              Reich_etal
      37              Tuite_etal
      38          Virlogeux_etal
      39          Virlogeux_etal
      40          Virlogeux_etal
      41          Virlogeux_etal
      42          Virlogeux_etal
      43            Rudolph_etal
      44                  Pavlin
      45                  Pavlin
      46            Lessler_etal
      47             Assiri_etal
      48            Cowling_etal
      49           Charniga_etal
      50            Guzetta_etal
      51           Madewell_etal
      52           Madewell_etal
      53              Miura_etal
      54               Wang_etal
      55               Wang_etal
      56               Wang_etal
      57                Wei_etal
      58                Wei_etal
      59                Wei_etal
      60            Lessler_etal
      61            Lessler_etal
      62            Rudolph_etal
      63            Lessler_etal
      64              Reich_etal
      65              Reich_etal
      66            Lessler_etal
      67            Rudolph_etal
      68            Rudolph_etal
      69            Rudolph_etal
      70            Rudolph_etal
      71            Rudolph_etal
      72            Lessler_etal
                                                                                                                                                                                  title
      1                                                                                                   Incubation periods of acute respiratory viral infections: a systematic review
      2                                                                                                      Incubation periods of mosquito-borne viral infections: a systematic review
      3                                                                                        Serial interval and incubation period of COVID-19: a systematic review and meta-analysis
      4                                                                                                                      Estimation of the incubation period of COVID-19 in Vietnam
      5                                                                                                                              The incubation period of COVID-19: A meta-analysis
      6                                                 The Incubation Period of Coronavirus Disease 2019 (COVID-19) From Publicly Reported Confirmed Cases: Estimation and Application
      7                                                 The Incubation Period of Coronavirus Disease 2019 (COVID-19) From Publicly Reported Confirmed Cases: Estimation and Application
      8                                                 The Incubation Period of Coronavirus Disease 2019 (COVID-19) From Publicly Reported Confirmed Cases: Estimation and Application
      9                                                 The Incubation Period of Coronavirus Disease 2019 (COVID-19) From Publicly Reported Confirmed Cases: Estimation and Application
      10 Incubation Period and Other Epidemiological Characteristics of 2019 Novel Coronavirus Infections with Right Truncation: A Statistical Analysis of Publicly Available Case Data
      11 Incubation Period and Other Epidemiological Characteristics of 2019 Novel Coronavirus Infections with Right Truncation: A Statistical Analysis of Publicly Available Case Data
      12 Incubation Period and Other Epidemiological Characteristics of 2019 Novel Coronavirus Infections with Right Truncation: A Statistical Analysis of Publicly Available Case Data
      13                                                                           Incubation period of COVID-19: a rapid systematic review and meta-analysis of observational research
      14                                                                           Incubation period of COVID-19: a rapid systematic review and meta-analysis of observational research
      15                                                                                                                  Estimate the incubation period of coronavirus 2019 (COVID-19)
      16                                                                                                          Incubation period for COVID-19: a systematic review and meta-analysis
      17                                                                                                                                       The Incubation Periods of Dengue Viruses
      18                                                                                                                                       The Incubation Periods of Dengue Viruses
      19                                                                                                                                       The Incubation Periods of Dengue Viruses
      20                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      21                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      22                                                                                                                     Incubation period of ebola hemorrhagic virus subtype zaire
      23                                                                                                 West African Ebola Epidemic after One Year — Slowing but Not Yet under Control
      24                                                                                                 West African Ebola Epidemic after One Year — Slowing but Not Yet under Control
      25                                                                                                 West African Ebola Epidemic after One Year — Slowing but Not Yet under Control
      26                                                                                                 West African Ebola Epidemic after One Year — Slowing but Not Yet under Control
      27                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      28                                                                                                     The Early Transmission Dynamics of H1N1pdm Influenza in the United Kingdom
      29                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      30                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      31                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      32                                                                                                         Outbreak of 2009 Pandemic Influenza A (H1N1) at a New York City School
      33                     Estimation of the incubation period of influenza A (H1N1-2009) among imported cases: addressing censoring using outbreak data at the origin of importation
      34                     Estimation of the incubation period of influenza A (H1N1-2009) among imported cases: addressing censoring using outbreak data at the origin of importation
      35                                                                                                                    Estimating incubation period distributions with coarse data
      36                                                                                                                    Estimating incubation period distributions with coarse data
      37                                                                                       Estimated epidemiologic parameters and morbidity associated with pandemic H1N1 influenza
      38                                                                        Estimating the Distribution of the Incubation Periods of Human Avian Influenza A(H7N9) Virus Infections
      39                                                                        Estimating the Distribution of the Incubation Periods of Human Avian Influenza A(H7N9) Virus Infections
      40                                                                     Association between the Severity of Influenza A(H7N9) Virus Infections and Length of the Incubation Period
      41                                                                     Association between the Severity of Influenza A(H7N9) Virus Infections and Length of the Incubation Period
      42                                                                     Association between the Severity of Influenza A(H7N9) Virus Infections and Length of the Incubation Period
      43                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      44                                                                          Calculation of incubation period and serial interval from multiple outbreaks of Marburg virus disease
      45                                                                          Calculation of incubation period and serial interval from multiple outbreaks of Marburg virus disease
      46                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      47                                                                                                              Hospital Outbreak of Middle East Respiratory Syndrome Coronavirus
      48                                                                                   Preliminary epidemiological assessment of MERS-CoV outbreak in South Korea, May to June 2015
      49                                                                                    Estimating the incubation period of monkeypox virus during the 2022 multi-national outbreak
      50                                                                 Early Estimates of Monkeypox Incubation Period, Generation Time, and Reproduction Number, Italy, May-June 2022
      51                                                       Serial interval and incubation period estimates of monkeypox virus infection in 12 U.S. jurisdictions, May – August 2022
      52                                                       Serial interval and incubation period estimates of monkeypox virus infection in 12 U.S. jurisdictions, May – August 2023
      53                                                                                         Estimated incubation period for monkeypox cases confirmed in the Netherlands, May 2022
      54                                                                                                          Serial intervals and incubation periods of the monkeypox virus clades
      55                                                                                                          Serial intervals and incubation periods of the monkeypox virus clades
      56                                                                                                          Serial intervals and incubation periods of the monkeypox virus clades
      57                                                                                                                     Study and prediction of the 2022 global monkeypox epidemic
      58                                                                                                                     Study and prediction of the 2022 global monkeypox epidemic
      59                                                                                                                     Study and prediction of the 2022 global monkeypox epidemic
      60                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      61                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      62                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      63                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      64                                                                                                                    Estimating incubation period distributions with coarse data
      65                                                                                                                    Estimating incubation period distributions with coarse data
      66                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      67                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      68                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      69                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      70                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      71                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      72                                                                           Times to key events in Zika virus infection and implications for blood donation: a systematic review
                                                       journal year sample_size
      1                         The Lancet Infectious Diseases 2009          14
      2  The American Journal of Tropical Medicine and Hygiene 2014          21
      3                                BMC Infectious Diseases 2021        1453
      4                                               PLoS One 2020          19
      5           International Journal of Infectious Diseases 2021       28675
      6                            Annals of Internal Medicine 2020         181
      7                            Annals of Internal Medicine 2020          99
      8                            Annals of Internal Medicine 2020         108
      9                            Annals of Internal Medicine 2020          73
      10                          Journal of Clinical Medicine 2020          52
      11                          Journal of Clinical Medicine 2020         158
      12                          Journal of Clinical Medicine 2020          52
      13                                              BMJ Open 2020        1357
      14                                              BMJ Open 2020        1269
      15                                               medRxiv 2020          59
      16             Zeitschrift fur Gesundheitswissenschaften 2022        6241
      17                                              PLoS One 2012         146
      18                                              PLoS One 2012         146
      19                                              PLoS One 2012         153
      20 The American Journal of Tropical Medicine and Hygiene 2014         169
      21 The American Journal of Tropical Medicine and Hygiene 2014         124
      22         Osong Public Health and Research Perspectives 2011         196
      23                   The New England Journal of Medicine 2015          49
      24                   The New England Journal of Medicine 2015         957
      25                   The New England Journal of Medicine 2015         792
      26                   The New England Journal of Medicine 2015        1798
      27                        The Lancet Infectious Diseases 2009          13
      28                                         PLoS Currents 2009          16
      29                        The Lancet Infectious Diseases 2009         151
      30                        The Lancet Infectious Diseases 2009          90
      31                        The Lancet Infectious Diseases 2009          78
      32                   The New England Journal of Medicine 2009         124
      33                        Journal of Theoretical Biology 2011          72
      34                        Journal of Theoretical Biology 2011          72
      35                                Statistics in Medicine 2009         151
      36                                Statistics in Medicine 2009         151
      37                  Canadian Medical Association Journal 2010         316
      38                      American Journal of Epidemiology 2015         229
      39                      American Journal of Epidemiology 2015         229
      40                                              PLoS One 2016         395
      41                                              PLoS One 2016         173
      42                                              PLoS One 2016         222
      43 The American Journal of Tropical Medicine and Hygiene 2014           6
      44                                    BMC Research Notes 2014          76
      45                                    BMC Research Notes 2014          18
      46                        The Lancet Infectious Diseases 2009          55
      47                   The New England Journal of Medicine 2013          23
      48                                      Eurosurveillance 2015         166
      49                                               medRxiv 2022          22
      50                          Emerging Infectious Diseases 2022         255
      51                                               medRxiv 2022          35
      52                                               medRxiv 2022          36
      53                                      Eurosurveillance 2022          18
      54                            Journal of Travel Medicine 2022          16
      55                            Journal of Travel Medicine 2022          27
      56                            Journal of Travel Medicine 2022         114
      57                  Journal of Biosafety and Biosecurity 2022          NA
      58                  Journal of Biosafety and Biosecurity 2022          NA
      59                  Journal of Biosafety and Biosecurity 2022          NA
      60                        The Lancet Infectious Diseases 2009          11
      61                        The Lancet Infectious Diseases 2009          28
      62 The American Journal of Tropical Medicine and Hygiene 2014          23
      63                        The Lancet Infectious Diseases 2009          24
      64                                Statistics in Medicine 2009          24
      65                                Statistics in Medicine 2009          24
      66                        The Lancet Infectious Diseases 2009         157
      67 The American Journal of Tropical Medicine and Hygiene 2014          18
      68 The American Journal of Tropical Medicine and Hygiene 2014           8
      69 The American Journal of Tropical Medicine and Hygiene 2014           6
      70 The American Journal of Tropical Medicine and Hygiene 2014          91
      71 The American Journal of Tropical Medicine and Hygiene 2014          80
      72             Bulletin of the World Health Organization 2016          25
                                       region              transmission_mode
      1                                   USA                   experimental
      2                                 Mixed                   vector_borne
      3                                 Mixed natural_natural_human_to_human
      4                               Vietnam natural_natural_human_to_human
      5                                 Mixed natural_natural_human_to_human
      6                                 Mixed         natural_human_to_human
      7                                 Mixed         natural_human_to_human
      8                                 Mixed         natural_human_to_human
      9                                 China         natural_human_to_human
      10                                China natural_natural_human_to_human
      11                                China natural_natural_human_to_human
      12                                China         natural_human_to_human
      13                                Mixed natural_natural_human_to_human
      14                                Mixed natural_natural_human_to_human
      15                                China natural_natural_human_to_human
      16                                Mixed natural_natural_human_to_human
      17                                Mixed                   vector_borne
      18                                Mixed                   vector_borne
      19                                Mixed                   vector_borne
      20                                Mixed                       multiple
      21                                Mixed                   vector_borne
      22 Kikwit, Democratic Republic of Congo natural_natural_human_to_human
      23                               Guinea natural_natural_human_to_human
      24                              Liberia natural_natural_human_to_human
      25                         Sierra Leone natural_natural_human_to_human
      26                          West Africa natural_natural_human_to_human
      27                                   UK                   experimental
      28                                   UK                natural_unknown
      29                                Mixed                          mixed
      30                                Mixed                          mixed
      31                                  USA                   experimental
      32                        New York, USA                natural_unknown
      33                                Japan                natural_unknown
      34                                Japan                natural_unknown
      35                                Mixed                        unknown
      36                                Mixed                        unknown
      37                               Canada                natural_unknown
      38                                China                natural_unknown
      39                                China                natural_unknown
      40                                China                natural_unknown
      41                                China                natural_unknown
      42                                China                natural_unknown
      43                                Mixed                   vector_borne
      44                                Mixed                          mixed
      45                                Mixed                          mixed
      46                                Mixed                natural_unknown
      47                         Saudi Arabia natural_natural_human_to_human
      48                          South Korea                natural_unknown
      49                                  USA natural_natural_human_to_human
      50                                Italy natural_natural_human_to_human
      51                                  USA natural_natural_human_to_human
      52                                  USA natural_natural_human_to_human
      53                          Netherlands natural_natural_human_to_human
      54                                Congo                natural_unknown
      55                                  USA                natural_unknown
      56                                mixed                natural_unknown
      57                                  USA                natural_unknown
      58                               Europe                natural_unknown
      59                               Global                natural_unknown
      60                                Mixed                   experimental
      61                                  USA                   experimental
      62                                Mixed                   vector_borne
      63                                Mixed                          mixed
      64                                Mixed                        unknown
      65                                Mixed                        unknown
      66                                Mixed                natural_unknown
      67                                Mixed                       multiple
      68                                Mixed                   vector_borne
      69                                Mixed               organ_transplant
      70                                Mixed                       multiple
      71                                Mixed                   vector_borne
      72                                Mixed                   vector_borne
                                     vector extrinsic prob_distribution
      1                                <NA>     FALSE             lnorm
      2                    Aedes albopictus     FALSE             lnorm
      3                                <NA>     FALSE              <NA>
      4                                <NA>     FALSE           weibull
      5                                <NA>     FALSE              <NA>
      6                                <NA>     FALSE             lnorm
      7                                <NA>     FALSE             lnorm
      8                                <NA>     FALSE             lnorm
      9                                <NA>     FALSE             lnorm
      10                               <NA>     FALSE             lnorm
      11                               <NA>     FALSE             lnorm
      12                               <NA>     FALSE             lnorm
      13                               <NA>     FALSE             lnorm
      14                               <NA>     FALSE             lnorm
      15                               <NA>     FALSE              <NA>
      16                               <NA>     FALSE              <NA>
      17 Aedes aegypti and Aedes albopictus      TRUE             lnorm
      18 Aedes aegypti and Aedes albopictus      TRUE             lnorm
      19 Aedes aegypti and Aedes albopictus     FALSE             lnorm
      20                               <NA>     FALSE             lnorm
      21 Aedes aegypti and Aedes albopictus     FALSE             lnorm
      22                               <NA>     FALSE             lnorm
      23                               <NA>     FALSE             gamma
      24                               <NA>     FALSE             gamma
      25                               <NA>     FALSE             gamma
      26                               <NA>     FALSE             gamma
      27                               <NA>     FALSE             lnorm
      28                               <NA>     FALSE             gamma
      29                               <NA>     FALSE             lnorm
      30                               <NA>     FALSE             lnorm
      31                               <NA>     FALSE             lnorm
      32                               <NA>     FALSE             lnorm
      33                               <NA>     FALSE             gamma
      34                               <NA>     FALSE           weibull
      35                               <NA>     FALSE             lnorm
      36                               <NA>     FALSE             lnorm
      37                               <NA>     FALSE             lnorm
      38                               <NA>     FALSE           weibull
      39                               <NA>     FALSE             gamma
      40                               <NA>     FALSE           weibull
      41                               <NA>     FALSE           weibull
      42                               <NA>     FALSE           weibull
      43                           mosquito     FALSE             lnorm
      44                               <NA>     FALSE              <NA>
      45                               <NA>     FALSE              <NA>
      46                               <NA>     FALSE             lnorm
      47                               <NA>     FALSE             lnorm
      48                               <NA>     FALSE             gamma
      49                               <NA>     FALSE             lnorm
      50                               <NA>     FALSE             gamma
      51                               <NA>     FALSE             lnorm
      52                               <NA>     FALSE             lnorm
      53                               <NA>     FALSE             lnorm
      54                               <NA>     FALSE              <NA>
      55                               <NA>     FALSE              <NA>
      56                               <NA>     FALSE              <NA>
      57                               <NA>     FALSE              <NA>
      58                               <NA>     FALSE              <NA>
      59                               <NA>     FALSE              <NA>
      60                               <NA>     FALSE             lnorm
      61                               <NA>     FALSE             lnorm
      62                           mosquito     FALSE             lnorm
      63                               <NA>     FALSE             lnorm
      64                               <NA>     FALSE             lnorm
      65                               <NA>     FALSE             lnorm
      66                               <NA>     FALSE             lnorm
      67                               <NA>     FALSE             lnorm
      68                           mosquito     FALSE             lnorm
      69                               <NA>     FALSE             lnorm
      70                               <NA>     FALSE             lnorm
      71                           mosquito     FALSE             lnorm
      72 Aedes aegypti and Aedes albopictus     FALSE             lnorm
         inference_method  mean mean_ci_limits mean_ci    sd sd_ci_limits sd_ci
      1               mle    NA         NA, NA      NA    NA       NA, NA    NA
      2               mle    NA         NA, NA      NA    NA       NA, NA    NA
      3              <NA>  6.50       5.9, 7.1      95    NA       NA, NA    NA
      4          bayesian  6.40     4.89, 8.50      95  3.05   3.05, 5.30    95
      5              <NA>  6.38     5.79, 6.97      95    NA       NA, NA    NA
      6               mle  5.50         NA, NA      NA    NA       NA, NA    NA
      7               mle    NA         NA, NA      NA    NA       NA, NA    NA
      8               mle    NA         NA, NA      NA    NA       NA, NA    NA
      9               mle    NA         NA, NA      NA    NA       NA, NA    NA
      10         bayesian  5.00       4.2, 6.0      95  3.00     2.1, 4.5    95
      11         bayesian  5.60       5.0, 6.3      95  2.80     2.2, 3.6    95
      12         bayesian  5.60       4.4, 4.8      95  3.90     2.4, 6.9    95
      13              mle    NA         NA, NA      NA    NA       NA, NA    NA
      14              mle  5.80       5.0, 6.7      95    NA       NA, NA    NA
      15             <NA>  5.84     5.07, 6.55      95  2.98   2.31, 3.72    95
      16             <NA>  5.74     5.18, 6.30      95    NA       NA, NA    NA
      17         bayesian 15.00         10, 20      95    NA       NA, NA    NA
      18         bayesian  6.50       4.8, 8.8      95    NA       NA, NA    NA
      19         bayesian  5.97       5.5, 6.4      95  1.64       NA, NA    NA
      20              mle    NA         NA, NA      NA    NA       NA, NA    NA
      21              mle    NA         NA, NA      NA    NA       NA, NA    NA
      22              mle 12.70         NA, NA      NA  4.31       NA, NA    NA
      23              mle 12.60      9.1, 17.1      95 13.10    9.6, 19.6    95
      24              mle 10.00      9.6, 10.5      95  7.60     7.1, 8.1    95
      25              mle 10.40      9.8, 11.0      95  8.60     8.0, 9.3    95
      26              mle 10.30      9.9, 10.7      95  8.20     7.8, 8.6    95
      27         bayesian    NA         NA, NA      NA    NA       NA, NA    NA
      28              mle  2.05         NA, NA      NA  0.49       NA, NA    NA
      29              mle    NA         NA, NA      NA    NA       NA, NA    NA
      30              mle    NA         NA, NA      NA    NA       NA, NA    NA
      31              mle    NA         NA, NA      NA    NA       NA, NA    NA
      32              mle    NA         NA, NA      NA    NA       NA, NA    NA
      33              mle    NA         NA, NA      NA    NA       NA, NA    NA
      34              mle    NA         NA, NA      NA    NA       NA, NA    NA
      35              mle    NA         NA, NA      NA    NA       NA, NA    NA
      36              mle    NA         NA, NA      NA    NA       NA, NA    NA
      37             <NA>  4.30       2.6, 6.6      95    NA       NA, NA    NA
      38              mle  3.40       3.0, 3.7      95  1.70       NA, NA    NA
      39              mle  4.50      2.8, 16.2      95  3.30       NA, NA    NA
      40         bayesian  3.50       3.2, 3.8      95    NA       NA, NA    NA
      41         bayesian  3.70       3.4, 4.1      95    NA       NA, NA    NA
      42         bayesian  3.30       2.9, 3.6      95    NA       NA, NA    NA
      43              mle    NA         NA, NA      NA    NA       NA, NA    NA
      44             <NA>    NA         NA, NA      NA    NA       NA, NA    NA
      45             <NA>    NA         NA, NA      NA    NA       NA, NA    NA
      46              mle    NA         NA, NA      NA    NA       NA, NA    NA
      47              mle    NA         NA, NA      NA    NA       NA, NA    NA
      48         bayesian  6.70       6.1, 7.3      95    NA       NA, NA    NA
      49         bayesian  7.60       6.2, 9.7      95  1.80     1.6, 2.2    95
      50         bayesian  9.10      6.5, 10.9      95    NA       NA, NA    NA
      51         bayesian  7.50       6.0, 9.8      95  4.90     3.2, 8.8    95
      52         bayesian  5.60       4.3, 7.8      95  4.40     2.8, 8.7    95
      53         bayesian  9.00      6.6, 10.9      95    NA       NA, NA    NA
      54             <NA>    NA         NA, NA      NA    NA       NA, NA    NA
      55             <NA>    NA         NA, NA      NA    NA       NA, NA    NA
      56             <NA>    NA         NA, NA      NA    NA       NA, NA    NA
      57             <NA>  8.13      4.9, 19.5      95    NA       NA, NA    NA
      58             <NA>  8.08      4.8, 21.0      95    NA       NA, NA    NA
      59             <NA>  8.23      4.9, 21.4      95    NA       NA, NA    NA
      60              mle    NA         NA, NA      NA    NA       NA, NA    NA
      61              mle    NA         NA, NA      NA    NA       NA, NA    NA
      62              mle    NA         NA, NA      NA    NA       NA, NA    NA
      63              mle    NA         NA, NA      NA    NA       NA, NA    NA
      64              mle    NA         NA, NA      NA    NA       NA, NA    NA
      65              mle    NA         NA, NA      NA    NA       NA, NA    NA
      66              mle    NA         NA, NA      NA    NA       NA, NA    NA
      67              mle    NA         NA, NA      NA    NA       NA, NA    NA
      68              mle    NA         NA, NA      NA    NA       NA, NA    NA
      69              mle    NA         NA, NA      NA    NA       NA, NA    NA
      70              mle    NA         NA, NA      NA    NA       NA, NA    NA
      71              mle    NA         NA, NA      NA    NA       NA, NA    NA
      72         bayesian    NA         NA, NA      NA    NA       NA, NA    NA
         quantile_2.5 quantile_5 quantile_25 median median_ci_limits median_ci
      1            NA         NA        4.80   5.60         4.8, 6.3        95
      2            NA         NA        2.90   3.00         0.5, 3.1        95
      3            NA         NA          NA     NA           NA, NA        NA
      4          1.35       1.90          NA   6.10           NA, NA        NA
      5            NA         NA          NA     NA           NA, NA        NA
      6          2.20         NA          NA   5.10         4.5, 5.8        95
      7          2.60         NA          NA   5.70         4.9, 6.8        95
      8          2.10         NA          NA   5.50         4.4, 7.0        95
      9          2.50         NA          NA   4.80         4.2, 5.6        95
      10           NA       1.70          NA   4.30         3.5, 5.1        95
      11           NA       2.30          NA   5.00         4.4, 5.6        95
      12           NA       1.70          NA   4.60         3.7, 5.7        95
      13           NA         NA          NA     NA           NA, NA        NA
      14           NA         NA          NA   5.10         4.5, 5.8        95
      15         2.69         NA          NA   5.01             4, 6        95
      16           NA         NA          NA     NA           NA, NA        NA
      17         5.00         NA          NA     NA           NA, NA        NA
      18         2.40         NA          NA     NA           NA, NA        NA
      19         3.40         NA          NA     NA           NA, NA        NA
      20           NA         NA        4.50   5.60         5.3, 6.0        95
      21           NA         NA        4.30   5.30         5.0, 5.7        95
      22           NA         NA          NA     NA           NA, NA        NA
      23           NA         NA          NA     NA           NA, NA        NA
      24           NA         NA          NA     NA           NA, NA        NA
      25           NA         NA          NA     NA           NA, NA        NA
      26           NA         NA          NA     NA           NA, NA        NA
      27           NA         NA        2.90   3.20         2.8, 3.7        95
      28           NA         NA          NA     NA           NA, NA        NA
      29           NA       0.70        1.10   1.40         1.3, 1.5        95
      30           NA       1.40        1.70   1.90         1.8, 2.0        95
      31           NA       0.30        0.40   0.60         0.5, 0.6        95
      32           NA       0.90          NA   1.40         1.0, 1.8        95
      33           NA         NA          NA   1.51       1.47, 1.55        95
      34           NA         NA          NA   1.43       1.21, 1.65        95
      35           NA       0.73          NA   1.46       1.35, 1.57        95
      36           NA       0.73          NA   1.43       1.33, 1.54        95
      37           NA         NA          NA   4.00           NA, NA        NA
      38           NA         NA          NA     NA           NA, NA        NA
      39           NA         NA          NA     NA           NA, NA        NA
      40           NA         NA          NA     NA           NA, NA        NA
      41           NA         NA          NA     NA           NA, NA        NA
      42           NA         NA          NA     NA           NA, NA        NA
      43           NA         NA        8.10   8.40         5.1, 9.4        95
      44           NA         NA          NA     NA           NA, NA        NA
      45           NA         NA          NA   7.00           NA, NA        NA
      46           NA       8.90       10.90  12.50       11.8, 13.3        95
      47           NA       2.20          NA   5.20        1.9, 14.7        NA
      48           NA         NA          NA   6.30         5.7, 6.8        95
      49           NA         NA          NA   6.40         5.1, 7.9        95
      50           NA       2.00          NA     NA           NA, NA        NA
      51           NA         NA          NA     NA           NA, NA        NA
      52           NA         NA          NA     NA           NA, NA        NA
      53         3.60       4.20          NA   8.50        6.6, 10.9        95
      54           NA         NA        8.00   9.50           NA, NA        NA
      55           NA         NA       11.39  16.76           NA, NA        NA
      56           NA         NA          NA   8.26       7.55, 8.97        95
      57           NA         NA          NA     NA           NA, NA        NA
      58           NA         NA          NA     NA           NA, NA        NA
      59           NA         NA          NA     NA           NA, NA        NA
      60           NA         NA        2.10   2.60         2.1, 3.1        95
      61           NA       0.80        1.30   1.90         1.4, 2.4        95
      62           NA         NA        3.10   4.00         3.4, 4.9        95
      63           NA       3.10        3.80   4.40         3.9, 4.9        95
      64           NA       3.05          NA   4.41       3.90, 4.92        95
      65           NA       3.11          NA   4.41       3.89, 4.94        95
      66           NA       1.50        2.70   4.00         3.6, 4.4        95
      67           NA       1.00        1.70   2.60         1.6, 3.5        95
      68           NA         NA        2.80   2.90         0.5, 3.1        95
      69           NA         NA        8.70  10.80        8.4, 14.2        95
      70           NA       1.90        3.20   4.40             4, 5        95
      71           NA       1.90        3.10   4.40         3.9, 5.0        95
      72           NA       3.20        4.60   5.90         4.4, 7.6        95
         quantile_75 quantile_87.5 quantile_95 quantile_97.5 lower_range upper_range
      1         6.50            NA          NA            NA          NA          NA
      2         3.00            NA          NA            NA          NA          NA
      3           NA            NA          NA            NA          NA          NA
      4           NA            NA       11.90         13.04          NA          NA
      5           NA            NA          NA            NA          NA          NA
      6           NA            NA          NA         11.50          NA          NA
      7           NA            NA          NA         12.50          NA          NA
      8           NA            NA          NA         14.70          NA          NA
      9           NA            NA          NA          9.20          NA          NA
      10          NA            NA       10.60            NA          NA          NA
      11          NA            NA       10.80            NA          NA          NA
      12          NA            NA       12.30            NA          NA          NA
      13          NA            NA          NA            NA          NA          NA
      14          NA            NA       11.70            NA          NA          NA
      15          NA            NA          NA         12.89          NA          NA
      16          NA            NA          NA            NA          NA          NA
      17          NA            NA          NA         33.00          NA          NA
      18          NA            NA          NA         15.00          NA          NA
      19          NA            NA          NA         10.00          NA          NA
      20        7.10            NA          NA            NA          NA          NA
      21        6.60            NA          NA            NA          NA          NA
      22          NA            NA          NA            NA          NA          NA
      23          NA            NA          NA            NA          NA          NA
      24          NA            NA          NA            NA          NA          NA
      25          NA            NA          NA            NA          NA          NA
      26          NA            NA          NA            NA          NA          NA
      27        3.50            NA          NA            NA          NA          NA
      28          NA            NA          NA            NA          NA          NA
      29        1.90            NA        2.80            NA          NA          NA
      30        2.20            NA        2.70            NA          NA          NA
      31        0.70            NA        1.10            NA          NA          NA
      32          NA            NA        2.20            NA          NA          NA
      33          NA            NA        3.43            NA          NA          NA
      34          NA            NA        3.18            NA          NA          NA
      35          NA            NA        2.94            NA          NA          NA
      36          NA            NA        2.83            NA          NA          NA
      37          NA            NA          NA            NA          NA          NA
      38          NA            NA        6.50            NA          NA          NA
      39          NA            NA       11.00            NA          NA          NA
      40          NA            NA          NA            NA          NA          NA
      41          NA            NA          NA            NA          NA          NA
      42          NA            NA          NA            NA          NA          NA
      43        8.60            NA          NA            NA          NA          NA
      44          NA            NA          NA            NA           2          26
      45          NA            NA          NA            NA           2          13
      46       14.40            NA       17.70            NA          NA          NA
      47          NA            NA       12.40            NA          NA          NA
      48          NA            NA       12.10            NA          NA          NA
      49          NA            NA       17.10            NA          NA          NA
      50          NA            NA       20.00            NA          NA          NA
      51          NA            NA          NA            NA          NA          NA
      52          NA            NA          NA            NA          NA          NA
      53          NA            NA       17.30         19.90          NA          NA
      54       12.25            NA          NA            NA          NA          NA
      55       23.91            NA          NA            NA          NA          NA
      56          NA            NA          NA            NA          NA          NA
      57          NA            NA          NA            NA          NA          NA
      58          NA            NA          NA            NA          NA          NA
      59          NA            NA       20.00            NA          NA          NA
      60        3.20            NA          NA            NA          NA          NA
      61        2.70            NA        4.50            NA          NA          NA
      62        5.30            NA          NA            NA          NA          NA
      63        5.10            NA        6.30            NA          NA          NA
      64          NA            NA        6.39            NA          NA          NA
      65          NA            NA        6.26            NA          NA          NA
      66        5.90            NA       10.60            NA          NA          NA
      67        3.80            NA        7.00            NA          NA          NA
      68        3.00            NA          NA            NA          NA          NA
      69       13.30            NA          NA            NA          NA          NA
      70        6.30            NA       10.30            NA          NA          NA
      71        6.20            NA       10.30            NA          NA          NA
      72        7.60            NA       11.20            NA          NA          NA
         shape shape_ci_limits shape_ci scale scale_ci_limits scale_ci meanlog
      1     NA          NA, NA       NA    NA          NA, NA       NA      NA
      2     NA          NA, NA       NA    NA          NA, NA       NA      NA
      3     NA          NA, NA       NA    NA          NA, NA       NA      NA
      4     NA          NA, NA       NA    NA          NA, NA       NA      NA
      5     NA          NA, NA       NA    NA          NA, NA       NA      NA
      6     NA          NA, NA       NA    NA          NA, NA       NA      NA
      7     NA          NA, NA       NA    NA          NA, NA       NA      NA
      8     NA          NA, NA       NA    NA          NA, NA       NA      NA
      9     NA          NA, NA       NA    NA          NA, NA       NA      NA
      10    NA          NA, NA       NA    NA          NA, NA       NA      NA
      11    NA          NA, NA       NA    NA          NA, NA       NA      NA
      12    NA          NA, NA       NA    NA          NA, NA       NA      NA
      13    NA          NA, NA       NA    NA          NA, NA       NA    1.66
      14    NA          NA, NA       NA    NA          NA, NA       NA    1.63
      15    NA          NA, NA       NA    NA          NA, NA       NA      NA
      16    NA          NA, NA       NA    NA          NA, NA       NA      NA
      17    NA          NA, NA       NA    NA          NA, NA       NA      NA
      18    NA          NA, NA       NA    NA          NA, NA       NA      NA
      19    NA          NA, NA       NA    NA          NA, NA       NA    1.75
      20    NA          NA, NA       NA    NA          NA, NA       NA      NA
      21    NA          NA, NA       NA    NA          NA, NA       NA      NA
      22    NA          NA, NA       NA    NA          NA, NA       NA      NA
      23    NA          NA, NA       NA    NA          NA, NA       NA      NA
      24    NA          NA, NA       NA    NA          NA, NA       NA      NA
      25    NA          NA, NA       NA    NA          NA, NA       NA      NA
      26    NA          NA, NA       NA    NA          NA, NA       NA      NA
      27    NA          NA, NA       NA    NA          NA, NA       NA      NA
      28    NA          NA, NA       NA    NA          NA, NA       NA      NA
      29    NA          NA, NA       NA    NA          NA, NA       NA      NA
      30    NA          NA, NA       NA    NA          NA, NA       NA      NA
      31    NA          NA, NA       NA    NA          NA, NA       NA      NA
      32    NA          NA, NA       NA    NA          NA, NA       NA      NA
      33  3.27          NA, NA       NA  0.51          NA, NA       NA      NA
      34  1.74          NA, NA       NA  1.83          NA, NA       NA      NA
      35    NA          NA, NA       NA    NA          NA, NA       NA      NA
      36    NA          NA, NA       NA    NA          NA, NA       NA      NA
      37    NA          NA, NA       NA    NA          NA, NA       NA      NA
      38    NA          NA, NA       NA    NA          NA, NA       NA      NA
      39    NA          NA, NA       NA    NA          NA, NA       NA      NA
      40    NA          NA, NA       NA    NA          NA, NA       NA      NA
      41  2.30      1.80, 2.89       95  4.21      3.62, 4.85       95      NA
      42  2.03      1.62, 2.52       95  3.74      3.20, 4.36       95      NA
      43    NA          NA, NA       NA    NA          NA, NA       NA      NA
      44    NA          NA, NA       NA    NA          NA, NA       NA      NA
      45    NA          NA, NA       NA    NA          NA, NA       NA      NA
      46    NA          NA, NA       NA    NA          NA, NA       NA      NA
      47    NA          NA, NA       NA    NA          NA, NA       NA      NA
      48    NA          NA, NA       NA    NA          NA, NA       NA      NA
      49    NA          NA, NA       NA    NA          NA, NA       NA      NA
      50    NA          NA, NA       NA    NA          NA, NA       NA      NA
      51    NA          NA, NA       NA    NA          NA, NA       NA    1.80
      52    NA          NA, NA       NA    NA          NA, NA       NA    1.50
      53    NA          NA, NA       NA    NA          NA, NA       NA      NA
      54    NA          NA, NA       NA    NA          NA, NA       NA      NA
      55    NA          NA, NA       NA    NA          NA, NA       NA      NA
      56    NA          NA, NA       NA    NA          NA, NA       NA      NA
      57    NA          NA, NA       NA    NA          NA, NA       NA      NA
      58    NA          NA, NA       NA    NA          NA, NA       NA      NA
      59    NA          NA, NA       NA    NA          NA, NA       NA      NA
      60    NA          NA, NA       NA    NA          NA, NA       NA      NA
      61    NA          NA, NA       NA    NA          NA, NA       NA      NA
      62    NA          NA, NA       NA    NA          NA, NA       NA      NA
      63    NA          NA, NA       NA    NA          NA, NA       NA      NA
      64    NA          NA, NA       NA    NA          NA, NA       NA      NA
      65    NA          NA, NA       NA    NA          NA, NA       NA      NA
      66    NA          NA, NA       NA    NA          NA, NA       NA      NA
      67    NA          NA, NA       NA    NA          NA, NA       NA      NA
      68    NA          NA, NA       NA    NA          NA, NA       NA      NA
      69    NA          NA, NA       NA    NA          NA, NA       NA      NA
      70    NA          NA, NA       NA    NA          NA, NA       NA      NA
      71    NA          NA, NA       NA    NA          NA, NA       NA      NA
      72    NA          NA, NA       NA    NA          NA, NA       NA      NA
         meanlog_ci_limits meanlog_ci sdlog sdlog_ci_limits sdlog_ci dispersion
      1             NA, NA         NA    NA          NA, NA       NA       1.26
      2             NA, NA         NA    NA          NA, NA       NA       1.04
      3             NA, NA         NA    NA          NA, NA       NA         NA
      4             NA, NA         NA    NA          NA, NA       NA         NA
      5             NA, NA         NA    NA          NA, NA       NA         NA
      6             NA, NA         NA    NA          NA, NA       NA       1.52
      7             NA, NA         NA    NA          NA, NA       NA         NA
      8             NA, NA         NA    NA          NA, NA       NA         NA
      9             NA, NA         NA    NA          NA, NA       NA         NA
      10            NA, NA         NA    NA          NA, NA       NA         NA
      11            NA, NA         NA    NA          NA, NA       NA         NA
      12            NA, NA         NA    NA          NA, NA       NA         NA
      13        1.55, 1.76         95  0.48      0.42, 0.54       95         NA
      14        1.51, 1.75         95  0.50      0.46, 0.55       95         NA
      15            NA, NA         NA    NA          NA, NA       NA         NA
      16            NA, NA         NA    NA          NA, NA       NA         NA
      17            NA, NA         NA    NA          NA, NA       NA         NA
      18            NA, NA         NA    NA          NA, NA       NA         NA
      19            NA, NA         NA  0.27          NA, NA       NA         NA
      20            NA, NA         NA    NA          NA, NA       NA       1.41
      21            NA, NA         NA    NA          NA, NA       NA       1.37
      22            NA, NA         NA    NA          NA, NA       NA         NA
      23            NA, NA         NA    NA          NA, NA       NA         NA
      24            NA, NA         NA    NA          NA, NA       NA         NA
      25            NA, NA         NA    NA          NA, NA       NA         NA
      26            NA, NA         NA    NA          NA, NA       NA         NA
      27            NA, NA         NA    NA          NA, NA       NA       1.15
      28            NA, NA         NA    NA          NA, NA       NA         NA
      29            NA, NA         NA    NA          NA, NA       NA       1.51
      30            NA, NA         NA    NA          NA, NA       NA       1.23
      31            NA, NA         NA    NA          NA, NA       NA       1.51
      32            NA, NA         NA    NA          NA, NA       NA         NA
      33            NA, NA         NA    NA          NA, NA       NA         NA
      34            NA, NA         NA    NA          NA, NA       NA         NA
      35            NA, NA         NA    NA          NA, NA       NA       1.53
      36            NA, NA         NA    NA          NA, NA       NA       1.51
      37            NA, NA         NA    NA          NA, NA       NA         NA
      38            NA, NA         NA    NA          NA, NA       NA         NA
      39            NA, NA         NA    NA          NA, NA       NA         NA
      40            NA, NA         NA    NA          NA, NA       NA         NA
      41            NA, NA         NA    NA          NA, NA       NA         NA
      42            NA, NA         NA    NA          NA, NA       NA         NA
      43            NA, NA         NA    NA          NA, NA       NA       1.04
      44            NA, NA         NA    NA          NA, NA       NA         NA
      45            NA, NA         NA    NA          NA, NA       NA         NA
      46            NA, NA         NA    NA          NA, NA       NA       1.23
      47            NA, NA         NA    NA          NA, NA       NA         NA
      48            NA, NA         NA    NA          NA, NA       NA         NA
      49            NA, NA         NA    NA          NA, NA       NA         NA
      50            NA, NA         NA    NA          NA, NA       NA         NA
      51          1.6, 2.1         95  0.60        0.4, 0.8       95         NA
      52          1.2, 1.8         95  0.70        0.5, 1.0       95         NA
      53            NA, NA         NA    NA          NA, NA       NA         NA
      54            NA, NA         NA    NA          NA, NA       NA         NA
      55            NA, NA         NA    NA          NA, NA       NA         NA
      56            NA, NA         NA    NA          NA, NA       NA         NA
      57            NA, NA         NA    NA          NA, NA       NA         NA
      58            NA, NA         NA    NA          NA, NA       NA         NA
      59            NA, NA         NA    NA          NA, NA       NA         NA
      60            NA, NA         NA    NA          NA, NA       NA       1.35
      61            NA, NA         NA    NA          NA, NA       NA       1.68
      62            NA, NA         NA    NA          NA, NA       NA       1.50
      63            NA, NA         NA    NA          NA, NA       NA       1.24
      64            NA, NA         NA    NA          NA, NA       NA       1.25
      65            NA, NA         NA    NA          NA, NA       NA       1.24
      66            NA, NA         NA    NA          NA, NA       NA       1.81
      67            NA, NA         NA    NA          NA, NA       NA       1.82
      68            NA, NA         NA    NA          NA, NA       NA       1.04
      69            NA, NA         NA    NA          NA, NA       NA       1.35
      70            NA, NA         NA    NA          NA, NA       NA       1.66
      71            NA, NA         NA    NA          NA, NA       NA       1.67
      72            NA, NA         NA    NA          NA, NA       NA       1.50
         dispersion_ci_limits dispersion_ci precision precision_ci_limits
      1            1.13, 1.38            95        NA              NA, NA
      2            1.04, 1.08            95        NA              NA, NA
      3                NA, NA            NA        NA              NA, NA
      4                NA, NA            NA        NA              NA, NA
      5                NA, NA            NA        NA              NA, NA
      6            1.32, 1.72            95        NA              NA, NA
      7                NA, NA            NA        NA              NA, NA
      8                NA, NA            NA        NA              NA, NA
      9                NA, NA            NA        NA              NA, NA
      10               NA, NA            NA        NA              NA, NA
      11               NA, NA            NA        NA              NA, NA
      12               NA, NA            NA        NA              NA, NA
      13               NA, NA            NA        NA              NA, NA
      14               NA, NA            NA        NA              NA, NA
      15               NA, NA            NA        NA              NA, NA
      16               NA, NA            NA        NA              NA, NA
      17               NA, NA            NA        NA              NA, NA
      18               NA, NA            NA       4.9            2.8, 7.5
      19               NA, NA            NA      13.7          10.9, 16.9
      20           1.34, 1.50            95        NA              NA, NA
      21           1.27, 1.52            95        NA              NA, NA
      22               NA, NA            NA        NA              NA, NA
      23               NA, NA            NA        NA              NA, NA
      24               NA, NA            NA        NA              NA, NA
      25               NA, NA            NA        NA              NA, NA
      26               NA, NA            NA        NA              NA, NA
      27           1.07, 1.34            95        NA              NA, NA
      28               NA, NA            NA        NA              NA, NA
      29           1.43, 1.60            95        NA              NA, NA
      30           1.17, 1.29            95        NA              NA, NA
      31           1.37, 1.64            95        NA              NA, NA
      32               NA, NA            NA        NA              NA, NA
      33               NA, NA            NA        NA              NA, NA
      34               NA, NA            NA        NA              NA, NA
      35           1.44, 1.61            95        NA              NA, NA
      36           1.43, 1.60            95        NA              NA, NA
      37               NA, NA            NA        NA              NA, NA
      38               NA, NA            NA        NA              NA, NA
      39               NA, NA            NA        NA              NA, NA
      40               NA, NA            NA        NA              NA, NA
      41               NA, NA            NA        NA              NA, NA
      42               NA, NA            NA        NA              NA, NA
      43           1.04, 1.05            95        NA              NA, NA
      44               NA, NA            NA        NA              NA, NA
      45               NA, NA            NA        NA              NA, NA
      46           1.18, 1.28            95        NA              NA, NA
      47               NA, NA            NA        NA              NA, NA
      48               NA, NA            NA        NA              NA, NA
      49               NA, NA            NA        NA              NA, NA
      50               NA, NA            NA        NA              NA, NA
      51               NA, NA            NA        NA              NA, NA
      52               NA, NA            NA        NA              NA, NA
      53               NA, NA            NA        NA              NA, NA
      54               NA, NA            NA        NA              NA, NA
      55               NA, NA            NA        NA              NA, NA
      56               NA, NA            NA        NA              NA, NA
      57               NA, NA            NA        NA              NA, NA
      58               NA, NA            NA        NA              NA, NA
      59               NA, NA            NA        NA              NA, NA
      60           1.16, 1.55            95        NA              NA, NA
      61           1.36, 2.01            95        NA              NA, NA
      62           1.22, 1.82            95        NA              NA, NA
      63           1.13, 1.35            95        NA              NA, NA
      64           1.14, 1.36            95        NA              NA, NA
      65           1.12, 1.35            95        NA              NA, NA
      66           1.67, 1.95            95        NA              NA, NA
      67           1.27, 2.67            95        NA              NA, NA
      68           1.04, 1.29            95        NA              NA, NA
      69           1.12, 1.47            95        NA              NA, NA
      70           1.48, 1.82            95        NA              NA, NA
      71           1.47, 1.84            95        NA              NA, NA
      72             1.2, 1.9            95        NA              NA, NA
         precision_ci truncation discretised censored right_truncated
      1            NA         NA       FALSE     TRUE           FALSE
      2            NA         NA       FALSE     TRUE           FALSE
      3            NA         NA       FALSE    FALSE           FALSE
      4            NA         NA       FALSE     TRUE           FALSE
      5            NA         NA       FALSE    FALSE           FALSE
      6            NA         NA       FALSE     TRUE           FALSE
      7            NA         NA       FALSE     TRUE           FALSE
      8            NA         NA       FALSE     TRUE           FALSE
      9            NA         NA       FALSE     TRUE           FALSE
      10           NA         NA       FALSE     TRUE           FALSE
      11           NA         NA       FALSE     TRUE           FALSE
      12           NA         NA       FALSE     TRUE            TRUE
      13           NA         NA       FALSE    FALSE           FALSE
      14           NA         NA       FALSE    FALSE           FALSE
      15           NA         NA       FALSE    FALSE           FALSE
      16           NA         NA       FALSE    FALSE           FALSE
      17           NA         NA       FALSE     TRUE           FALSE
      18           95         NA       FALSE     TRUE           FALSE
      19           95         NA       FALSE     TRUE           FALSE
      20           NA         NA       FALSE     TRUE           FALSE
      21           NA         NA       FALSE     TRUE           FALSE
      22           NA         NA       FALSE    FALSE           FALSE
      23           NA         NA       FALSE     TRUE           FALSE
      24           NA         NA       FALSE     TRUE           FALSE
      25           NA         NA       FALSE     TRUE           FALSE
      26           NA         NA       FALSE     TRUE           FALSE
      27           NA         NA       FALSE     TRUE           FALSE
      28           NA         NA       FALSE     TRUE           FALSE
      29           NA         NA       FALSE     TRUE           FALSE
      30           NA         NA       FALSE     TRUE           FALSE
      31           NA         NA       FALSE     TRUE           FALSE
      32           NA         NA       FALSE     TRUE           FALSE
      33           NA         NA       FALSE     TRUE           FALSE
      34           NA         NA       FALSE     TRUE           FALSE
      35           NA         NA       FALSE     TRUE           FALSE
      36           NA         NA       FALSE     TRUE           FALSE
      37           NA         NA       FALSE    FALSE           FALSE
      38           NA         NA       FALSE     TRUE           FALSE
      39           NA         NA       FALSE     TRUE           FALSE
      40           NA         NA       FALSE     TRUE           FALSE
      41           NA         NA       FALSE     TRUE           FALSE
      42           NA         NA       FALSE     TRUE           FALSE
      43           NA         NA       FALSE     TRUE           FALSE
      44           NA         NA       FALSE    FALSE           FALSE
      45           NA         NA       FALSE    FALSE           FALSE
      46           NA         NA       FALSE     TRUE           FALSE
      47           NA         NA       FALSE     TRUE           FALSE
      48           NA         NA       FALSE     TRUE           FALSE
      49           NA         NA       FALSE     TRUE           FALSE
      50           NA         NA       FALSE    FALSE           FALSE
      51           NA         NA       FALSE    FALSE           FALSE
      52           NA         NA       FALSE    FALSE           FALSE
      53           NA         NA       FALSE    FALSE           FALSE
      54           NA         NA       FALSE    FALSE           FALSE
      55           NA         NA       FALSE    FALSE           FALSE
      56           NA         NA       FALSE    FALSE           FALSE
      57           NA         NA       FALSE    FALSE           FALSE
      58           NA         NA       FALSE    FALSE           FALSE
      59           NA         NA       FALSE    FALSE           FALSE
      60           NA         NA       FALSE     TRUE           FALSE
      61           NA         NA       FALSE     TRUE           FALSE
      62           NA         NA       FALSE     TRUE           FALSE
      63           NA         NA       FALSE     TRUE           FALSE
      64           NA         NA       FALSE     TRUE           FALSE
      65           NA         NA       FALSE     TRUE           FALSE
      66           NA         NA       FALSE     TRUE           FALSE
      67           NA         NA       FALSE     TRUE           FALSE
      68           NA         NA       FALSE     TRUE           FALSE
      69           NA         NA       FALSE     TRUE           FALSE
      70           NA         NA       FALSE     TRUE           FALSE
      71           NA         NA       FALSE     TRUE           FALSE
      72           NA         NA       FALSE     TRUE           FALSE
         phase_bias_adjusted
      1                FALSE
      2                FALSE
      3                FALSE
      4                FALSE
      5                FALSE
      6                 TRUE
      7                 TRUE
      8                 TRUE
      9                 TRUE
      10               FALSE
      11               FALSE
      12                TRUE
      13               FALSE
      14               FALSE
      15               FALSE
      16               FALSE
      17               FALSE
      18               FALSE
      19               FALSE
      20               FALSE
      21               FALSE
      22               FALSE
      23               FALSE
      24               FALSE
      25               FALSE
      26               FALSE
      27               FALSE
      28               FALSE
      29               FALSE
      30               FALSE
      31               FALSE
      32               FALSE
      33                TRUE
      34                TRUE
      35               FALSE
      36               FALSE
      37               FALSE
      38               FALSE
      39               FALSE
      40               FALSE
      41               FALSE
      42               FALSE
      43               FALSE
      44               FALSE
      45               FALSE
      46               FALSE
      47               FALSE
      48               FALSE
      49               FALSE
      50               FALSE
      51               FALSE
      52               FALSE
      53               FALSE
      54               FALSE
      55               FALSE
      56               FALSE
      57               FALSE
      58               FALSE
      59               FALSE
      60               FALSE
      61               FALSE
      62               FALSE
      63               FALSE
      64               FALSE
      65               FALSE
      66               FALSE
      67               FALSE
      68               FALSE
      69               FALSE
      70               FALSE
      71               FALSE
      72               FALSE
                                                                                                                                                                                                                                                                                                                                                                                                                                           notes
      1                                                                                                        Analysis on data from Commission on Acute Respiratory Disease. Experimental transmission of minor respiratory illness to human volunteers by filter-passing agents. I. Demonstration of two types of illness characterized by long and short incubation periods and diff erent clinical features. J Clin Invest 1947; 26: 957–82.
      2                                                                                                                                                                                                                                                                                                                                                  Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      3                                                                                                                                                                                                       This estimated mean incubation period is from a meta-analysis of 14 other incubation period estimates. Only the mean is reported and a distribution cannot be specified as the meta-mean is estimated from a random-effects model.
      4                                                                                                                                                                                                                                                                                                                                                                                                                      No additional notes
      5                                                                                                                                                                                                       This estimated mean incubation period is from a meta-analysis of 99 other incubation period estimates. Only the mean is reported and a distribution cannot be specified as the meta-mean is estimated from a random-effects model.
      6                                                                                                                                                                                                                                                                                                                                                                                                           This is the complete data set.
      7                                                                                                                                                                                                                                                                                 This is a subset of the data, including only those cases with a known onset of fever to be sure that the onset of symptoms is not from another pathogen.
      8                                                                                                                                                                                                                                                                                                                                          This is a subset of the data, including only cases that are detected outside of mainland China.
      9                                                                                                                                                                                                                                                                                                                                              This is a subset of the data, including only cases that are detected inside mainland China.
      10                                                                                                                                                                                                                                         This dataset excludes Wuhan residents (to have a more precise exposure interval). This method does not apply right-truncation, but does compare the gamma, weibull and lognormal distributions.
      11                                                                                                                                                                                                                                      This dataset includes Wuhan residents (which have a less precise exposure interval). This method does not apply right-truncation, but does compare the gamma, weibull and lognormal distributions.
      12                                                                                                                                                                                                                                                      This is excluding Wuhan residents from the dataset as this provides a more precise exposure interval. This method applies right-truncation but only fits a lognormal distribution.
      13                                                                                                                                                                                                                                           The incubation period parameters are estimated from a meta-analysis of other studies that estimated the incubation period using a lognormal distribution. This is the full set of data (N=9).
      14                                                                                                                                                                                The incubation period parameters are estimated from a meta-analysis of other studies that estimated the incubation period using a lognormal distribution. This is the data set with Backer removed as they did not have a defined exposure window (N=8).
      15                                                                                                                                                                                                                                                                                                          The estimate of the incubation period is from a non-parametric bootstrap approach that does not fit a parametric distribution.
      16                                                                                                                                                                                                      This estimated mean incubation period is from a meta-analysis of 15 other incubation period estimates. Only the mean is reported and a distribution cannot be specified as the meta-mean is estimated from a random-effects model.
      17                                                                                                                                                                                                                                                                                                                                                                              Extrinsic incubation period for data at 25 degrees celcius
      18                                                                                                                                                                                                                                                                                                                                                                              Extrinsic incubation period for data at 30 degrees celcius
      19                                                                                                                                                                                                                                                                                                                                    Standard deviation, meanlog and sdlog is taken from Siraj et al. 2017 <10.1371/journal.pntd.0005797>
      20                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      21                                                                                                                                                                                                                                                                       Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      22                                                                                                                                                                                                                                                 The paper reports lower and upper supported ranges for the mean and standard deviation but it is not clear if these are confidence intervals or not so are not included in the database
      23                                                                                                                                                                                                                     This data comes from the entire period of the Guinea ebola outbreak up to the point the paper was published (Dec 2013 - 25 Nov 2014). The methods fitting are reported in another paper: DOI: 10.1056/NEJMoa1411100
      24                                                                                                                                                                                                                    This data comes from the entire period of the Liberia ebola outbreak up to the point the paper was published (Dec 2013 - 25 Nov 2014). The methods fitting are reported in another paper: DOI: 10.1056/NEJMoa1411100
      25                                                                                                                                                                                                               This data comes from the entire period of the Seirra Leone ebola outbreak up to the point the paper was published (Dec 2013 - 25 Nov 2014). The methods fitting are reported in another paper: DOI: 10.1056/NEJMoa1411100
      26                                                                                                                                                                                  Data extracted from Appendix. This data comes from the entire period of the west africa ebola outbreak up to the point the paper was published (Dec 2013 - 25 Nov 2014). The methods fitting are reported in another paper: DOI: 10.1056/NEJMoa1411100
      27                                                                                                                                                                                                                                                                                         Analysis on data from  Bradburne AF, Bynoe ML, Tyrrell DA. Eff ects of a “new” human respiratory virus in volunteers. Br Med J 1967; 3: 767–69.
      28                                                                                                                                                                                                                                                                                                                                                                                                                     No additional notes
      29                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      30                                                                                                                                                                   These estimates for the incubation period of influenza A from Lessler et al. 2009 are different from the estimates from the complete data, as they remove Henle et al. 1945 J Immunol, as it is an outlier in the dataset (n=61). Values found at the bottom Table 3.
      31                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      32                                                                                                                                                                                                                                                                                                                                                                                                                    No additional notes.
      33                                                                                                                                                                                                                                                                                            Gamma and weibull distributions had equally good fit to the data. This entry is the gamma distribution. Gamma, exponential. Not open source.
      34                                                                                                                                                                                                                                                                                                          Gamma and weibull distributions had equally good fit to the data. This entry is the weibull distribution. Weibull, exponential
      35                                                                                                                                                                                                                                                                                                                                                   Data from Lessler et al 2009 using double interval-censored analysis. Not open source
      36                                                                                                                                                                                                                                                                                                                                                   Data from Lessler et al 2009 using single interval-censored analysis. Not open source
      37                                                                                                            The mid-point of the exposure time was used to approximate an exact exposure time instead of interval-censoring. This can lead to a possible bias (overestimation) in incubation times. It was ambiguously reported whether the mean is the mean of the distribution or the meanlog parameter of the lognormal distribution.
      38                                                                                                                                                                                                                                                                      This study used an original data set and a modified data set. This weibull distribution was fitted to the modified data set and it is recommended to use this one.
      39                                                                                                                                                                                                               This study used an original data set and a modified data set. This gamma distribution was fitted to the original data set and it is recommended to use the weibull distribution that was fitted to the modified data set.
      40                                                                                                                                                                                                        This study fit the weibull distribution to estimate the parameters for the complete data set, those who had a fatal outcome and those with a non-fatal outcome. This is the distribution fit to the complete unpartitioned data.
      41                                                                                                                                                                                                                 This study fit the weibull distribution to estimate the parameters for the complete data set, those who had a fatal outcome and those with a non-fatal outcome. This is the distribution fit to the fatal outcome data.
      42                                                                                                                                                                                                             This study fit the weibull distribution to estimate the parameters for the complete data set, those who had a fatal outcome and those with a non-fatal outcome. This is the distribution fit to the non-fatal outcome data.
      43                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      44 This paper did not fit a distribution to the incubation period data and only reported a lower and upper range of the data. This is present in the database as there are no other studies that report the incubation period for Marburg virus. There is another incubation period reported from the same paper for a subset of the data which report the median and interquartile range but again do not fit a distribution to the data.
      45                                                                                                        This paper did not fit a distribution to the incubation period data and only reported a median and range for a subset of the data. This is present in the database as there are no other studies that report the incubation period for Marburg virus. This paper also reports the maximum and minimum for the complete data set.
      46                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      47                                                                                                                                                                                            The sample size is not explicitly stated. The number of confirmed cases is 23 and there are 2 suspected cases, therefore it is not clear whether the 2 suspected cases were included in the estimation, the sample size is assumed to be 23.
      48                                                                                                                                                                                                                                                                                                                                                                                                                     No additional notes
      49                                                                                                                                                                                                                                                                                    Uses the methods described by Lessler (10.2471/BLT.16.174540) and Reich (10.1002/sim.3659). Estimated from time from exposure to first symptom onset
      50                                                                                                                                                                                                                                                                                                                                                                                                                     No additional notes
      51                                                                                                                                                                                                                                                                          Meanlog, sdlog, and fitted distribution from supplementary material. Uses cases from Charniga 2022 + extra cases. Incubation period as exposure to rash onset.
      52                                                                                                                                                                                                                                                                       Meanlog, sdlog, and fitted distribution from supplementary material. Uses cases from Charniga 2022 + extra cases. Incubation period as exposure to symptom onset.
      53                                                                                                                                                                                                                                                                                                                                                                                                                     No additional notes
      54                                                                                                                                                                                                                                                                                                                                                                                                                       Systematic review
      55                                                                                                                                                                                                                                                                                                                                                                                                                       Systematic review
      56                                                                                                                                                                                                                                                                                                                                                                                                                       Systematic review
      57                                                                                                                                                                                                                                                                                                                                        SEIR model from 10.1016/j.mbs.2008.06.005 where the IP is assumed to follow a gamma distribution
      58                                                                                                                                                                                                                                                                                                                                        SEIR model from 10.1016/j.mbs.2008.06.005 where the IP is assumed to follow a gamma distribution
      59                                                                                                                                                                                                                                                                                                                                        SEIR model from 10.1016/j.mbs.2008.06.005 where the IP is assumed to follow a gamma distribution
      60                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      61                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      62                                                                                                                                                                                                                                                                         Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. Of the 18 samples at least 17 of them are not trasmitted by mosquitoes
      63                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      64                                                                                                                                                                                                                                                                                                                                                   Data from Lessler et al 2009 using double interval-censored analysis. Not open source
      65                                                                                                                                                                                                                                                                                                                                                   Data from Lessler et al 2009 using single interval-censored analysis. Not open source
      66                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      67                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      68                                                                                                                                                                                                                                                                       Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      69                                                                                                                                                                                                                                                            Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only tramsission by transplant or transfusion. 
      70                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      71                                                                                                                                                                                                                                                                       Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      72                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2016 for references of datasets
             PMID                                     DOI
      1  19393959           10.1016/S1473-3099(09)70069-6
      2  24639305                   10.4269/ajtmh.13-0403
      3  33706702              10.1186/s12879-021-05950-x
      4  33362233            10.1371/journal.pone.0243889
      5  33548553              10.1016/j.ijid.2021.01.069
      6  32150748                        10.7326/M20-0504
      7  32150748                        10.7326/M20-0504
      8  32150748                        10.7326/M20-0504
      9  32150748                        10.7326/M20-0504
      10 32079150                      10.3390/jcm9020538
      11 32079150                      10.3390/jcm9020538
      12 32079150                      10.3390/jcm9020538
      13 32801208             10.1136/bmjopen-2020-039652
      14 32801208             10.1136/bmjopen-2020-039652
      15       NA             10.1101/2020.02.24.20027474
      16 33643779              10.1007/s10389-021-01478-1
      17 23226436            10.1371/journal.pone.0050972
      18 23226436            10.1371/journal.pone.0050972
      19 23226436            10.1371/journal.pone.0050972
      20 24639305                   10.4269/ajtmh.13-0403
      21 24639305                   10.4269/ajtmh.13-0403
      22 24159443              10.1016/j.phrp.2011.04.001
      23 25539446                    10.1056/NEJMc1414993
      24 25539446                    10.1056/NEJMc1414994
      25 25539446                    10.1056/NEJMc1414995
      26 25539446                    10.1056/NEJMc1414992
      27 19393959           10.1016/S1473-3099(09)70069-7
      28 20029668                10.1371/currents.RRN1130
      29 19393959           10.1016/S1473-3099(09)70069-9
      30 19393959          10.1016/S1473-3099(09)70069-10
      31 19393959          10.1016/S1473-3099(09)70069-11
      32 20042754                   10.1056/NEJMoa0906089
      33 21168422              10.1016/j.jtbi.2010.12.017
      34 21168422              10.1016/j.jtbi.2010.12.017
      35 19598148                        10.1002/sim.3659
      36 19598148                        10.1002/sim.3659
      37 19959592                     10.1503/cmaj.091807
      38 26409239                      10.1093/aje/kwv115
      39 26409239                      10.1093/aje/kwv115
      40 26885816            10.1371/journal.pone.0148506
      41 26885816            10.1371/journal.pone.0148506
      42 26885816            10.1371/journal.pone.0148506
      43 24639305                   10.4269/ajtmh.13-0403
      44 25495697                 10.1186/1756-0500-7-906
      45 25495697                 10.1186/1756-0500-7-906
      46 19393959          10.1016/S1473-3099(09)70069-12
      47 23782161                   10.1056/NEJMoa1306742
      48 26132767    10.2807/1560-7917.es2015.20.25.21163
      49       NA             10.1101/2022.06.22.22276713
      50 35994726                  10.3201/eid2810.221126
      51       NA             10.1101/2022.10.26.22281516
      52       NA             10.1101/2022.10.26.22281517
      53 35713026 10.2807/1560-7917.ES.2022.27.24.2200448
      54 36130210                     10.1093/jtm/taac107
      55 36130210                     10.1093/jtm/taac108
      56 36130210                     10.1093/jtm/taac109
      57 36573222              10.1016/j.jobb.2022.12.001
      58 36573222              10.1016/j.jobb.2022.12.002
      59 36573222              10.1016/j.jobb.2022.12.003
      60 19393959          10.1016/S1473-3099(09)70069-13
      61 19393959          10.1016/S1473-3099(09)70069-15
      62 24639305                   10.4269/ajtmh.13-0403
      63 19393959          10.1016/S1473-3099(09)70069-14
      64 19598148                        10.1002/sim.3659
      65 19598148                        10.1002/sim.3659
      66 19393959           10.1016/S1473-3099(09)70069-8
      67 24639305                   10.4269/ajtmh.13-0403
      68 24639305                   10.4269/ajtmh.13-0403
      69 24639305                   10.4269/ajtmh.13-0403
      70 24639305                   10.4269/ajtmh.13-0403
      71 24639305                   10.4269/ajtmh.13-0403
      72 27821887                   10.2471/BLT.16.174540

# list_distributions works for different distribution

    Code
      list_distributions(epiparam = eparam, epi_dist = "serial_interval")
    Output
                       disease epi_distribution prob_distribution
      1               COVID-19  serial_interval              <NA>
      2    Ebola Virus Disease  serial_interval             gamma
      3    Ebola Virus Disease  serial_interval             gamma
      4    Ebola Virus Disease  serial_interval             gamma
      5    Ebola Virus Disease  serial_interval             gamma
      6              Influenza  serial_interval             gamma
      7  Marburg Virus Disease  serial_interval             gamma
      8  Marburg Virus Disease  serial_interval              <NA>
      9                   MERS  serial_interval             lnorm
      10                  MERS  serial_interval             gamma
      11                  Mpox  serial_interval             gamma
      12                  Mpox  serial_interval             gamma
      13                  Mpox  serial_interval             gamma
      14                  Mpox  serial_interval              <NA>
      15                  Mpox  serial_interval              <NA>
                          author year sample_size
      1               Alene_etal 2021        3924
      2  WHO_Ebola_Response_Team 2015         305
      3  WHO_Ebola_Response_Team 2015          37
      4  WHO_Ebola_Response_Team 2015         147
      5  WHO_Ebola_Response_Team 2015         112
      6               Ghani_etal 2009          58
      7            Ajelli_Merler 2012         374
      8                   Pavlin 2014          38
      9              Assiri_etal 2013          23
      10            Cowling_etal 2015          99
      11                Guo_etal 2022          42
      12           Madewell_etal 2022          57
      13           Madewell_etal 2022          40
      14               Wang_etal 2022          16
      15               Wang_etal 2022          34

# list_distributions works for different dist, subset_db = FALSE

    Code
      list_distributions(epiparam = eparam, epi_dist = "serial_interval", subset_db = FALSE)
    Output
                       disease            pathogen epi_distribution
      1               COVID-19          SARS-CoV-2  serial_interval
      2    Ebola Virus Disease         Ebola Virus  serial_interval
      3    Ebola Virus Disease         Ebola Virus  serial_interval
      4    Ebola Virus Disease         Ebola Virus  serial_interval
      5    Ebola Virus Disease         Ebola Virus  serial_interval
      6              Influenza Influenza-A-H1N1Pdm  serial_interval
      7  Marburg Virus Disease       Marburg Virus  serial_interval
      8  Marburg Virus Disease       Marburg Virus  serial_interval
      9                   MERS            MERS-Cov  serial_interval
      10                  MERS            MERS-Cov  serial_interval
      11                  Mpox          Mpox Virus  serial_interval
      12                  Mpox          Mpox Virus  serial_interval
      13                  Mpox          Mpox Virus  serial_interval
      14                  Mpox  Mpox Virus Clade I  serial_interval
      15                  Mpox          Mpox Virus  serial_interval
                          author
      1               Alene_etal
      2  WHO_Ebola_Response_Team
      3  WHO_Ebola_Response_Team
      4  WHO_Ebola_Response_Team
      5  WHO_Ebola_Response_Team
      6               Ghani_etal
      7            Ajelli_Merler
      8                   Pavlin
      9              Assiri_etal
      10            Cowling_etal
      11                Guo_etal
      12           Madewell_etal
      13           Madewell_etal
      14               Wang_etal
      15               Wang_etal
                                                                                                                            title
      1                                  Serial interval and incubation period of COVID-19: a systematic review and meta-analysis
      2                                            West African Ebola Epidemic after One Year — Slowing but Not Yet under Control
      3                                            West African Ebola Epidemic after One Year — Slowing but Not Yet under Control
      4                                            West African Ebola Epidemic after One Year — Slowing but Not Yet under Control
      5                                            West African Ebola Epidemic after One Year — Slowing but Not Yet under Control
      6                                                The Early Transmission Dynamics of H1N1pdm Influenza in the United Kingdom
      7                              Transmission Potential and Design of Adequate Control Measures for Marburg Hemorrhagic Fever
      8                     Calculation of incubation period and serial interval from multiple outbreaks of Marburg virus disease
      9                                                         Hospital Outbreak of Middle East Respiratory Syndrome Coronavirus
      10                             Preliminary epidemiological assessment of MERS-CoV outbreak in South Korea, May to June 2016
      11                                         Estimation of the serial interval of monkeypox during the early outbreak in 2022
      12 Serial interval and incubation period estimates of monkeypox virus infection in 12 U.S. jurisdictions, May – August 2024
      13 Serial interval and incubation period estimates of monkeypox virus infection in 12 U.S. jurisdictions, May – August 2025
      14                                                    Serial intervals and incubation periods of the monkeypox virus clades
      15                                                    Serial intervals and incubation periods of the monkeypox virus clades
                                     journal year sample_size       region
      1              BMC Infectious Diseases 2021        3924        Mixed
      2  The New England Journal of Medicine 2015         305  West Africa
      3  The New England Journal of Medicine 2015          37       Guinea
      4  The New England Journal of Medicine 2015         147      Liberia
      5  The New England Journal of Medicine 2015         112 Sierra Leone
      6                        PLoS Currents 2009          58           UK
      7                             PLoS One 2012         374       Angola
      8                   BMC Research Notes 2014          38        Mixed
      9  The New England Journal of Medicine 2013          23 Saudi Arabia
      10                    Eurosurveillance 2015          99  South Korea
      11         Journal of Medical Virology 2022          42        Mixed
      12                             medRxiv 2022          57          USA
      13                             medRxiv 2022          40          USA
      14          Journal of Travel Medicine 2022          16        Congo
      15          Journal of Travel Medicine 2022          34        Mixed
                      transmission_mode vector extrinsic prob_distribution
      1  natural_natural_human_to_human   <NA>     FALSE              <NA>
      2  natural_natural_human_to_human   <NA>     FALSE             gamma
      3  natural_natural_human_to_human   <NA>     FALSE             gamma
      4  natural_natural_human_to_human   <NA>     FALSE             gamma
      5  natural_natural_human_to_human   <NA>     FALSE             gamma
      6                 natural_unknown   <NA>     FALSE             gamma
      7                 natural_unknown   <NA>     FALSE             gamma
      8                           mixed   <NA>     FALSE              <NA>
      9  natural_natural_human_to_human   <NA>     FALSE             lnorm
      10                natural_unknown   <NA>     FALSE             gamma
      11                          mixed   <NA>     FALSE             gamma
      12 natural_natural_human_to_human   <NA>     FALSE             gamma
      13 natural_natural_human_to_human   <NA>     FALSE             gamma
      14                natural_unknown   <NA>     FALSE              <NA>
      15                natural_unknown   <NA>     FALSE              <NA>
         inference_method  mean mean_ci_limits mean_ci    sd sd_ci_limits sd_ci
      1              <NA>  5.20       4.9, 5.5      95    NA       NA, NA    NA
      2               mle 14.20     13.1, 15.3      95  9.60    8.6, 10.7    95
      3               mle 15.50     13.4, 18.1      95  7.00     5.5, 9.4    95
      4               mle 15.10     13.5, 16.9      95 10.50    9.1, 12.5    95
      5               mle 12.40     10.8, 14.2      95  9.00    7.5, 10.9    95
      6               mle  2.51         NA, NA      NA  1.55       NA, NA    NA
      7              <NA>  9.00      8.2, 10.0      95  5.40     3.9, 8.6    95
      8              <NA>    NA         NA, NA      NA    NA       NA, NA    NA
      9               mle    NA         NA, NA      NA    NA       NA, NA    NA
      10         bayesian 12.60     12.1, 13.1      95  2.80     2.4, 3.1    95
      11         bayesian  5.60      1.7, 10.4      95  1.50     0.4, 2.4    95
      12         bayesian  8.50       7.3, 9.9      95  5.00     4.0, 6.4    95
      13         bayesian  7.00       5.8, 8.4      95  4.20     3.2, 5.6    95
      14             <NA>    NA         NA, NA      NA    NA       NA, NA    NA
      15             <NA>    NA         NA, NA      NA    NA       NA, NA    NA
         quantile_2.5 quantile_5 quantile_25 median median_ci_limits median_ci
      1            NA         NA          NA     NA           NA, NA        NA
      2            NA         NA          NA     NA           NA, NA        NA
      3            NA         NA          NA     NA           NA, NA        NA
      4            NA         NA          NA     NA           NA, NA        NA
      5            NA         NA          NA     NA           NA, NA        NA
      6            NA         NA          NA     NA           NA, NA        NA
      7            NA         NA          NA     NA           NA, NA        NA
      8            NA         NA        8.00  11.00           NA, NA        NA
      9            NA          3          NA   7.60        2.5, 23.1        NA
      10           NA         NA          NA     NA           NA, NA        NA
      11           NA         NA          NA   5.50        1.4, 10.4        95
      12           NA         NA          NA     NA           NA, NA        NA
      13           NA         NA          NA     NA           NA, NA        NA
      14           NA         NA        9.28   9.67           NA, NA        NA
      15           NA         NA        8.90   9.78           NA, NA        NA
         quantile_75 quantile_87.5 quantile_95 quantile_97.5 lower_range upper_range
      1           NA            NA          NA            NA          NA          NA
      2           NA            NA          NA            NA          NA          NA
      3           NA            NA          NA            NA          NA          NA
      4           NA            NA          NA            NA          NA          NA
      5           NA            NA          NA            NA          NA          NA
      6           NA            NA          NA            NA          NA          NA
      7           NA            NA          NA            NA          NA          NA
      8        15.00            NA          NA            NA          NA          NA
      9           NA            NA        19.4            NA          NA          NA
      10          NA            NA          NA            NA          NA          NA
      11          NA            NA         8.3            NA          NA          NA
      12          NA            NA          NA            NA          NA          NA
      13          NA            NA          NA            NA          NA          NA
      14       10.05            NA          NA            NA          NA          NA
      15       10.67            NA          NA            NA          NA          NA
         shape shape_ci_limits shape_ci scale scale_ci_limits scale_ci meanlog
      1     NA          NA, NA       NA    NA          NA, NA       NA      NA
      2     NA          NA, NA       NA    NA          NA, NA       NA      NA
      3     NA          NA, NA       NA    NA          NA, NA       NA      NA
      4     NA          NA, NA       NA    NA          NA, NA       NA      NA
      5     NA          NA, NA       NA    NA          NA, NA       NA      NA
      6     NA          NA, NA       NA    NA          NA, NA       NA      NA
      7     NA          NA, NA       NA    NA          NA, NA       NA      NA
      8     NA          NA, NA       NA    NA          NA, NA       NA      NA
      9     NA          NA, NA       NA    NA          NA, NA       NA      NA
      10    NA          NA, NA       NA    NA          NA, NA       NA      NA
      11    NA          NA, NA       NA    NA          NA, NA       NA      NA
      12   2.9        2.0, 4.1       95   2.9        2.0, 4.4       95      NA
      13   2.8        1.8, 4.2       95   2.5        2.5, 4.0       95      NA
      14    NA          NA, NA       NA    NA          NA, NA       NA      NA
      15    NA          NA, NA       NA    NA          NA, NA       NA      NA
         meanlog_ci_limits meanlog_ci sdlog sdlog_ci_limits sdlog_ci dispersion
      1             NA, NA         NA    NA          NA, NA       NA         NA
      2             NA, NA         NA    NA          NA, NA       NA         NA
      3             NA, NA         NA    NA          NA, NA       NA         NA
      4             NA, NA         NA    NA          NA, NA       NA         NA
      5             NA, NA         NA    NA          NA, NA       NA         NA
      6             NA, NA         NA    NA          NA, NA       NA         NA
      7             NA, NA         NA    NA          NA, NA       NA         NA
      8             NA, NA         NA    NA          NA, NA       NA         NA
      9             NA, NA         NA    NA          NA, NA       NA         NA
      10            NA, NA         NA    NA          NA, NA       NA         NA
      11            NA, NA         NA    NA          NA, NA       NA         NA
      12            NA, NA         NA    NA          NA, NA       NA         NA
      13            NA, NA         NA    NA          NA, NA       NA         NA
      14            NA, NA         NA    NA          NA, NA       NA         NA
      15            NA, NA         NA    NA          NA, NA       NA         NA
         dispersion_ci_limits dispersion_ci precision precision_ci_limits
      1                NA, NA            NA        NA              NA, NA
      2                NA, NA            NA        NA              NA, NA
      3                NA, NA            NA        NA              NA, NA
      4                NA, NA            NA        NA              NA, NA
      5                NA, NA            NA        NA              NA, NA
      6                NA, NA            NA        NA              NA, NA
      7                NA, NA            NA        NA              NA, NA
      8                NA, NA            NA        NA              NA, NA
      9                NA, NA            NA        NA              NA, NA
      10               NA, NA            NA        NA              NA, NA
      11               NA, NA            NA        NA              NA, NA
      12               NA, NA            NA        NA              NA, NA
      13               NA, NA            NA        NA              NA, NA
      14               NA, NA            NA        NA              NA, NA
      15               NA, NA            NA        NA              NA, NA
         precision_ci truncation discretised censored right_truncated
      1            NA         NA       FALSE    FALSE           FALSE
      2            NA         NA       FALSE    FALSE           FALSE
      3            NA         NA       FALSE    FALSE           FALSE
      4            NA         NA       FALSE    FALSE           FALSE
      5            NA         NA       FALSE    FALSE           FALSE
      6            NA         NA       FALSE     TRUE           FALSE
      7            NA         NA       FALSE    FALSE           FALSE
      8            NA         NA       FALSE    FALSE           FALSE
      9            NA         NA       FALSE     TRUE           FALSE
      10           NA         NA       FALSE     TRUE           FALSE
      11           NA         NA       FALSE    FALSE            TRUE
      12           NA         NA       FALSE    FALSE           FALSE
      13           NA         NA       FALSE    FALSE           FALSE
      14           NA         NA       FALSE    FALSE           FALSE
      15           NA         NA       FALSE    FALSE           FALSE
         phase_bias_adjusted
      1                FALSE
      2                FALSE
      3                FALSE
      4                FALSE
      5                FALSE
      6                FALSE
      7                FALSE
      8                FALSE
      9                FALSE
      10               FALSE
      11                TRUE
      12               FALSE
      13               FALSE
      14               FALSE
      15               FALSE
                                                                                                                                                                                                                                                                                                                                     notes
      1                                                                                                     This estimated mean serial interval is from a meta-analysis of 23 other serial interval estimates. Only the mean is reported and a distribution cannot be specified as the meta-mean is estimated from a random-effects model.
      2                                                                                                           This data comes from the entire period of the west africa ebola outbreak up to the point the paper was published (Dec 2013 - 25 Nov 2014). The methods fitting are reported in another paper: DOI: 10.1056/NEJMoa1411100
      3                                                                                                                This data comes from the entire period of the Guinea ebola outbreak up to the point the paper was published (Dec 2013 - 25 Nov 2014). The methods fitting are reported in another paper: DOI: 10.1056/NEJMoa1411100
      4                                                                                                               This data comes from the entire period of the Liberia ebola outbreak up to the point the paper was published (Dec 2013 - 25 Nov 2014). The methods fitting are reported in another paper: DOI: 10.1056/NEJMoa1411100
      5                                                                                                          This data comes from the entire period of the Sierra Leone ebola outbreak up to the point the paper was published (Dec 2013 - 25 Nov 2014). The methods fitting are reported in another paper: DOI: 10.1056/NEJMoa1411100
      6                                                                                                                                                                                                                                                                                                                No additional notes
      7  The generation time is estimated from non-human viral load data. This paper reports the generation time but assumes the generation time and serial interval are the same it is classified as serial interval here based on Van Kerkove et al. 2015 <10.1038/sdata.2015.19>. The sample size is take from Van Kerkove et al. 2015.
      8                                                                                             This paper did not fit a distribution to the serial interval data and only reported a median and interquartile range. This is present in the database as there are no other studies that report the serial interval for Marburg virus.
      9                                                                                       The sample size is not explicitly stated. The number of confirmed cases is 23 and there are 2 suspected cases, therefore it is not clear whether the 2 suspected cases were included in the estimation, the sample size is assumed to be 23.
      10                                                                                                                                                                                                                                                                                                               No additional notes
      11                                                                                                                                                                                                                                                                             Data from Kraemer et al 10.1016/S1473-3099(22)00359-0
      12                                                                                                                                                                                                                                                 Shape and scale from supp. material. Serial interval as exposure to symptom onset
      13                                                                                                                                                                                                                                                    Shape and scale from supp. material. Serial interval as exposure to rash onset
      14                                                                                                                                                                                                                                                                                                                 Systematic review
      15                                                                                                                                                                                                                                                                                                                 Systematic review
             PMID                                  DOI
      1  33706702           10.1186/s12879-021-05950-x
      2  25539446                 10.1056/NEJMc1414992
      3  25539446                 10.1056/NEJMc1414992
      4  25539446                 10.1056/NEJMc1414992
      5  25539446                 10.1056/NEJMc1414992
      6  20029668             10.1371/currents.RRN1130
      7  23251407         10.1371/journal.pone.0050948
      8  25495697              10.1186/1756-0500-7-906
      9  23782161                10.1056/NEJMoa1306742
      10 26132767 10.2807/1560-7917.es2015.20.25.21163
      11 36271480                    10.1002/jmv.28248
      12       NA          10.1101/2022.10.26.22281518
      13       NA          10.1101/2022.10.26.22281519
      14 36130210                  10.1093/jtm/taac105
      15 36130210                  10.1093/jtm/taac106
