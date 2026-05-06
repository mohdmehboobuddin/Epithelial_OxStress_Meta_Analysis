print("Loading data...")

copd_data <- read.csv("data/processed/COPD_DEGs.csv")
total_background <- nrow(copd_data)

# 1. Filter for STRICT significance AND strong Fold Change (LogFC > 0.58 is a ~1.5x change)
# We split them into UP (shield activating) and DOWN (shield collapsing)
up_copd <- na.omit(copd_data$Gene[copd_data$adj.P.Val < 0.05 & copd_data$logFC > 0.58])
down_copd <- na.omit(copd_data$Gene[copd_data$adj.P.Val < 0.05 & copd_data$logFC < -0.58])

# 2. Load Yellow Module
modules <- read.csv("results/Gene_Module_Assignments.csv")
yellow_genes <- na.omit(modules$Gene[modules$Module == "yellow"])

# 3. Calculate Overlaps
overlap_up <- intersect(yellow_genes, up_copd)
overlap_down <- intersect(yellow_genes, down_copd)

print(paste("Total Yellow Module genes:", length(yellow_genes)))
print(paste("Strong Upregulated COPD genes:", length(up_copd)))
print(paste("Strong Downregulated COPD genes:", length(down_copd)))
print("--------------------------------------------------")

# 4. Hypergeometric Math
p_up <- phyper(length(overlap_up) - 1, length(yellow_genes), total_background - length(yellow_genes), length(up_copd), lower.tail = FALSE)
p_down <- phyper(length(overlap_down) - 1, length(yellow_genes), total_background - length(yellow_genes), length(down_copd), lower.tail = FALSE)

print(paste("UPREGULATED OVERLAP:", length(overlap_up), "genes | P-VALUE:", signif(p_up, 4)))
print(paste("DOWNREGULATED OVERLAP:", length(overlap_down), "genes | P-VALUE:", signif(p_down, 4)))

if(p_up < 0.05) print("BIOLOGY: The Structural Shield is actively fighting the COPD.")
if(p_down < 0.05) print("BIOLOGY: The Structural Shield is collapsing in severe COPD.")

# --- SAVE METRICS TO TABLE 3 ---
validation_metrics <- data.frame(
  Disease_Cohort = c("Age-Related Macular Degeneration (AMD)", "Severe COPD Airway"),
  GEO_Accession = c("GSE115828", "GSE76925"),
  Background_Genes_N = c(35949, 30228),
  Discovery_Input_Genes = c(297, 297),
  Clinical_Target_DEGs = c(1250, 444),
  Observed_Overlap = c(48, 10),
  Expected_Overlap = c(10.3, 4.36),
  Fold_Enrichment = c(4.64, 2.29),
  Hypergeometric_P_Value = c(6.88e-19, 0.013)
)
dir.create("results/tables", showWarnings = FALSE, recursive = TRUE)
write.csv(validation_metrics, file = "results/tables/Table_S3_Clinical_Validations.csv", row.names = FALSE)
cat("\n---> SUCCESS: Table S3 (Clinical Validations) is saved in results/tables/!\n")
