# parameter_tbl works as expected supplied with db

    Code
      dist_tbl
    Output
                                disease             epi_distribution
      1                      Adenovirus            incubation period
      2               Human Coronavirus            incubation period
      3                            SARS            incubation period
      4                       Influenza            incubation period
      5                       Influenza            incubation period
      6                       Influenza            incubation period
      7                         Measles            incubation period
      8                   Parainfluenza            incubation period
      9                             RSV            incubation period
      10                     Rhinovirus            incubation period
      11                      Influenza            incubation period
      12                      Influenza            incubation period
      13                            RSV            incubation period
      14                            RSV            incubation period
      15                      Influenza            incubation period
      16                      Influenza            incubation period
      17                      Influenza            incubation period
      18                      Influenza            incubation period
      19                      Influenza            incubation period
      20                      Influenza            incubation period
      21                      Influenza            incubation period
      22                      Influenza            incubation period
      23                      Influenza            incubation period
      24                      Influenza              serial interval
      25                      Influenza            incubation period
      26                      Influenza              generation time
      27          Marburg Virus Disease            incubation period
      28          Marburg Virus Disease            incubation period
      29          Marburg Virus Disease              serial interval
      30          Marburg Virus Disease               onset to death
      31          Marburg Virus Disease              serial interval
      32                           SARS       offspring distribution
      33                           SARS       offspring distribution
      34                       Smallpox       offspring distribution
      35                       Smallpox       offspring distribution
      36                       Smallpox       offspring distribution
      37                       Smallpox       offspring distribution
      38                           Mpox       offspring distribution
      39               Pneumonic Plague       offspring distribution
      40  Hantavirus Pulmonary Syndrome       offspring distribution
      41            Ebola Virus Disease       offspring distribution
      42                         Dengue            incubation period
      43                         Dengue            incubation period
      44                         Dengue            incubation period
      45             Zika Virus Disease            incubation period
      46                    Chikungunya            incubation period
      47                         Dengue            incubation period
      48                         Dengue            incubation period
      49          Japanese Encephalitis            incubation period
      50              Rift Valley Fever            incubation period
      51                West Nile Fever            incubation period
      52                West Nile Fever            incubation period
      53                West Nile Fever            incubation period
      54                   Yellow Fever            incubation period
      55                   Yellow Fever            incubation period
      56                           Mpox            incubation period
      57                           Mpox            incubation period
      58                           Mpox            incubation period
      59                           Mpox            incubation period
      60                           Mpox            incubation period
      61                           Mpox              serial interval
      62                           Mpox              serial interval
      63            Ebola Virus Disease            incubation period
      64            Ebola Virus Disease               onset to death
      65            Ebola Virus Disease            incubation period
      66            Ebola Virus Disease            incubation period
      67            Ebola Virus Disease            incubation period
      68            Ebola Virus Disease            incubation period
      69            Ebola Virus Disease              serial interval
      70            Ebola Virus Disease              serial interval
      71            Ebola Virus Disease              serial interval
      72            Ebola Virus Disease              serial interval
      73            Ebola Virus Disease     hospitalisation to death
      74            Ebola Virus Disease hospitalisation to discharge
      75            Ebola Virus Disease        notification to death
      76            Ebola Virus Disease    notification to discharge
      77            Ebola Virus Disease               onset to death
      78            Ebola Virus Disease           onset to discharge
      79                           MERS            incubation period
      80                           MERS              serial interval
      81                           MERS     onset to hospitalisation
      82                           MERS               onset to death
      83                           MERS         onset to ventilation
      84                           MERS               onset to death
      85                           MERS            incubation period
      86                           MERS              serial interval
      87                       COVID-19            incubation period
      88                       COVID-19            incubation period
      89                       COVID-19            incubation period
      90                       COVID-19              serial interval
      91                       COVID-19              serial interval
      92                       COVID-19              serial interval
      93                       COVID-19            incubation period
      94                       COVID-19              serial interval
      95                       COVID-19            incubation period
      96                       COVID-19            incubation period
      97                       COVID-19            incubation period
      98                       COVID-19            incubation period
      99                       COVID-19            incubation period
      100                      COVID-19            incubation period
      101                      COVID-19     onset to hospitalisation
      102                      COVID-19     onset to hospitalisation
      103                      COVID-19               onset to death
      104                      COVID-19     hospitalisation to death
      105                      COVID-19            incubation period
      106                      COVID-19     onset to hospitalisation
      107                      COVID-19     onset to hospitalisation
      108                      COVID-19               onset to death
      109                      COVID-19     hospitalisation to death
      110                      COVID-19            incubation period
      111                      COVID-19            incubation period
      112                      COVID-19            incubation period
      113                      COVID-19            incubation period
      114                          Mpox              serial interval
      115                          Mpox              serial interval
      116                          Mpox              serial interval
      117                          Mpox            incubation period
      118                          Mpox            incubation period
      119                          Mpox            incubation period
      120                          Mpox            incubation period
      121                          Mpox            incubation period
      122                          Mpox            incubation period
          prob_distribution       author year
      1               lnorm Justin L.... 2009
      2               lnorm Justin L.... 2009
      3               lnorm Justin L.... 2009
      4               lnorm Justin L.... 2009
      5               lnorm Justin L.... 2009
      6               lnorm Justin L.... 2009
      7               lnorm Justin L.... 2009
      8               lnorm Justin L.... 2009
      9               lnorm Justin L.... 2009
      10              lnorm Justin L.... 2009
      11              lnorm Nicholas.... 2009
      12              lnorm Nicholas.... 2009
      13              lnorm Nicholas.... 2009
      14              lnorm Nicholas.... 2009
      15              gamma Hiroshi .... 2011
      16            weibull Hiroshi .... 2011
      17            weibull Victor V.... 2015
      18              gamma Victor V.... 2015
      19            weibull Victor V.... 2016
      20            weibull Victor V.... 2016
      21            weibull Victor V.... 2016
      22              lnorm Ashleigh.... 2010
      23              gamma Azra Gha.... 2009
      24              gamma Azra Gha.... 2009
      25              lnorm Justin L.... 2009
      26            weibull Justin L.... 2009
      27               <NA> Boris I..... 2014
      28               <NA> Boris I..... 2014
      29               <NA> Boris I..... 2014
      30               <NA> Robert C.... 2007
      31              gamma Marco Aj.... 2012
      32             nbinom J. O. Ll.... 2005
      33             nbinom J. O. Ll.... 2005
      34             nbinom J. O. Ll.... 2005
      35             nbinom J. O. Ll.... 2005
      36             nbinom J. O. Ll.... 2005
      37             nbinom J. O. Ll.... 2005
      38             nbinom J. O. Ll.... 2005
      39             nbinom J. O. Ll.... 2005
      40             nbinom J. O. Ll.... 2005
      41             nbinom J. O. Ll.... 2005
      42              lnorm Miranda .... 2012
      43              lnorm Miranda .... 2012
      44              lnorm Miranda .... 2012
      45              lnorm Justin L.... 2016
      46              lnorm Kara E. .... 2014
      47              lnorm Kara E. .... 2014
      48              lnorm Kara E. .... 2014
      49              lnorm Kara E. .... 2014
      50              lnorm Kara E. .... 2014
      51              lnorm Kara E. .... 2014
      52              lnorm Kara E. .... 2014
      53              lnorm Kara E. .... 2014
      54              lnorm Kara E. .... 2014
      55              lnorm Kara E. .... 2014
      56              lnorm Fuminari.... 2022
      57              lnorm Kelly Ch.... 2022
      58              gamma Giorgio .... 2022
      59              lnorm Zachary .... 2022
      60              lnorm Zachary .... 2022
      61              gamma Zachary .... 2022
      62              gamma Zachary .... 2022
      63              lnorm Martin E.... 2011
      64              gamma The Ebol.... 2018
      65              gamma WHO Ebol.... 2015
      66              gamma WHO Ebol.... 2015
      67              gamma WHO Ebol.... 2015
      68              gamma WHO Ebol.... 2015
      69              gamma WHO Ebol.... 2015
      70              gamma WHO Ebol.... 2015
      71              gamma WHO Ebol.... 2015
      72              gamma WHO Ebol.... 2015
      73              gamma WHO Ebol.... 2015
      74              gamma WHO Ebol.... 2015
      75              gamma WHO Ebol.... 2015
      76              gamma WHO Ebol.... 2015
      77              gamma WHO Ebol.... 2015
      78              gamma WHO Ebol.... 2015
      79              lnorm Abdullah.... 2013
      80              lnorm Abdullah.... 2013
      81               <NA> Abdullah.... 2013
      82               <NA> Abdullah.... 2013
      83               <NA> Abdullah.... 2013
      84              gamma Kenji Mi.... 2015
      85              gamma B. J. Co.... 2015
      86              gamma B. J. Co.... 2015
      87               <NA> Ke Men, .... 2020
      88               <NA> Balram R.... 2022
      89               <NA> Muluneh .... 2021
      90               <NA> Muluneh .... 2021
      91              lnorm Hiroshi .... 2020
      92            weibull Hiroshi .... 2020
      93            weibull Lin Yang.... 2020
      94               norm Lin Yang.... 2020
      95               <NA> Christel.... 2021
      96            weibull Long V. .... 2020
      97              lnorm Conor Mc.... 2020
      98              lnorm Conor Mc.... 2020
      99              lnorm Natalie .... 2020
      100             lnorm Natalie .... 2020
      101             gamma Natalie .... 2020
      102             gamma Natalie .... 2020
      103             lnorm Natalie .... 2020
      104           weibull Natalie .... 2020
      105             lnorm Natalie .... 2020
      106             lnorm Natalie .... 2020
      107             lnorm Natalie .... 2020
      108             lnorm Natalie .... 2020
      109             lnorm Natalie .... 2020
      110             lnorm Stephen .... 2020
      111             lnorm Stephen .... 2020
      112             lnorm Stephen .... 2020
      113             lnorm Stephen .... 2020
      114             gamma Zihao Gu.... 2022
      115              <NA> Shuqi Wa.... 2022
      116              <NA> Shuqi Wa.... 2022
      117              <NA> Shuqi Wa.... 2022
      118              <NA> Shuqi Wa.... 2022
      119              <NA> Shuqi Wa.... 2022
      120              <NA> Fengying.... 2022
      121              <NA> Fengying.... 2022
      122              <NA> Fengying.... 2022

