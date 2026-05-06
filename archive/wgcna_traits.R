library(WGCNA)
library(data.table)

MEs <- read.csv("~/Epithelial_OxStress_Meta/results/Module_Eigengenes.csv", row.names = 1)
metadata <- read.csv("~/Epithelial_OxStress_Meta/data/processed/metadata.csv")

metadata <- metadata[metadata$Sample_ID %in% rownames(MEs), ]
metadata <- metadata[match(rownames(MEs), metadata$Sample_ID), ]

traitData <- as.data.frame(as.numeric(as.factor(metadata$Condition)) - 1)
colnames(traitData) <- "Oxidative_Stress"

moduleTraitCor = cor(MEs, traitData, use = "p")
moduleTraitPvalue = corPvalueStudent(moduleTraitCor, nrow(MEs))

pdf("~/Epithelial_OxStress_Meta/results/Module_Trait_Correlation.pdf", width = 10, height = 7)

textMatrix = paste(round(moduleTraitCor, 2), "\n(",
                   signif(moduleTraitPvalue, 1), ")", sep = "")
dim(textMatrix) = dim(moduleTraitCor)

labeledHeatmap(Matrix = moduleTraitCor,
               xLabels = colnames(traitData),
               yLabels = names(MEs),
               ySymbols = names(MEs),
               colorLabels = FALSE,
               colors = blueWhiteRed(50),
               textMatrix = textMatrix,
               setStdMargins = FALSE,
               cex.text = 0.8,
               zlim = c(-1,1),
               main = "Module-Trait Relationships (Conserved Architecture)")

dev.off()

results <- data.frame(Module = rownames(moduleTraitCor), 
                      Correlation = moduleTraitCor[,1], 
                      P_Value = moduleTraitPvalue[,1])
write.csv(results, "~/Epithelial_OxStress_Meta/results/Module_Trait_Statistics.csv", row.names=FALSE)

