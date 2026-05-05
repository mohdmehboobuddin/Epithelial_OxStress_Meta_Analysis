# A Conserved Structural Defense Architecture in Human Epithelial Tissues Under Oxidative Stress

This repository contains the complete computational workflow and Weighted Gene Co-expression Network Analysis (WGCNA) pipeline used to identify the universal "Structural Shield" epithelial adaptation to oxidative insult.

## Project Overview

While oxidative stress drives pathological remodeling across human epithelial barriers, the prevailing focus has heavily favored the canonical Nrf2/KEAP1 antioxidant axis. Translating highly heterogeneous transcriptomic data into a universal survival model requires large-scale network biology.

This meta-analysis framework integrates:
* 594 transcriptomic samples spanning gut, lung, and skin epithelia.
* Rigorous inter-study batch correction via ComBat-seq.
* Scale-free topology network construction (WGCNA).
* Intramodular connectivity (kME) hub gene ranking.
* Direct clinical validation using a hypergeometric overlap model against 523 human Age-Related Macular Degeneration (AMD) transcriptomes.

The goal is to bridge isolated *in vitro* stress responses into a unified, mathematically robust *in vivo* disease defense model.

## Repository Structure

* `data/` - Contains the ComBat-seq adjusted count matrices and sample metadata.
* `processed_data/` - Contains the WGCNA module assignments and node connectivity scores.
* `results/` - Target directory for generated enrichment tables and hypergeometric statistics.
* `figures/` - High-resolution network visualizations and PCA plots.
* `scripts/` - Contains the executable R scripts for network construction and validation.

## The "Halt and Fortify" Framework

This pipeline successfully isolates a dual-module transcriptomic architecture that reframes epithelial survival as a form of "Metabolic Triage." 

**1. The Structural Shield (Yellow Module - ME4)**
* **Dynamics:** Highly upregulated under stress (r = 0.48, P = 2.87e-36).
* **Key Drivers:** Classical cadherins (CDH12, CDH7), extensive protocadherin clusters, stress keratins, and the metabolic detoxifier AKR1B10.
* **Function:** Immediate physical barrier fortification and lipid detoxification.

**2. Genomic Suppression (Turquoise Module - ME3)**
* **Dynamics:** Actively suppressed under stress (r = -0.49, P = 1.71e-37).
* **Function:** Halting active cellular proliferation, chromatin remodeling, and DNA repair to funnel resources into the structural shield.

## Reproducibility

All analyses were performed using R. The pipeline is designed to be run sequentially from the root directory using the finalized scripts located in the `scripts/` folder:
1. `01_WGCNA_Network.R` (Builds the structural network and ranks hubs)
2. `02_Clinical_Validation.R` (Calculates AMD enrichment significance)

Processed outputs and statistical validations are available in the `results/` directory.

## Software and Computational Environment

* **OS:** x86_64-pc-linux-gnu (Ubuntu/WSL2)
* **Hardware:** AMD Ryzen 5 7520U (Multi-threading enabled)
* **R Version:** 4.3.3
* **Dependencies:** `WGCNA`, `sva` (ComBat-seq), `DESeq2`, `topGO`

## Data Sources

All raw datasets are publicly accessible via the NCBI Gene Expression Omnibus (GEO):
* **Discovery Cohorts:** GSE125342, GSE293179, GSE134533, GSE285905, GSE292944, GSE301606
* **Clinical Validation Cohort:** GSE115828 (Human AMD)

*Note: Large raw sequencing files and raw count matrices are not hosted in this repository due to size constraints. Adjusted count matrices are provided for immediate pipeline execution.*

## Author

**Mohd Mehboob Uddin** Department of Life Sciences  
Osmania University, Hyderabad, India  

## Citation

If you utilize this WGCNA pipeline or the identified structural gene signatures, please cite the associated manuscript.
