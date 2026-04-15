library(data.table)
library(org.Hs.eg.db)

yellow_genes <- fread("~/Epithelial_OxStress_Meta/results/Architecture_Genes_Yellow.csv")$Gene

amd_data <- fread("~/Epithelial_OxStress_Meta/data/raw/GSE115828_Human_Retina_AMD_counts.tsv.gz")
ensembl_ids <- amd_data$GeneID

gene_map <- select(org.Hs.eg.db, 
                   keys = ensembl_ids, 
                   columns = c("SYMBOL"), 
                   keytype = "ENSEMBL")

amd_symbols <- unique(gene_map$SYMBOL)

overlap_genes <- intersect(yellow_genes, amd_symbols)
n_overlap <- length(overlap_genes)

total_universe <- 20000
p_value <- phyper(n_overlap - 1, length(yellow_genes), total_universe - length(yellow_genes), length(amd_symbols), lower.tail = FALSE)

results <- data.frame(
    Yellow_Size = length(yellow_genes),
    AMD_Size = length(amd_symbols),
    Overlap = n_overlap,
    P_Value = p_value
)

write.csv(results, "~/Epithelial_OxStress_Meta/results/Final_Clinical_Anchor_Stats.csv", row.names = FALSE)
write.csv(data.frame(Gene = overlap_genes), "~/Epithelial_OxStress_Meta/results/Clinical_Overlap_Genes.csv", row.names = FALSE)

cat("\n--- TRANSLATIONAL SUCCESS ---\n")
cat("Architecture Genes found in Clinical AMD Data:", n_overlap, "\n")
cat("Significance (P-value):", p_value, "\n")
cat("-----------------------------\n")
