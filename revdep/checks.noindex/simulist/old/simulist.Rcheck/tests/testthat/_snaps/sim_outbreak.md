# sim_outbreak works as expected with defaults

    Code
      sim_outbreak()
    Output
      $linelist
           id                 case_name case_type sex age date_onset date_admission
      1     1      Marquione Currington suspected   m  59 2023-01-01     2023-01-09
      2     2        Ghaaliba el-Hassen  probable   f  90 2023-01-01           <NA>
      3     3   Leslie Morales-Gonzalez  probable   f   4 2023-01-02           <NA>
      4     5          Labeeb el-Hariri confirmed   m  29 2023-01-04           <NA>
      5     6               Carla Moore confirmed   f  14 2023-01-05     2023-01-09
      6     7        Saabiqa al-Hammoud  probable   f  85 2023-01-06     2023-01-08
      7    10              Alex Voliton confirmed   m  25 2023-01-13           <NA>
      8    11                 Mara Gast confirmed   f  34 2023-01-11     2023-01-24
      9    12       Dasha Willis-Arvizu suspected   f  89 2023-01-13           <NA>
      10   14          Justus Goodstein suspected   m  63 2023-01-11           <NA>
      11   18       Kiyontus Howard III confirmed   m  74 2023-01-14           <NA>
      12   19        Alexandria Hoshiko suspected   f  34 2023-01-12           <NA>
      13   22              Sarah Walker confirmed   f  29 2023-01-12           <NA>
      14   24             Kylie Warthen confirmed   f  46 2023-01-13           <NA>
      15   27                 Corey Mao confirmed   f  24 2023-01-14     2023-01-19
      16   29              Alyce Hodges confirmed   f  41 2023-01-21           <NA>
      17   30        Kimuraamor Mizelle confirmed   f  72 2023-01-19           <NA>
      18   31          Christopher Bell  probable   m   6 2023-01-20           <NA>
      19   33               Evan Mulder confirmed   m  61 2023-01-14           <NA>
      20   34              Lauren Garza suspected   f  44 2023-01-14     2023-02-10
      21   35           Mahaa al-Arshad  probable   f  71 2023-01-27           <NA>
      22   38           Mastoor al-Azer suspected   m  69 2023-01-23           <NA>
      23   39           Deshawn Gallion confirmed   m  61 2023-01-23           <NA>
      24   41 Makalia Hernandez Mendoza suspected   f  64 2023-01-24           <NA>
      25   44                Lewis Tani  probable   m  61 2023-01-22           <NA>
      26   45             Shalin Decker confirmed   f  66 2023-01-22           <NA>
      27   47             Alexander Bly confirmed   m  81 2023-01-28           <NA>
      28   50            Alexander Ryan  probable   m  53 2023-01-28     2023-01-30
      29   51              Israel Downs suspected   m  45 2023-01-29           <NA>
      30   53            Hannah Johnson suspected   f  42 2023-02-02     2023-02-11
      31   54          Maaiz al-Harroun confirmed   m  78 2023-02-03           <NA>
      32   55            Sabri el-Pasha suspected   m  35 2023-01-24           <NA>
      33   56         Lizabeth Anderson confirmed   f  54 2023-01-26           <NA>
      34   58             Elijah Nguyen confirmed   m  68 2023-01-25     2023-01-29
      35   59          Hilmi al-Mustafa confirmed   m   3 2023-01-23           <NA>
      36   60              Darian Ramos suspected   m  44 2023-01-29     2023-02-02
      37   63           Ayyoob al-Sabet  probable   m  62 2023-01-31           <NA>
      38   64          Quraish el-Aslam  probable   m  35 2023-01-29           <NA>
      39   65              Joanne Daley confirmed   f  90 2023-02-03     2023-02-08
      40   66                Erica Rupp suspected   f  25 2023-02-01     2023-02-05
      41   71         Shantavia Barnett suspected   f  46 2023-01-29           <NA>
      42   73          Azeeza al-Othman confirmed   f   8 2023-02-01           <NA>
      43   77           Saamir al-Kalil  probable   m  63 2023-01-30           <NA>
      44   78             Sarah Hankins confirmed   f  54 2023-01-29           <NA>
      45   80         Majeeda el-Baluch  probable   f  67 2023-02-03           <NA>
      46   85            Isaac Cardenas confirmed   m  37 2023-02-02           <NA>
      47   88            Adam Gallagher suspected   m  73 2023-01-30           <NA>
      48   89              Zachary Abel confirmed   m  13 2023-02-02           <NA>
      49   90           Waleeda al-Alam suspected   f  72 2023-02-01           <NA>
      50   93            Qais el-Younes confirmed   m  61 2023-02-04           <NA>
      51   97          Ridwaan el-Zaman confirmed   m  22 2023-02-05           <NA>
      52   98           Azeema al-Rayes confirmed   f  29 2023-02-04           <NA>
      53  101            Subhi al-Qasim confirmed   m  17 2023-02-07           <NA>
      54  108               Luis Chacon  probable   m  71 2023-02-14           <NA>
      55  111             Marley Wilson confirmed   f  90 2023-02-09           <NA>
      56  113            Mondray Thomas suspected   m  23 2023-02-12           <NA>
      57  114         Humaina al-Habeeb  probable   f  35 2023-02-16           <NA>
      58  116             Ishan Kumagai confirmed   m  62 2023-02-24           <NA>
      59  119             Joanna Guerra  probable   f  57 2023-02-23           <NA>
      60  120           Dashelle Milner confirmed   f  44 2023-02-18           <NA>
      61  122             Derek Cooksey confirmed   m  57 2023-03-02           <NA>
      62  123           Suhaib al-Hoque  probable   m  63 2023-03-08     2023-03-11
      63  125           Christine Bajwa confirmed   f  46 2023-02-28           <NA>
      64  126       Jalen Herrera-Vigil  probable   m  66 2023-02-26           <NA>
      65  130                   Alex Vu  probable   m  68 2023-03-07           <NA>
      66  131          Alexander Nakata  probable   m  12 2023-03-09           <NA>
      67  133            Alia Archuleta confirmed   f  51 2023-03-18           <NA>
      68  138           Maazina el-Amin  probable   f   2 2023-03-10           <NA>
      69  139             Albert Marley confirmed   m  53 2023-03-09     2023-03-16
      70  142          Mackenzie Conley confirmed   f  76 2023-03-23           <NA>
      71  143              Angel Silvas confirmed   m  82 2023-03-21           <NA>
      72  145             Keyona Dydell suspected   f  25 2023-03-15           <NA>
      73  146                Laura Sher confirmed   f  76 2023-03-13           <NA>
      74  147         Tuvshinbayar Tran  probable   m  14 2023-03-13     2023-03-17
      75  150            Maiya Hazelman  probable   f  76 2023-03-11           <NA>
      76  153                  Mori Hsu  probable   m  78 2023-03-15           <NA>
      77  154           Gretchen Prieto confirmed   f  75 2023-03-24     2023-03-31
      78  155           Kameela al-Zaki confirmed   f  76 2023-03-24           <NA>
      79  157         Zumruda al-Arshad  probable   f  80 2023-03-18           <NA>
      80  158              Nimesha Kane  probable   f  41 2023-03-18           <NA>
      81  159               Jennifer An confirmed   f  78 2023-03-19           <NA>
      82  163            Matthew Welter confirmed   m  28 2023-03-15           <NA>
      83  164            Kendall Rhoads suspected   f   2 2023-03-21           <NA>
      84  166           Antaiaja Cromer  probable   f  82 2023-03-26           <NA>
      85  171            Fikri al-Amara  probable   m   5 2023-03-22           <NA>
      86  172       Gabriella Two  Crow confirmed   f   1 2023-03-20           <NA>
      87  173              Yutitham Tan  probable   m  44 2023-03-19     2023-03-22
      88  174         Ramalaan el-Zafar  probable   m  76 2023-03-16           <NA>
      89  175    Carlo Ceazar Phanekham  probable   m   3 2023-03-29           <NA>
      90  176            Brandon Bailey  probable   m  15 2023-03-25           <NA>
      91  177         Mu'taz al-Shabazz confirmed   m  19 2023-03-26           <NA>
      92  178               Ana Guijosa confirmed   f  76 2023-03-25           <NA>
      93  182              Ethan Turner  probable   m  90 2023-03-27           <NA>
      94  186       Raashid el-Shehadeh confirmed   m  64 2023-04-03           <NA>
      95  189             Nuzha el-Ally  probable   f  35 2023-03-29           <NA>
      96  195           Tiffany Lenahan confirmed   f  84 2023-03-27           <NA>
      97  196            Joshua Sanchez confirmed   m  18 2023-03-30     2023-04-03
      98  197          Lolette Robinson confirmed   f  79 2023-03-28     2023-04-03
      99  199            Mariah Simmons suspected   f  49 2023-04-07           <NA>
      100 200              Dawna Beeton confirmed   f  56 2023-04-05           <NA>
      101 201                 Mia Lumba suspected   f  76 2023-04-07     2023-04-12
      102 202            David Reichman suspected   m  41 2023-04-03           <NA>
      103 205        Mackenzie Mcmullen suspected   f  29 2023-04-01           <NA>
      104 209            Michael Navajo  probable   m  39 2023-04-05     2023-04-12
      105 210           Ernesto Cachola  probable   m  32 2023-04-01           <NA>
      106 211           Emmanuel Ibarra confirmed   m   9 2023-04-06           <NA>
      107 213           Rachel Mcdonald confirmed   f  39 2023-04-11     2023-04-13
      108 214          Saleet al-Rahimi  probable   m  12 2023-04-17     2023-04-20
      109 219            Jamaal el-Reza  probable   m  52 2023-04-10           <NA>
      110 221           Dalicia Wilkins confirmed   f  22 2023-04-02           <NA>
      111 224          Jameela al-Rahim confirmed   f  68 2023-04-08           <NA>
      112 226              James Morgan suspected   m  57 2023-04-06           <NA>
      113 229            Desmond Castro confirmed   m   8 2023-04-12           <NA>
      114 230               Elijah Ross confirmed   f  28 2023-04-12           <NA>
      115 232              Yuvorn Ahmad confirmed   m   2 2023-04-02           <NA>
      116 233           Jericho Powless confirmed   m  84 2023-04-09           <NA>
      117 234               Claire Osse confirmed   f  52 2023-04-09     2023-04-13
      118 235           Dearee Scurlock suspected   m  58 2023-04-12           <NA>
      119 236            Hafsa el-Pasha confirmed   f  29 2023-04-10           <NA>
      120 238           Danielle Finken confirmed   f  30 2023-04-14           <NA>
      121 240           Yusri al-Salame suspected   m  71 2023-04-15           <NA>
      122 243               Cody Parker confirmed   m  43 2023-04-13           <NA>
      123 245               Connor Hahs  probable   m  40 2023-04-15           <NA>
      124 250               Kevin Huang  probable   m  46 2023-04-16           <NA>
      125 251               Yusuf Shahi confirmed   m  69 2023-04-11           <NA>
      126 252             Ruby Martinez confirmed   f  69 2023-04-20           <NA>
      127 253             Jameel Curtis suspected   m  38 2023-04-20           <NA>
      128 254              Ryan Sorrell suspected   m  28 2023-04-16           <NA>
      129 255              Otoniel Huff  probable   m  82 2023-04-16           <NA>
      130 258      Nafeesa el-Mohiuddin confirmed   f  19 2023-04-14           <NA>
      131 261          Muhaajir al-Ozer confirmed   m  46 2023-04-26           <NA>
      132 262             Jazmine Mcgee confirmed   f  71 2023-04-13     2023-04-18
      133 264        Nawwaara al-Hammad confirmed   f   4 2023-04-25     2023-04-27
      134 265           Trevor Videtzky confirmed   m  31 2023-04-25           <NA>
      135 267          Ghaaliya al-Azzi confirmed   f  16 2023-04-20     2023-04-24
      136 268          Mansoor el-Salem confirmed   m  53 2023-04-21     2023-04-29
      137 277             Russell Stott suspected   m  14 2023-05-01           <NA>
      138 278             Diksha Javaid suspected   f  48 2023-04-28     2023-05-01
      139 279            Ronnie Labadie  probable   m  89 2023-04-25           <NA>
      140 280        Alexander Mitchell confirmed   m  39 2023-04-26           <NA>
      141 282          Brandon Marchman confirmed   m  20 2023-04-21     2023-04-26
      142 284            Jasmine Thomas suspected   f   6 2023-05-03           <NA>
      143 285           De'Chelle Yorks suspected   f  28 2023-05-05           <NA>
      144 291   Alexander Rangel Mendez confirmed   m  42 2023-05-01           <NA>
      145 292          Taylor Pickering suspected   f  71 2023-04-23           <NA>
      146 293      Cheyanna Bear-Flores confirmed   f   9 2023-05-05           <NA>
      147 296        Rhiannon Aviado II confirmed   f  61 2023-05-06           <NA>
      148 298                Samuel San confirmed   m  53 2023-05-02           <NA>
      149 301              Lafaith Bean confirmed   f  76 2023-04-23           <NA>
      150 302          Morgan Tollivoro  probable   f  69 2023-04-26           <NA>
      151 304            Weston Henzler confirmed   m  50 2023-05-07     2023-05-11
      152 307           Hissa el-Yassin confirmed   f   7 2023-05-09           <NA>
      153 310            Afaaf el-Anwar confirmed   f  45 2023-04-24           <NA>
      154 311             Joshua Molina suspected   m  83 2023-04-25           <NA>
      155 313         Nichole Scharnell confirmed   f  41 2023-04-27           <NA>
      156 316              Renae Mcadoo confirmed   f  88 2023-05-10           <NA>
      157 320  Jeremy Montelongo Declay confirmed   m  79 2023-05-01           <NA>
      158 326           Jez-Mas Powells suspected   m  82 2023-05-08     2023-05-21
            outcome date_outcome date_first_contact date_last_contact ct_value
      1        died   2023-01-13               <NA>              <NA>       NA
      2   recovered         <NA>         2022-12-31        2023-01-05       NA
      3   recovered         <NA>         2022-12-30        2023-01-01       NA
      4   recovered         <NA>         2023-01-05        2023-01-05     24.0
      5        died   2023-01-23         2023-01-07        2023-01-08     27.1
      6   recovered         <NA>         2023-01-03        2023-01-06       NA
      7   recovered         <NA>         2023-01-06        2023-01-06     28.8
      8        died   2023-01-20         2023-01-01        2023-01-06     28.9
      9   recovered         <NA>         2023-01-06        2023-01-08       NA
      10  recovered         <NA>         2023-01-02        2023-01-08       NA
      11  recovered         <NA>         2023-01-12        2023-01-17     26.5
      12  recovered         <NA>         2023-01-09        2023-01-11       NA
      13  recovered         <NA>         2023-01-12        2023-01-14     23.3
      14  recovered         <NA>         2023-01-10        2023-01-16     24.9
      15       died   2023-01-27         2023-01-11        2023-01-13     23.9
      16  recovered         <NA>         2023-01-11        2023-01-15     23.6
      17  recovered         <NA>         2023-01-14        2023-01-17     24.2
      18  recovered         <NA>         2023-01-14        2023-01-16       NA
      19  recovered         <NA>         2023-01-12        2023-01-16     28.5
      20  recovered         <NA>         2023-01-13        2023-01-17       NA
      21  recovered         <NA>         2023-01-22        2023-01-23       NA
      22  recovered         <NA>         2023-01-20        2023-01-22       NA
      23       died   2023-01-26         2023-01-19        2023-01-23     25.4
      24  recovered         <NA>         2023-01-19        2023-01-22       NA
      25  recovered         <NA>         2023-01-23        2023-01-24       NA
      26  recovered         <NA>         2023-01-23        2023-01-25     28.8
      27  recovered         <NA>         2023-01-23        2023-01-28     25.2
      28       died   2023-02-16         2023-01-22        2023-01-24       NA
      29  recovered         <NA>         2023-01-23        2023-01-28       NA
      30  recovered         <NA>         2023-01-25        2023-01-26       NA
      31  recovered         <NA>         2023-01-24        2023-01-26     24.8
      32  recovered         <NA>         2023-01-23        2023-01-26       NA
      33  recovered         <NA>         2023-01-18        2023-01-23     21.2
      34  recovered         <NA>         2023-01-19        2023-01-23     25.3
      35       died   2023-02-03         2023-01-22        2023-01-26     24.7
      36       died   2023-02-09         2023-01-27        2023-01-27       NA
      37  recovered         <NA>         2023-01-26        2023-01-28       NA
      38  recovered         <NA>         2023-01-25        2023-01-30       NA
      39       died   2023-02-21         2023-01-27        2023-01-30     22.8
      40  recovered         <NA>         2023-01-27        2023-01-31       NA
      41  recovered         <NA>         2023-01-30        2023-01-31       NA
      42  recovered         <NA>         2023-02-01        2023-02-04     26.0
      43  recovered         <NA>         2023-01-28        2023-02-02       NA
      44  recovered         <NA>         2023-01-27        2023-02-02     30.1
      45       died   2023-02-09         2023-02-03        2023-02-04       NA
      46  recovered         <NA>         2023-02-01        2023-02-03     22.3
      47  recovered         <NA>         2023-01-31        2023-02-01       NA
      48  recovered         <NA>         2023-01-30        2023-02-02     24.2
      49  recovered         <NA>         2023-01-31        2023-01-31       NA
      50  recovered         <NA>         2023-01-30        2023-02-04     23.6
      51       died   2023-02-18         2023-02-04        2023-02-06     24.3
      52  recovered         <NA>         2023-02-03        2023-02-05     23.9
      53  recovered         <NA>         2023-01-30        2023-02-04     22.8
      54  recovered         <NA>         2023-02-05        2023-02-08       NA
      55  recovered         <NA>         2023-02-06        2023-02-08     26.3
      56  recovered         <NA>         2023-02-10        2023-02-11       NA
      57  recovered         <NA>         2023-02-14        2023-02-19       NA
      58  recovered         <NA>         2023-02-13        2023-02-16     23.9
      59  recovered         <NA>         2023-02-10        2023-02-13       NA
      60  recovered         <NA>         2023-02-16        2023-02-18     26.1
      61       died   2023-03-20         2023-03-02        2023-03-02     24.9
      62       died   2023-03-25         2023-02-26        2023-03-03       NA
      63  recovered         <NA>         2023-02-24        2023-02-26     23.6
      64  recovered         <NA>         2023-02-17        2023-02-23       NA
      65       died   2023-03-15         2023-03-06        2023-03-07       NA
      66  recovered         <NA>         2023-03-03        2023-03-04       NA
      67  recovered         <NA>         2023-03-07        2023-03-09     25.2
      68  recovered         <NA>         2023-03-06        2023-03-11       NA
      69       died   2023-03-14         2023-03-07        2023-03-11     27.1
      70  recovered         <NA>         2023-03-18        2023-03-23     21.7
      71  recovered         <NA>         2023-03-20        2023-03-20     29.1
      72  recovered         <NA>         2023-03-07        2023-03-12       NA
      73  recovered         <NA>         2023-03-10        2023-03-14     21.5
      74  recovered         <NA>         2023-03-06        2023-03-11       NA
      75  recovered         <NA>         2023-03-10        2023-03-11       NA
      76  recovered         <NA>         2023-03-16        2023-03-21       NA
      77  recovered         <NA>         2023-03-16        2023-03-19     24.2
      78  recovered         <NA>         2023-03-12        2023-03-19     25.3
      79  recovered         <NA>         2023-03-13        2023-03-14       NA
      80  recovered         <NA>         2023-03-12        2023-03-14       NA
      81  recovered         <NA>         2023-03-12        2023-03-17     25.0
      82  recovered         <NA>         2023-03-12        2023-03-17     21.6
      83  recovered         <NA>         2023-03-15        2023-03-18       NA
      84  recovered         <NA>         2023-03-21        2023-03-25       NA
      85  recovered         <NA>         2023-03-16        2023-03-20       NA
      86  recovered         <NA>         2023-03-18        2023-03-21     22.5
      87       died   2023-04-03         2023-03-17        2023-03-18       NA
      88  recovered         <NA>         2023-03-20        2023-03-21       NA
      89  recovered         <NA>         2023-03-26        2023-03-27       NA
      90  recovered         <NA>         2023-03-24        2023-03-24       NA
      91  recovered         <NA>         2023-03-22        2023-03-24     24.5
      92  recovered         <NA>         2023-03-19        2023-03-24     25.8
      93  recovered         <NA>         2023-03-20        2023-03-20       NA
      94  recovered         <NA>         2023-03-29        2023-04-01     24.1
      95  recovered         <NA>         2023-03-27        2023-03-28       NA
      96  recovered         <NA>         2023-03-23        2023-03-28     27.2
      97  recovered         <NA>         2023-03-25        2023-03-29     26.4
      98  recovered         <NA>         2023-03-26        2023-03-28     21.7
      99  recovered         <NA>         2023-04-02        2023-04-07       NA
      100 recovered         <NA>         2023-04-03        2023-04-06     23.2
      101 recovered         <NA>         2023-03-31        2023-04-03       NA
      102 recovered         <NA>         2023-03-28        2023-04-01       NA
      103 recovered         <NA>         2023-03-24        2023-03-29       NA
      104 recovered         <NA>         2023-03-28        2023-04-01       NA
      105      died   2023-04-12         2023-03-30        2023-04-06       NA
      106 recovered         <NA>         2023-04-03        2023-04-05     26.1
      107      died   2023-04-14         2023-04-07        2023-04-08     25.4
      108      died   2023-04-28         2023-04-08        2023-04-08       NA
      109 recovered         <NA>         2023-04-06        2023-04-06       NA
      110 recovered         <NA>         2023-04-01        2023-04-05     25.4
      111 recovered         <NA>         2023-04-03        2023-04-06     24.8
      112 recovered         <NA>         2023-04-01        2023-04-04       NA
      113 recovered         <NA>         2023-04-11        2023-04-16     27.9
      114 recovered         <NA>         2023-04-09        2023-04-12     24.1
      115 recovered         <NA>         2023-04-05        2023-04-06     28.6
      116 recovered         <NA>         2023-04-01        2023-04-03     25.9
      117      died   2023-04-18         2023-04-01        2023-04-09     25.6
      118 recovered         <NA>         2023-04-04        2023-04-08       NA
      119 recovered         <NA>         2023-04-12        2023-04-13     22.7
      120      died   2023-04-22         2023-04-14        2023-04-17     24.3
      121 recovered         <NA>         2023-04-03        2023-04-05       NA
      122 recovered         <NA>         2023-04-09        2023-04-12     30.0
      123 recovered         <NA>         2023-04-10        2023-04-16       NA
      124 recovered         <NA>         2023-04-06        2023-04-11       NA
      125 recovered         <NA>         2023-04-07        2023-04-12     24.0
      126 recovered         <NA>         2023-04-04        2023-04-11     24.6
      127 recovered         <NA>         2023-04-10        2023-04-11       NA
      128 recovered         <NA>         2023-04-13        2023-04-16       NA
      129 recovered         <NA>         2023-04-14        2023-04-18       NA
      130 recovered         <NA>         2023-04-13        2023-04-14     22.1
      131 recovered         <NA>         2023-04-15        2023-04-18     23.8
      132      died   2023-05-02         2023-04-14        2023-04-14     22.3
      133 recovered         <NA>         2023-04-12        2023-04-21     27.1
      134 recovered         <NA>         2023-04-16        2023-04-21     27.6
      135 recovered         <NA>         2023-04-19        2023-04-25     25.5
      136      died   2023-05-05         2023-04-23        2023-04-25     25.1
      137 recovered         <NA>         2023-04-11        2023-04-15       NA
      138 recovered         <NA>         2023-04-23        2023-04-26       NA
      139 recovered         <NA>         2023-04-21        2023-04-22       NA
      140 recovered         <NA>         2023-04-18        2023-04-22     22.5
      141 recovered         <NA>         2023-04-21        2023-04-25     28.6
      142 recovered         <NA>         2023-05-05        2023-05-06       NA
      143 recovered         <NA>         2023-04-28        2023-04-29       NA
      144 recovered         <NA>         2023-04-19        2023-04-21     24.7
      145 recovered         <NA>         2023-04-21        2023-04-23       NA
      146 recovered         <NA>         2023-05-03        2023-05-05     23.6
      147 recovered         <NA>         2023-05-06        2023-05-08     26.1
      148 recovered         <NA>         2023-05-01        2023-05-03     28.7
      149 recovered         <NA>         2023-04-25        2023-04-27     25.5
      150 recovered         <NA>         2023-04-20        2023-04-25       NA
      151 recovered         <NA>         2023-05-08        2023-05-10     23.0
      152 recovered         <NA>         2023-04-28        2023-05-04     24.5
      153 recovered         <NA>         2023-04-19        2023-04-25     28.9
      154 recovered         <NA>         2023-04-25        2023-04-26       NA
      155 recovered         <NA>         2023-04-25        2023-04-29     21.3
      156 recovered         <NA>         2023-05-05        2023-05-08     25.4
      157 recovered         <NA>         2023-04-22        2023-04-28     27.4
      158      died   2023-05-17         2023-05-01        2023-05-03       NA
      
      $contacts
                               from                        to age sex
      1        Marquione Currington        Ghaaliba el-Hassen  90   f
      2        Marquione Currington   Leslie Morales-Gonzalez   4   f
      3          Ghaaliba el-Hassen           Qutb el-Ghattas  86   m
      4          Ghaaliba el-Hassen          Labeeb el-Hariri  29   m
      5     Leslie Morales-Gonzalez               Carla Moore  14   f
      6     Leslie Morales-Gonzalez        Saabiqa al-Hammoud  85   f
      7     Leslie Morales-Gonzalez            Zachary Farris  18   m
      8            Labeeb el-Hariri               Joseph Koul  59   m
      9                 Carla Moore              Alex Voliton  25   m
      10                Carla Moore                 Mara Gast  34   f
      11                Carla Moore       Dasha Willis-Arvizu  89   f
      12                Carla Moore               Laura Smith   5   f
      13         Saabiqa al-Hammoud          Justus Goodstein  63   m
      14                  Mara Gast            Jordan Brandon  50   m
      15                  Mara Gast           Michael Garhart   5   m
      16                  Mara Gast    Kayla Vazquez Barcenaz  89   f
      17        Dasha Willis-Arvizu       Kiyontus Howard III  74   m
      18           Justus Goodstein        Alexandria Hoshiko  34   f
      19           Justus Goodstein           Arhab el-Mourad  47   m
      20           Justus Goodstein           Joseph Mckenney  85   m
      21           Justus Goodstein              Sarah Walker  29   f
      22        Kiyontus Howard III Micael Quinteros-Renteria  24   m
      23         Alexandria Hoshiko             Kylie Warthen  46   f
      24         Alexandria Hoshiko             Tyler Herrera  63   m
      25         Alexandria Hoshiko            Sergio Velotta  19   m
      26         Alexandria Hoshiko                 Corey Mao  24   f
      27               Sarah Walker           Dylan Dickerson   9   m
      28               Sarah Walker              Alyce Hodges  41   f
      29               Sarah Walker        Kimuraamor Mizelle  72   f
      30               Sarah Walker          Christopher Bell   6   m
      31              Kylie Warthen          Raita el-Shehata   9   f
      32                  Corey Mao               Evan Mulder  61   m
      33                  Corey Mao              Lauren Garza  44   f
      34               Alyce Hodges           Mahaa al-Arshad  71   f
      35               Alyce Hodges              Dashawn Reed  34   m
      36               Alyce Hodges         Aabdeen al-Maroun  75   m
      37               Alyce Hodges           Mastoor al-Azer  69   m
      38               Alyce Hodges           Deshawn Gallion  61   m
      39               Alyce Hodges             Andrew Gibson  67   m
      40         Kimuraamor Mizelle Makalia Hernandez Mendoza  64   f
      41         Kimuraamor Mizelle            Tianna Coleman  11   f
      42         Kimuraamor Mizelle            Hayley Roberts  59   f
      43           Christopher Bell                Lewis Tani  61   m
      44           Christopher Bell             Shalin Decker  66   f
      45               Lauren Garza             Nkaujzoo Tran  16   f
      46            Mahaa al-Arshad             Alexander Bly  81   m
      47            Mahaa al-Arshad            Neelish Thrift  88   m
      48            Deshawn Gallion                 Alex Thao  53   m
      49            Deshawn Gallion            Alexander Ryan  53   m
      50  Makalia Hernandez Mendoza              Israel Downs  45   m
      51  Makalia Hernandez Mendoza              Olivia Close  42   f
      52  Makalia Hernandez Mendoza            Hannah Johnson  42   f
      53  Makalia Hernandez Mendoza          Maaiz al-Harroun  78   m
      54                 Lewis Tani            Sabri el-Pasha  35   m
      55                 Lewis Tani         Lizabeth Anderson  54   f
      56                 Lewis Tani            Laaiqa al-Miah  54   f
      57              Shalin Decker             Elijah Nguyen  68   m
      58              Shalin Decker          Hilmi al-Mustafa   3   m
      59              Shalin Decker              Darian Ramos  44   m
      60              Alexander Bly          Elizabeth Taylor  35   f
      61             Alexander Ryan          Leslie Gutierrez  23   f
      62             Alexander Ryan           Ayyoob al-Sabet  62   m
      63             Alexander Ryan          Quraish el-Aslam  35   m
      64               Israel Downs              Joanne Daley  90   f
      65               Israel Downs                Erica Rupp  25   f
      66           Maaiz al-Harroun                  Mele Vue  41   f
      67          Lizabeth Anderson             Mayra Jackson  17   f
      68          Lizabeth Anderson               Anna Tipoti  26   f
      69              Elijah Nguyen           Waleed el-Saleh  61   m
      70              Elijah Nguyen         Shantavia Barnett  46   f
      71           Hilmi al-Mustafa             Precious King  57   f
      72               Darian Ramos          Azeeza al-Othman   8   f
      73               Darian Ramos            Lynsz Martinez  11   f
      74            Ayyoob al-Sabet                David Jack  56   m
      75           Quraish el-Aslam               Se Quintana  32   f
      76           Quraish el-Aslam           Saamir al-Kalil  63   m
      77           Quraish el-Aslam             Sarah Hankins  54   f
      78           Quraish el-Aslam               Cole Ponzio  22   m
      79                 Erica Rupp         Majeeda el-Baluch  67   f
      80                 Erica Rupp          Andrew O'Dorisio  83   m
      81                 Erica Rupp          Nusaiba al-Ishak  16   f
      82                 Erica Rupp               Sarai Sells  38   f
      83          Shantavia Barnett            Tiffani Harris  19   f
      84           Azeeza al-Othman            Isaac Cardenas  37   m
      85           Azeeza al-Othman           Alicia Mehrotra  46   f
      86           Azeeza al-Othman         Shaamila al-Galla  64   f
      87            Saamir al-Kalil            Adam Gallagher  73   m
      88            Saamir al-Kalil              Zachary Abel  13   m
      89              Sarah Hankins           Waleeda al-Alam  72   f
      90              Sarah Hankins           Kelly Langcauon  12   f
      91          Majeeda el-Baluch             Julia Storrer  52   f
      92          Majeeda el-Baluch            Qais el-Younes  61   m
      93          Majeeda el-Baluch            Cicely Hickson   9   f
      94          Majeeda el-Baluch      Aimee Nakarmi Dhital   9   f
      95          Majeeda el-Baluch            Taylor Metzger  42   f
      96             Isaac Cardenas          Ridwaan el-Zaman  22   m
      97             Adam Gallagher           Azeema al-Rayes  29   f
      98               Zachary Abel               Karen Garza  15   f
      99               Zachary Abel       Humaira el-Ghaffari  69   f
      100              Zachary Abel            Subhi al-Qasim  17   m
      101              Zachary Abel      Brittany Habtemicael  21   f
      102              Zachary Abel                Amy Nguyen  54   f
      103              Zachary Abel           Alyssa Enriquez  20   f
      104              Zachary Abel             Jose Sandoval   9   m
      105            Qais el-Younes              Maya Bunting  26   f
      106            Qais el-Younes        Mubaaraka al-Habib  80   f
      107            Qais el-Younes               Luis Chacon  71   m
      108            Qais el-Younes              Asia Osborne  57   f
      109            Qais el-Younes             Caitlyn Kirby  77   f
      110           Azeema al-Rayes             Marley Wilson  90   f
      111            Subhi al-Qasim              Bryanna Diaz  58   f
      112            Subhi al-Qasim            Mondray Thomas  23   m
      113               Luis Chacon         Humaina al-Habeeb  35   f
      114             Marley Wilson           Paige Mendicino  66   f
      115            Mondray Thomas             Ishan Kumagai  62   m
      116            Mondray Thomas             Arnold Madera  62   m
      117            Mondray Thomas            Vincent Murphy  34   m
      118            Mondray Thomas             Joanna Guerra  57   f
      119         Humaina al-Habeeb           Dashelle Milner  44   f
      120         Humaina al-Habeeb               Te Hamilton  22   m
      121             Ishan Kumagai             Derek Cooksey  57   m
      122             Ishan Kumagai           Suhaib al-Hoque  63   m
      123             Joanna Guerra         Joelle Valenzuela   7   f
      124             Joanna Guerra           Christine Bajwa  46   f
      125             Joanna Guerra       Jalen Herrera-Vigil  66   m
      126           Dashelle Milner              Sir Williams   4   m
      127           Dashelle Milner               Anthony Fox  10   m
      128             Derek Cooksey         Dong-Keun Puentes  68   m
      129             Derek Cooksey                   Alex Vu  68   m
      130             Derek Cooksey          Alexander Nakata  12   m
      131           Suhaib al-Hoque          Naqiyya al-Nawaz  51   f
      132           Suhaib al-Hoque            Alia Archuleta  51   f
      133           Christine Bajwa       Benjamin Cunningham   8   m
      134       Jalen Herrera-Vigil           Mai Jing Eshima  55   f
      135                   Alex Vu               Joshua Ward  77   m
      136                   Alex Vu             Kalika Bostic  22   f
      137          Alexander Nakata           Maazina el-Amin   2   f
      138          Alexander Nakata             Albert Marley  53   m
      139            Alia Archuleta                Nhi Arvelo  31   f
      140            Alia Archuleta             Shania Wilson  77   f
      141            Alia Archuleta          Mackenzie Conley  76   f
      142            Alia Archuleta              Angel Silvas  82   m
      143            Alia Archuleta       Jeremiah Whiteplume  12   m
      144           Maazina el-Amin             Keyona Dydell  25   f
      145           Maazina el-Amin                Laura Sher  76   f
      146             Albert Marley         Tuvshinbayar Tran  14   m
      147             Albert Marley               Joseph Heng  31   m
      148             Albert Marley            Essence Neloms  90   f
      149             Albert Marley            Maiya Hazelman  76   f
      150          Mackenzie Conley              Tucker Manis  30   m
      151              Angel Silvas Shayla Hernandez Martinez  32   f
      152             Keyona Dydell                  Mori Hsu  78   m
      153             Keyona Dydell           Gretchen Prieto  75   f
      154             Keyona Dydell           Kameela al-Zaki  76   f
      155                Laura Sher           Siddeeqi el-Aly  88   m
      156         Tuvshinbayar Tran         Zumruda al-Arshad  80   f
      157         Tuvshinbayar Tran              Nimesha Kane  41   f
      158         Tuvshinbayar Tran               Jennifer An  78   f
      159         Tuvshinbayar Tran           Jaeson Malhotra  11   m
      160         Tuvshinbayar Tran       Brittanyclaire Neff  57   f
      161            Maiya Hazelman     Julian Garcia-Barrios  79   m
      162                  Mori Hsu            Matthew Welter  28   m
      163                  Mori Hsu            Kendall Rhoads   2   f
      164           Gretchen Prieto              Lashay Barry  16   f
      165           Kameela al-Zaki           Antaiaja Cromer  82   f
      166         Zumruda al-Arshad            Jazmen Johnson  51   f
      167         Zumruda al-Arshad        Angelina Hernandez  54   f
      168              Nimesha Kane               Alysia King  76   f
      169              Nimesha Kane              Stevie Jaime  56   f
      170              Nimesha Kane            Fikri al-Amara   5   m
      171               Jennifer An       Gabriella Two  Crow   1   f
      172            Matthew Welter              Yutitham Tan  44   m
      173            Matthew Welter         Ramalaan el-Zafar  76   m
      174           Antaiaja Cromer    Carlo Ceazar Phanekham   3   m
      175            Fikri al-Amara            Brandon Bailey  15   m
      176            Fikri al-Amara         Mu'taz al-Shabazz  19   m
      177            Fikri al-Amara               Ana Guijosa  76   f
      178       Gabriella Two  Crow          Jaylynn Gonzalez  12   f
      179         Ramalaan el-Zafar        Shukri el-Mohammed  43   m
      180         Ramalaan el-Zafar   Abdul Ghafoor al-Farooq   9   m
      181         Ramalaan el-Zafar              Ethan Turner  90   m
      182         Ramalaan el-Zafar            James Colligan   7   m
      183    Carlo Ceazar Phanekham       Treyvon Stadelbauer  15   m
      184    Carlo Ceazar Phanekham               Courtni Day  54   f
      185         Mu'taz al-Shabazz       Raashid el-Shehadeh  64   m
      186         Mu'taz al-Shabazz            Kristian Palma  21   m
      187         Mu'taz al-Shabazz               Ellen Lopez  37   f
      188         Mu'taz al-Shabazz             Nuzha el-Ally  35   f
      189         Mu'taz al-Shabazz             Serena Gaiser  70   f
      190               Ana Guijosa            Taamir al-Kaba  70   m
      191               Ana Guijosa             Crystal Mares  59   f
      192               Ana Guijosa           Faaris el-Sarah  77   m
      193               Ana Guijosa              Utkarsh Ngan  75   m
      194               Ana Guijosa           Tiffany Lenahan  84   f
      195              Ethan Turner            Joshua Sanchez  18   m
      196              Ethan Turner          Lolette Robinson  79   f
      197       Raashid el-Shehadeh           Hannah Williams  14   f
      198       Raashid el-Shehadeh            Mariah Simmons  49   f
      199       Raashid el-Shehadeh              Dawna Beeton  56   f
      200       Raashid el-Shehadeh                 Mia Lumba  76   f
      201             Nuzha el-Ally            David Reichman  41   m
      202             Nuzha el-Ally             Anisa Hatcher  16   f
      203             Nuzha el-Ally            Khongmong Tong   3   m
      204           Tiffany Lenahan        Mackenzie Mcmullen  29   f
      205           Tiffany Lenahan             Thomas Mosher  89   m
      206           Tiffany Lenahan           Nawaar al-Amiri  24   m
      207           Tiffany Lenahan             Sade Phillips  31   f
      208            Joshua Sanchez            Michael Navajo  39   m
      209            Joshua Sanchez           Ernesto Cachola  32   m
      210            Joshua Sanchez           Emmanuel Ibarra   9   m
      211          Lolette Robinson            Shane Santiago  82   m
      212            Mariah Simmons           Rachel Mcdonald  39   f
      213              Dawna Beeton          Saleet al-Rahimi  12   m
      214                 Mia Lumba   Savanna Delatorre-Lopez  54   f
      215                 Mia Lumba            Shuaib al-Imam  68   m
      216            David Reichman           Whitney Qureshi  73   f
      217            David Reichman          Chanise Armbrust  85   f
      218            David Reichman            Jamaal el-Reza  52   m
      219            David Reichman         Trever Feuerstein   3   m
      220        Mackenzie Mcmullen           Dalicia Wilkins  22   f
      221        Mackenzie Mcmullen          Ramla al-Massoud   5   f
      222            Michael Navajo        Mu,Aawiya al-Murad  66   m
      223            Michael Navajo          Jameela al-Rahim  68   f
      224           Ernesto Cachola          Taaj al-Siddique  38   m
      225           Ernesto Cachola              James Morgan  57   m
      226           Ernesto Cachola            Pedro Sendejas  48   m
      227           Emmanuel Ibarra          Sameeha al-Zaher  75   f
      228           Rachel Mcdonald            Desmond Castro   8   m
      229            Jamaal el-Reza               Elijah Ross  28   f
      230            Jamaal el-Reza             Tucker Flores  21   m
      231           Dalicia Wilkins              Yuvorn Ahmad   2   m
      232           Dalicia Wilkins           Jericho Powless  84   m
      233          Jameela al-Rahim               Claire Osse  52   f
      234          Jameela al-Rahim           Dearee Scurlock  58   m
      235          Jameela al-Rahim            Hafsa el-Pasha  29   f
      236              James Morgan        Cornelius Maryland   7   m
      237            Desmond Castro           Danielle Finken  30   f
      238            Desmond Castro              Itzel Zamora  11   f
      239              Yuvorn Ahmad           Yusri al-Salame  71   m
      240              Yuvorn Ahmad     Nelly Aviles Montalvo  50   f
      241           Jericho Powless        Qamraaa al-Shaheed  77   f
      242           Jericho Powless               Cody Parker  43   m
      243           Jericho Powless    Nakrista Kelly-Corichi  19   f
      244           Jericho Powless               Connor Hahs  40   m
      245           Jericho Powless              Eraina Smith  49   f
      246           Jericho Powless          Orville Trammell  11   m
      247           Jericho Powless              Edward Lopez  15   m
      248           Jericho Powless          Sidqi al-Hussein  61   m
      249            Hafsa el-Pasha               Kevin Huang  46   m
      250            Hafsa el-Pasha               Yusuf Shahi  69   m
      251            Hafsa el-Pasha             Ruby Martinez  69   f
      252            Hafsa el-Pasha             Jameel Curtis  38   m
      253           Danielle Finken              Ryan Sorrell  28   m
      254           Danielle Finken              Otoniel Huff  82   m
      255           Yusri al-Salame         Mastoor al-Shaker  45   m
      256           Yusri al-Salame      Marco Gomez-Buchanan  47   m
      257               Cody Parker      Nafeesa el-Mohiuddin  19   f
      258               Connor Hahs         Exzinia O'Donnell  85   f
      259               Kevin Huang           Caroline Garcia  24   f
      260               Kevin Huang          Muhaajir al-Ozer  46   m
      261               Yusuf Shahi             Jazmine Mcgee  71   f
      262               Yusuf Shahi      Jumail al-Salahuddin  69   m
      263             Ruby Martinez        Nawwaara al-Hammad   4   f
      264             Ruby Martinez           Trevor Videtzky  31   m
      265             Jameel Curtis              Kimiko Smith  18   f
      266             Jameel Curtis          Ghaaliya al-Azzi  16   f
      267             Jameel Curtis          Mansoor el-Salem  53   m
      268              Ryan Sorrell          Nizaam al-Akbari  62   m
      269              Ryan Sorrell                 Micah Cha  87   m
      270              Otoniel Huff         Carmelita Baldwin  28   f
      271              Otoniel Huff       Christian Rodriguez  42   m
      272      Nafeesa el-Mohiuddin          Laraena Sturgeon  42   f
      273          Muhaajir al-Ozer         Kashauna Thompson  84   f
      274          Muhaajir al-Ozer                 Daniel La  29   m
      275             Jazmine Mcgee             Austin Powell  47   m
      276             Jazmine Mcgee             Russell Stott  14   m
      277        Nawwaara al-Hammad             Diksha Javaid  48   f
      278          Ghaaliya al-Azzi            Ronnie Labadie  89   m
      279          Ghaaliya al-Azzi        Alexander Mitchell  39   m
      280          Ghaaliya al-Azzi            Shamari Batson  17   f
      281          Mansoor el-Salem          Brandon Marchman  20   m
      282          Mansoor el-Salem               Medhavi Tan  61   f
      283             Russell Stott            Jasmine Thomas   6   f
      284             Diksha Javaid           De'Chelle Yorks  28   f
      285            Ronnie Labadie          Keeman Martzloff  83   m
      286            Ronnie Labadie              Henry Arnick  68   m
      287            Ronnie Labadie              Cairra Woods  47   m
      288          Brandon Marchman                Monica Chu  73   f
      289          Brandon Marchman           Gloria Sandoval  24   f
      290          Brandon Marchman   Alexander Rangel Mendez  42   m
      291          Brandon Marchman          Taylor Pickering  71   f
      292            Jasmine Thomas      Cheyanna Bear-Flores   9   f
      293            Jasmine Thomas          Brittany Shaheen  78   f
      294           De'Chelle Yorks               Alexis Wall  24   f
      295           De'Chelle Yorks        Rhiannon Aviado II  61   f
      296   Alexander Rangel Mendez             Isabella Sena  49   f
      297   Alexander Rangel Mendez                Samuel San  53   m
      298   Alexander Rangel Mendez         Nadheera el-Ahmad  63   f
      299          Taylor Pickering             Alicia Nguyen  29   f
      300          Taylor Pickering              Lafaith Bean  76   f
      301          Taylor Pickering          Morgan Tollivoro  69   f
      302      Cheyanna Bear-Flores             Deisha Cooper  63   f
      303      Cheyanna Bear-Flores            Weston Henzler  50   m
      304      Cheyanna Bear-Flores              Shelby Jiron  58   f
      305                Samuel San            Mathurin Baker  88   m
      306                Samuel San           Hissa el-Yassin   7   f
      307                Samuel San  Collin Valencia Anchondo  51   m
      308              Lafaith Bean            Rida al-Firman  47   m
      309              Lafaith Bean            Afaaf el-Anwar  45   f
      310              Lafaith Bean             Joshua Molina  83   m
      311              Lafaith Bean            Rebekah Norman  30   f
      312          Morgan Tollivoro         Nichole Scharnell  41   f
      313            Weston Henzler              Shawn Miller  15   m
      314            Weston Henzler          Habeeba al-Salam  27   f
      315            Weston Henzler              Renae Mcadoo  88   f
      316           Hissa el-Yassin          Bertha Andreatta  74   f
      317            Afaaf el-Anwar           Aliyya al-Abdoo   1   f
      318            Afaaf el-Anwar         Chandel Caramillo  84   f
      319             Joshua Molina  Jeremy Montelongo Declay  79   m
      320         Nichole Scharnell           Mikayla Hopkins  54   f
      321         Nichole Scharnell           Markese Conners  24   m
      322         Nichole Scharnell        Christian Espinosa  37   m
      323              Renae Mcadoo          Rashele Freeland   3   f
      324              Renae Mcadoo             Qaaid al-Sala  48   m
      325  Jeremy Montelongo Declay           Jez-Mas Powells  82   m
      326           Jez-Mas Powells            Cassandra Long  30   f
          date_first_contact date_last_contact was_case           status
      1           2022-12-31        2023-01-05        Y             case
      2           2022-12-30        2023-01-01        Y             case
      3           2023-01-02        2023-01-04        N   under_followup
      4           2023-01-05        2023-01-05        Y             case
      5           2023-01-07        2023-01-08        Y             case
      6           2023-01-03        2023-01-06        Y             case
      7           2023-01-02        2023-01-04        N   under_followup
      8           2023-01-02        2023-01-06        N   under_followup
      9           2023-01-06        2023-01-06        Y             case
      10          2023-01-01        2023-01-06        Y             case
      11          2023-01-06        2023-01-08        Y             case
      12          2023-01-05        2023-01-07        N   under_followup
      13          2023-01-02        2023-01-08        Y             case
      14          2023-01-14        2023-01-17        N   under_followup
      15          2023-01-10        2023-01-13        N   under_followup
      16          2023-01-07        2023-01-13        N lost_to_followup
      17          2023-01-12        2023-01-17        Y             case
      18          2023-01-09        2023-01-11        Y             case
      19          2023-01-11        2023-01-15        N   under_followup
      20          2023-01-12        2023-01-15        N   under_followup
      21          2023-01-12        2023-01-14        Y             case
      22          2023-01-12        2023-01-16        N   under_followup
      23          2023-01-10        2023-01-16        Y             case
      24          2023-01-12        2023-01-14        N   under_followup
      25          2023-01-13        2023-01-16        N   under_followup
      26          2023-01-11        2023-01-13        Y             case
      27          2023-01-15        2023-01-16        N          unknown
      28          2023-01-11        2023-01-15        Y             case
      29          2023-01-14        2023-01-17        Y             case
      30          2023-01-14        2023-01-16        Y             case
      31          2023-01-17        2023-01-18        N   under_followup
      32          2023-01-12        2023-01-16        Y             case
      33          2023-01-13        2023-01-17        Y             case
      34          2023-01-22        2023-01-23        Y             case
      35          2023-01-19        2023-01-23        N          unknown
      36          2023-01-26        2023-01-26        N lost_to_followup
      37          2023-01-20        2023-01-22        Y             case
      38          2023-01-19        2023-01-23        Y             case
      39          2023-01-21        2023-01-23        N   under_followup
      40          2023-01-19        2023-01-22        Y             case
      41          2023-01-15        2023-01-20        N   under_followup
      42          2023-01-19        2023-01-21        N lost_to_followup
      43          2023-01-23        2023-01-24        Y             case
      44          2023-01-23        2023-01-25        Y             case
      45          2023-01-15        2023-01-16        N   under_followup
      46          2023-01-23        2023-01-28        Y             case
      47          2023-01-25        2023-01-29        N   under_followup
      48          2023-01-26        2023-01-27        N   under_followup
      49          2023-01-22        2023-01-24        Y             case
      50          2023-01-23        2023-01-28        Y             case
      51          2023-01-22        2023-01-27        N   under_followup
      52          2023-01-25        2023-01-26        Y             case
      53          2023-01-24        2023-01-26        Y             case
      54          2023-01-23        2023-01-26        Y             case
      55          2023-01-18        2023-01-23        Y             case
      56          2023-01-25        2023-01-27        N   under_followup
      57          2023-01-19        2023-01-23        Y             case
      58          2023-01-22        2023-01-26        Y             case
      59          2023-01-27        2023-01-27        Y             case
      60          2023-02-04        2023-02-04        N   under_followup
      61          2023-01-29        2023-01-30        N   under_followup
      62          2023-01-26        2023-01-28        Y             case
      63          2023-01-25        2023-01-30        Y             case
      64          2023-01-27        2023-01-30        Y             case
      65          2023-01-27        2023-01-31        Y             case
      66          2023-01-31        2023-02-04        N lost_to_followup
      67          2023-01-27        2023-01-28        N lost_to_followup
      68          2023-01-24        2023-01-29        N          unknown
      69          2023-01-26        2023-01-27        N          unknown
      70          2023-01-30        2023-01-31        Y             case
      71          2023-01-20        2023-01-25        N   under_followup
      72          2023-02-01        2023-02-04        Y             case
      73          2023-01-29        2023-01-31        N   under_followup
      74          2023-01-31        2023-02-04        N          unknown
      75          2023-01-24        2023-01-30        N lost_to_followup
      76          2023-01-28        2023-02-02        Y             case
      77          2023-01-27        2023-02-02        Y             case
      78          2023-01-29        2023-02-01        N   under_followup
      79          2023-02-03        2023-02-04        Y             case
      80          2023-01-31        2023-02-05        N   under_followup
      81          2023-02-01        2023-02-02        N lost_to_followup
      82          2023-02-01        2023-02-04        N   under_followup
      83          2023-02-01        2023-02-02        N   under_followup
      84          2023-02-01        2023-02-03        Y             case
      85          2023-01-28        2023-02-01        N   under_followup
      86          2023-01-30        2023-02-03        N lost_to_followup
      87          2023-01-31        2023-02-01        Y             case
      88          2023-01-30        2023-02-02        Y             case
      89          2023-01-31        2023-01-31        Y             case
      90          2023-01-31        2023-02-04        N   under_followup
      91          2023-01-28        2023-02-04        N          unknown
      92          2023-01-30        2023-02-04        Y             case
      93          2023-02-01        2023-02-06        N   under_followup
      94          2023-02-01        2023-02-03        N lost_to_followup
      95          2023-01-31        2023-02-04        N          unknown
      96          2023-02-04        2023-02-06        Y             case
      97          2023-02-03        2023-02-05        Y             case
      98          2023-02-02        2023-02-04        N   under_followup
      99          2023-02-02        2023-02-05        N lost_to_followup
      100         2023-01-30        2023-02-04        Y             case
      101         2023-02-04        2023-02-08        N   under_followup
      102         2023-01-31        2023-02-07        N   under_followup
      103         2023-02-05        2023-02-06        N   under_followup
      104         2023-01-30        2023-02-04        N   under_followup
      105         2023-02-01        2023-02-04        N   under_followup
      106         2023-02-01        2023-02-06        N   under_followup
      107         2023-02-05        2023-02-08        Y             case
      108         2023-02-04        2023-02-10        N   under_followup
      109         2023-02-02        2023-02-08        N   under_followup
      110         2023-02-06        2023-02-08        Y             case
      111         2023-02-08        2023-02-12        N   under_followup
      112         2023-02-10        2023-02-11        Y             case
      113         2023-02-14        2023-02-19        Y             case
      114         2023-02-11        2023-02-12        N   under_followup
      115         2023-02-13        2023-02-16        Y             case
      116         2023-02-10        2023-02-13        N lost_to_followup
      117         2023-02-15        2023-02-16        N   under_followup
      118         2023-02-10        2023-02-13        Y             case
      119         2023-02-16        2023-02-18        Y             case
      120         2023-02-18        2023-02-18        N   under_followup
      121         2023-03-02        2023-03-02        Y             case
      122         2023-02-26        2023-03-03        Y             case
      123         2023-02-18        2023-02-23        N lost_to_followup
      124         2023-02-24        2023-02-26        Y             case
      125         2023-02-17        2023-02-23        Y             case
      126         2023-02-18        2023-02-21        N lost_to_followup
      127         2023-02-16        2023-02-19        N lost_to_followup
      128         2023-03-01        2023-03-05        N   under_followup
      129         2023-03-06        2023-03-07        Y             case
      130         2023-03-03        2023-03-04        Y             case
      131         2023-03-04        2023-03-09        N   under_followup
      132         2023-03-07        2023-03-09        Y             case
      133         2023-02-27        2023-03-02        N   under_followup
      134         2023-03-02        2023-03-07        N   under_followup
      135         2023-03-08        2023-03-10        N lost_to_followup
      136         2023-03-02        2023-03-09        N   under_followup
      137         2023-03-06        2023-03-11        Y             case
      138         2023-03-07        2023-03-11        Y             case
      139         2023-03-16        2023-03-18        N   under_followup
      140         2023-03-14        2023-03-18        N   under_followup
      141         2023-03-18        2023-03-23        Y             case
      142         2023-03-20        2023-03-20        Y             case
      143         2023-03-19        2023-03-21        N          unknown
      144         2023-03-07        2023-03-12        Y             case
      145         2023-03-10        2023-03-14        Y             case
      146         2023-03-06        2023-03-11        Y             case
      147         2023-03-08        2023-03-12        N   under_followup
      148         2023-03-07        2023-03-09        N   under_followup
      149         2023-03-10        2023-03-11        Y             case
      150         2023-03-26        2023-03-29        N lost_to_followup
      151         2023-03-23        2023-03-27        N   under_followup
      152         2023-03-16        2023-03-21        Y             case
      153         2023-03-16        2023-03-19        Y             case
      154         2023-03-12        2023-03-19        Y             case
      155         2023-03-10        2023-03-14        N lost_to_followup
      156         2023-03-13        2023-03-14        Y             case
      157         2023-03-12        2023-03-14        Y             case
      158         2023-03-12        2023-03-17        Y             case
      159         2023-03-15        2023-03-18        N lost_to_followup
      160         2023-03-10        2023-03-15        N   under_followup
      161         2023-03-06        2023-03-12        N   under_followup
      162         2023-03-12        2023-03-17        Y             case
      163         2023-03-15        2023-03-18        Y             case
      164         2023-03-26        2023-03-29        N lost_to_followup
      165         2023-03-21        2023-03-25        Y             case
      166         2023-03-16        2023-03-19        N   under_followup
      167         2023-03-20        2023-03-22        N   under_followup
      168         2023-03-17        2023-03-20        N   under_followup
      169         2023-03-21        2023-03-22        N   under_followup
      170         2023-03-16        2023-03-20        Y             case
      171         2023-03-18        2023-03-21        Y             case
      172         2023-03-17        2023-03-18        Y             case
      173         2023-03-20        2023-03-21        Y             case
      174         2023-03-26        2023-03-27        Y             case
      175         2023-03-24        2023-03-24        Y             case
      176         2023-03-22        2023-03-24        Y             case
      177         2023-03-19        2023-03-24        Y             case
      178         2023-03-23        2023-03-24        N   under_followup
      179         2023-03-20        2023-03-21        N          unknown
      180         2023-03-20        2023-03-20        N   under_followup
      181         2023-03-20        2023-03-20        Y             case
      182         2023-03-11        2023-03-17        N          unknown
      183         2023-03-28        2023-04-02        N   under_followup
      184         2023-04-01        2023-04-02        N lost_to_followup
      185         2023-03-29        2023-04-01        Y             case
      186         2023-03-24        2023-03-26        N   under_followup
      187         2023-03-27        2023-03-29        N   under_followup
      188         2023-03-27        2023-03-28        Y             case
      189         2023-03-27        2023-03-30        N   under_followup
      190         2023-03-25        2023-03-29        N   under_followup
      191         2023-03-25        2023-03-27        N lost_to_followup
      192         2023-03-23        2023-03-27        N   under_followup
      193         2023-03-24        2023-03-29        N   under_followup
      194         2023-03-23        2023-03-28        Y             case
      195         2023-03-25        2023-03-29        Y             case
      196         2023-03-26        2023-03-28        Y             case
      197         2023-04-08        2023-04-08        N   under_followup
      198         2023-04-02        2023-04-07        Y             case
      199         2023-04-03        2023-04-06        Y             case
      200         2023-03-31        2023-04-03        Y             case
      201         2023-03-28        2023-04-01        Y             case
      202         2023-03-30        2023-03-31        N   under_followup
      203         2023-03-28        2023-04-01        N   under_followup
      204         2023-03-24        2023-03-29        Y             case
      205         2023-03-27        2023-03-27        N   under_followup
      206         2023-03-24        2023-03-30        N   under_followup
      207         2023-03-26        2023-03-28        N lost_to_followup
      208         2023-03-28        2023-04-01        Y             case
      209         2023-03-30        2023-04-06        Y             case
      210         2023-04-03        2023-04-05        Y             case
      211         2023-03-28        2023-04-01        N   under_followup
      212         2023-04-07        2023-04-08        Y             case
      213         2023-04-08        2023-04-08        Y             case
      214         2023-04-07        2023-04-10        N   under_followup
      215         2023-04-10        2023-04-10        N   under_followup
      216         2023-04-02        2023-04-03        N lost_to_followup
      217         2023-04-02        2023-04-06        N          unknown
      218         2023-04-06        2023-04-06        Y             case
      219         2023-04-04        2023-04-07        N   under_followup
      220         2023-04-01        2023-04-05        Y             case
      221         2023-03-31        2023-04-05        N   under_followup
      222         2023-04-04        2023-04-06        N   under_followup
      223         2023-04-03        2023-04-06        Y             case
      224         2023-04-03        2023-04-05        N   under_followup
      225         2023-04-01        2023-04-04        Y             case
      226         2023-04-02        2023-04-04        N   under_followup
      227         2023-04-04        2023-04-07        N   under_followup
      228         2023-04-11        2023-04-16        Y             case
      229         2023-04-09        2023-04-12        Y             case
      230         2023-04-11        2023-04-12        N   under_followup
      231         2023-04-05        2023-04-06        Y             case
      232         2023-04-01        2023-04-03        Y             case
      233         2023-04-01        2023-04-09        Y             case
      234         2023-04-04        2023-04-08        Y             case
      235         2023-04-12        2023-04-13        Y             case
      236         2023-04-05        2023-04-08        N lost_to_followup
      237         2023-04-14        2023-04-17        Y             case
      238         2023-04-11        2023-04-13        N lost_to_followup
      239         2023-04-03        2023-04-05        Y             case
      240         2023-04-03        2023-04-06        N   under_followup
      241         2023-04-06        2023-04-12        N   under_followup
      242         2023-04-09        2023-04-12        Y             case
      243         2023-04-09        2023-04-14        N          unknown
      244         2023-04-10        2023-04-16        Y             case
      245         2023-04-09        2023-04-11        N   under_followup
      246         2023-04-07        2023-04-10        N   under_followup
      247         2023-04-07        2023-04-10        N   under_followup
      248         2023-04-12        2023-04-14        N   under_followup
      249         2023-04-06        2023-04-11        Y             case
      250         2023-04-07        2023-04-12        Y             case
      251         2023-04-04        2023-04-11        Y             case
      252         2023-04-10        2023-04-11        Y             case
      253         2023-04-13        2023-04-16        Y             case
      254         2023-04-14        2023-04-18        Y             case
      255         2023-04-17        2023-04-18        N   under_followup
      256         2023-04-11        2023-04-16        N   under_followup
      257         2023-04-13        2023-04-14        Y             case
      258         2023-04-15        2023-04-16        N lost_to_followup
      259         2023-04-11        2023-04-18        N   under_followup
      260         2023-04-15        2023-04-18        Y             case
      261         2023-04-14        2023-04-14        Y             case
      262         2023-04-09        2023-04-14        N   under_followup
      263         2023-04-12        2023-04-21        Y             case
      264         2023-04-16        2023-04-21        Y             case
      265         2023-04-24        2023-04-26        N   under_followup
      266         2023-04-19        2023-04-25        Y             case
      267         2023-04-23        2023-04-25        Y             case
      268         2023-04-10        2023-04-17        N   under_followup
      269         2023-04-13        2023-04-16        N   under_followup
      270         2023-04-16        2023-04-19        N   under_followup
      271         2023-04-13        2023-04-18        N   under_followup
      272         2023-04-16        2023-04-17        N   under_followup
      273         2023-04-25        2023-04-28        N lost_to_followup
      274         2023-04-25        2023-04-27        N lost_to_followup
      275         2023-04-16        2023-04-16        N          unknown
      276         2023-04-11        2023-04-15        Y             case
      277         2023-04-23        2023-04-26        Y             case
      278         2023-04-21        2023-04-22        Y             case
      279         2023-04-18        2023-04-22        Y             case
      280         2023-04-21        2023-04-25        N   under_followup
      281         2023-04-21        2023-04-25        Y             case
      282         2023-04-26        2023-04-27        N   under_followup
      283         2023-05-05        2023-05-06        Y             case
      284         2023-04-28        2023-04-29        Y             case
      285         2023-04-28        2023-04-28        N   under_followup
      286         2023-04-27        2023-04-30        N   under_followup
      287         2023-04-26        2023-04-28        N   under_followup
      288         2023-04-22        2023-04-24        N   under_followup
      289         2023-04-22        2023-04-23        N   under_followup
      290         2023-04-19        2023-04-21        Y             case
      291         2023-04-21        2023-04-23        Y             case
      292         2023-05-03        2023-05-05        Y             case
      293         2023-05-07        2023-05-08        N   under_followup
      294         2023-05-03        2023-05-09        N   under_followup
      295         2023-05-06        2023-05-08        Y             case
      296         2023-05-03        2023-05-04        N   under_followup
      297         2023-05-01        2023-05-03        Y             case
      298         2023-04-28        2023-05-01        N   under_followup
      299         2023-04-25        2023-04-29        N   under_followup
      300         2023-04-25        2023-04-27        Y             case
      301         2023-04-20        2023-04-25        Y             case
      302         2023-04-30        2023-05-09        N   under_followup
      303         2023-05-08        2023-05-10        Y             case
      304         2023-05-04        2023-05-07        N   under_followup
      305         2023-05-04        2023-05-06        N   under_followup
      306         2023-04-28        2023-05-04        Y             case
      307         2023-05-03        2023-05-06        N   under_followup
      308         2023-04-26        2023-04-30        N   under_followup
      309         2023-04-19        2023-04-25        Y             case
      310         2023-04-25        2023-04-26        Y             case
      311         2023-04-24        2023-04-27        N   under_followup
      312         2023-04-25        2023-04-29        Y             case
      313         2023-05-08        2023-05-08        N lost_to_followup
      314         2023-05-04        2023-05-08        N   under_followup
      315         2023-05-05        2023-05-08        Y             case
      316         2023-05-07        2023-05-10        N lost_to_followup
      317         2023-04-23        2023-04-26        N   under_followup
      318         2023-04-25        2023-04-25        N   under_followup
      319         2023-04-22        2023-04-28        Y             case
      320         2023-04-22        2023-04-29        N   under_followup
      321         2023-04-27        2023-04-30        N          unknown
      322         2023-04-29        2023-05-02        N          unknown
      323         2023-05-10        2023-05-12        N lost_to_followup
      324         2023-05-15        2023-05-16        N   under_followup
      325         2023-05-01        2023-05-03        Y             case
      326         2023-05-09        2023-05-14        N          unknown
      

