## code to prepare core columns from the {epireview} epidemiological
## parameters goes here

# These are the columns from the {epireview} epidemiological parameter table
# (`load_epidata(<pathogen>)$params`) that are read by `as_epiparameter()` when
# converting an {epireview} entry into an `<epiparameter>` object (see
# `.epireview_to_epiparameter()` in R/coercion.R). They are used by
# `.is_epireview()` both to identify an {epireview} parameter table and to
# guarantee the columns required for conversion are present.
#
# This set is curated by hand (rather than computed as the intersection of the
# columns of every {epireview} parameter table) so that:
#   * detection is not coupled to columns the converter never uses (e.g. the
#     `parameter_uncertainty_singe_type` typo column, which is being corrected
#     to `parameter_uncertainty_single_type` on a per-pathogen basis), and
#   * regenerating the data does not require {epireview} to be installed.
epireview_core_cols <- c(
  "pathogen",
  "parameter_type",
  "parameter_value",
  "parameter_value_type",
  "parameter_unit",
  "parameter_lower_bound",
  "parameter_upper_bound",
  "parameter_uncertainty_type",
  "parameter_uncertainty_lower_value",
  "parameter_uncertainty_upper_value",
  "distribution_type",
  "distribution_par1_value",
  "distribution_par1_type",
  "distribution_par2_value",
  "distribution_par2_type",
  "population_sample_size",
  "population_country",
  "population_location",
  "first_author_surname",
  "year_publication",
  "id"
)

usethis::use_data(
  epireview_core_cols,
  overwrite = TRUE,
  version = 3
)
