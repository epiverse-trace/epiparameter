# sim_contacts works as expected with defaults

    Code
      sim_contacts()
    Output
                             from                       to age sex date_first_contact
      1     Naasiruddeen al-Jafri          Naadir al-Saleh  26   m         2023-01-04
      2     Naasiruddeen al-Jafri Louis Baltazar-Francisco  15   m         2023-01-02
      3  Louis Baltazar-Francisco       Kalia Lubthisophon  58   f         2023-01-16
      4  Louis Baltazar-Francisco           Skylinn Topaha  29   f         2023-01-11
      5  Louis Baltazar-Francisco           Aurreana Salas  24   f         2023-01-12
      6        Kalia Lubthisophon           Rachel Stevens  42   f         2023-01-15
      7        Kalia Lubthisophon        Mitchell Sandoval  48   m         2023-01-18
      8        Kalia Lubthisophon          Haala al-Akhter  76   f         2023-01-19
      9            Rachel Stevens       Mersadez Barringer  39   f         2023-01-24
      10          Haala al-Akhter           Yulisa Estrada  24   f         2023-01-21
      11          Haala al-Akhter        Bethany Mccracken  53   f         2023-01-22
      12           Yulisa Estrada             Cade Amerson  86   m         2023-01-24
      13           Yulisa Estrada             Andrew Wixom  40   m         2023-01-25
      14             Cade Amerson             Celsa Torres  83   f         2023-01-26
      15             Celsa Torres         Tristan Stockton  90   m         2023-02-02
      16             Celsa Torres         Bassaam al-Faris  35   m         2023-02-05
      17             Celsa Torres         Triana Henderson  43   f         2023-02-04
      18         Bassaam al-Faris        Jennifer Gallegos   1   f         2023-02-06
      19         Bassaam al-Faris           Patrick Martin  29   m         2023-01-31
      20         Bassaam al-Faris            Bryant Taylor  78   m         2023-02-04
         date_last_contact was_case           status
      1         2023-01-06        N   under_followup
      2         2023-01-03        Y             case
      3         2023-01-19        Y             case
      4         2023-01-16        N lost_to_followup
      5         2023-01-16        N   under_followup
      6         2023-01-19        Y             case
      7         2023-01-21        N   under_followup
      8         2023-01-21        Y             case
      9         2023-01-28        N lost_to_followup
      10        2023-01-24        Y             case
      11        2023-01-26        N   under_followup
      12        2023-01-26        Y             case
      13        2023-01-27        N          unknown
      14        2023-02-03        Y             case
      15        2023-02-05        N   under_followup
      16        2023-02-07        Y             case
      17        2023-02-05        N lost_to_followup
      18        2023-02-09        N   under_followup
      19        2023-02-06        Y             case
      20        2023-02-07        N lost_to_followup

