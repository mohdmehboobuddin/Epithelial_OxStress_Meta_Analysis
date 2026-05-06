library(WGCNA)
library(data.table)

# Allow multi-threading
allowWGCNAThreads()

# 1. Load and Prep Data
message("Loading data for power selection...")
datExpr_raw <- fread("~/Epithelial_OxStress_Meta/data/processed/Adjusted_Counts.csv", data.table=FALSE)
rownames(datExpr_raw) <- datExpr_raw[[1]]
datExpr <- t(log2(datExpr_raw[,-1] + 1))

# 2. Pick Soft Threshold
powers = c(c(1:10), seq(from = 12, to=20, by=2))
sft = pickSoftThreshold(datExpr, powerVector = powers, verbose = 5)

# 3. Generate High-Res TIFF Figure
message("Generating Figure S1: Scale-Free Topology...")

# Create SI_Files directory if it doesn't exist
if (!dir.exists("~/Epithelial_OxStress_Meta/results/SI_Files/")) {
  dir.create("~/Epithelial_OxStress_Meta/results/SI_Files/", recursive = TRUE)
}

tiff("~/Epithelial_OxStress_Meta/results/SI_Files/Figure_S1_Network_Topology.tif", 
     width = 12, height = 6, units = 'in', res = 300)

par(mfrow = c(1,2))
cex1 = 0.9

# Plot 1: Scale Independence
# This shows how well the network follows a scale-free power law
plot(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     xlab="Soft Threshold (power)", 
     ylab="Scale Free Topology Model Fit, signed R^2",
     type="n", 
     main = "Scale Independence")
text(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     labels=powers, cex=cex1, col="red")

# Reference lines
abline(h=0.80, col="red", lty=2)  # Standard threshold line
abline(v=14, col="blue", lty=3)  # Highlight YOUR chosen power

# Plot 2: Mean Connectivity
# This shows how many connections are lost as power increases
plot(sft$fitIndices[,1], sft$fitIndices[,5],
     xlab="Soft Threshold (power)", 
     ylab="Mean Connectivity", 
     type="n", 
     main = "Mean Connectivity")
text(sft$fitIndices[,1], sft$fitIndices[,5], labels=powers, cex=cex1, col="red")
abline(v=14, col="blue", lty=3)  # Highlight YOUR chosen power

dev.off()

message("SUCCESS: Figure S1 regenerated as high-res TIFF in results/SI_Files/")
