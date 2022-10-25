# pathogen_summary works with valid input

    Code
      pathogen_summary(pathogen = "ebola")
    Output
        pathogen         delay_dist distribution      mean       sd             study
      1    ebola    serial_interval        gamma 15.300001 9.300000 WHO_response_team
      2    ebola         incubation        gamma  9.100000 7.300000          WHO_team
      3    ebola onset_to_admission        gamma  5.000001 4.700000          WHO_team
      4    ebola     onset_to_death        gamma  7.499998 6.799999          WHO_team
                          DOI
      1 10.1056/nejmoa1411100
      2 10.1056/nejmoa1411100
      3 10.1056/nejmoa1411100
      4 10.1056/nejmoa1411100

# pathogen_summary works with pathogen with gamma and lnorm

    Code
      pathogen_summary(pathogen = "SARS_CoV")
    Output
        pathogen         delay_dist distribution     mean       sd         study
      1 SARS_CoV         incubation        gamma 6.369989 4.085333 Donnelly_etal
      2 SARS_CoV onset_to_admission        gamma 4.849999 3.491418 Donnelly_etal
      3 SARS_CoV         incubation        lnorm 4.722382 2.963483  Lessler_etal
                                  DOI
      1 10.1016/S0140-6736(03)13410-1
      2 10.1016/S0140-6736(03)13410-1
      3 10.1016/S1473-3099(09)70069-6