# sim_contacts works as expected

    Code
      sim_contacts(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5)
    Output
                            from                      to age sex date_first_contact
      1       Barrington Johnson       Nykalous Shumpert  51   m         2022-12-30
      2       Barrington Johnson            Alivia Perez  44   f         2023-01-01
      3             Alivia Perez          Arshad al-Basa  49   m         2023-01-02
      4             Alivia Perez          Madison Krause  60   f         2023-01-04
      5             Alivia Perez            Ashlan Allen  56   f         2022-12-29
      6           Arshad al-Basa          Turfa el-Farah  49   f         2023-01-03
      7           Arshad al-Basa            Ronald Welch  50   m         2023-01-02
      8           Arshad al-Basa           Simon Pickett   7   m         2023-01-03
      9           Arshad al-Basa            Destiny Hart  20   f         2023-01-02
      10          Arshad al-Basa            Jeramy Fitch  24   m         2023-01-02
      11          Arshad al-Basa          Joshua Ryckman  51   m         2023-01-03
      12            Ronald Welch             Adrian Wang  53   m         2023-01-02
      13            Ronald Welch           Luis Quintana  16   m         2023-01-02
      14            Jeramy Fitch        Janayva Ambrozic  83   f         2023-01-07
      15            Jeramy Fitch Nicole Vazquez Pallares   2   f         2023-01-02
      16            Jeramy Fitch        Nusaiba al-Rassi  48   f         2023-01-03
      17             Adrian Wang            Korren Watts  65   f         2023-01-04
      18        Janayva Ambrozic           Shan Saldanha  44   f         2023-01-03
      19        Janayva Ambrozic       Jonathan Krishnan  77   m         2023-01-03
      20        Janayva Ambrozic         Alexander Brown  90   m         2023-01-03
      21        Janayva Ambrozic          Cruz Hernandez  66   m         2023-01-07
      22 Nicole Vazquez Pallares        Ryanna Vialpando  19   f         2023-01-04
      23        Nusaiba al-Rassi           Preston Miles  17   m         2022-12-29
      24        Nusaiba al-Rassi              Drue White  34   m         2023-01-03
      25          Cruz Hernandez        Breanna Crandall  75   f         2022-12-31
         date_last_contact was_case           status
      1         2023-01-03        N   under_followup
      2         2023-01-02        Y             case
      3         2023-01-05        Y             case
      4         2023-01-07        N   under_followup
      5         2023-01-06        N   under_followup
      6         2023-01-06        N          unknown
      7         2023-01-05        Y             case
      8         2023-01-04        Y             case
      9         2023-01-06        N lost_to_followup
      10        2023-01-05        Y             case
      11        2023-01-06        N   under_followup
      12        2023-01-04        Y             case
      13        2023-01-04        N   under_followup
      14        2023-01-10        Y             case
      15        2023-01-05        Y             case
      16        2023-01-04        Y             case
      17        2023-01-04        N   under_followup
      18        2023-01-06        N   under_followup
      19        2023-01-09        N          unknown
      20        2023-01-06        N lost_to_followup
      21        2023-01-10        Y             case
      22        2023-01-07        N   under_followup
      23        2023-01-05        N   under_followup
      24        2023-01-06        Y             case
      25        2023-01-04        N   under_followup

# sim_contacts works as expected with modified config

    Code
      sim_contacts(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, config = create_config(last_contact_distribution = "geom",
          last_contact_distribution_params = c(prob = 0.5)))
    Output
                      from                       to age sex date_first_contact
      1        Marcus Lane            Noyami Alonzo  46   f         2023-01-04
      2        Marcus Lane        Raynaldo Dorrance  19   m         2022-12-27
      3  Raynaldo Dorrance             Keeley Brown  75   f         2023-01-01
      4  Raynaldo Dorrance           Jackson Foster  16   m         2022-12-29
      5  Raynaldo Dorrance              Cody Flores  40   m         2022-12-28
      6       Keeley Brown Hannah Aguirre-Rodriquez   9   f         2022-12-31
      7       Keeley Brown           Rory O'Dorisio  50   m         2023-01-02
      8       Keeley Brown        Hilmiyya al-Amiri  24   f         2023-01-01
      9       Keeley Brown          Margaret Tucker  10   f         2022-12-29
      10      Keeley Brown             Naomi Holley  79   f         2022-12-31
      11      Keeley Brown           Sheldon Salido  32   m         2022-12-31
      12    Rory O'Dorisio           Aquilah Santos  39   f         2022-12-29
      13    Rory O'Dorisio              Sam Summers  37   m         2022-12-29
      14      Naomi Holley             Brandon Hall  12   m         2022-12-31
      15      Naomi Holley             Deidra Byers  14   f         2022-12-31
      16      Naomi Holley           Danita Griffin  16   f         2022-12-29
      17    Aquilah Santos          Cleatus Edwards  15   m         2022-12-31
      18      Brandon Hall            Mariah Nguyen   2   f         2022-12-31
      19      Brandon Hall            Hailey Kilian  65   f         2022-12-31
      20      Brandon Hall        Elizabeth Damiana  67   f         2022-12-29
      21      Brandon Hall                Kyle Orio  73   m         2023-01-02
      22      Deidra Byers             Diego Fierro  17   m         2023-01-02
      23    Danita Griffin             Alexa Minter  84   f         2022-12-29
      24    Danita Griffin         Jelani Takahashi   5   m         2023-01-01
      25         Kyle Orio        Khaleel al-Demian  41   m         2022-12-30
         date_last_contact was_case           status
      1         2023-01-06        N          unknown
      2         2023-01-01        Y             case
      3         2023-01-04        Y             case
      4         2023-01-02        N   under_followup
      5         2023-01-02        N lost_to_followup
      6         2023-01-02        N lost_to_followup
      7         2023-01-03        Y             case
      8         2023-01-03        Y             case
      9         2023-01-02        N   under_followup
      10        2023-01-02        Y             case
      11        2023-01-03        N lost_to_followup
      12        2023-01-03        Y             case
      13        2023-01-03        N   under_followup
      14        2023-01-02        Y             case
      15        2023-01-02        Y             case
      16        2023-01-03        Y             case
      17        2023-01-03        N   under_followup
      18        2023-01-04        N lost_to_followup
      19        2023-01-03        N lost_to_followup
      20        2023-01-03        N   under_followup
      21        2023-01-04        Y             case
      22        2023-01-03        N   under_followup
      23        2023-01-03        N   under_followup
      24        2023-01-04        Y             case
      25        2023-01-04        N   under_followup

