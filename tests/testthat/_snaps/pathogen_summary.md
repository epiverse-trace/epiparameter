# pathogen_summary works with valid input

    Code
      pathogen_summary(pathogen = "ebola")
    Output
        pathogen      delay_dist distribution    mean       sd               study
      1    ebola      incubation        gamma  9.1000 7.300000            WHO_team
      2    ebola  onset_to_death        gamma  7.9992 5.163461 Ebola_outbreak_team
      3    ebola serial_interval        gamma 15.3000 9.300000   WHO_response_team
                                  DOI
      1         10.1056/nejmoa1411100
      2 10.1016/S0140-6736(18)31387-4
      3         10.1056/nejmoa1411100

# pathogen_summary works with pathogen with gamma and lnorm

    Code
      pathogen_summary(pathogen = "SARS_CoV")
    Output
        pathogen         delay_dist distribution     mean       sd         study
      1 SARS_CoV         incubation        gamma 6.369989 4.085333 Donnelly_etal
      2 SARS_CoV         incubation        lnorm 4.722382 2.963483  Lessler_etal
      3 SARS_CoV onset_to_admission        gamma 4.849999 3.491418 Donnelly_etal
                                  DOI
      1 10.1016/S0140-6736(03)13410-1
      2 10.1016/S1473-3099(09)70069-6
      3 10.1016/S0140-6736(03)13410-1

