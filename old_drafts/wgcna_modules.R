library(WGCNA)
library(data.table)

# Allow multi-threading for speed
allowWGCNAThreads()

# 1. Load Data
counts_file <- "~/Epithelial_OxStress_Meta/data/processed/Adjusted_Counts.csv"
datExpr_raw <- fread(counts_file, data.table=FALSE)

# 2. Format Matrix (Transpose so genes are columns)
rownames(datExpr_raw) <- datExpr_raw[[1]]
datExpr <- t(log2(datExpr_raw[,-1] + 1))

# 3. Run Blockwise Network Construction
softPower = 14

net = blockwiseModules(
  datExpr,
  power = softPower,
  TOMType = "signed",
  minModuleSize = 30,
  reassignThreshold = 0,
  mergeCutHeight = 0.25,
  numericLabels = TRUE,
  pamRespectsDendro = FALSE,
  saveTOMs = TRUE,
  saveTOMFileBase = "EpithelialTOM",
  verbose = 3
)

# 4. Process Colors
moduleColors = labels2colors(net$colors)

# 5. Save Numerical Results
gene_module_results <- data.frame(
  Gene = colnames(datExpr),
  Module = moduleColors
)
write.csv(gene_module_results,
          "~/Epithelial_OxStress_Meta/results/Gene_Module_Assignments.csv",
          row.names = FALSE)

write.csv(net$MEs,
          "~/Epithelial_OxStress_Meta/results/Module_Eigengenes.csv",
          row.names = TRUE)

# --- 6. GENERATE CLEAN FIGURE 2 ---
# This section uses only Block 1 to avoid the 'Length of colors vector' error
message("Generating Clean Figure 2...")

# Create directory if missing
if (!dir.exists("~/Epithelial_OxStress_Meta/results/figures/")) {
  dir.create("~/Epithelial_OxStress_Meta/results/figures/", recursive = TRUE)
}

tiff("~/Epithelial_OxStress_Meta/results/figures/Figure_2_WGCNA_Clustering.tif", 
     width = 10, height = 7, units = 'in', res = 300)

# Identify which genes belong to the first dendrogram block
block1_indices <- net$blockGenes[[1]]

plotDendroAndColors(
  net$dendrograms[[1]], 
  moduleColors[block1_indices],  # Subset colors to match the block
  "Module colors", 
  dendroLabels = FALSE,          # REMOVES THE BLACK TEXT MASS
  hang = 0.03, 
  addGuide = TRUE, 
  guideHang = 0.05, 
  main = "Sample Clustering (Batch Corrected - Representative Block)"
)

dev.off()
message("SUCCESS: Figure 2 regenerated without labels.")
