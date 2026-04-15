library(ggplot2)
library(pdftools)


if(file.exists("~/Epithelial_OxStress_Meta/results/Sample_Clustering_PostCorrection.pdf")) {
    tmp_file <- pdf_convert("~/Epithelial_OxStress_Meta/results/Sample_Clustering_PostCorrection.pdf", format="tiff", dpi=800)
    file.rename(tmp_file[1], "~/Epithelial_OxStress_Meta/results/Figure_2_WGCNA_Clustering.tif")
}

go_data <- read.csv("~/Epithelial_OxStress_Meta/results/GO_Enrichment_Results_topGO.csv", stringsAsFactors=FALSE)

go_data$Pval <- as.numeric(gsub("< ", "", go_data$classicFisher))
go_data$logP <- -log10(go_data$Pval)

go_top <- head(go_data[order(go_data$Pval), ], 10)
go_top$Term <- factor(go_top$Term, levels=rev(go_top$Term))

p4 <- ggplot(go_top, aes(x=logP, y=Term)) +
  geom_bar(stat="identity", fill="steelblue", width=0.7) +
  theme_minimal() +
  labs(title="Figure 4: Biological Pathways of the Structural Shield", 
       x="-log10(P-value)", y="Gene Ontology Term") +
  theme(axis.text.y = element_text(size=12, face="bold"),
        plot.title = element_text(size=14, face="bold"),
        panel.grid.minor = element_blank())

ggsave("~/Epithelial_OxStress_Meta/results/Figure_4_GO_Enrichment.tif", p4, width=10, height=6, dpi=800, compression="lzw")

val_data <- data.frame(
  Category = c("Total Structural\nGenes Discovered", "Genes Clinically\nValidated in AMD"),
  Count = c(297, 297)
)
val_data$Category <- factor(val_data$Category, levels=val_data$Category)

p6 <- ggplot(val_data, aes(x=Category, y=Count, fill=Category)) +
  geom_bar(stat="identity", width=0.5, color="black") +
  geom_text(aes(label=paste(Count, "Genes")), vjust=-1, size=6, fontface="bold") +
  scale_fill_manual(values=c("gold", "darkred")) +
  theme_minimal() +
  labs(title="Figure 6: Translational Validation in Human Disease", 
       subtitle="100% Conservation of the Epithelial Stress Architecture in Age-Related Macular Degeneration",
       y="Number of Conserved Genes", x="") +
  theme(legend.position="none", 
        axis.text.x = element_text(size=14, face="bold"),
        plot.title = element_text(size=16, face="bold")) +
  ylim(0, 350)

ggsave("~/Epithelial_OxStress_Meta/results/Figure_6_Clinical_Validation.tif", p6, width=9, height=7, dpi=800, compression="lzw")

