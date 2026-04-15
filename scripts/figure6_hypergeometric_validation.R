library(ggplot2)

# Init params
background_total <- 35949
yellow_module_size <- 297

# Target dataset inputs
amd_disease_genes <- 1250
actual_overlap <- 48

# Compute expected
expected_overlap <- (yellow_module_size * amd_disease_genes) / background_total

# Hypergeometric test
p_value <- phyper(actual_overlap - 1, 
                  yellow_module_size, 
                  background_total - yellow_module_size, 
                  amd_disease_genes, 
                  lower.tail = FALSE)

fold_enrichment <- actual_overlap / expected_overlap

# Prep plot df
plot_data <- data.frame(
  Metric = c("Expected", "Actual"),
  Gene_Count = c(expected_overlap, actual_overlap)
)
plot_data$Metric <- factor(plot_data$Metric, levels = c("Expected", "Actual"))

p_label <- sprintf("P = %.2e", p_value)
fold_label <- sprintf("Enrichment: %.1fx", fold_enrichment)

# Plot
p6 <- ggplot(plot_data, aes(x = Metric, y = Gene_Count, fill = Metric)) +
  geom_bar(stat = "identity", width = 0.5, color = "black") +
  geom_text(aes(label = round(Gene_Count, 1)), vjust = -1, size = 6, fontface = "bold") +
  scale_fill_manual(values = c("gray70", "darkred")) +
  theme_minimal() +
  labs(title = "Clinical AMD Hypergeometric Enrichment",
       subtitle = paste(fold_label, "|", p_label),
       y = "Overlapping Genes", 
       x = "") +
  theme(legend.position = "none",
        axis.text.x = element_text(size = 14, face = "bold"),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(size = 16, face = "bold"))

# Export tif
ggsave("~/Epithelial_OxStress_Meta/results/figures/Figure_6_Clinical_Validation.tif", 
       p6, width = 9, height = 7, dpi = 800, compression = "lzw")

# Export stats
stats_out <- data.frame(
  Background = background_total,
  Module_Size = yellow_module_size,
  Disease_Genes = amd_disease_genes,
  Expected_Overlap = expected_overlap,
  Actual_Overlap = actual_overlap,
  Fold_Enrichment = fold_enrichment,
  HyperP = p_value
)
write.csv(stats_out, "~/Epithelial_OxStress_Meta/results/tables/Table_S3_Clinical_Hypergeometric_Stats.csv", row.names = FALSE)
