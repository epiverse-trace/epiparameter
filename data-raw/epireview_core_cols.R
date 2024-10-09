## code to prepare core columns from the {epireview} epidemiological
## parameters goes here

# {epireview} is not a package dependency so wrapped in requireNamespace()
if (requireNamespace("epireview", quietly = TRUE)) {
  epireview_marburg <- epireview::load_epidata("marburg")
  epireview_ebola <- epireview::load_epidata("ebola")
  epireview_lassa <- epireview::load_epidata("lassa")

  intersect_marburg_ebola <- intersect(
    colnames(epireview_marburg$params),
    colnames(epireview_ebola$params)
  )
  epireview_core_cols <- intersect(
    intersect_marburg_ebola,
    colnames(epireview_lassa$params)
  )
  usethis::use_data(
    epireview_core_cols,
    overwrite = TRUE,
    version = 3
  )
}


