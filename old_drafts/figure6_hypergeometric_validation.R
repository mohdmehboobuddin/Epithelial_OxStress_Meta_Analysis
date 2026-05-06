library(ggplot2)

# --- 1. DATA PREPARATION ---
# Based on verified Final_Clinical_Anchor_Stats.csv
plot_data <- data.frame(
  Type = factor(c("Expected", "Actual"), levels = c("Expected", "Actual")),
  OverlapCount = c(10.3, 48)
)

# --- 2. GENERATE CLEAN FIGURE 6 ---
message("Generating Clean Figure 6 (Clinical Validation)...")

# Create plot
p6 <- ggplot(plot_data, aes(x = Type, y = OverlapCount, fill = Type)) +
  geom_bar(stat = "identity", color = "black", width = 0.6, show.legend = FALSE) +
  # Use a clean font and explicit text to fix the '4o' rendering artifact
  geom_text(aes(label = c("10.3", "48")), 
            vjust = -0.8, 
            size = 6, 
            fontface = "bold", 
            family = "sans") +
  scale_fill_manual(values = c("Expected" = "#BDBDBD", "Actual" = "#8B0000")) +
  scale_y_continuous(limits = c(0, 60), expand = c(0, 0)) +
  labs(title = "Clinical AMD Hypergeometric Enrichment",
       subtitle = "Enrichment: 4.6x | P = 6.88e-19",
       x = "",
       y = "Overlapping Genes") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 14, hjust = 0.5, color = "grey30"),
    axis.text = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank()
  )

# --- 3. SAVE HIGH-RES TIFF ---
tiff("~/Epithelial_OxStress_Meta/results/figures/Figure_6_Clinical_Validation.tif", 
     width = 10, height = 8, units = 'in', res = 600)
print(p6)
dev.off()

message("SUCCESS: Figure 6 regenerated with clean '48' label and 4.6x enrichment subtitle.")
