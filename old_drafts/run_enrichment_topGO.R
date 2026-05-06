library(topGO)
library(org.Hs.eg.db)
library(data.table)

genes_df <- fread("~/Epithelial_OxStress_Meta/results/Architecture_Genes_Yellow.csv", data.table=FALSE)
candidate_genes <- genes_df$Gene

all_genes_df <- fread("~/Epithelial_OxStress_Meta/results/Gene_Module_Assignments.csv", data.table=FALSE)
all_genes <- all_genes_df$Gene

geneList <- factor(as.integer(all_genes %in% candidate_genes))
names(geneList) <- all_genes

GOdata <- new("topGOdata",
              ontology = "BP",
              allGenes = geneList,
              annot = annFUN.org,
              mapping = "org.Hs.eg.db",
              ID = "symbol")

resultFisher <- runTest(GOdata, algorithm = "weight01", statistic = "fisher")

allRes <- GenTable(GOdata, classicFisher = resultFisher,
                   orderBy = "classicFisher", ranksOf = "classicFisher", 
                   topNodes = 50)

write.csv(allRes, "~/Epithelial_OxStress_Meta/results/GO_Enrichment_Results_topGO.csv", row.names = FALSE)

print(head(allRes[, c("GO.ID", "Term", "classicFisher")], 10))

