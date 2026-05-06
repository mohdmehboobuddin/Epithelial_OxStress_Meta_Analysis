library(data.table)

genes <- fread("~/Epithelial_OxStress_Meta/results/Gene_Module_Assignments.csv", data.table=FALSE)

stress_genes <- genes[genes$Module == "yellow", ]

write.csv(stress_genes, "~/Epithelial_OxStress_Meta/results/Architecture_Genes_Yellow.csv", row.names=FALSE)

print(head(stress_genes$Gene, 10))