# sim_outbreak works as expected

    Code
      sim_outbreak(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death)
    Output
      $linelist
         id        case_name case_type sex age date_onset date_admission   outcome
      1   1  Wajdi al-Demian  probable   m  35 2023-01-01           <NA> recovered
      2   2    Raaid el-Diab confirmed   m  43 2023-01-01     2023-01-07 recovered
      3   3   Nickolas Nault suspected   m   1 2023-01-01           <NA> recovered
      4   5      Hee Kennedy confirmed   m  78 2023-01-01     2023-01-03      died
      5   6      Hope Arshad suspected   f  22 2023-01-01     2023-01-28      died
      6   8   Shanta Holiday  probable   f  28 2023-01-01           <NA> recovered
      7  11 Raakaan al-Shams  probable   m  46 2023-01-01           <NA> recovered
      8  12   Chandra Kilian suspected   f  67 2023-01-01           <NA> recovered
      9  13  Ricardo Sanchez confirmed   m  86 2023-01-01           <NA> recovered
      10 18    Kanani Nguyen confirmed   f  60 2023-01-02           <NA> recovered
      11 20   Jared Chambers  probable   m  49 2023-01-02           <NA> recovered
      12 22     Annie Carter  probable   f   7 2023-01-02           <NA> recovered
         date_outcome date_first_contact date_last_contact ct_value
      1          <NA>               <NA>              <NA>       NA
      2          <NA>         2022-12-30        2023-01-05     23.2
      3          <NA>         2022-12-30        2023-01-02       NA
      4    2023-01-21         2022-12-29        2023-01-02     25.2
      5    2023-01-10         2023-01-01        2023-01-03       NA
      6          <NA>         2023-01-03        2023-01-04       NA
      7          <NA>         2023-01-04        2023-01-05       NA
      8          <NA>         2023-01-01        2023-01-04       NA
      9          <NA>         2022-12-31        2023-01-03     25.7
      10         <NA>         2022-12-30        2023-01-03     26.1
      11         <NA>         2023-01-01        2023-01-04       NA
      12         <NA>         2023-01-01        2023-01-03       NA
      
      $contacts
                     from                     to age sex date_first_contact
      1   Wajdi al-Demian          Raaid el-Diab  43   m         2022-12-30
      2   Wajdi al-Demian         Nickolas Nault   1   m         2022-12-30
      3     Raaid el-Diab            Durine Cobb  29   f         2022-12-27
      4     Raaid el-Diab            Hee Kennedy  78   m         2022-12-29
      5    Nickolas Nault            Hope Arshad  22   f         2023-01-01
      6    Nickolas Nault      Mubarak el-Vaziri  70   m         2022-12-30
      7    Nickolas Nault         Shanta Holiday  28   f         2023-01-03
      8       Hee Kennedy           Darian Guyon  37   f         2023-01-06
      9       Hope Arshad          Mackenzie Ahn  61   f         2023-01-01
      10   Shanta Holiday       Raakaan al-Shams  46   m         2023-01-04
      11   Shanta Holiday         Chandra Kilian  67   f         2023-01-01
      12   Shanta Holiday        Ricardo Sanchez  86   m         2022-12-31
      13 Raakaan al-Shams         Tae Woo Nguyen  71   m         2022-12-28
      14 Raakaan al-Shams       Mikhaila Carlson  51   f         2023-01-01
      15 Raakaan al-Shams         Alexander Orio  44   m         2023-01-02
      16   Chandra Kilian      Alexandra Johnson  49   f         2023-01-02
      17  Ricardo Sanchez          Kanani Nguyen  60   f         2022-12-30
      18  Ricardo Sanchez Nirvana Elizalde Villa  56   f         2023-01-06
      19  Ricardo Sanchez         Jared Chambers  49   m         2023-01-01
      20  Ricardo Sanchez         Thomas Morales  50   m         2023-01-01
      21    Kanani Nguyen           Annie Carter   7   f         2023-01-01
         date_last_contact was_case           status
      1         2023-01-05        Y             case
      2         2023-01-02        Y             case
      3         2023-01-03        N   under_followup
      4         2023-01-02        Y             case
      5         2023-01-03        Y             case
      6         2023-01-02        N   under_followup
      7         2023-01-04        Y             case
      8         2023-01-06        N          unknown
      9         2023-01-05        N lost_to_followup
      10        2023-01-05        Y             case
      11        2023-01-04        Y             case
      12        2023-01-03        Y             case
      13        2023-01-05        N lost_to_followup
      14        2023-01-04        N          unknown
      15        2023-01-05        N          unknown
      16        2023-01-03        N   under_followup
      17        2023-01-03        Y             case
      18        2023-01-09        N   under_followup
      19        2023-01-04        Y             case
      20        2023-01-03        N   under_followup
      21        2023-01-03        Y             case
      

