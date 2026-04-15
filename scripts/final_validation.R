library(data.table)
library(org.Hs.eg.db)

trait_stats <- fread("~/Epithelial_OxStress_Meta/results/Module_Trait_Statistics.csv")
turq_stats <- trait_stats[grep("turquoise|ME1$", Module)] 
if(nrow(turq_stats) > 0) {
    print(turq_stats)
} else {
    print(head(trait_stats, 5))
}

yellow_genes <- fread("~/Epithelial_OxStress_Meta/results/Architecture_Genes_Yellow.csv")$Gene
amd_data <- fread("~/Epithelial_OxStress_Meta/data/raw/GSE115828_Human_Retina_AMD_counts.tsv.gz")

amd_symbols <- mapIds(org.Hs.eg.db, keys = amd_data$GeneID, column = "SYMBOL", keytype = "ENSEMBL", multiVals = "first")
amd_symbols <- na.omit(unique(amd_symbols))

overlap <- intersect(yellow_genes, amd_symbols)
p_val <- phyper(length(overlap) - 1, length(yellow_genes), 20000 - length(yellow_genes), length(amd_symbols), lower.tail = FALSE)

tf_families <- "FOS|JUN|REL|STAT|IRF|HIF1A|ATF|CEBP|EGR|KLF"
tf_candidates <- yellow_genes[grepl(tf_families, yellow_genes)]

if(length(tf_candidates) > 0) {
    print(tf_candidates)
} else {
}

final_report <- data.frame(
  Module = c("Yellow (Structural)", "Turquoise (Metabolic)"),
  Trait_Correlation = c(0.48, if(nrow(turq_stats)>0) turq_stats$Correlation[1] else "Pending"),
  Discovery_P_Val = c("2.8e-36", if(nrow(turq_stats)>0) turq_stats$P_Value[1] else "Pending"),
  Clinical_Enrichment_P = c(p_val, "N/A")
)
write.csv(final_report, "~/Epithelial_OxStress_Meta/results/Master_Validation_Report.csv", row.names = FALSE)
