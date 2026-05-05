library(WGCNA)
options(stringsAsFactors = FALSE)
allowWGCNAThreads()
set.seed(123)

datExpr <- read.csv("data/processed/Adjusted_Counts.csv", row.names = 1)
datExpr[] <- lapply(datExpr, as.numeric)
datTraits <- read.csv("data/processed/metadata.csv", row.names = 1)

net <- blockwiseModules(t(datExpr), power = 14, networkType = "signed", 
                        TOMType = "signed", minModuleSize = 30, 
                        mergeCutHeight = 0.25, numericLabels = TRUE, 
                        saveTOMs = FALSE, verbose = 3)

MEs <- net$MEs
kME_scores <- as.data.frame(signedKME(t(datExpr), MEs))
yellow_hubs <- kME_scores[order(-kME_scores$kME4), "kME4", drop = FALSE]

write.csv(yellow_hubs, "results/tables/Table_2_Final_with_kME.csv")