# sim_outbreak works as expected with anonymised

    Code
      sim_outbreak(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death,
        anonymise = TRUE)
    Output
      $linelist
         id  case_name case_type sex age date_onset date_admission   outcome
      1   1 qKY39Zyiuu  probable   m  35 2023-01-01           <NA> recovered
      2   2 oY8Kxng7Az confirmed   m  43 2023-01-01     2023-01-07 recovered
      3   3 DS6oXfHuaq  probable   m   1 2023-01-01           <NA> recovered
      4   5 yEtT6tejRt confirmed   m  78 2023-01-01     2023-01-03      died
      5   6 34oCba8e6y confirmed   f  22 2023-01-01     2023-01-28      died
      6   8 eZaLTmhWsV suspected   f  28 2023-01-01           <NA> recovered
      7  11 XnmE3U4HDz confirmed   m  46 2023-01-01           <NA> recovered
      8  12 SVgVAWQihv confirmed   f  67 2023-01-01           <NA> recovered
      9  13 SfYVARDjDa confirmed   m  86 2023-01-01           <NA> recovered
      10 18 3p6KxuczwJ  probable   f  60 2023-01-02           <NA> recovered
      11 20 6ZKaUKvu5A  probable   m  49 2023-01-02           <NA> recovered
      12 22 tN2GNkk2uu confirmed   f   7 2023-01-02           <NA> recovered
         date_outcome date_first_contact date_last_contact ct_value
      1          <NA>               <NA>              <NA>       NA
      2          <NA>         2022-12-30        2023-01-05     23.4
      3          <NA>         2022-12-30        2023-01-02       NA
      4    2023-01-21         2022-12-29        2023-01-02     24.9
      5    2023-01-10         2023-01-01        2023-01-03     22.7
      6          <NA>         2023-01-03        2023-01-04       NA
      7          <NA>         2023-01-04        2023-01-05     25.0
      8          <NA>         2023-01-01        2023-01-04     25.3
      9          <NA>         2022-12-31        2023-01-03     24.7
      10         <NA>         2022-12-30        2023-01-03       NA
      11         <NA>         2023-01-01        2023-01-04       NA
      12         <NA>         2023-01-01        2023-01-03     24.7
      
      $contacts
               from         to age sex date_first_contact date_last_contact was_case
      1  qKY39Zyiuu oY8Kxng7Az  43   m         2022-12-30        2023-01-05        Y
      2  qKY39Zyiuu DS6oXfHuaq   1   m         2022-12-30        2023-01-02        Y
      3  oY8Kxng7Az m1SzNbO5h4  29   f         2022-12-27        2023-01-03        N
      4  oY8Kxng7Az yEtT6tejRt  78   m         2022-12-29        2023-01-02        Y
      5  DS6oXfHuaq 34oCba8e6y  22   f         2023-01-01        2023-01-03        Y
      6  DS6oXfHuaq KFNmydPL7X  70   m         2022-12-30        2023-01-02        N
      7  DS6oXfHuaq eZaLTmhWsV  28   f         2023-01-03        2023-01-04        Y
      8  yEtT6tejRt UBVWYTLkhw  37   f         2023-01-06        2023-01-06        N
      9  34oCba8e6y 9tYeb1elcz  61   f         2023-01-01        2023-01-05        N
      10 eZaLTmhWsV XnmE3U4HDz  46   m         2023-01-04        2023-01-05        Y
      11 eZaLTmhWsV SVgVAWQihv  67   f         2023-01-01        2023-01-04        Y
      12 eZaLTmhWsV SfYVARDjDa  86   m         2022-12-31        2023-01-03        Y
      13 XnmE3U4HDz fq8m2zbFUJ  71   m         2022-12-28        2023-01-05        N
      14 XnmE3U4HDz RewLYtBBlI  51   f         2023-01-01        2023-01-04        N
      15 XnmE3U4HDz dUTzmcTo9H  44   m         2023-01-02        2023-01-05        N
      16 SVgVAWQihv LY9VZdzuuT  49   f         2023-01-02        2023-01-03        N
      17 SfYVARDjDa 3p6KxuczwJ  60   f         2022-12-30        2023-01-03        Y
      18 SfYVARDjDa 3WvUcVV4dJ  56   f         2023-01-06        2023-01-09        N
      19 SfYVARDjDa 6ZKaUKvu5A  49   m         2023-01-01        2023-01-04        Y
      20 SfYVARDjDa k6RZkfVJ5f  50   m         2023-01-01        2023-01-03        N
      21 3p6KxuczwJ tN2GNkk2uu   7   f         2023-01-01        2023-01-03        Y
                   status
      1              case
      2              case
      3           unknown
      4              case
      5              case
      6    under_followup
      7              case
      8  lost_to_followup
      9    under_followup
      10             case
      11             case
      12             case
      13 lost_to_followup
      14   under_followup
      15   under_followup
      16   under_followup
      17             case
      18   under_followup
      19             case
      20 lost_to_followup
      21             case
      

