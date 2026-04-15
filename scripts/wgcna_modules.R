library(WGCNA)
library(data.table)

allowWGCNAThreads()

counts_file <- "~/Epithelial_OxStress_Meta/data/processed/Adjusted_Counts.csv"
datExpr_raw <- fread(counts_file, data.table=FALSE)

rownames(datExpr_raw) <- datExpr_raw[[1]]
datExpr <- t(log2(datExpr_raw[,-1] + 1))

softPower = 14

net = blockwiseModules(datExpr, 
                       power = softPower,
                       TOMType = "signed", 
                       minModuleSize = 30,
                       reassignThreshold = 0, 
                       mergeCutHeight = 0.25,
                       numericLabels = TRUE, 
                       pamRespectsDendro = FALSE,
                       saveTOMs = TRUE,
                       saveTOMFileBase = "EpithelialTOM",
                       verbose = 3)


moduleColors = labels2colors(net$colors)

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

