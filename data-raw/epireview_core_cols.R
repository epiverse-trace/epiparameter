## code to prepare core columns from the {epireview} epidemiological
## parameters goes here

# {epireview} is not a package dependency so wrapped in requireNamespace()
if (requireNamespace("epireview", quietly = TRUE)) {
  epireview_marburg <- epireview::load_epidata("marburg")
  epireview_ebola <- epireview::load_epidata("ebola")
  epireview_lassa <- epireview::load_epidata("lassa")
  epireview_sars <- epireview::load_epidata("sars")

  epireview_core_cols <- intersect(
    colnames(epireview_marburg$params),
    colnames(epireview_ebola$params)
  )
  epireview_core_cols <- intersect(
    epireview_core_cols,
    colnames(epireview_lassa$params)
  )
  epireview_core_cols <- intersect(
    epireview_core_cols,
    colnames(epireview_sars$params)
  )
  usethis::use_data(
    epireview_core_cols,
    overwrite = TRUE,
    version = 3
  )
}