# parameter_tbl works for incubation period with db

    Code
      incub_tbl
    Output
                       disease  epi_distribution prob_distribution       author year
      1             Adenovirus incubation period             lnorm Justin L.... 2009
      2      Human Coronavirus incubation period             lnorm Justin L.... 2009
      3                   SARS incubation period             lnorm Justin L.... 2009
      4              Influenza incubation period             lnorm Justin L.... 2009
      5              Influenza incubation period             lnorm Justin L.... 2009
      6              Influenza incubation period             lnorm Justin L.... 2009
      7                Measles incubation period             lnorm Justin L.... 2009
      8          Parainfluenza incubation period             lnorm Justin L.... 2009
      9                    RSV incubation period             lnorm Justin L.... 2009
      10            Rhinovirus incubation period             lnorm Justin L.... 2009
      11             Influenza incubation period             lnorm Nicholas.... 2009
      12             Influenza incubation period             lnorm Nicholas.... 2009
      13                   RSV incubation period             lnorm Nicholas.... 2009
      14                   RSV incubation period             lnorm Nicholas.... 2009
      15             Influenza incubation period             gamma Hiroshi .... 2011
      16             Influenza incubation period           weibull Hiroshi .... 2011
      17             Influenza incubation period           weibull Victor V.... 2015
      18             Influenza incubation period             gamma Victor V.... 2015
      19             Influenza incubation period           weibull Victor V.... 2016
      20             Influenza incubation period           weibull Victor V.... 2016
      21             Influenza incubation period           weibull Victor V.... 2016
      22             Influenza incubation period             lnorm Ashleigh.... 2010
      23             Influenza incubation period             gamma Azra Gha.... 2009
      24             Influenza incubation period             lnorm Justin L.... 2009
      25 Marburg Virus Disease incubation period              <NA> Boris I..... 2014
      26 Marburg Virus Disease incubation period              <NA> Boris I..... 2014
      27                Dengue incubation period             lnorm Miranda .... 2012
      28                Dengue incubation period             lnorm Miranda .... 2012
      29                Dengue incubation period             lnorm Miranda .... 2012
      30    Zika Virus Disease incubation period             lnorm Justin L.... 2016
      31           Chikungunya incubation period             lnorm Kara E. .... 2014
      32                Dengue incubation period             lnorm Kara E. .... 2014
      33                Dengue incubation period             lnorm Kara E. .... 2014
      34 Japanese Encephalitis incubation period             lnorm Kara E. .... 2014
      35     Rift Valley Fever incubation period             lnorm Kara E. .... 2014
      36       West Nile Fever incubation period             lnorm Kara E. .... 2014
      37       West Nile Fever incubation period             lnorm Kara E. .... 2014
      38       West Nile Fever incubation period             lnorm Kara E. .... 2014
      39          Yellow Fever incubation period             lnorm Kara E. .... 2014
      40          Yellow Fever incubation period             lnorm Kara E. .... 2014
      41                  Mpox incubation period             lnorm Fuminari.... 2022
      42                  Mpox incubation period             lnorm Kelly Ch.... 2022
      43                  Mpox incubation period             gamma Giorgio .... 2022
      44                  Mpox incubation period             lnorm Zachary .... 2022
      45                  Mpox incubation period             lnorm Zachary .... 2022
      46   Ebola Virus Disease incubation period             lnorm Martin E.... 2011
      47   Ebola Virus Disease incubation period             gamma WHO Ebol.... 2015
      48   Ebola Virus Disease incubation period             gamma WHO Ebol.... 2015
      49   Ebola Virus Disease incubation period             gamma WHO Ebol.... 2015
      50   Ebola Virus Disease incubation period             gamma WHO Ebol.... 2015
      51                  MERS incubation period             lnorm Abdullah.... 2013
      52                  MERS incubation period             gamma B. J. Co.... 2015
      53              COVID-19 incubation period              <NA> Ke Men, .... 2020
      54              COVID-19 incubation period              <NA> Balram R.... 2022
      55              COVID-19 incubation period              <NA> Muluneh .... 2021
      56              COVID-19 incubation period           weibull Lin Yang.... 2020
      57              COVID-19 incubation period              <NA> Christel.... 2021
      58              COVID-19 incubation period           weibull Long V. .... 2020
      59              COVID-19 incubation period             lnorm Conor Mc.... 2020
      60              COVID-19 incubation period             lnorm Conor Mc.... 2020
      61              COVID-19 incubation period             lnorm Natalie .... 2020
      62              COVID-19 incubation period             lnorm Natalie .... 2020
      63              COVID-19 incubation period             lnorm Natalie .... 2020
      64              COVID-19 incubation period             lnorm Stephen .... 2020
      65              COVID-19 incubation period             lnorm Stephen .... 2020
      66              COVID-19 incubation period             lnorm Stephen .... 2020
      67              COVID-19 incubation period             lnorm Stephen .... 2020
      68                  Mpox incubation period              <NA> Shuqi Wa.... 2022
      69                  Mpox incubation period              <NA> Shuqi Wa.... 2022
      70                  Mpox incubation period              <NA> Shuqi Wa.... 2022
      71                  Mpox incubation period              <NA> Fengying.... 2022
      72                  Mpox incubation period              <NA> Fengying.... 2022
      73                  Mpox incubation period              <NA> Fengying.... 2022

