library(data.table)

genes_df <- fread("~/Epithelial_OxStress_Meta/results/Architecture_Genes_Yellow.csv", data.table=FALSE)

hubs <- genes_df[grepl("CDH|KRT|ANXA|ADAM|PCDH", genes_df$Gene), ]

hubs$Functional_Role <- "Structural Integrity / Barrier Defense"

write.csv(hubs, "~/Epithelial_OxStress_Meta/results/Conserved_Architecture_Hub_Genes.csv", row.names = FALSE)

