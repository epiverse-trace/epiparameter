# vb_epidist print & format method works as expected

    Code
      dengue_dist <- suppressMessages(vb_epidist(intrinsic_epidist = epidist(disease = "dengue",
        epi_dist = "incubation", prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1), metadata = create_epidist_metadata(
          transmission_mode = "vector_borne")), extrinsic_epidist = epidist(disease = "dengue",
        epi_dist = "incubation", prob_distribution = "gamma",
        prob_distribution_params = c(shape = 2, scale = 2), metadata = create_epidist_metadata(
          transmission_mode = "vector_borne", extrinsic = TRUE))))

---

    Code
      print(dengue_dist)
    Output
      Disease: dengue
      Pathogen: NA
      Epi Distribution: incubation
      Study: (????). "No citation."
      
       <Intrinsic Distribution> 
      
      Distribution: gamma
      Parameters:
        shape: 1.000
        scale: 1.000
      
       <Extrinsic Distribution> 
      
      Distribution: gamma
      Parameters:
        shape: 2.000
        scale: 2.000

---

    Code
      format(dengue_dist)
    Output
      Disease: dengue
      Pathogen: NA
      Epi Distribution: incubation
      Study: (????). "No citation."
      
       <Intrinsic Distribution> 
      
      Distribution: gamma
      Parameters:
        shape: 1.000
        scale: 1.000
      
       <Extrinsic Distribution> 
      
      Distribution: gamma
      Parameters:
        shape: 2.000
        scale: 2.000

---

    Code
      dengue_dist <- suppressMessages(vb_epidist(intrinsic_epidist = epidist(disease = "dengue",
        epi_dist = "incubation", prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1), metadata = create_epidist_metadata(
          transmission_mode = "vector_borne"), discretise = TRUE), extrinsic_epidist = epidist(
        disease = "dengue", epi_dist = "incubation", prob_distribution = "gamma",
        prob_distribution_params = c(shape = 2, scale = 2), metadata = create_epidist_metadata(
          transmission_mode = "vector_borne", extrinsic = TRUE), discretise = TRUE)))

---

    Code
      print(dengue_dist)
    Output
      Disease: dengue
      Pathogen: NA
      Epi Distribution: incubation
      Study: (????). "No citation."
      
       <Intrinsic Distribution> 
      
      Distribution: discrete gamma
      Parameters:
        shape: 1.000
        scale: 1.000
      
       <Extrinsic Distribution> 
      
      Distribution: discrete gamma
      Parameters:
        shape: 2.000
        scale: 2.000

---

    Code
      format(dengue_dist)
    Output
      Disease: dengue
      Pathogen: NA
      Epi Distribution: incubation
      Study: (????). "No citation."
      
       <Intrinsic Distribution> 
      
      Distribution: discrete gamma
      Parameters:
        shape: 1.000
        scale: 1.000
      
       <Extrinsic Distribution> 
      
      Distribution: discrete gamma
      Parameters:
        shape: 2.000
        scale: 2.000

