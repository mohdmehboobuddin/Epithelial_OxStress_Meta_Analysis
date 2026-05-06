library(igraph)
library(data.table)

hubs <- fread("~/Epithelial_OxStress_Meta/results/Conserved_Architecture_Hub_Genes.csv")
g <- make_full_graph(nrow(hubs))
V(g)$name <- hubs$Gene
V(g)$color <- ifelse(grepl("PCDH", hubs$Gene), "salmon", 
              ifelse(grepl("KRT", hubs$Gene), "skyblue", "gold"))

tiff("~/Epithelial_OxStress_Meta/results/Figure5_Hub_Network.tif", width=8, height=8, units="in", res=800)
plot(g, vertex.label=V(g)$name, vertex.size=25, vertex.label.cex=0.8, 
     main="Top 20 Conserved Structural Hubs", layout=layout_in_circle)
dev.off()
