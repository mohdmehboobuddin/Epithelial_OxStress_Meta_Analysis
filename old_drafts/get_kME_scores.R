library(WGCNA)
library(data.table)

message("Calculating exact kME scores for Table 2...")

# 1. Load Data
counts_file <- "~/Epithelial_OxStress_Meta/data/processed/Adjusted_Counts.csv"
datExpr_raw <- fread(counts_file, data.table=FALSE)
rownames(datExpr_raw) <- datExpr_raw[[1]]
datExpr <- t(log2(datExpr_raw[,-1] + 1))

MEs <- read.csv("~/Epithelial_OxStress_Meta/results/Module_Eigengenes.csv", row.names=1)

# 2. Calculate kME (Module Membership)
kME_table <- signedKME(datExpr, MEs)

# 3. DYNAMICALLY find the column for ME4 (Yellow)
# This searches for the column name that ends with the number '4'
target_col <- grep("4$", colnames(kME_table), value=TRUE)
message("--> WGCNA named the Yellow module column: ", target_col)

kME_yellow <- data.frame(
  Gene = rownames(kME_table),
  kME = kME_table[[target_col]]
)

# 4. Load your verified 20 Hub Genes
hubs <- read.csv("~/Epithelial_OxStress_Meta/results/tables/Conserved_Architecture_Hub_Genes.csv")

# 5. Merge and sort highest to lowest
final_table <- merge(hubs, kME_yellow, by="Gene")
final_table <- final_table[order(-final_table$kME), ]

# 6. Save the final, publication-ready Table 2
write.csv(final_table, 
          "~/Epithelial_OxStress_Meta/results/tables/Table_2_Final_with_kME.csv", 
          row.names=FALSE)

message("SUCCESS: Exact kME values calculated. Here are your top 5 for the manuscript:")
print(head(final_table, 5))