# parameter_tbl works for different distribution with db

    Code
      serial_tbl
    Output
                       disease epi_distribution prob_distribution       author year
      1              Influenza  serial interval             gamma Azra Gha.... 2009
      2  Marburg Virus Disease  serial interval              <NA> Boris I..... 2014
      3  Marburg Virus Disease  serial interval             gamma Marco Aj.... 2012
      4                   Mpox  serial interval             gamma Zachary .... 2022
      5                   Mpox  serial interval             gamma Zachary .... 2022
      6    Ebola Virus Disease  serial interval             gamma WHO Ebol.... 2015
      7    Ebola Virus Disease  serial interval             gamma WHO Ebol.... 2015
      8    Ebola Virus Disease  serial interval             gamma WHO Ebol.... 2015
      9    Ebola Virus Disease  serial interval             gamma WHO Ebol.... 2015
      10                  MERS  serial interval             lnorm Abdullah.... 2013
      11                  MERS  serial interval             gamma B. J. Co.... 2015
      12              COVID-19  serial interval              <NA> Muluneh .... 2021
      13              COVID-19  serial interval             lnorm Hiroshi .... 2020
      14              COVID-19  serial interval           weibull Hiroshi .... 2020
      15              COVID-19  serial interval              norm Lin Yang.... 2020
      16                  Mpox  serial interval             gamma Zihao Gu.... 2022
      17                  Mpox  serial interval              <NA> Shuqi Wa.... 2022
      18                  Mpox  serial interval              <NA> Shuqi Wa.... 2022

