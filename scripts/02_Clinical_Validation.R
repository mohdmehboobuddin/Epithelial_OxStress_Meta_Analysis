options(scipen = 0)

n_total <- 35949
m_size <- 297
d_genes <- 1250
o_count <- 48

expected <- (m_size * d_genes) / n_total
enrichment <- (o_count / m_size) / (d_genes / n_total)
p_val <- phyper(o_count - 1, d_genes, n_total - d_genes, m_size, lower.tail = FALSE)

results <- data.frame(
  Metric = c("Expected Overlap", "Calculated Enrichment", "Hypergeometric P-value"),
  Value = c(round(expected, 2), round(enrichment, 2), format(p_val, scientific = TRUE))
)

write.csv(results, "results/tables/Validation_Statistics.csv", row.names = FALSE)
