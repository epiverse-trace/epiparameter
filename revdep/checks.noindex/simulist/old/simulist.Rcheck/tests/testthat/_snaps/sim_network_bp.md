# .sim_network_bp works as expected

    Code
      .sim_network_bp(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, max_outbreak_size = 10000, config = create_config())
    Output
         id ancestor generation infected     time
      1   1       NA          1 infected 0.000000
      2   2        1          2  contact 1.691130
      3   3        1          2 infected 1.778258
      4   4        3          3 infected 1.823650
      5   5        3          3  contact 1.807604
      6   6        3          3  contact 1.820571
      7   7        4          4  contact 1.883762
      8   8        4          4 infected 1.960367
      9   9        4          4 infected 1.877154
      10 10        4          4  contact 1.899434
      11 11        4          4 infected 1.917903
      12 12        4          4  contact 1.901236
      13 13        8          5 infected 2.787989
      14 14        8          5  contact 2.612689
      15 15       11          5 infected 2.505053
      16 16       11          5 infected 2.818889
      17 17       11          5 infected 2.770190
      18 18       13          6  contact 3.967263
      19 19       15          6  contact 2.517370
      20 20       15          6  contact 2.633031
      21 21       15          6  contact 2.554628
      22 22       15          6 infected 2.627785
      23 23       16          6  contact 3.028413
      24 24       17          6  contact 4.562579
      25 25       17          6 infected 3.776408
      26 26       22          7  contact 2.866176

# .sim_network_bp works as expected with no contacts

    Code
      .sim_network_bp(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, max_outbreak_size = 10000, config = create_config())
    Output
        id ancestor generation infected time
      1  1       NA          1 infected    0

# .sim_network_bp works as expected with unadjusted network

    Code
      .sim_network_bp(contact_distribution = contact_distribution, infectious_period = infectious_period,
        prob_infection = 0.5, max_outbreak_size = 10000, config = create_config(
          network = "unadjusted"))
    Output
         id ancestor generation infected     time
      1   1       NA          1 infected 0.000000
      2   2        1          2  contact 1.691130
      3   3        1          2 infected 1.778258
      4   4        3          3 infected 1.823650
      5   5        3          3  contact 1.807604
      6   6        3          3  contact 1.820571
      7   7        4          4  contact 1.883762
      8   8        4          4 infected 1.960367
      9   9        4          4 infected 1.877154
      10 10        4          4  contact 1.899434
      11 11        4          4 infected 1.917903
      12 12        4          4  contact 1.901236
      13 13        8          5 infected 2.787989
      14 14        8          5  contact 2.612689
      15 15       11          5 infected 2.505053
      16 16       11          5 infected 2.818889
      17 17       11          5 infected 2.770190
      18 18       13          6  contact 3.967263
      19 19       15          6  contact 2.517370
      20 20       15          6  contact 2.633031
      21 21       15          6  contact 2.554628
      22 22       15          6 infected 2.627785
      23 23       16          6  contact 3.028413
      24 24       17          6  contact 4.562579
      25 25       17          6 infected 3.776408
      26 26       22          7  contact 2.866176

