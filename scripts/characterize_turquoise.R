library(topGO)
library(org.Hs.eg.db)
library(data.table)

genes_df <- fread("~/Epithelial_OxStress_Meta/results/Gene_Module_Assignments.csv", data.table=FALSE)
turq_genes <- genes_df$Gene[genes_df$Module == "turquoise"]
all_genes <- genes_df$Gene

geneList <- factor(as.integer(all_genes %in% turq_genes))
names(geneList) <- all_genes

GOdata <- new("topGOdata", 
              ontology = "BP", 
              allGenes = geneList,
              annot = annFUN.org, 
              mapping = "org.Hs.eg.db", 
              ID = "symbol")

resultFisher <- runTest(GOdata, algorithm = "weight01", statistic = "fisher")
allRes <- GenTable(GOdata, classicFisher = resultFisher, topNodes = 20)

write.csv(allRes, "~/Epithelial_OxStress_Meta/results/Turquoise_Metabolic_Functions.csv", row.names = FALSE)

print(head(allRes[, c("Term", "classicFisher")], 5))
