library(WGCNA)
library(data.table)

allowWGCNAThreads()

datExpr <- fread("~/Epithelial_OxStress_Meta/data/processed/Adjusted_Counts.csv", data.table=FALSE)
rownames(datExpr) <- datExpr[[1]]
datExpr <- t(log2(datExpr[,-1] + 1)) # Transpose: Samples in rows, Genes in columns

powers = c(c(1:10), seq(from = 12, to=20, by=2))
sft = pickSoftThreshold(datExpr, powerVector = powers, verbose = 5)

pdf("~/Epithelial_OxStress_Meta/results/WGCNA_Power_Selection.pdf", width = 12, height = 9)
par(mfrow = c(1,2))
cex1 = 0.9

plot(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     xlab="Soft Threshold (power)", ylab="Scale Free Topology Model Fit,signed R^2",
     type="n", main = paste("Scale independence"))
text(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     labels=powers, cex=cex1, col="red")
abline(h=0.90, col="red")

plot(sft$fitIndices[,1], sft$fitIndices[,5],
     xlab="Soft Threshold (power)", ylab="Mean Connectivity",
     type="n", main = paste("Mean connectivity"))
text(sft$fitIndices[,1], sft$fitIndices[,5], labels=powers, cex=cex1, col="red")
dev.off()