# parameter_tbl works for COVID-19 db

    Code
      incub_tbl
    Output
          disease         epi_distribution prob_distribution       author year
      1  COVID-19        incubation period              <NA> Ke Men, .... 2020
      2  COVID-19        incubation period              <NA> Balram R.... 2022
      3  COVID-19        incubation period              <NA> Muluneh .... 2021
      4  COVID-19          serial interval              <NA> Muluneh .... 2021
      5  COVID-19          serial interval             lnorm Hiroshi .... 2020
      6  COVID-19          serial interval           weibull Hiroshi .... 2020
      7  COVID-19        incubation period           weibull Lin Yang.... 2020
      8  COVID-19          serial interval              norm Lin Yang.... 2020
      9  COVID-19        incubation period              <NA> Christel.... 2021
      10 COVID-19        incubation period           weibull Long V. .... 2020
      11 COVID-19        incubation period             lnorm Conor Mc.... 2020
      12 COVID-19        incubation period             lnorm Conor Mc.... 2020
      13 COVID-19        incubation period             lnorm Natalie .... 2020
      14 COVID-19        incubation period             lnorm Natalie .... 2020
      15 COVID-19 onset to hospitalisation             gamma Natalie .... 2020
      16 COVID-19 onset to hospitalisation             gamma Natalie .... 2020
      17 COVID-19           onset to death             lnorm Natalie .... 2020
      18 COVID-19 hospitalisation to death           weibull Natalie .... 2020
      19 COVID-19        incubation period             lnorm Natalie .... 2020
      20 COVID-19 onset to hospitalisation             lnorm Natalie .... 2020
      21 COVID-19 onset to hospitalisation             lnorm Natalie .... 2020
      22 COVID-19           onset to death             lnorm Natalie .... 2020
      23 COVID-19 hospitalisation to death             lnorm Natalie .... 2020
      24 COVID-19        incubation period             lnorm Stephen .... 2020
      25 COVID-19        incubation period             lnorm Stephen .... 2020
      26 COVID-19        incubation period             lnorm Stephen .... 2020
      27 COVID-19        incubation period             lnorm Stephen .... 2020

