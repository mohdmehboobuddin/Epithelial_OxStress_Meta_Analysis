# Install packages if you don't have them
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager", repos="http://cran.us.r-project.org")
if (!require("GEOquery", quietly = TRUE)) BiocManager::install("GEOquery", update=FALSE)
if (!require("limma", quietly = TRUE)) BiocManager::install("limma", update=FALSE)

library(GEOquery)
library(limma)

print("1. Downloading GSE76925 from NCBI (This may take a few minutes)...")
# Download the matrix directly to RAM
gset <- getGEO("GSE76925", GSEMatrix = TRUE, AnnotGPL = FALSE)
if (length(gset) > 1) idx <- grep("GPL10558", attr(gset, "names")) else idx <- 1
gset <- gset[[idx]]

print("2. Auto-tagging COPD patients and Controls...")
# Automatically look at the titles and assign groups!
sample_titles <- pData(gset)$title
groups <- ifelse(grepl("cont", sample_titles), "Control", "COPD")
groups <- factor(groups, levels = c("Control", "COPD"))

print("3. Running limma statistics...")
# Build the math model
design <- model.matrix(~0 + groups)
colnames(design) <- c("Control", "COPD")

fit <- lmFit(exprs(gset), design)
cont.matrix <- makeContrasts(COPDvsControl = COPD - Control, levels=design)
fit2 <- contrasts.fit(fit, cont.matrix)
fit2 <- eBayes(fit2, 0.01)

# Get the full list of genes
tT <- topTable(fit2, adjust="fdr", sort.by="B", number=Inf)

print("4. Mapping Gene Symbols...")
# Pull the actual gene names from the Illumina platform data
fData_cols <- fData(gset)
gene_symbols <- fData_cols$Symbol
if(is.null(gene_symbols)) gene_symbols <- fData_cols$ILMN_Gene

# Match them up and clean out the empty ones
tT$Gene <- gene_symbols[match(rownames(tT), rownames(fData_cols))]
tT <- tT[!is.na(tT$Gene) & tT$Gene != "", ]

print("5. Saving to data/processed/COPD_DEGs.csv...")
dir.create("data/processed", showWarnings = FALSE, recursive = TRUE)
write.csv(tT, "data/processed/COPD_DEGs.csv", row.names=FALSE)

print("SUCCESS! The dataset is ready for validation.")
