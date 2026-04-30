options(repos = c(CRAN = "https://cloud.r-project.org"))

required_packages <- c(
  "dslabs",
  "here",
  "knitr",
  "showtext",
  "sysfonts",
  "tidyverse"
)

missing_packages <- required_packages[
  !vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)
]

if (length(missing_packages) > 0) {
  install.packages(missing_packages)
}

message("Project package check complete.")
message("If you need local-only materials, copy them into data/, references/, and legacy/ from your main archive.")