# sim_outbreak works as expected with age-strat risks

    Code
      sim_outbreak(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death,
        hosp_risk = age_dep_hosp_risk, hosp_death_risk = age_dep_hosp_death_risk,
        non_hosp_death_risk = age_dep_non_hosp_death_risk)
    Output
      $linelist
         id          case_name case_type sex age date_onset date_admission   outcome
      1   1         Kyle Crane suspected   m  35 2023-01-01           <NA> recovered
      2   2 Ghaamid el-Ishmael confirmed   m  43 2023-01-01     2023-01-07 recovered
      3   3   Faatih el-Kaiser confirmed   m   1 2023-01-01           <NA> recovered
      4   5   Va'Aahi Galligan suspected   m  78 2023-01-01           <NA> recovered
      5   6     Katelyn Catlin confirmed   f  22 2023-01-01           <NA> recovered
      6   8       Lynsey Duron confirmed   f  28 2023-01-01           <NA> recovered
      7  11    Wajdi al-Demian confirmed   m  46 2023-01-01           <NA> recovered
      8  12       Jacy Cousins confirmed   f  67 2023-01-01           <NA> recovered
      9  13      Travis Foster confirmed   m  86 2023-01-01           <NA> recovered
      10 18     Maria Eberhart  probable   f  60 2023-01-02           <NA> recovered
      11 20  Mubarak el-Vaziri suspected   m  49 2023-01-02           <NA> recovered
      12 22        Erin Payson confirmed   f   7 2023-01-02           <NA> recovered
         date_outcome date_first_contact date_last_contact ct_value
      1          <NA>               <NA>              <NA>       NA
      2          <NA>         2022-12-30        2023-01-05     25.3
      3          <NA>         2022-12-30        2023-01-02     25.8
      4          <NA>         2022-12-29        2023-01-02       NA
      5          <NA>         2023-01-01        2023-01-03     24.9
      6          <NA>         2023-01-03        2023-01-04     24.5
      7          <NA>         2023-01-04        2023-01-05     26.4
      8          <NA>         2023-01-01        2023-01-04     27.3
      9          <NA>         2022-12-31        2023-01-03     20.2
      10         <NA>         2022-12-30        2023-01-03       NA
      11         <NA>         2023-01-01        2023-01-04       NA
      12         <NA>         2023-01-01        2023-01-03     26.1
      
      $contacts
                       from                     to age sex date_first_contact
      1          Kyle Crane     Ghaamid el-Ishmael  43   m         2022-12-30
      2          Kyle Crane       Faatih el-Kaiser   1   m         2022-12-30
      3  Ghaamid el-Ishmael Carisa Flores-Gonzalez  29   f         2022-12-27
      4  Ghaamid el-Ishmael       Va'Aahi Galligan  78   m         2022-12-29
      5    Faatih el-Kaiser         Katelyn Catlin  22   f         2023-01-01
      6    Faatih el-Kaiser          Aiman el-Riaz  70   m         2022-12-30
      7    Faatih el-Kaiser           Lynsey Duron  28   f         2023-01-03
      8    Va'Aahi Galligan        Amaani al-Gaber  37   f         2023-01-06
      9      Katelyn Catlin         Lilibeth Black  61   f         2023-01-01
      10       Lynsey Duron        Wajdi al-Demian  46   m         2023-01-04
      11       Lynsey Duron           Jacy Cousins  67   f         2023-01-01
      12       Lynsey Duron          Travis Foster  86   m         2022-12-31
      13    Wajdi al-Demian         Raymond Murray  71   m         2022-12-28
      14    Wajdi al-Demian       Marquaja Johnson  51   f         2023-01-01
      15    Wajdi al-Demian          Raaid el-Diab  44   m         2023-01-02
      16       Jacy Cousins            Kayla Tudor  49   f         2023-01-02
      17      Travis Foster         Maria Eberhart  60   f         2022-12-30
      18      Travis Foster            Katja Muetz  56   f         2023-01-06
      19      Travis Foster      Mubarak el-Vaziri  49   m         2023-01-01
      20      Travis Foster     Alexandre Guerrero  50   m         2023-01-01
      21     Maria Eberhart            Erin Payson   7   f         2023-01-01
         date_last_contact was_case           status
      1         2023-01-05        Y             case
      2         2023-01-02        Y             case
      3         2023-01-03        N   under_followup
      4         2023-01-02        Y             case
      5         2023-01-03        Y             case
      6         2023-01-02        N   under_followup
      7         2023-01-04        Y             case
      8         2023-01-06        N   under_followup
      9         2023-01-05        N   under_followup
      10        2023-01-05        Y             case
      11        2023-01-04        Y             case
      12        2023-01-03        Y             case
      13        2023-01-05        N lost_to_followup
      14        2023-01-04        N lost_to_followup
      15        2023-01-05        N   under_followup
      16        2023-01-03        N   under_followup
      17        2023-01-03        Y             case
      18        2023-01-09        N   under_followup
      19        2023-01-04        Y             case
      20        2023-01-03        N          unknown
      21        2023-01-03        Y             case
      