# sim_contacts works as expected with modified config parameters

    Code
      sim_contacts(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, config = create_config(
          last_contact_distribution_params = c(lambda = 5)))
    Output
                            from                      to age sex date_first_contact
      1       Barrington Johnson       Nykalous Shumpert  51   m         2022-12-31
      2       Barrington Johnson            Alivia Perez  44   f         2023-01-02
      3             Alivia Perez          Arshad al-Basa  49   m         2023-01-05
      4             Alivia Perez          Madison Krause  60   f         2023-01-07
      5             Alivia Perez            Ashlan Allen  56   f         2023-01-01
      6           Arshad al-Basa          Turfa el-Farah  49   f         2023-01-06
      7           Arshad al-Basa            Ronald Welch  50   m         2023-01-04
      8           Arshad al-Basa           Simon Pickett   7   m         2023-01-05
      9           Arshad al-Basa            Destiny Hart  20   f         2023-01-05
      10          Arshad al-Basa            Jeramy Fitch  24   m         2023-01-04
      11          Arshad al-Basa          Joshua Ryckman  51   m         2023-01-05
      12            Ronald Welch             Adrian Wang  53   m         2023-01-04
      13            Ronald Welch           Luis Quintana  16   m         2023-01-04
      14            Jeramy Fitch        Janayva Ambrozic  83   f         2023-01-10
      15            Jeramy Fitch Nicole Vazquez Pallares   2   f         2023-01-05
      16            Jeramy Fitch        Nusaiba al-Rassi  48   f         2023-01-04
      17             Adrian Wang            Korren Watts  65   f         2023-01-06
      18        Janayva Ambrozic           Shan Saldanha  44   f         2023-01-05
      19        Janayva Ambrozic       Jonathan Krishnan  77   m         2023-01-05
      20        Janayva Ambrozic         Alexander Brown  90   m         2023-01-05
      21        Janayva Ambrozic          Cruz Hernandez  66   m         2023-01-10
      22 Nicole Vazquez Pallares        Ryanna Vialpando  19   f         2023-01-06
      23        Nusaiba al-Rassi           Preston Miles  17   m         2022-12-31
      24        Nusaiba al-Rassi              Drue White  34   m         2023-01-04
      25          Cruz Hernandez        Breanna Crandall  75   f         2023-01-02
         date_last_contact was_case           status
      1         2023-01-04        N   under_followup
      2         2023-01-03        Y             case
      3         2023-01-08        Y             case
      4         2023-01-10        N   under_followup
      5         2023-01-09        N   under_followup
      6         2023-01-09        N          unknown
      7         2023-01-07        Y             case
      8         2023-01-06        Y             case
      9         2023-01-09        N lost_to_followup
      10        2023-01-07        Y             case
      11        2023-01-08        N   under_followup
      12        2023-01-06        Y             case
      13        2023-01-06        N   under_followup
      14        2023-01-13        Y             case
      15        2023-01-08        Y             case
      16        2023-01-05        Y             case
      17        2023-01-06        N   under_followup
      18        2023-01-08        N   under_followup
      19        2023-01-11        N          unknown
      20        2023-01-08        N lost_to_followup
      21        2023-01-13        Y             case
      22        2023-01-09        N   under_followup
      23        2023-01-07        N   under_followup
      24        2023-01-07        Y             case
      25        2023-01-06        N   under_followup

