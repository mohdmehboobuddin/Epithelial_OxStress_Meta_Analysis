library(pdftools)
setwd("~/Epithelial_OxStress_Meta/results")

convert_or_rename <- function(target_new_name, possible_old_names) {
    for (old in possible_old_names) {
        if (file.exists(old)) {
            if (grepl("\\.pdf$", old, ignore.case = TRUE)) {
                pdf_convert(old, format = "tiff", dpi = 800, filenames = target_new_name)
                return(TRUE)
            } else if (grepl("\\.tif$", old, ignore.case = TRUE) || grepl("\\.tiff$", old, ignore.case = TRUE)) {
                if (old != target_new_name) {
                    file.rename(old, target_new_name)
                } else {
                }
                return(TRUE)
            }
        }
    }
    return(FALSE)
}


convert_or_rename("Figure_1_PCA.tif", c("Figure1_PCA_Final.tif"))

convert_or_rename("Figure_2_WGCNA_Dendrogram.tif", c("WGCNA_Dendrogram.pdf", "WGCNA_Dendrogram.tif"))

convert_or_rename("Figure_3_Module_Trait_Heatmap.tif", c("Module_Trait_Correlation.tif", "Module_Trait_Correlation.pdf"))

convert_or_rename("Figure_4_GO_Enrichment.tif", c("GO_Enrichment_Barplot.pdf", "GO_Enrichment_Barplot.tif"))

convert_or_rename("Figure_5_Hub_Network.tif", c("Figure5_Hub_Network.tif"))

convert_or_rename("Figure_6_Clinical_GSEA.tif", c("Clinical_GSEA_Plot.pdf", "Clinical_GSEA_Plot.tif"))

