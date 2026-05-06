# Install msigdbr if you don't have it
if (!require("msigdbr", quietly = TRUE)) install.packages("msigdbr", repos="http://cran.us.r-project.org")
library(msigdbr)

print("1. Fetching Hallmark Pathways from MSigDB...")
hallmarks <- msigdbr(species = "Homo sapiens", category = "H")

# Isolate the exact genes for EMT and Apoptosis
emt_genes <- hallmarks$gene_symbol[hallmarks$gs_name == "HALLMARK_EPITHELIAL_MESENCHYMAL_TRANSITION"]
apoptosis_genes <- hallmarks$gene_symbol[hallmarks$gs_name == "HALLMARK_APOPTOSIS"]

print("2. Loading the Structural Shield (Yellow Module)...")
modules <- read.csv("results/Gene_Module_Assignments.csv")
yellow_genes <- na.omit(modules$Gene[modules$Module == "yellow"])

print("3. Calculating Overlap...")
emt_overlap <- intersect(yellow_genes, emt_genes)
apoptosis_overlap <- intersect(yellow_genes, apoptosis_genes)

# Calculate what percentage of your module is just generic EMT or Apoptosis
emt_percent <- (length(emt_overlap) / length(yellow_genes)) * 100
apop_percent <- (length(apoptosis_overlap) / length(yellow_genes)) * 100

print("--------------------------------------------------")
print(paste("Yellow Module size:", length(yellow_genes), "genes"))
print(paste("Genes shared with EMT:", length(emt_overlap)))
print(paste("Genes shared with Apoptosis:", length(apoptosis_overlap)))
print("--------------------------------------------------")
print(paste("EMT Similarity:", round(emt_percent, 2), "%"))
print(paste("Apoptosis Similarity:", round(apop_percent, 2), "%"))

if(emt_percent < 10 && apop_percent < 10) {
    print("BIOLOGY: SUCCESS! The Structural Shield is distinct from generic EMT or cell death.")
} else {
    print("BIOLOGY: The module shares significant machinery with known alternative pathways.")
}
print("--------------------------------------------------")
