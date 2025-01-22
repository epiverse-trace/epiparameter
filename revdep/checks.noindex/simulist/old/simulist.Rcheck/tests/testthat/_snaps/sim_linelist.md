# sim_linelist works as expected with defaults

    Code
      sim_linelist()
    Output
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

# sim_linelist works as expected

    Code
      sim_linelist(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death)
    Output
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

# sim_linelist works as expected with age-strat risks

    Code
      sim_linelist(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death,
        hosp_risk = age_dep_hosp_risk, hosp_death_risk = age_dep_hosp_death_risk,
        non_hosp_death_risk = age_dep_non_hosp_death_risk)
    Output
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

# sim_linelist works as expected with anonymous

    Code
      sim_linelist(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death,
        anonymise = TRUE)
    Output
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

# sim_linelist works as expected with age structure

    Code
      sim_linelist(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death,
        population_age = age_struct)
    Output
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

# sim_linelist works as expected with age-strat risks & age struct

    Code
      sim_linelist(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death,
        hosp_risk = age_dep_hosp_risk, population_age = age_struct)
    Output
         id           case_name case_type sex age date_onset date_admission   outcome
      1   1        Bryce Kelley confirmed   m  44 2023-01-01           <NA> recovered
      2   2 Khristopher Carlson confirmed   m  13 2023-01-01           <NA> recovered
      3   3       Cleatus Black suspected   m  22 2023-01-01           <NA> recovered
      4   5       Tyler Spencer confirmed   m  85 2023-01-01           <NA> recovered
      5   6    Sajiyya el-Bahri confirmed   f  41 2023-01-01           <NA> recovered
      6   8   Shameema al-Fayad confirmed   f  89 2023-01-01           <NA> recovered
      7  11           Jelani Le confirmed   m  69 2023-01-01           <NA> recovered
      8  12    Ashley Depoyster confirmed   f  23 2023-01-01           <NA> recovered
      9  13     Rushdi el-Amara  probable   m   9 2023-01-01           <NA> recovered
      10 18      Sabrina Catlin suspected   f  62 2023-01-02           <NA> recovered
      11 20       Jackson Sheek confirmed   m  52 2023-01-02           <NA> recovered
      12 22       Talia Cousins  probable   f  76 2023-01-02     2023-01-05 recovered
         date_outcome date_first_contact date_last_contact ct_value
      1          <NA>               <NA>              <NA>     26.0
      2          <NA>         2022-12-30        2023-01-05     25.8
      3          <NA>         2022-12-30        2023-01-02       NA
      4          <NA>         2022-12-29        2023-01-02     28.7
      5          <NA>         2023-01-01        2023-01-03     27.1
      6          <NA>         2023-01-03        2023-01-04     25.2
      7          <NA>         2023-01-04        2023-01-05     24.8
      8          <NA>         2023-01-01        2023-01-04     26.2
      9          <NA>         2022-12-31        2023-01-03       NA
      10         <NA>         2022-12-30        2023-01-03       NA
      11         <NA>         2023-01-01        2023-01-04     23.2
      12         <NA>         2023-01-01        2023-01-03       NA

# sim_linelist works as expected with modified config

    Code
      sim_linelist(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death,
        config = create_config(last_contact_distribution = "geom",
          last_contact_distribution_params = c(prob = 0.5)))
    Output
         id           case_name case_type sex age date_onset date_admission   outcome
      1   1        Lily Camacho confirmed   f  20 2023-01-01           <NA> recovered
      2   2 Charles Stuart Rasi suspected   m  24 2023-01-01     2023-01-02      died
      3   3        Jonah Burden suspected   m  51 2023-01-01           <NA> recovered
      4   5          Craig Agee  probable   m  16 2023-01-01           <NA> recovered
      5   6 Christopher Lohrenz suspected   m  83 2023-01-01           <NA>      died
      6   8      Kevin Saunders suspected   m  48 2023-01-01           <NA> recovered
      7  11     Saabiq al-Samra  probable   m  77 2023-01-01     2023-01-15 recovered
      8  12      Kenneth Cahill confirmed   m  90 2023-01-01           <NA> recovered
      9  13    Halle Batchelder confirmed   f  66 2023-01-01           <NA> recovered
      10 18  Morgan Grant-Perry confirmed   f  31 2023-01-02           <NA> recovered
      11 20      Enrique Galvan confirmed   m  46 2023-01-02           <NA> recovered
      12 22     Robert Chaparro confirmed   m  75 2023-01-02           <NA> recovered
         date_outcome date_first_contact date_last_contact ct_value
      1          <NA>               <NA>              <NA>     24.3
      2    2023-01-10         2022-12-30        2023-01-01       NA
      3          <NA>         2022-12-31        2023-01-02       NA
      4          <NA>         2022-12-30        2023-01-02       NA
      5    2023-01-16         2022-12-31        2023-01-01       NA
      6          <NA>         2022-12-31        2023-01-01       NA
      7          <NA>         2022-12-30        2023-01-02       NA
      8          <NA>         2022-12-30        2023-01-01     23.1
      9          <NA>         2022-12-29        2023-01-01     24.5
      10         <NA>         2022-12-30        2023-01-01     25.8
      11         <NA>         2022-12-30        2023-01-01     23.3
      12         <NA>         2022-12-30        2023-01-02     30.3

# sim_linelist works as expected with modified config parameters

    Code
      sim_linelist(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death,
        config = create_config(last_contact_distribution_params = c(lambda = 5)))
    Output
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
      2          <NA>         2023-01-01        2023-01-07     23.2
      3          <NA>         2022-12-31        2023-01-03       NA
      4    2023-01-21         2022-12-31        2023-01-04     25.2
      5    2023-01-10         2023-01-02        2023-01-04       NA
      6          <NA>         2023-01-06        2023-01-07       NA
      7          <NA>         2023-01-07        2023-01-08       NA
      8          <NA>         2023-01-03        2023-01-06       NA
      9          <NA>         2023-01-02        2023-01-05     25.7
      10         <NA>         2023-01-01        2023-01-05     26.1
      11         <NA>         2023-01-04        2023-01-07       NA
      12         <NA>         2023-01-03        2023-01-05       NA

# sim_linelist works as expected with time-varying cfr

    Code
      sim_linelist(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death,
        config = create_config(time_varying_death_risk = function(risk, time) risk *
          exp(-time)))
    Output
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

# sim_linelist works as expected with time-varying cfr & age-strat

    Code
      sim_linelist(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, onset_to_hosp = onset_to_hosp, onset_to_death = onset_to_death,
        hosp_death_risk = age_dep_hosp_death_risk, config = create_config(
          time_varying_death_risk = function(risk, time) risk * exp(-time)))
    Output
         id          case_name case_type sex age date_onset date_admission   outcome
      1   1         Kyle Crane suspected   m  35 2023-01-01           <NA> recovered
      2   2 Ghaamid el-Ishmael confirmed   m  43 2023-01-01     2023-01-07 recovered
      3   3   Faatih el-Kaiser confirmed   m   1 2023-01-01           <NA> recovered
      4   5   Va'Aahi Galligan suspected   m  78 2023-01-01     2023-01-03 recovered
      5   6     Katelyn Catlin confirmed   f  22 2023-01-01     2023-01-28 recovered
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

