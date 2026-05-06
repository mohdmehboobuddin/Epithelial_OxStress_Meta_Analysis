library(data.table)

yellow <- fread("~/Epithelial_OxStress_Meta/results/Architecture_Genes_Yellow.csv")
cat("\n--- Yellow Architecture Preview ---\n")
print(head(yellow$Gene))

amd <- fread("~/Epithelial_OxStress_Meta/data/raw/GSE115828_Human_Retina_AMD_counts.tsv.gz", nrows = 5)
cat("\n--- AMD Clinical Data Preview ---\n")
print(amd[1:5, 1:3]) # Look at the first 5 rows and 3 columns