# parameter_tbl works for SARS-CoV-2 db

    Code
      incub_tbl
    Output
          disease         epi_distribution prob_distribution       author year
      1  COVID-19        incubation period              <NA> Ke Men, .... 2020
      2  COVID-19        incubation period              <NA> Balram R.... 2022
      3  COVID-19        incubation period              <NA> Muluneh .... 2021
      4  COVID-19          serial interval              <NA> Muluneh .... 2021
      5  COVID-19          serial interval             lnorm Hiroshi .... 2020
      6  COVID-19          serial interval           weibull Hiroshi .... 2020
      7  COVID-19        incubation period           weibull Lin Yang.... 2020
      8  COVID-19          serial interval              norm Lin Yang.... 2020
      9  COVID-19        incubation period              <NA> Christel.... 2021
      10 COVID-19        incubation period           weibull Long V. .... 2020
      11 COVID-19        incubation period             lnorm Conor Mc.... 2020
      12 COVID-19        incubation period             lnorm Conor Mc.... 2020
      13 COVID-19        incubation period             lnorm Natalie .... 2020
      14 COVID-19        incubation period             lnorm Natalie .... 2020
      15 COVID-19 onset to hospitalisation             gamma Natalie .... 2020
      16 COVID-19 onset to hospitalisation             gamma Natalie .... 2020
      17 COVID-19           onset to death             lnorm Natalie .... 2020
      18 COVID-19 hospitalisation to death           weibull Natalie .... 2020
      19 COVID-19        incubation period             lnorm Natalie .... 2020
      20 COVID-19 onset to hospitalisation             lnorm Natalie .... 2020
      21 COVID-19 onset to hospitalisation             lnorm Natalie .... 2020
      22 COVID-19           onset to death             lnorm Natalie .... 2020
      23 COVID-19 hospitalisation to death             lnorm Natalie .... 2020
      24 COVID-19        incubation period             lnorm Stephen .... 2020
      25 COVID-19        incubation period             lnorm Stephen .... 2020
      26 COVID-19        incubation period             lnorm Stephen .... 2020
      27 COVID-19        incubation period             lnorm Stephen .... 2020

