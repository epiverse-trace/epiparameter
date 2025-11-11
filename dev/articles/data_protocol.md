# Data Collation and Synthesis Protocol

## About the package

The [`{epiparameter}` R
package](https://github.com/epiverse-trace/epiparameter) contains a
library of epidemiological parameter data and functions that read and
handle this data. The delay distributions describe the time between two
events in epidemiology, for example incubation period, serial interval
and onset-to-death; while the offspring distributions describe the
number of secondary infections from a primary infection in disease
transmission. The library is compiled by a process of collecting,
reviewing and extracting data from peer-reviewed literature[¹](#fn1),
including research articles, systematic reviews and meta-analyses.

The [epiparameter](https://github.com/epiverse-trace/epiparameter/)
package will act as a ‘living systematic review’ (*sensu* Elliott et al.
([2014](#ref-elliottLivingSystematicReviews2014))) which will be
actively updated and maintained to provide a reliable source of data on
epidemiological distributions. To prevent bias in the collection or
assessment of the data, a well-defined methodology of searching and
refining is required. This document aims to provide transparency on the
methodology used by the
[epiparameter](https://github.com/epiverse-trace/epiparameter/)
maintainers by outlining the steps taken at each stage of the data
handling. It can also serve as a guide to contributors wanting to search
and provide epidemiological parameters currently missing from the
library. This protocol should also facilitate reproducibility in the
searches, results and appraisal steps.

There is a large body of work on the methods to best conduct literature
searches and data collection as part of systematic reviews and
meta-analyses[²](#fn2), which we use as the basis for our protocol.
These sources are:

- [Cochrane Handbook](https://training.cochrane.org/handbook/current/)
  ([Higgins et al. 2019](#ref-higginsCochraneHandbookSystematic2019))
- [PRISMA](https://www.prisma-statement.org/) ([Page et al.
  2021](#ref-pagePRISMA2020Statement2021))

## Objective of `{epiparameter}`

As defined by the PRISMA guidelines, having a clearly stated objective
helps to refine the goal of the project.
[epiparameter](https://github.com/epiverse-trace/epiparameter/)’s
objective is to provide information for a collection of distributions
for a range of infectious diseases that is as accurate, unbiased and as
comprehensive as possible. Such distributions will enable outbreak
analysts to easily access these distributions for routine analysis. For
example, delay distributions are necessary for: calculating case
fatality rates adjusting for delay to outcome, quantifying implications
of different screening measures and quarantine periods, estimating
reproduction numbers, and scenario modelling using transmission dynamic
models.

## Contributing to the package

To contribute to the
[epiparameter](https://github.com/epiverse-trace/epiparameter/) library
of epidemiological parameter information, added your data to [this
google
sheet](https://docs.google.com/spreadsheets/d/1zVpaaKkQ7aeMdRN2r0p-W4d2TtccL5HcIOp_w-lfkEQ/edit?usp=sharing).
This will then be integrated into the
[epiparameter](https://github.com/epiverse-trace/epiparameter/) library
by the package maintainers, and the information will then be accessible
to all [epiparameter](https://github.com/epiverse-trace/epiparameter/)
package users.

## Scope of package

The [epiparameter](https://github.com/epiverse-trace/epiparameter/)
package spans a range of infectious diseases, including several
distributions for each disease when available. The pathogens and
diseases that are currently systematically searched for and included in
the package library are:

    #> Returning 125 results that match the criteria (100 are parameterised). 
    #> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
    #> To retrieve the citation for each use the 'get_citation' function

|            Disease            |          Pathogen           |
|:-----------------------------:|:---------------------------:|
|          Adenovirus           |         Adenovirus          |
|       Human Coronavirus       |          Human_Cov          |
|             SARS              |         SARS-Cov-1          |
|           Influenza           |         Influenza-A         |
|           Influenza           |         Influenza-A         |
|           Influenza           |         Influenza-B         |
|            Measles            |        Measles Virus        |
|         Parainfluenza         |     Parainfluenza Virus     |
|              RSV              |             RSV             |
|          Rhinovirus           |         Rhinovirus          |
|           Influenza           |         Influenza-A         |
|           Influenza           |         Influenza-A         |
|              RSV              |             RSV             |
|              RSV              |             RSV             |
|           Influenza           |      Influenza-A-H1N1       |
|           Influenza           |      Influenza-A-H1N1       |
|           Influenza           |      Influenza-A-H7N9       |
|           Influenza           |      Influenza-A-H7N9       |
|           Influenza           |      Influenza-A-H7N9       |
|           Influenza           |      Influenza-A-H7N9       |
|           Influenza           |      Influenza-A-H7N9       |
|           Influenza           |      Influenza-A-H1N1       |
|           Influenza           |     Influenza-A-H1N1Pdm     |
|           Influenza           |     Influenza-A-H1N1Pdm     |
|           Influenza           |      Influenza-A-H1N1       |
|           Influenza           |      Influenza-A-H1N1       |
|     Marburg Virus Disease     |        Marburg Virus        |
|     Marburg Virus Disease     |        Marburg Virus        |
|     Marburg Virus Disease     |        Marburg Virus        |
|     Marburg Virus Disease     |        Marburg Virus        |
|     Marburg Virus Disease     |        Marburg Virus        |
|             SARS              |         SARS-Cov-1          |
|             SARS              |         SARS-Cov-1          |
|           Smallpox            |   Smallpox-Variola-Major    |
|           Smallpox            |   Smallpox-Variola-Major    |
|           Smallpox            |   Smallpox-Variola-Minor    |
|           Smallpox            |   Smallpox-Variola-Minor    |
|             Mpox              |       Monkeypox Virus       |
|       Pneumonic Plague        |       Yersinia Pestis       |
| Hantavirus Pulmonary Syndrome |  Hantavirus (Andes Virus)   |
|      Ebola Virus Disease      |         Ebola Virus         |
|            Dengue             |        Dengue Virus         |
|            Dengue             |        Dengue Virus         |
|            Dengue             |        Dengue Virus         |
|      Zika Virus Disease       |         Zika Virus          |
|          Chikungunya          |      Chikungunya Virus      |
|            Dengue             |        Dengue Virus         |
|            Dengue             |        Dengue Virus         |
|     Japanese Encephalitis     | Japanese Encephalitis Virus |
|       Rift Valley Fever       |   Rift Valley Fever Virus   |
|        West Nile Fever        |       West Nile Virus       |
|        West Nile Fever        |       West Nile Virus       |
|        West Nile Fever        |       West Nile Virus       |
|         Yellow Fever          |    Yellow Fever Viruses     |
|         Yellow Fever          |    Yellow Fever Viruses     |
|             Mpox              |         Mpox Virus          |
|             Mpox              |         Mpox Virus          |
|             Mpox              |         Mpox Virus          |
|             Mpox              |         Mpox Virus          |
|             Mpox              |         Mpox Virus          |
|             Mpox              |         Mpox Virus          |
|             Mpox              |         Mpox Virus          |
|      Ebola Virus Disease      |  Ebola Virus-Zaire Subtype  |
|      Ebola Virus Disease      |  Ebola Virus-Zaire Subtype  |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|      Ebola Virus Disease      |         Ebola Virus         |
|             MERS              |          MERS-Cov           |
|             MERS              |          MERS-Cov           |
|             MERS              |          MERS-Cov           |
|             MERS              |          MERS-Cov           |
|             MERS              |          MERS-Cov           |
|             MERS              |          MERS-Cov           |
|             MERS              |          MERS-Cov           |
|             MERS              |          MERS-Cov           |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|           COVID-19            |         SARS-CoV-2          |
|             Mpox              |         Mpox Virus          |
|             Mpox              |     Mpox Virus Clade I      |
|             Mpox              |         Mpox Virus          |
|             Mpox              |     Mpox Virus Clade I      |
|             Mpox              |    Mpox Virus Clade IIa     |
|             Mpox              |    Mpox Virus Clade IIb     |
|             Mpox              |         Mpox Virus          |
|             Mpox              |         Mpox Virus          |
|             Mpox              |         Mpox Virus          |
|          Chikungunya          |      Chikungunya Virus      |
|          Chikungunya          |      Chikungunya Virus      |
|          Chikungunya          |      Chikungunya Virus      |

The distributions currently included in the literature search for each
pathogen/disease are:

    #> Returning 125 results that match the criteria (100 are parameterised). 
    #> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
    #> To retrieve the citation for each use the 'get_citation' function

|  Epidemiological Parameter   |
|:----------------------------:|
|      incubation period       |
|       serial interval        |
|       generation time        |
|        onset to death        |
|    offspring distribution    |
|   hospitalisation to death   |
| hospitalisation to discharge |
|    notification to death     |
|  notification to discharge   |
|      onset to discharge      |
|   onset to hospitalisation   |
|     onset to ventilation     |
|      case fatality risk      |

## Guide to identifying distributions in the literature

1.  **Key word searches**: when searching the literature, the use of
    specific search phrases to ensure the correct literature is procured
    is required. We use a search schema that includes searching for the
    pathogen or the disease, and the desired distribution. The search
    phrase can optionally include a specific variant/strain/subtype. The
    search is not constrained based on year of publication. Examples of
    searches:

- “SARS-CoV-2 incubation period”
- “ebola serial interval”
- “influenza H7N9 onset to admission”

However, these simple search phrases can return a large number of
irrelevant papers. Using a more specific search schema depending on the
search engine used. For example, if using Google Scholar a schema like:

- (“Middle East Respiratory Syndrome” OR MERS) AND “onset to death” AND
  (estimation OR inference OR calculation)
- (ebola OR EVD) AND “onset to death” AND (estimation OR inference OR
  calculation)

Or if Web of Science is being used:

- (“Middle East Respiratory Syndrome” OR MERS) AND “onset to death” AND
  estimat\*
- (ebola OR EVD) AND “onset to death” AND estimat\*

This should refine the results to a more suitable set of literature.

1.  **Literature search engines**: using a selection of search engines
    to prevent one source potentially omitting papers. Suggested search
    sites are: Google Scholar, Web of Science, PubMed, and Scopus.

2.  **Adding papers**: in addition to the database entries from papers
    that have been identified in a literature search, entries can be
    supplemented by recommendations (i.e. from the community) or through
    being cited by a paper in the literature search. Papers may be
    recommended by experts in research or public health communities. We
    plan to use two methods of community engagement. Firstly a
    [open-access Google
    sheet](https://docs.google.com/spreadsheets/d/1zVpaaKkQ7aeMdRN2r0p-W4d2TtccL5HcIOp_w-lfkEQ/edit?usp=sharing)
    allows people to add their distribution data which will then be
    reviewed by one of the
    [epiparameter](https://github.com/epiverse-trace/epiparameter/)
    maintainers and incorporated if it meets quality checks. The second
    method - not yet implemented - involves community members uploading
    their data to [zenodo](https://zenodo.org/), which can then be read
    and loaded into R using
    [epiparameter](https://github.com/epiverse-trace/epiparameter/) once
    checked.

3.  **Language restrictions**: papers in English or Spanish are
    currently supported in
    [epiparameter](https://github.com/epiverse-trace/epiparameter/).
    Papers written in another language but verified by an expert can
    also be included in the database. However, these are not evaluated
    with the review process described below and as a result are flagged
    to the user when loaded in
    [epiparameter](https://github.com/epiverse-trace/epiparameter/).

## Guide to data refinement once sources identified

1.  **Removing duplicates**: the library of parameters does not contain
    duplicates of studies, but multiple entries per study can be
    included if a paper reports multiple results (e.g. from the full
    data set and then a subset of the data). Studies that use the same
    data, subsets or supersets of data used in other papers in the
    library are included.

2.  **Abstract and methods screening**: once a number of unique sources
    have been identified, each should be reviewed for its suitability by
    reviewing the abstract and searching for words or phrases in the
    paper that indicate it reports the parameters or summary statistics
    of a distribution, this can include searching the methods section
    for words on types of distributions (e.g. lognormal), fitting
    procedures (e.g. maximum likelihood or bayesian), or searching the
    results for parameter estimates. The
    [epiparameter](https://github.com/epiverse-trace/epiparameter/)
    library includes entries where parameters or summary statistics are
    reported but a distribution is not specified, and entries where the
    distribution is specified but the parameters are not reported.

    A database of unsuitable papers will be kept to remind maintainers
    which papers have not been included and aids in the updating of the
    database (see below) by preventing redundant reviewing a previously
    rejected paper.

3.  **Stopping criteria**: for many searches, the number of results is
    far larger than could be reasonably evaluated outside a full
    systematic review. After refining which papers contain the required
    information (abstract and methods screening), around 10 papers per
    pathogen are screened for each search (per search round, see
    updating section below for details). If the number of papers that
    pass the abstract and methods screening is fewer than 10, all
    suitable papers are reviewed.

4.  **Full paper screening**: after the abstract and methods screening,
    those papers not excluded should be reviewed in full to verify they
    indeed contain the required information on distribution parameters
    and information on methodology used. It is acceptable to include a
    secondary source that contains information on the delay distribution
    when the primary source is unavailable or does not report the
    distribution. The inference of the delay distribution does not have
    to be a primary subject of the research article, for example if it
    was inferred to be used in estimation of $R_{0}$ it can still be
    included in the database. Additionally, distribution parameters
    based on illustrative values for use in simulations - rather than
    inferred from data - are considered unsuitable and should be
    excluded.

    Again, any papers excluded at this stage should be recorded in the
    database of unsuitable sources with reasoning to prevent having to
    reassess when updating the database.

5.  **Post hoc removal**: if any
    [epiparameter](https://github.com/epiverse-trace/epiparameter/)
    parameters are later identified as being inappropriate then they can
    be removed from the database. In most cases this is unlikely as
    limitations can be appended onto data entries to make users aware of
    limitations (e.g. around assumptions used to infer the
    distribution), only in the most extreme cases will data be
    completely removed from the database.

Note: systematic reviews focusing on effect sizes can be subject to
publication bias (e.g. more positive or significant results in the
literature). However, distribution inference does not focus on
significance testing or effect sizes, so this bias is not considered in
the collection process.

## Guide to extracting parameters

**Extracting parameters**: for any underlying distributions (e.g. gamma,
lognormal), parameters (e.g. shape/scale, meanlog/sdlog), and summary
statistics (e.g. mean, standard deviation, median, range or quantiles)
given in the paper, values should be recorded verbatim from the paper
into the database. When these are read into R using the
[epiparameter](https://github.com/epiverse-trace/epiparameter/) package,
other aspects of the distribution are automatically calculated and
available. For example if the mean and standard deviation of a gamma
distribution is reported for a serial interval these values will be
stored in the database. But once in R, the shape and scale parameters of
the gamma distribution will be automatically reconstructed and the
resulting distribution available for use.

The [epiparameter](https://github.com/epiverse-trace/epiparameter/)
library exactly reflects the literature. By which we mean that
information not present in the paper should not be imputed from prior
knowledge (e.g. vector of a disease is known but not stated), or by
performing calculating with reported values. This prevents the issue of
not having clear provenance for the data in the library.

The requirements of each entry in the database is defined by the data
dictionary. Here we outline the minimal dataset that is required to be
included in the
[epiparameter](https://github.com/epiverse-trace/epiparameter/) library
is:

- Name of disease
- Type of distribution
- Citation information (author(s) of the paper, the year of publication,
  publication title and journal, and DOI)
- Whether the distribution is extrinsic (e.g. extrinsic incubation
  period). If the disease is not vector-borne this should be NA.
- Whether the distribution fitted was discretised, this is a boolean
  (true or false).

All other information for each database entry is non-essential.

See the data dictionary included in
[epiparameter](https://github.com/epiverse-trace/epiparameter/) for all
database fields with a description of each and the range of possible
values each field can take.

## Data quality assessment in `{epiparameter}`

The inference of parameters for a delay distribution often requires
methodological adjustments to correct for factors that would otherwise
bias the estimates. These includes accounting for interval-censoring of
the data when the timing of an event (e.g. exposure to a pathogen) is
not know with certainty, but rather within a time window. Or adjusting
for phase bias when the distribution is estimated during a growing or
shrinking stage of an epidemic. The aim of
[epiparameter](https://github.com/epiverse-trace/epiparameter/) is not
to make a judgement on which parameters are ‘better’ than others, but to
notify and warn the user of the potential limitations of the data. The
aspects assessed are: 1) whether the method includes single or double
interval-censoring when the exposure or onset times are not known with
certainty (i.e. on a single day); 2) does the method adjust for phase
bias when the outbreak is in an ascending or descending phase. These are
indicated by boolean values to indicate whether they are reported in the
paper and users are recommended to refer back to the paper to determine
whether estimates are biased.

## Guide to the `{epiparameter}` review process

For a set of parameters to be included in the database it must pass the
abstract and methods screening and full screening and subsequently a
review by one of the
[epiparameter](https://github.com/epiverse-trace/epiparameter/)
maintainers. This process involves running diagnostic checks and
cross-referencing the reported parameters with those in the paper to
ensure they match exactly and that the results plot of the PDF/CDF/PMF
matches anything plotted in the paper, if available. This prevents a
possible misinterpretation (e.g. serial interval for incubation period).
This check also includes making sure the unique identifiers for the
paper match the author’s name, publication year and other data recorded
in the database.

## Updating parameters in the database

Because search and review stages are time consuming and cannot be
continuously carried out, we aim to keep the
[epiparameter](https://github.com/epiverse-trace/epiparameter/) library
up-to-date as a living data library by conducting regular searches
(i.e. every 3-4 months) to fill in any missing papers or new publication
since the last search. The epidemiological literature can expand
rapidly, especially during a new outbreak. Therefore we can optionally
include new studies that are of use to the epidemiological community in
between regular updates. These small additions will still be subject to
the data quality assessment and diagnostics to ensure accuracy, and will
likely be picked up in the subsequent literature searches. It is likely
that for existing pathogens that have not had a major increase in
incidence since the last update few new papers will be reporting delay
distributions. In these cases papers that were not previously reviewed
due to limited reviewing time for each round of updates are now checked.

We particularly value community contributions to the database, so
everyone can benefit from analysis that has already been conducted, and
duplicated of effort is reduced.

## Database of excluded papers

All papers that are returned in the search results but are not suitable,
either at the stage of abstract screening, or after reviewing the
entirety of the paper, are recorded in a database by the following
information:

- First author’s last name
- Unique identifier, ideally the DOI
- Journal, pre-print server, or host website
- One or several reasons for why it was deemed unsuitable
- Date of recording

## References

Elliott, Julian H., Tari Turner, Ornella Clavisi, James Thomas, Julian
P. T. Higgins, Chris Mavergames, and Russell L. Gruen. 2014. “Living
Systematic Reviews: An Emerging Opportunity to Narrow the
Evidence-Practice Gap.” *PLoS Medicine* 11 (2): e1001603.
<https://doi.org/10.1371/journal.pmed.1001603>.

Higgins, Julian, James Thomas, Jacqueline Chandler, Miranda Cumpston,
Tianjing Li, Matthew J. Page, and Vivian Andrea Welch. 2019. *Cochrane
Handbook for Systematic Reviews of Interventions*. 2nd ed. Wiley
Cochrane. Newark: John Wiley & Sons, Incorporated.

Page, Matthew J, Joanne E McKenzie, Patrick M Bossuyt, Isabelle Boutron,
Tammy C Hoffmann, Cynthia D Mulrow, Larissa Shamseer, et al. 2021. “The
PRISMA 2020 Statement: An Updated Guideline for Reporting Systematic
Reviews.” *BMJ*, March, n71. <https://doi.org/10.1136/bmj.n71>.

------------------------------------------------------------------------

1.  We also include distribution parameters that are published on
    pre-print servers such as arxiv, bioRxiv and medRxiv. But will
    update the citation reference once the paper is accepted and
    published by a journal.

2.  [epiparameter](https://github.com/epiverse-trace/epiparameter/) is
    itself not a meta-analytic tool, but the references stored within
    may be useful as part of a meta-analysis.
