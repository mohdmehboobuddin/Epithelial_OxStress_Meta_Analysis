library(data.table)

data <- fread("~/Epithelial_OxStress_Meta/data/processed/Adjusted_Counts.csv", data.table=FALSE)
rownames(data) <- data[[1]]
data <- data[,-1]

datExpr <- log2(t(data) + 1)

sampleTree = hclust(dist(datExpr), method = "average")

pdf("~/Epithelial_OxStress_Meta/results/Sample_Clustering_PostCorrection.pdf", width = 12, height = 9)
plot(sampleTree, main = "Sample Clustering (Batch Corrected)", 
     sub="", xlab="", cex.lab = 1.5, cex.axis = 1.5, cex.main = 2)
dev.off()

