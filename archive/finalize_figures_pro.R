if (!require("pdftools")) install.packages("pdftools", repos='http://cran.us.r-project.org')

plots <- c(
  "Module_Trait_Correlation.pdf",
  "GO_Enrichment_Barplot.pdf"
)


for (p in plots) {
  input_path <- file.path("~/Epithelial_OxStress_Meta/results", p)
  output_path <- gsub(".pdf", ".tif", input_path)
  
  if (file.exists(input_path)) {
    temp_name <- pdf_convert(input_path, format = "tiff", dpi = 800)
    file.rename(temp_name, output_path)
    
  } else {
  }
}

