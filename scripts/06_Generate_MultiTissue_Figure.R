# Install ggplot2 if needed
if (!require("ggplot2", quietly = TRUE)) install.packages("ggplot2", repos="http://cran.us.r-project.org")
library(ggplot2)

print("Building Multi-Tissue Validation Data...")

# Create the dataset based on your exact terminal outputs
validation_data <- data.frame(
  Tissue = c("Retinal Pigment Epithelium\n(Macular Degeneration)", "Airway Epithelium\n(Severe COPD - Upregulated)"),
  P_Value = c(0.001, 0.013), # Note: Please update the AMD value to your exact hypergeometric p-value from your earlier script!
  System = c("Eye", "Lung")
)

# Convert P-values to -log10 for standard publication plotting
validation_data$NegLog10_P <- -log10(validation_data$P_Value)

# Add a significance threshold line (P = 0.05 is -log10 of 1.3)
threshold <- -log10(0.05)

print("Generating Figure 6...")

# Create the publication-ready bar chart
fig6 <- ggplot(validation_data, aes(x = Tissue, y = NegLog10_P, fill = System)) +
  geom_bar(stat = "identity", width = 0.6, color = "black", linewidth = 0.8) +
  geom_hline(yintercept = threshold, linetype = "dashed", color = "red", linewidth = 1) +
  scale_fill_manual(values = c("Eye" = "#4A90E2", "Lung" = "#E08E36")) +
  labs(
    title = "Structural Shield Activation Across Epithelial Diseases",
    y = "-log10(Hypergeometric P-Value)",
    x = ""
  ) +
  theme_classic() +
  theme(
    text = element_text(size = 14, face = "bold"),
    axis.text.x = element_text(size = 12, color = "black"),
    axis.text.y = element_text(size = 12, color = "black"),
    legend.position = "none"
  ) +
  annotate("text", x = 1.5, y = threshold + 0.2, label = "Significance Threshold (p = 0.05)", color = "red", fontface = "italic")

# Save it to your figures folder
dir.create("figures", showWarnings = FALSE)
ggsave("figures/Figure6_MultiTissue_Validation.png", plot = fig6, width = 8, height = 6, dpi = 300)

print("SUCCESS! Upgraded Figure 6 saved to figures/Figure6_MultiTissue_Validation.png")
