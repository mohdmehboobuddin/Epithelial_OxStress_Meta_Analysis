library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library(data.table)

genes_df <- fread("~/Epithelial_OxStress_Meta/results/Architecture_Genes_Yellow.csv", data.table=FALSE)
gene_list <- genes_df$Gene

ego <- enrichGO(gene          = gene_list,
                OrgDb         = org.Hs.eg.db,
                keyType       = 'SYMBOL',
                ont           = "BP",
                pAdjustMethod = "BH",
                pvalueCutoff  = 0.05,
                qvalueCutoff  = 0.2)

write.csv(as.data.frame(ego), "~/Epithelial_OxStress_Meta/results/GO_Enrichment_Results.csv", row.names = FALSE)

pdf("~/Epithelial_OxStress_Meta/results/GO_Enrichment_Barplot.pdf", width = 10, height = 8)
print(barplot(ego, showCategory=15, title="Biological Processes in Conserved Stress Architecture"))
dev.off()

