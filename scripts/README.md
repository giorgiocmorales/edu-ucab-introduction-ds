# Scripts

Store reusable course automation here. Keep authoring templates beside the
artifact they generate, not in this folder.

Current scripts:

- `setup_project.R`: install/check the small set of R packages used by lectures
- `export_lecture_pdf.ps1`: render a lecture and export matching
  lecture-numbered Reveal HTML and PDF files with backgrounds preserved
- `clean_generated.ps1`: remove local Quarto/RStudio generated folders; pass
  `-IncludeRenderedSlides` to also clear `outputs/rendered-slides/`
