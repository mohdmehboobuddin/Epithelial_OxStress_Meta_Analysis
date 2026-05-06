library(ggplot2)
library(pdftools)


if(file.exists("~/Epithelial_OxStress_Meta/results/figures/WGCNA_Power_Selection.pdf")) {
    tmp <- pdf_convert("~/Epithelial_OxStress_Meta/results/figures/WGCNA_Power_Selection.pdf", format="tiff", dpi=800)
    file.rename(tmp[1], "~/Epithelial_OxStress_Meta/results/SI_Files/Figure_S1_Network_Topology.tif")
}

if(file.exists("~/Epithelial_OxStress_Meta/results/tables/Turquoise_Metabolic_Functions.csv")) {
    turq_data <- read.csv("~/Epithelial_OxStress_Meta/results/tables/Turquoise_Metabolic_Functions.csv", stringsAsFactors=FALSE)
    
    if("classicFisher" %in% colnames(turq_data)) {
        turq_data$Pval <- as.numeric(gsub("< ", "", turq_data$classicFisher))
        turq_data$logP <- -log10(turq_data$Pval)
        
        top_turq <- head(turq_data[order(turq_data$Pval), ], 10)
        top_turq$Term <- factor(top_turq$Term, levels=rev(top_turq$Term))
        
        p_s2 <- ggplot(top_turq, aes(x=logP, y=Term)) +
          geom_bar(stat="identity", fill="turquoise4", width=0.7) +
          theme_minimal() +
          labs(title="Figure S2: Metabolic Disruption in the Turquoise Module", 
               x="-log10(P-value)", y="Gene Ontology Term") +
          theme(axis.text.y = element_text(size=12, face="bold"),
                plot.title = element_text(size=14, face="bold"))
        
        ggsave("~/Epithelial_OxStress_Meta/results/SI_Files/Figure_S2_Turquoise_Metabolism.tif", p_s2, width=10, height=6, dpi=800, compression="lzw")
    }
}