# sim_outbreak works as expected with age structure

    Code
      sim_outbreak(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death,
        population_age = age_struct)
    Output
      $linelist
         id          case_name case_type sex age date_onset date_admission   outcome
      1   1      Gabriel Black  probable   m  44 2023-01-01     2023-01-02 recovered
      2   2       Tyler Kelley confirmed   m  13 2023-01-01           <NA> recovered
      3   3       Cody Morales suspected   m  22 2023-01-01           <NA> recovered
      4   5          Joewid Le  probable   m  85 2023-01-01           <NA> recovered
      5   6      Carolyn Moore confirmed   f  41 2023-01-01           <NA> recovered
      6   8  Cheyenne Sayavong confirmed   f  89 2023-01-01           <NA> recovered
      7  11 Pierce Khanthavong confirmed   m  69 2023-01-01           <NA> recovered
      8  12          Kendra To suspected   f  23 2023-01-01           <NA> recovered
      9  13  Preston Barringer confirmed   m   9 2023-01-01           <NA> recovered
      10 18  Dominique Raymond confirmed   f  62 2023-01-02     2023-01-03      died
      11 20   Bassaam el-Majid  probable   m  52 2023-01-02           <NA> recovered
      12 22      Susana Varela  probable   f  76 2023-01-02     2023-01-05 recovered
         date_outcome date_first_contact date_last_contact ct_value
      1          <NA>               <NA>              <NA>       NA
      2          <NA>         2022-12-30        2023-01-05     23.0
      3          <NA>         2022-12-30        2023-01-02       NA
      4          <NA>         2022-12-29        2023-01-02       NA
      5          <NA>         2023-01-01        2023-01-03     28.2
      6          <NA>         2023-01-03        2023-01-04     25.0
      7          <NA>         2023-01-04        2023-01-05     19.2
      8          <NA>         2023-01-01        2023-01-04       NA
      9          <NA>         2022-12-31        2023-01-03     22.8
      10   2023-01-21         2022-12-30        2023-01-03     28.1
      11         <NA>         2023-01-01        2023-01-04       NA
      12         <NA>         2023-01-01        2023-01-03       NA
      
      $contacts
                       from                        to age sex date_first_contact
      1       Gabriel Black              Tyler Kelley  13   m         2022-12-30
      2       Gabriel Black              Cody Morales  22   m         2022-12-30
      3        Tyler Kelley             Taylor Graves   5   f         2022-12-27
      4        Tyler Kelley                 Joewid Le  85   m         2022-12-29
      5        Cody Morales             Carolyn Moore  41   f         2023-01-01
      6        Cody Morales           Rushdi al-Ishak   2   m         2022-12-30
      7        Cody Morales         Cheyenne Sayavong  89   f         2023-01-03
      8           Joewid Le         Mercedes Lovelace  86   f         2023-01-06
      9       Carolyn Moore Chantelle Vazquez-Luevano  82   f         2023-01-01
      10  Cheyenne Sayavong        Pierce Khanthavong  69   m         2023-01-04
      11  Cheyenne Sayavong                 Kendra To  23   f         2023-01-01
      12  Cheyenne Sayavong         Preston Barringer   9   m         2022-12-31
      13 Pierce Khanthavong           Jackson Carlson  79   m         2022-12-28
      14 Pierce Khanthavong               Megan Hayes  29   f         2023-01-01
      15 Pierce Khanthavong               Sam Spencer   4   m         2023-01-02
      16          Kendra To         Amanda Larochelle  13   f         2023-01-02
      17  Preston Barringer         Dominique Raymond  62   f         2022-12-30
      18  Preston Barringer            Natalie Newton  24   f         2023-01-06
      19  Preston Barringer          Bassaam el-Majid  52   m         2023-01-01
      20  Preston Barringer           Qaaid al-Madani  74   m         2023-01-01
      21  Dominique Raymond             Susana Varela  76   f         2023-01-01
         date_last_contact was_case           status
      1         2023-01-05        Y             case
      2         2023-01-02        Y             case
      3         2023-01-03        N   under_followup
      4         2023-01-02        Y             case
      5         2023-01-03        Y             case
      6         2023-01-02        N   under_followup
      7         2023-01-04        Y             case
      8         2023-01-06        N   under_followup
      9         2023-01-05        N   under_followup
      10        2023-01-05        Y             case
      11        2023-01-04        Y             case
      12        2023-01-03        Y             case
      13        2023-01-05        N   under_followup
      14        2023-01-04        N lost_to_followup
      15        2023-01-05        N   under_followup
      16        2023-01-03        N   under_followup
      17        2023-01-03        Y             case
      18        2023-01-09        N   under_followup
      19        2023-01-04        Y             case
      20        2023-01-03        N   under_followup
      21        2023-01-03        Y             case
      

