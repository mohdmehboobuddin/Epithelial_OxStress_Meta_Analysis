library(ggplot2)
library(patchwork)

metadata <- read.csv("~/Epithelial_OxStress_Meta/data/processed/metadata.csv", stringsAsFactors=FALSE)
raw_counts <- read.csv("~/Epithelial_OxStress_Meta/data/processed/Master_Raw_Counts.csv", stringsAsFactors=FALSE)
adj_counts <- read.csv("~/Epithelial_OxStress_Meta/data/processed/Adjusted_Counts.csv", stringsAsFactors=FALSE)

get_pca <- function(counts_df, meta, title, color_col) {
  num_df <- suppressWarnings(as.data.frame(lapply(counts_df, as.numeric)))
  valid_cols <- colSums(is.na(num_df)) < nrow(num_df)
  num_df <- num_df[, valid_cols]
  
  mat <- as.matrix(num_df)
  mat <- mat[complete.cases(mat), ]
  rv <- apply(mat, 1, var)
  mat <- mat[rv > 1e-10, ]
  pca <- prcomp(t(mat), scale. = TRUE)
  
  col_idx <- grep(color_col, colnames(meta), ignore.case = TRUE)[1]
  
  if(is.na(col_idx)) {
      print(colnames(meta))
      stop("Please check the column names above. Edit the bottom of this script to match them perfectly.")
  }
  
  pca_df <- data.frame(
    PC1 = pca$x[,1], 
    PC2 = pca$x[,2], 
    Group = as.factor(meta[, col_idx])
  )
  
  var_exp <- round(pca$sdev^2 / sum(pca$sdev^2) * 100, 1)
  
  ggplot(pca_df, aes(PC1, PC2, color=Group)) +
    geom_point(size=2.5, alpha=0.7) +
    theme_minimal() +
    labs(title=title, 
         x=paste0("PC1 (", var_exp[1], "%)"), 
         y=paste0("PC2 (", var_exp[2], "%)")) +
    theme(panel.grid = element_blank(), legend.position = "bottom")
}

p1 <- get_pca(raw_counts, metadata, "Before: Batch-Driven Clustering", "Batch")
p2 <- get_pca(adj_counts, metadata, "After: Biological Signal Retention", "Condition")

ggsave("~/Epithelial_OxStress_Meta/results/Figure1_PCA_Final.tif", 
       p1 + p2, width=12, height=6, dpi=800, compression="lzw")