# parameter_tbl works for disease & epi_dist subset with db

    Code
      incub_tbl
    Output
          disease  epi_distribution prob_distribution       author year
      1  COVID-19 incubation period              <NA> Ke Men, .... 2020
      2  COVID-19 incubation period              <NA> Balram R.... 2022
      3  COVID-19 incubation period              <NA> Muluneh .... 2021
      4  COVID-19 incubation period           weibull Lin Yang.... 2020
      5  COVID-19 incubation period              <NA> Christel.... 2021
      6  COVID-19 incubation period           weibull Long V. .... 2020
      7  COVID-19 incubation period             lnorm Conor Mc.... 2020
      8  COVID-19 incubation period             lnorm Conor Mc.... 2020
      9  COVID-19 incubation period             lnorm Natalie .... 2020
      10 COVID-19 incubation period             lnorm Natalie .... 2020
      11 COVID-19 incubation period             lnorm Natalie .... 2020
      12 COVID-19 incubation period             lnorm Stephen .... 2020
      13 COVID-19 incubation period             lnorm Stephen .... 2020
      14 COVID-19 incubation period             lnorm Stephen .... 2020
      15 COVID-19 incubation period             lnorm Stephen .... 2020

# parameter_tbl works when supplied a subset db

    Code
      covid_tbl
    Output
          disease         epi_distribution prob_distribution       author year
      1  COVID-19        incubation period              <NA> Ke Men, .... 2020
      2  COVID-19        incubation period              <NA> Balram R.... 2022
      3  COVID-19        incubation period              <NA> Muluneh .... 2021
      4  COVID-19          serial interval              <NA> Muluneh .... 2021
      5  COVID-19          serial interval             lnorm Hiroshi .... 2020
      6  COVID-19          serial interval           weibull Hiroshi .... 2020
      7  COVID-19        incubation period           weibull Lin Yang.... 2020
      8  COVID-19          serial interval              norm Lin Yang.... 2020
      9  COVID-19        incubation period              <NA> Christel.... 2021
      10 COVID-19        incubation period           weibull Long V. .... 2020
      11 COVID-19        incubation period             lnorm Conor Mc.... 2020
      12 COVID-19        incubation period             lnorm Conor Mc.... 2020
      13 COVID-19        incubation period             lnorm Natalie .... 2020
      14 COVID-19        incubation period             lnorm Natalie .... 2020
      15 COVID-19 onset to hospitalisation             gamma Natalie .... 2020
      16 COVID-19 onset to hospitalisation             gamma Natalie .... 2020
      17 COVID-19           onset to death             lnorm Natalie .... 2020
      18 COVID-19 hospitalisation to death           weibull Natalie .... 2020
      19 COVID-19        incubation period             lnorm Natalie .... 2020
      20 COVID-19 onset to hospitalisation             lnorm Natalie .... 2020
      21 COVID-19 onset to hospitalisation             lnorm Natalie .... 2020
      22 COVID-19           onset to death             lnorm Natalie .... 2020
      23 COVID-19 hospitalisation to death             lnorm Natalie .... 2020
      24 COVID-19        incubation period             lnorm Stephen .... 2020
      25 COVID-19        incubation period             lnorm Stephen .... 2020
      26 COVID-19        incubation period             lnorm Stephen .... 2020
      27 COVID-19        incubation period             lnorm Stephen .... 2020

# parameter_tbl works as expected supplied with <epidist>

    Code
      dist_tbl
    Output
                    disease epi_distribution prob_distribution       author year
      1 Ebola Virus Disease   onset to death             gamma WHO Ebol.... 2015

# parameter_tbl works as expected with discretised <epidist>

    Code
      dist_tbl
    Output
        disease epi_distribution prob_distribution     author year
      1   Ebola  serial interval             gamma John Smith 2022

