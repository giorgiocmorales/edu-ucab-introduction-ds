options(repos = c(CRAN = "https://cloud.r-project.org"))

if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

renv::restore(prompt = FALSE)

message("Project packages restored.")
message("If you need local-only materials, copy them into data/, references/, and legacy/ from your main archive.")
