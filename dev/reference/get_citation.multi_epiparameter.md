# Get citation from a list of `<epiparameter>` objects

Extract the citation stored in a list of `<epiparameter>` objects.

## Usage

``` r
# S3 method for class 'multi_epiparameter'
get_citation(x, ...)
```

## Arguments

- x:

  An `<epiparameter>` object.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Not used, extra arguments
  supplied will cause a warning.

## Value

A `<bibentry>` object containing multiple references. The length of
output `<bibentry>` is equal to the length of the list of
`<epiparameter>` objects supplied.

## Examples

``` r
# example with list of <epiparameter>
db <- epiparameter_db()
#> Returning 125 results that match the criteria (100 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function
get_citation(db)
#> Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-6
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-6>.
#> 
#> Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-7
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-7>.
#> 
#> Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-8
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-8>.
#> 
#> Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-9
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-9>.
#> 
#> Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-10
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-10>.
#> 
#> Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-11
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-11>.
#> 
#> Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-12
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-12>.
#> 
#> Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-13
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-13>.
#> 
#> Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-14
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-14>.
#> 
#> Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-15
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-15>.
#> 
#> Reich N, Lessler J, Cummings D, Brookmeyer R (2009). “Estimating
#> incubation period distributions with coarse data.” _Statistics in
#> Medicine_. doi:10.1002/sim.3659 <https://doi.org/10.1002/sim.3659>.
#> 
#> Reich N, Lessler J, Cummings D, Brookmeyer R (2009). “Estimating
#> incubation period distributions with coarse data.” _Statistics in
#> Medicine_. doi:10.1002/sim.3659 <https://doi.org/10.1002/sim.3659>.
#> 
#> Reich N, Lessler J, Cummings D, Brookmeyer R (2009). “Estimating
#> incubation period distributions with coarse data.” _Statistics in
#> Medicine_. doi:10.1002/sim.3659 <https://doi.org/10.1002/sim.3659>.
#> 
#> Reich N, Lessler J, Cummings D, Brookmeyer R (2009). “Estimating
#> incubation period distributions with coarse data.” _Statistics in
#> Medicine_. doi:10.1002/sim.3659 <https://doi.org/10.1002/sim.3659>.
#> 
#> Nishiura H, Inaba H (2011). “Estimation of the incubation period of
#> influenza A (H1N1-2009) among imported cases: addressing censoring
#> using outbreak data at the origin of importation.” _Journal of
#> Theoretical Biology_. doi:10.1016/j.jtbi.2010.12.017
#> <https://doi.org/10.1016/j.jtbi.2010.12.017>.
#> 
#> Nishiura H, Inaba H (2011). “Estimation of the incubation period of
#> influenza A (H1N1-2009) among imported cases: addressing censoring
#> using outbreak data at the origin of importation.” _Journal of
#> Theoretical Biology_. doi:10.1016/j.jtbi.2010.12.017
#> <https://doi.org/10.1016/j.jtbi.2010.12.017>.
#> 
#> Virlogeux V, Li M, Tsang T, Feng L, Fang V, Jiang H, Wu P, Zheng J, Lau
#> E, Cao Y, Qin Y, Liao Q, Yu H, Cowling B (2015). “Estimating the
#> Distribution of the Incubation Periods of Human Avian Influenza A(H7N9)
#> Virus Infections.” _American Journal of Epidemiology_.
#> doi:10.1093/aje/kwv115 <https://doi.org/10.1093/aje/kwv115>.
#> 
#> Virlogeux V, Li M, Tsang T, Feng L, Fang V, Jiang H, Wu P, Zheng J, Lau
#> E, Cao Y, Qin Y, Liao Q, Yu H, Cowling B (2015). “Estimating the
#> Distribution of the Incubation Periods of Human Avian Influenza A(H7N9)
#> Virus Infections.” _American Journal of Epidemiology_.
#> doi:10.1093/aje/kwv115 <https://doi.org/10.1093/aje/kwv115>.
#> 
#> Virlogeux V, Yang J, Fang V, Feng L, Tsang T, Jiang H, Wu P, Zheng J,
#> Lau E, Qin Y, Peng Z, Peiris J, Yu H, Cowling B (2016). “Association
#> between the Severity of Influenza A(H7N9) Virus Infections and Length
#> of the Incubation Period.” _PLoS One_. doi:10.1371/journal.pone.0148506
#> <https://doi.org/10.1371/journal.pone.0148506>.
#> 
#> Virlogeux V, Yang J, Fang V, Feng L, Tsang T, Jiang H, Wu P, Zheng J,
#> Lau E, Qin Y, Peng Z, Peiris J, Yu H, Cowling B (2016). “Association
#> between the Severity of Influenza A(H7N9) Virus Infections and Length
#> of the Incubation Period.” _PLoS One_. doi:10.1371/journal.pone.0148506
#> <https://doi.org/10.1371/journal.pone.0148506>.
#> 
#> Virlogeux V, Yang J, Fang V, Feng L, Tsang T, Jiang H, Wu P, Zheng J,
#> Lau E, Qin Y, Peng Z, Peiris J, Yu H, Cowling B (2016). “Association
#> between the Severity of Influenza A(H7N9) Virus Infections and Length
#> of the Incubation Period.” _PLoS One_. doi:10.1371/journal.pone.0148506
#> <https://doi.org/10.1371/journal.pone.0148506>.
#> 
#> Tuite A, Greer A, Whelan M, Winter A, Lee B, Yan P, Wu J, Moghadas S,
#> Buckeridge D, Pourbohloul B, Fisman D (2010). “Estimated epidemiologic
#> parameters and morbidity associated with pandemic H1N1 influenza.”
#> _Canadian Medical Association Journal_. doi:10.1503/cmaj.091807
#> <https://doi.org/10.1503/cmaj.091807>.
#> 
#> Ghani A, Baguelin M, Griffin J, Flasche S, van Hoek A, Cauchemez S,
#> Donnelly C, Robertson C, White M, Truscott J, Fraser C, Garske T, White
#> P, Leach S, Hall I, Jenkins H, Ferguson N, Cooper B (2009). “The Early
#> Transmission Dynamics of H1N1pdm Influenza in the United Kingdom.”
#> _PLoS Currents_. doi:10.1371/currents.RRN1130
#> <https://doi.org/10.1371/currents.RRN1130>.
#> 
#> Ghani A, Baguelin M, Griffin J, Flasche S, van Hoek A, Cauchemez S,
#> Donnelly C, Robertson C, White M, Truscott J, Fraser C, Garske T, White
#> P, Leach S, Hall I, Jenkins H, Ferguson N, Cooper B (2009). “The Early
#> Transmission Dynamics of H1N1pdm Influenza in the United Kingdom.”
#> _PLoS Currents_. doi:10.1371/currents.RRN1130
#> <https://doi.org/10.1371/currents.RRN1130>.
#> 
#> Lessler J, Reich N, Cummings D, New York City Department of Health and
#> Mental Hygiene Swine Influenza Investigation Team (2009). “Outbreak of
#> 2009 Pandemic Influenza A (H1N1) at a New York City School.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMoa0906089
#> <https://doi.org/10.1056/NEJMoa0906089>.
#> 
#> Lessler J, Reich N, Cummings D, New York City Department of Health and
#> Mental Hygiene Swine Influenza Investigation Team (2009). “Outbreak of
#> 2009 Pandemic Influenza A (H1N1) at a New York City School.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMoa0906089
#> <https://doi.org/10.1056/NEJMoa0906089>.
#> 
#> Pavlin B (2014). “Calculation of incubation period and serial interval
#> from multiple outbreaks of Marburg virus disease.” _BMC Research
#> Notes_. doi:10.1186/1756-0500-7-906
#> <https://doi.org/10.1186/1756-0500-7-906>.
#> 
#> Pavlin B (2014). “Calculation of incubation period and serial interval
#> from multiple outbreaks of Marburg virus disease.” _BMC Research
#> Notes_. doi:10.1186/1756-0500-7-906
#> <https://doi.org/10.1186/1756-0500-7-906>.
#> 
#> Pavlin B (2014). “Calculation of incubation period and serial interval
#> from multiple outbreaks of Marburg virus disease.” _BMC Research
#> Notes_. doi:10.1186/1756-0500-7-906
#> <https://doi.org/10.1186/1756-0500-7-906>.
#> 
#> Colebunders R, Tshomba A, Van Kerkhove M, Bausch D, Campbell P, Libande
#> M, Pirard P, Tshioko F, Mardel S, Mulangu S, Sleurs H, Rollin P,
#> Muyembe-Tamfum J, Jeffs B, Borchert M, International Scientific and
#> Technical Committee 'DRC Watsa/Durba 1999 Marburg Outbreak
#> Investigation Group' (2007). “Marburg hemorrhagic fever in Durba and
#> Watsa, Democratic Republic of the Congo: clinical documentation,
#> features of illness, and treatment.” _The Journal of Infectious
#> Diseases_. doi:10.1086/520543 <https://doi.org/10.1086/520543>.
#> 
#> Ajelli M, Merler S (2012). “Transmission Potential and Design of
#> Adequate Control Measures for Marburg Hemorrhagic Fever.” _PLoS One_.
#> doi:10.1371/journal.pone.0050948
#> <https://doi.org/10.1371/journal.pone.0050948>.
#> 
#> Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> 
#> Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> 
#> Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> 
#> Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> 
#> Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> 
#> Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> 
#> Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> 
#> Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> 
#> Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> 
#> Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> 
#> Chan M, Johansson M (2012). “The Incubation Periods of Dengue Viruses.”
#> _PLoS One_. doi:10.1371/journal.pone.0050972
#> <https://doi.org/10.1371/journal.pone.0050972>.
#> 
#> Chan M, Johansson M (2012). “The Incubation Periods of Dengue Viruses.”
#> _PLoS One_. doi:10.1371/journal.pone.0050972
#> <https://doi.org/10.1371/journal.pone.0050972>.
#> 
#> Chan M, Johansson M (2012). “The Incubation Periods of Dengue Viruses.”
#> _PLoS One_. doi:10.1371/journal.pone.0050972
#> <https://doi.org/10.1371/journal.pone.0050972>.
#> 
#> Lessler J, Ott C, Carcelen A, Konikoff J, Williamson J, Bi Q, Kucirka
#> L, Cummings D, Reich N, Chaisson L (2016). “Times to key events in Zika
#> virus infection and implications for blood donation: a systematic
#> review.” _Bulletin of the World Health Organization_.
#> doi:10.2471/BLT.16.174540 <https://doi.org/10.2471/BLT.16.174540>.
#> 
#> Rudolph K, Lessler J, Moloney R, Kmush B, Cummings D (2014).
#> “Incubation periods of mosquito-borne viral infections: a systematic
#> review.” _The American Journal of Tropical Medicine and Hygiene_.
#> doi:10.4269/ajtmh.13-0403 <https://doi.org/10.4269/ajtmh.13-0403>.
#> 
#> Rudolph K, Lessler J, Moloney R, Kmush B, Cummings D (2014).
#> “Incubation periods of mosquito-borne viral infections: a systematic
#> review.” _The American Journal of Tropical Medicine and Hygiene_.
#> doi:10.4269/ajtmh.13-0403 <https://doi.org/10.4269/ajtmh.13-0403>.
#> 
#> Rudolph K, Lessler J, Moloney R, Kmush B, Cummings D (2014).
#> “Incubation periods of mosquito-borne viral infections: a systematic
#> review.” _The American Journal of Tropical Medicine and Hygiene_.
#> doi:10.4269/ajtmh.13-0403 <https://doi.org/10.4269/ajtmh.13-0403>.
#> 
#> Rudolph K, Lessler J, Moloney R, Kmush B, Cummings D (2014).
#> “Incubation periods of mosquito-borne viral infections: a systematic
#> review.” _The American Journal of Tropical Medicine and Hygiene_.
#> doi:10.4269/ajtmh.13-0403 <https://doi.org/10.4269/ajtmh.13-0403>.
#> 
#> Rudolph K, Lessler J, Moloney R, Kmush B, Cummings D (2014).
#> “Incubation periods of mosquito-borne viral infections: a systematic
#> review.” _The American Journal of Tropical Medicine and Hygiene_.
#> doi:10.4269/ajtmh.13-0403 <https://doi.org/10.4269/ajtmh.13-0403>.
#> 
#> Rudolph K, Lessler J, Moloney R, Kmush B, Cummings D (2014).
#> “Incubation periods of mosquito-borne viral infections: a systematic
#> review.” _The American Journal of Tropical Medicine and Hygiene_.
#> doi:10.4269/ajtmh.13-0403 <https://doi.org/10.4269/ajtmh.13-0403>.
#> 
#> Rudolph K, Lessler J, Moloney R, Kmush B, Cummings D (2014).
#> “Incubation periods of mosquito-borne viral infections: a systematic
#> review.” _The American Journal of Tropical Medicine and Hygiene_.
#> doi:10.4269/ajtmh.13-0403 <https://doi.org/10.4269/ajtmh.13-0403>.
#> 
#> Rudolph K, Lessler J, Moloney R, Kmush B, Cummings D (2014).
#> “Incubation periods of mosquito-borne viral infections: a systematic
#> review.” _The American Journal of Tropical Medicine and Hygiene_.
#> doi:10.4269/ajtmh.13-0403 <https://doi.org/10.4269/ajtmh.13-0403>.
#> 
#> Rudolph K, Lessler J, Moloney R, Kmush B, Cummings D (2014).
#> “Incubation periods of mosquito-borne viral infections: a systematic
#> review.” _The American Journal of Tropical Medicine and Hygiene_.
#> doi:10.4269/ajtmh.13-0403 <https://doi.org/10.4269/ajtmh.13-0403>.
#> 
#> Rudolph K, Lessler J, Moloney R, Kmush B, Cummings D (2014).
#> “Incubation periods of mosquito-borne viral infections: a systematic
#> review.” _The American Journal of Tropical Medicine and Hygiene_.
#> doi:10.4269/ajtmh.13-0403 <https://doi.org/10.4269/ajtmh.13-0403>.
#> 
#> Miura F, van Ewijk C, Backer J, Xiridou M, Franz E, Op de Coul E,
#> Brandwagt D, van Cleef B, van Rijckevorsel G, Swaan C, van den Hof S,
#> Wallinga J (2022). “Estimated incubation period for monkeypox cases
#> confirmed in the Netherlands, May 2022.” _Eurosurveillance_.
#> doi:10.2807/1560-7917.ES.2022.27.24.2200448
#> <https://doi.org/10.2807/1560-7917.ES.2022.27.24.2200448>.
#> 
#> Charniga K, Masters N, Slayton R, Gosdin L, Minhaj F, Philpott D, Smith
#> D, Gearhart S, Alvarado-Ramy F, Brown C, Waltenburg M, Hughes C,
#> Nakazawa Y (2022). “Estimating the incubation period of monkeypox virus
#> during the 2022 multi-national outbreak.” _medRxiv_.
#> doi:10.1101/2022.06.22.22276713
#> <https://doi.org/10.1101/2022.06.22.22276713>.
#> 
#> Guzzetta G, Mammone A, Ferraro F, Caraglia A, Rapiti A, Marziano V,
#> Poletti P, Cereda D, Vairo F, Mattei G, Maraglino F, Rezza G, Merler S
#> (2022). “Early Estimates of Monkeypox Incubation Period, Generation
#> Time, and Reproduction Number, Italy, May-June 2022.” _Emerging
#> Infectious Diseases_. doi:10.3201/eid2810.221126
#> <https://doi.org/10.3201/eid2810.221126>.
#> 
#> Madewell Z, Charniga K, Masters N, Asher J, Fahrenwald L, Still W, Chen
#> J, Kipperman N, Bui D, Shea M, Saathoff-Huber L, Johnson S, Harbi K,
#> Berns A, Perez T, Gateley E, Spicknall I, Nakazawa Y, Gift T, 2022
#> Monkeypox Outbreak Response Team (2022). “Serial interval and
#> incubation period estimates of monkeypox virus infection in 12 U.S.
#> jurisdictions, May – August 2022.” _medRxiv_.
#> doi:10.1101/2022.10.26.22281516
#> <https://doi.org/10.1101/2022.10.26.22281516>.
#> 
#> Madewell Z, Charniga K, Masters N, Asher J, Fahrenwald L, Still W, Chen
#> J, Kipperman N, Bui D, Shea M, Saathoff-Huber L, Johnson S, Harbi K,
#> Berns A, Perez T, Gateley E, Spicknall I, Nakazawa Y, Gift T, 2022
#> Monkeypox Outbreak Response Team (2022). “Serial interval and
#> incubation period estimates of monkeypox virus infection in 12 U.S.
#> jurisdictions, May – August 2023.” _medRxiv_.
#> doi:10.1101/2022.10.26.22281516
#> <https://doi.org/10.1101/2022.10.26.22281516>.
#> 
#> Madewell Z, Charniga K, Masters N, Asher J, Fahrenwald L, Still W, Chen
#> J, Kipperman N, Bui D, Shea M, Saathoff-Huber L, Johnson S, Harbi K,
#> Berns A, Perez T, Gateley E, Spicknall I, Nakazawa Y, Gift T, 2022
#> Monkeypox Outbreak Response Team (2022). “Serial interval and
#> incubation period estimates of monkeypox virus infection in 12 U.S.
#> jurisdictions, May – August 2024.” _medRxiv_.
#> doi:10.1101/2022.10.26.22281516
#> <https://doi.org/10.1101/2022.10.26.22281516>.
#> 
#> Madewell Z, Charniga K, Masters N, Asher J, Fahrenwald L, Still W, Chen
#> J, Kipperman N, Bui D, Shea M, Saathoff-Huber L, Johnson S, Harbi K,
#> Berns A, Perez T, Gateley E, Spicknall I, Nakazawa Y, Gift T, 2022
#> Monkeypox Outbreak Response Team (2022). “Serial interval and
#> incubation period estimates of monkeypox virus infection in 12 U.S.
#> jurisdictions, May – August 2025.” _medRxiv_.
#> doi:10.1101/2022.10.26.22281516
#> <https://doi.org/10.1101/2022.10.26.22281516>.
#> 
#> Eichner M, Dowell S, Firese N (2011). “Incubation period of ebola
#> hemorrhagic virus subtype zaire.” _Osong Public Health and Research
#> Perspectives_. doi:10.1016/j.phrp.2011.04.001
#> <https://doi.org/10.1016/j.phrp.2011.04.001>.
#> 
#> The Ebola Outbreak Epidemiology Team, Barry A, Ahuka-Mundeke S, Ali
#> Ahmed Y, Allarangar Y, Anoko J, Archer B, Abedi A, Bagaria J, Belizaire
#> M, Bhatia S, Bokenge T, Bruni E, Cori A, Dabire E, Diallo A, Diallo B,
#> Donnelly C, Dorigatti I, Dorji T, Waeber A, Fall I, Ferguson N,
#> FitzJohn R, Tengomo G, Formenty P, Forna A, Fortin A, Garske T,
#> Gaythorpe K, Gurry C, Hamblion E, Djingarey M, Haskew C, Hugonnet S,
#> Imai N, Impouma B, Kabongo G, Kalenga O, Kibangou E, Lee T, Lukoya C,
#> Ly O, Makiala-Mandanda S, Mamba A, Mbala-Kingebeni P, Mboussou F,
#> Mlanda T, Makuma V, Morgan O, Mulumba A, Kakoni P, Mukadi-Bamuleka D,
#> Muyembe J, Bathé N, Ndumbi Ngamala P, Ngom R, Ngoy G, Nouvellet P, Nsio
#> J, Ousman K, Peron E, Polonsky J, Ryan M, Touré A, Towner R, Tshapenda
#> G, Van De Weerdt R, Van Kerkhove M, Wendland A, Yao N, Yoti Z, Yuma E,
#> Kalambayi Kabamba G, Mwati J, Mbuy G, Lubula L, Mutombo A, Mavila O,
#> Lay Y, Kitenge E (2018). “Outbreak of Ebola virus disease in the
#> Democratic Republic of the Congo, April–May, 2018: an epidemiological
#> study.” _The Lancet_. doi:10.1016/S0140-6736(18)31387-4
#> <https://doi.org/10.1016/S0140-6736%2818%2931387-4>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> 
#> Assiri A, McGeer A, Perl T, Price C, Al Rabeeah A, Cummings D,
#> Alabdullatif Z, Assad M, Almulhim A, Makhdoom H, Madani H, Alhakeem R,
#> Al-Tawfiq J, Cotten M, Watson S, Kellam P, Zumla A, Memish Z, KSA
#> MERSCOV Investigation Team (2013). “Hospital Outbreak of Middle East
#> Respiratory Syndrome Coronavirus.” _The New England Journal of
#> Medicine_. doi:10.1056/NEJMoa1306742
#> <https://doi.org/10.1056/NEJMoa1306742>.
#> 
#> Assiri A, McGeer A, Perl T, Price C, Al Rabeeah A, Cummings D,
#> Alabdullatif Z, Assad M, Almulhim A, Makhdoom H, Madani H, Alhakeem R,
#> Al-Tawfiq J, Cotten M, Watson S, Kellam P, Zumla A, Memish Z, KSA
#> MERSCOV Investigation Team (2013). “Hospital Outbreak of Middle East
#> Respiratory Syndrome Coronavirus.” _The New England Journal of
#> Medicine_. doi:10.1056/NEJMoa1306742
#> <https://doi.org/10.1056/NEJMoa1306742>.
#> 
#> Assiri A, McGeer A, Perl T, Price C, Al Rabeeah A, Cummings D,
#> Alabdullatif Z, Assad M, Almulhim A, Makhdoom H, Madani H, Alhakeem R,
#> Al-Tawfiq J, Cotten M, Watson S, Kellam P, Zumla A, Memish Z, KSA
#> MERSCOV Investigation Team (2013). “Hospital Outbreak of Middle East
#> Respiratory Syndrome Coronavirus.” _The New England Journal of
#> Medicine_. doi:10.1056/NEJMoa1306742
#> <https://doi.org/10.1056/NEJMoa1306742>.
#> 
#> Assiri A, McGeer A, Perl T, Price C, Al Rabeeah A, Cummings D,
#> Alabdullatif Z, Assad M, Almulhim A, Makhdoom H, Madani H, Alhakeem R,
#> Al-Tawfiq J, Cotten M, Watson S, Kellam P, Zumla A, Memish Z, KSA
#> MERSCOV Investigation Team (2013). “Hospital Outbreak of Middle East
#> Respiratory Syndrome Coronavirus.” _The New England Journal of
#> Medicine_. doi:10.1056/NEJMoa1306742
#> <https://doi.org/10.1056/NEJMoa1306742>.
#> 
#> Assiri A, McGeer A, Perl T, Price C, Al Rabeeah A, Cummings D,
#> Alabdullatif Z, Assad M, Almulhim A, Makhdoom H, Madani H, Alhakeem R,
#> Al-Tawfiq J, Cotten M, Watson S, Kellam P, Zumla A, Memish Z, KSA
#> MERSCOV Investigation Team (2013). “Hospital Outbreak of Middle East
#> Respiratory Syndrome Coronavirus.” _The New England Journal of
#> Medicine_. doi:10.1056/NEJMoa1306742
#> <https://doi.org/10.1056/NEJMoa1306742>.
#> 
#> Mizumoto K, Endo A, Chowell G, Miyamatsu Y, Saitoh M, Nishiura H
#> (2015). “Real-time characterization of risks of death associated with
#> the Middle East respiratory syndrome (MERS) in the Republic of Korea,
#> 2015.” _BMC Medicine_. doi:10.1186/s12916-015-0468-3
#> <https://doi.org/10.1186/s12916-015-0468-3>.
#> 
#> Cowling B, Park M, Fang V, Wu P, Leung G, Wu J (2015). “Preliminary
#> epidemiological assessment of MERS-CoV outbreak in South Korea, May to
#> June 2015.” _Eurosurveillance_.
#> doi:10.2807/1560-7917.es2015.20.25.21163
#> <https://doi.org/10.2807/1560-7917.es2015.20.25.21163>.
#> 
#> Cowling B, Park M, Fang V, Wu P, Leung G, Wu J (2015). “Preliminary
#> epidemiological assessment of MERS-CoV outbreak in South Korea, May to
#> June 2016.” _Eurosurveillance_.
#> doi:10.2807/1560-7917.es2015.20.25.21163
#> <https://doi.org/10.2807/1560-7917.es2015.20.25.21163>.
#> 
#> Men K, Wang X, Yihao L, Zhang G, Hu J, Gao Y, Han H (2020). “Estimate
#> the incubation period of coronavirus 2019 (COVID-19).” _medRxiv_.
#> doi:10.1101/2020.02.24.20027474
#> <https://doi.org/10.1101/2020.02.24.20027474>.
#> 
#> Rai B, Shukla A, Dwivedi L (2022). “Incubation period for COVID-19: a
#> systematic review and meta-analysis.” _Zeitschrift fur
#> Gesundheitswissenschaften_. doi:10.1007/s10389-021-01478-1
#> <https://doi.org/10.1007/s10389-021-01478-1>.
#> 
#> Alene M, Yismaw L, Assemie M, Ketema D, Gietaneh W, Birhan T (2021).
#> “Serial interval and incubation period of COVID-19: a systematic review
#> and meta-analysis.” _BMC Infectious Diseases_.
#> doi:10.1186/s12879-021-05950-x
#> <https://doi.org/10.1186/s12879-021-05950-x>.
#> 
#> Alene M, Yismaw L, Assemie M, Ketema D, Gietaneh W, Birhan T (2021).
#> “Serial interval and incubation period of COVID-19: a systematic review
#> and meta-analysis.” _BMC Infectious Diseases_.
#> doi:10.1186/s12879-021-05950-x
#> <https://doi.org/10.1186/s12879-021-05950-x>.
#> 
#> Nishiura H, Linton N, Akhmetzhanov A (2020). “Serial interval of novel
#> coronavirus (COVID-19) infections.” _International Journal of
#> Infectious Diseases_. doi:10.1016/j.ijid.2020.02.060
#> <https://doi.org/10.1016/j.ijid.2020.02.060>.
#> 
#> Nishiura H, Linton N, Akhmetzhanov A (2020). “Serial interval of novel
#> coronavirus (COVID-19) infections.” _International Journal of
#> Infectious Diseases_. doi:10.1016/j.ijid.2020.02.060
#> <https://doi.org/10.1016/j.ijid.2020.02.060>.
#> 
#> Yang L, Dai J, Zhao J, Wang Y, Deng P, Wang J (2020). “Estimation of
#> incubation period and serial interval of COVID-19: analysis of 178
#> cases and 131 transmission chains in Hubei province, China.”
#> _Epidemiology and Infection_. doi:10.1017/S0950268820001338
#> <https://doi.org/10.1017/S0950268820001338>.
#> 
#> Yang L, Dai J, Zhao J, Wang Y, Deng P, Wang J (2020). “Estimation of
#> incubation period and serial interval of COVID-19: analysis of 178
#> cases and 131 transmission chains in Hubei province, China.”
#> _Epidemiology and Infection_. doi:10.1017/S0950268820001338
#> <https://doi.org/10.1017/S0950268820001338>.
#> 
#> Elias C, Sekri A, Leblanc P, Cucherat M, Vanhems P (2021). “The
#> incubation period of COVID-19: A meta-analysis.” _International Journal
#> of Infectious Diseases_. doi:10.1016/j.ijid.2021.01.069
#> <https://doi.org/10.1016/j.ijid.2021.01.069>.
#> 
#> Bui L, Nguyen H, Levine H, Nguyen H, Nguyen T, Nguyen T, Nguyen T, Do
#> T, Pham N, Bui M (2020). “Estimation of the incubation period of
#> COVID-19 in Vietnam.” _PLoS One_. doi:10.1371/journal.pone.0243889
#> <https://doi.org/10.1371/journal.pone.0243889>.
#> 
#> McAloon C, Collins Á, Hunt K, Barber A, Byrne A, Butler F, Casey M,
#> Griffin J, Lane E, McEvoy D, Wall P, Green M, O'Grady L, More S (2020).
#> “Incubation period of COVID-19: a rapid systematic review and
#> meta-analysis of observational research.” _BMJ Open_.
#> doi:10.1136/bmjopen-2020-039652
#> <https://doi.org/10.1136/bmjopen-2020-039652>.
#> 
#> McAloon C, Collins Á, Hunt K, Barber A, Byrne A, Butler F, Casey M,
#> Griffin J, Lane E, McEvoy D, Wall P, Green M, O'Grady L, More S (2020).
#> “Incubation period of COVID-19: a rapid systematic review and
#> meta-analysis of observational research.” _BMJ Open_.
#> doi:10.1136/bmjopen-2020-039652
#> <https://doi.org/10.1136/bmjopen-2020-039652>.
#> 
#> Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.
#> 
#> Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.
#> 
#> Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.
#> 
#> Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.
#> 
#> Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.
#> 
#> Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.
#> 
#> Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.
#> 
#> Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.
#> 
#> Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.
#> 
#> Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.
#> 
#> Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.
#> 
#> Lauer S, Grantz K, Bi Q, Jones F, Zheng Q, Meredith H, Azman A, Reich
#> N, Lessler J (2020). “The Incubation Period of Coronavirus Disease 2019
#> (COVID-19) From Publicly Reported Confirmed Cases: Estimation and
#> Application.” _Annals of Internal Medicine_. doi:10.7326/M20-0504
#> <https://doi.org/10.7326/M20-0504>.
#> 
#> Lauer S, Grantz K, Bi Q, Jones F, Zheng Q, Meredith H, Azman A, Reich
#> N, Lessler J (2020). “The Incubation Period of Coronavirus Disease 2019
#> (COVID-19) From Publicly Reported Confirmed Cases: Estimation and
#> Application.” _Annals of Internal Medicine_. doi:10.7326/M20-0504
#> <https://doi.org/10.7326/M20-0504>.
#> 
#> Lauer S, Grantz K, Bi Q, Jones F, Zheng Q, Meredith H, Azman A, Reich
#> N, Lessler J (2020). “The Incubation Period of Coronavirus Disease 2019
#> (COVID-19) From Publicly Reported Confirmed Cases: Estimation and
#> Application.” _Annals of Internal Medicine_. doi:10.7326/M20-0504
#> <https://doi.org/10.7326/M20-0504>.
#> 
#> Lauer S, Grantz K, Bi Q, Jones F, Zheng Q, Meredith H, Azman A, Reich
#> N, Lessler J (2020). “The Incubation Period of Coronavirus Disease 2019
#> (COVID-19) From Publicly Reported Confirmed Cases: Estimation and
#> Application.” _Annals of Internal Medicine_. doi:10.7326/M20-0504
#> <https://doi.org/10.7326/M20-0504>.
#> 
#> Guo Z, Zhao S, Sun S, He D, Chong K, Yeoh E (2022). “Estimation of the
#> serial interval of monkeypox during the early outbreak in 2022.”
#> _Journal of Medical Virology_. doi:10.1002/jmv.28248
#> <https://doi.org/10.1002/jmv.28248>.
#> 
#> Wang S, Zhang F, Yuan Z, Xu M, Wang Z, Gao C, Guo R, Du Z (2022).
#> “Serial intervals and incubation periods of the monkeypox virus
#> clades.” _Journal of Travel Medicine_. doi:10.1093/jtm/taac105
#> <https://doi.org/10.1093/jtm/taac105>.
#> 
#> Wang S, Zhang F, Yuan Z, Xu M, Wang Z, Gao C, Guo R, Du Z (2022).
#> “Serial intervals and incubation periods of the monkeypox virus
#> clades.” _Journal of Travel Medicine_. doi:10.1093/jtm/taac105
#> <https://doi.org/10.1093/jtm/taac105>.
#> 
#> Wang S, Zhang F, Yuan Z, Xu M, Wang Z, Gao C, Guo R, Du Z (2022).
#> “Serial intervals and incubation periods of the monkeypox virus
#> clades.” _Journal of Travel Medicine_. doi:10.1093/jtm/taac105
#> <https://doi.org/10.1093/jtm/taac105>.
#> 
#> Wang S, Zhang F, Yuan Z, Xu M, Wang Z, Gao C, Guo R, Du Z (2022).
#> “Serial intervals and incubation periods of the monkeypox virus
#> clades.” _Journal of Travel Medicine_. doi:10.1093/jtm/taac105
#> <https://doi.org/10.1093/jtm/taac105>.
#> 
#> Wang S, Zhang F, Yuan Z, Xu M, Wang Z, Gao C, Guo R, Du Z (2022).
#> “Serial intervals and incubation periods of the monkeypox virus
#> clades.” _Journal of Travel Medicine_. doi:10.1093/jtm/taac105
#> <https://doi.org/10.1093/jtm/taac105>.
#> 
#> Wei F, Peng Z, Jin Z, Wang J, Xu X, Zhang X, Xu J, Ren Z, Bai Y, Wang
#> X, Lu B, Wang Z, Xu J, Huang S (2022). “Study and prediction of the
#> 2022 global monkeypox epidemic.” _Journal of Biosafety and
#> Biosecurity_. doi:10.1016/j.jobb.2022.12.001
#> <https://doi.org/10.1016/j.jobb.2022.12.001>.
#> 
#> Wei F, Peng Z, Jin Z, Wang J, Xu X, Zhang X, Xu J, Ren Z, Bai Y, Wang
#> X, Lu B, Wang Z, Xu J, Huang S (2022). “Study and prediction of the
#> 2022 global monkeypox epidemic.” _Journal of Biosafety and
#> Biosecurity_. doi:10.1016/j.jobb.2022.12.001
#> <https://doi.org/10.1016/j.jobb.2022.12.001>.
#> 
#> Wei F, Peng Z, Jin Z, Wang J, Xu X, Zhang X, Xu J, Ren Z, Bai Y, Wang
#> X, Lu B, Wang Z, Xu J, Huang S (2022). “Study and prediction of the
#> 2022 global monkeypox epidemic.” _Journal of Biosafety and
#> Biosecurity_. doi:10.1016/j.jobb.2022.12.001
#> <https://doi.org/10.1016/j.jobb.2022.12.001>.
#> 
#> Salje H, Cauchemez S, Alera M, Rodriguez-Barraquer I, Thaisomboonsuk B,
#> Srikiatkhachorn A, Lago C, Villa D, Klungthong C, Tac-An I, Fernandez
#> S, Velasco J, Roque Jr V, Nisalak A, Macareo L, Levy J, Cummings D,
#> Yoon I (2015). “Reconstruction of 60 Years of Chikungunya Epidemiology
#> in the Philippines Demonstrates Episodic and Focal Transmission.” _The
#> Journal of Infectious Diseases_. doi:10.1093/infdis/jiv470
#> <https://doi.org/10.1093/infdis/jiv470>.
#> 
#> Guzzetta G, Vairo F, Mammone A, Lanini S, Poletti P, Manica M, Rosa R,
#> Caputo B, Solimini A, della Torre A, Scognamiglio P, Zumla A, Ippolito
#> G, Merler S (2020). “Spatial modes for transmission of chikungunya
#> virus during a large chikungunya outbreak in Italy: a modeling
#> analysis.” _BMC Medicine_. doi:10.1186/s12916-020-01674-y
#> <https://doi.org/10.1186/s12916-020-01674-y>.
#> 
#> de Souza W, de Lima S, Mello L, Candido D, Buss L, Whittaker C, Claro
#> I, Chandradeva N, Granja F, de Jesus R, Lemos P, Toledo-Teixeira D,
#> Barbosa P, Firmino A, Amorim M, Duarte L, Pessoa Jr I, Forato J,
#> Vasconcelos I, Maximo A, Araújo E, Mello L, Sabino E, Proença-Módena J,
#> Faria N, Weaver S (2023). “Spatiotemporal dynamics and recurrence of
#> chikungunya virus in Brazil: an epidemiological study.” _The Lancet
#> Microbe_. doi:10.1016/S2666-5247(23)00033-2
#> <https://doi.org/10.1016/S2666-5247%2823%2900033-2>.
```