# sim_contacts works as expected with age structure

    Code
      sim_contacts(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, population_age = age_struct)
    Output
                        from                      to age sex date_first_contact
      1          Ramon Burch             Job Cabrera  62   m         2022-12-30
      2          Ramon Burch       Raihaana el-Irani  24   f         2023-01-01
      3    Raihaana el-Irani          Joshua Puckett  52   m         2023-01-02
      4    Raihaana el-Irani      Katherine Benjamin  74   f         2023-01-04
      5    Raihaana el-Irani         Destiny Cornejo  76   f         2022-12-29
      6       Joshua Puckett      Ashleigh Contreras  26   f         2023-01-03
      7       Joshua Puckett        Miguel Maldonado  25   m         2023-01-02
      8       Joshua Puckett Christian Siewiyumptewa  69   m         2023-01-03
      9       Joshua Puckett         Lilliana Garcia  53   f         2023-01-02
      10      Joshua Puckett           Diego Trevino  19   m         2023-01-02
      11      Joshua Puckett                Eric Tat  49   m         2023-01-03
      12    Miguel Maldonado       Robert Drazkowski  68   m         2023-01-02
      13    Miguel Maldonado          Chumron Lummis  82   m         2023-01-02
      14       Diego Trevino         Mufeeda el-Ozer  84   f         2023-01-07
      15       Diego Trevino          Carina Beltran  79   f         2023-01-02
      16       Diego Trevino         Tiffanie Falcon   5   f         2023-01-03
      17   Robert Drazkowski     Hannah Zhang Cheung  78   f         2023-01-04
      18     Mufeeda el-Ozer           Rebeca Chavez  85   f         2023-01-03
      19     Mufeeda el-Ozer              Hyungu Han  36   m         2023-01-03
      20     Mufeeda el-Ozer        Matthew Silevani  62   m         2023-01-03
      21     Mufeeda el-Ozer     Jesse-Reese Burukie  66   m         2023-01-07
      22      Carina Beltran          Johannah Costa  43   f         2023-01-04
      23     Tiffanie Falcon            Austin Pinch  61   m         2022-12-29
      24     Tiffanie Falcon             Neil Dorado  26   m         2023-01-03
      25 Jesse-Reese Burukie             Ruby Gaspar  81   f         2022-12-31
         date_last_contact was_case         status
      1         2023-01-03        N under_followup
      2         2023-01-02        Y           case
      3         2023-01-05        Y           case
      4         2023-01-07        N under_followup
      5         2023-01-06        N under_followup
      6         2023-01-06        N under_followup
      7         2023-01-05        Y           case
      8         2023-01-04        Y           case
      9         2023-01-06        N under_followup
      10        2023-01-05        Y           case
      11        2023-01-06        N        unknown
      12        2023-01-04        Y           case
      13        2023-01-04        N under_followup
      14        2023-01-10        Y           case
      15        2023-01-05        Y           case
      16        2023-01-04        Y           case
      17        2023-01-04        N under_followup
      18        2023-01-06        N        unknown
      19        2023-01-09        N under_followup
      20        2023-01-06        N under_followup
      21        2023-01-10        Y           case
      22        2023-01-07        N under_followup
      23        2023-01-05        N under_followup
      24        2023-01-06        Y           case
      25        2023-01-04        N under_followup

