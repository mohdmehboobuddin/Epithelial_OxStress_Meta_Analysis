# Transcriptomic Meta-Analysis Reveals a Conserved Structural Gene Signature Associated with Oxidative Stress Across Human Epithelia

This repository contains the complete computational workflow and Weighted Gene Co-expression Network Analysis (WGCNA) pipeline used to identify a conserved oxidative stress-associated structural gene signature across human epithelial tissues.

## Project Overview
While oxidative stress drives pathological remodeling across human epithelial barriers, the prevailing focus has heavily favored the canonical Nrf2/KEAP1 antioxidant axis. Translating highly heterogeneous transcriptomic data into a conserved survival model requires large-scale network biology.

This meta-analysis framework integrates:
* 594 transcriptomic samples spanning gut, lung, and skin epithelia.
* Rigorous inter-study batch correction via ComBat-seq.
* Scale-free topology network construction (WGCNA).
* Intramodular connectivity (kME) hub gene ranking.
* Dual Clinical Validation: Hypergeometric overlap model against human Age-Related Macular Degeneration (AMD) and severe Chronic Obstructive Pulmonary Disease (COPD) transcriptomes.

The goal is to investigate whether a conserved transcriptional signature associated with oxidative stress can be identified across multiple epithelial tissues and evaluated in independent clinical cohorts.

## Repository Structure
* `data/` - Contains the ComBat-seq adjusted count matrices and sample metadata.
* `results/` - Target directory for generated enrichment tables, hypergeometric statistics (Table S3), and clinical validation metrics.
* `figures/` - High-resolution network visualizations, PCA plots, and clinical validation charts.
* `scripts/` - Contains the executable R scripts for network construction and validation.
* `archive/` - Legacy drafts and superseded pipeline iterations.

## Key Findings
This pipeline isolates a dual-module transcriptomic architecture that reframes epithelial survival as a form of "Metabolic Triage":

### Oxidative Stress-Associated Structural Gene Signature (Yellow Module - ME4)
* **Dynamics:** Highly upregulated under stress (r = 0.48, P = 2.87e-36).
* **Key Drivers:** Classical cadherins (CDH12, CDH7), extensive protocadherin clusters, stress keratins, and the metabolic detoxifier AKR1B10.
* **Function:** Functional enrichment suggests associations with cell-cell adhesion, epithelial structural maintenance, and lipid detoxification pathways.

### Genomic Suppression (Turquoise Module - ME3)
* **Dynamics:** Actively suppressed under stress (r = -0.49, P = 1.71e-37).
* **Function:** Functional enrichment indicates negative association with proliferation, chromatin organization, and DNA repair-related pathways.

## Reproducibility
All analyses were performed using R (v4.3.3). The pipeline is designed to be run sequentially from the root directory:
* `scripts/01_WGCNA_Network.R` (Builds the structural network and ranks hubs)
* `scripts/02_Clinical_Validation.R` (Calculates AMD enrichment significance)
* `scripts/04_Validate_COPD.R` (Calculates COPD enrichment significance and generates Table S3)

### Software Environment
* **R version:** 4.3.3
* **Key packages:**
  * WGCNA
  * sva (ComBat-seq)
  * topGO
  * DESeq2
  * limma
  * msigdbr

Complete package versions are provided in the supplementary materials.

## Data Sources
All raw datasets are publicly accessible via the NCBI Gene Expression Omnibus (GEO):
* **Discovery Cohorts:** GSE125342, GSE293179, GSE134533, GSE285905, GSE292944, GSE301606
* **Clinical Validation Cohorts:** GSE115828 (Human AMD) and GSE76925 (Severe COPD)

## Author
**Mohd Mehboob Uddin**
Department of Life Sciences, A.V. College of Arts, Science and Commerce (Osmania University), Hyderabad, India

## Citation
If you utilize this WGCNA pipeline or the identified structural gene signatures, please cite the associated manuscript.

---
**Important Note:** This repository presents computational analyses based on publicly available transcriptomic datasets. The identified co-expression modules represent statistical associations and do not establish direct causal or regulatory relationships. Experimental validation will be required to confirm the functional roles of candidate genes identified in this study.
