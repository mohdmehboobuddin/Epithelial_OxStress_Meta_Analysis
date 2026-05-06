library(data.table)

yellow_genes <- fread("~/Epithelial_OxStress_Meta/results/Architecture_Genes_Yellow.csv")$Gene
amd_data <- fread("~/Epithelial_OxStress_Meta/data/processed/GSE115828_DEGs.csv")
amd_degs <- amd_data$V1  # Standardizing to the first column where gene symbols reside

overlap_genes <- intersect(yellow_genes, amd_degs)
n_overlap <- length(overlap_genes)

total_genes <- 13645 
p_value <- phyper(n_overlap - 1, length(yellow_genes), total_genes - length(yellow_genes), length(amd_degs), lower.tail = FALSE)

results_summary <- data.frame(
    Metric = c("Yellow_Module_Size", "AMD_DEG_Size", "Overlap_Count", "P_Value"),
    Value = c(length(yellow_genes), length(amd_degs), n_overlap, p_value)
)

write.csv(results_summary, "~/Epithelial_OxStress_Meta/results/Clinical_Anchor_Stats.csv", row.names = FALSE)
write.csv(data.frame(Gene = overlap_genes), "~/Epithelial_OxStress_Meta/results/Clinical_Overlap_Genes.csv", row.names = FALSE)

cat("\n--- CLINICAL VALIDATION RESULTS ---\n")
cat("Overlap found:", n_overlap, "genes\n")
cat("Significance (P-value):", p_value, "\n")
cat("------------------------------------\n")
