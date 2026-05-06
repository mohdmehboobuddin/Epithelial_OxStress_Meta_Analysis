library(sva)
library(data.table)

counts_file <- "~/Epithelial_OxStress_Meta/data/processed/Master_Raw_Counts.csv"
meta_file <- "~/Epithelial_OxStress_Meta/data/processed/metadata.csv"

counts_data <- fread(counts_file, data.table=FALSE)

rownames(counts_data) <- counts_data[[1]]
counts_matrix <- as.matrix(counts_data[,-1])

storage.mode(counts_matrix) <- "numeric"

counts_matrix <- round(counts_matrix)

metadata <- read.csv(meta_file)

common_samples <- intersect(colnames(counts_matrix), metadata$Sample_ID)
counts_matrix <- counts_matrix[, common_samples]
metadata <- metadata[metadata$Sample_ID %in% common_samples, ]
metadata <- metadata[match(colnames(counts_matrix), metadata$Sample_ID), ]

batch <- as.factor(metadata$Batch)
group <- as.factor(metadata$Condition)

adjusted_counts <- ComBat_seq(counts_matrix, batch=batch, group=group)

output_file <- "~/Epithelial_OxStress_Meta/data/processed/Adjusted_Counts.csv"
write.csv(adjusted_counts, output_file)
