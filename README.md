# A Conserved Structural Defense Architecture in Human Epithelial Tissues Under Oxidative Stress: A Multi-Cohort Transcriptomic Meta-Analysis

This repository contains the complete computational workflow and Weighted Gene Co-expression Network Analysis (WGCNA) pipeline used to identify the conserved "structural shield" epithelial adaptation to oxidative insult.

## Project Overview

While oxidative stress drives pathological remodeling across human epithelial barriers, the prevailing focus has heavily favored the canonical Nrf2/KEAP1 antioxidant axis. Translating highly heterogeneous transcriptomic data into a conserved survival model requires large-scale network biology.

This meta-analysis framework integrates:
* 594 transcriptomic samples spanning gut, lung, and skin epithelia.
* Rigorous inter-study batch correction via ComBat-seq.
* Scale-free topology network construction (WGCNA).
* Intramodular connectivity (kME) hub gene ranking.
* **Dual Clinical Validation:** Hypergeometric overlap model against human Age-Related Macular Degeneration (AMD) and severe Chronic Obstructive Pulmonary Disease (COPD) transcriptomes.

The goal is to bridge isolated *in vitro* stress responses into a unified, mathematically robust *in vivo* disease defense model.

## Repository Structure

* `data/` - Contains the ComBat-seq adjusted count matrices and sample metadata.
* `results/` - Target directory for generated enrichment tables, hypergeometric statistics (Table S3), and clinical validation metrics.
* `figures/` - High-resolution network visualizations, PCA plots, and clinical validation charts.
* `scripts/` - Contains the executable R scripts for network construction and validation.
* `archive/` - Legacy drafts and superseded pipeline iterations.

## The "Halt and Fortify" Framework

This pipeline isolates a dual-module transcriptomic architecture that reframes epithelial survival as a form of "Metabolic Triage":

1. **The Structural Shield (Yellow Module - ME4)**
   * **Dynamics:** Highly upregulated under stress (r = 0.48, P = 2.87e-36).
   * **Key Drivers:** Classical cadherins (CDH12, CDH7), extensive protocadherin clusters, stress keratins, and the metabolic detoxifier AKR1B10.
   * **Function:** Immediate physical barrier fortification and lipid detoxification.

2. **Genomic Suppression (Turquoise Module - ME3)**
   * **Dynamics:** Actively suppressed under stress (r = -0.49, P = 1.71e-37).
   * **Function:** Halting active cellular proliferation, chromatin remodeling, and DNA repair to funnel resources into structural fortification.

## Reproducibility

All analyses were performed using R (v4.3.3). The pipeline is designed to be run sequentially from the root directory:
1. `scripts/01_WGCNA_Network.R` (Builds the structural network and ranks hubs)
2. `scripts/02_Clinical_Validation.R` (Calculates AMD enrichment significance)
3. `scripts/04_Validate_COPD.R` (Calculates COPD enrichment significance and generates Table S3)

## Data Sources

All raw datasets are publicly accessible via the NCBI Gene Expression Omnibus (GEO):
* **Discovery Cohorts:** GSE125342, GSE293179, GSE134533, GSE285905, GSE292944, GSE301606
* **Clinical Validation Cohorts:** GSE115828 (Human AMD) and GSE76925 (Severe COPD)

## Author

**Mohd Mehboob Uddin**
Department of Life Sciences, 
A.V. College of Arts, Science and Commerce
(Osmania University), Hyderabad, India
# A Conserved Structural Defense Architecture in Human Epithelial Tissues Under Oxidative Stress: A Multi-Cohort Transcriptomic Meta-Analysis

This repository contains the complete computational workflow and Weighted Gene Co-expression Network Analysis (WGCNA) pipeline used to identify the conserved "structural shield" epithelial adaptation to oxidative insult.

## Project Overview

While oxidative stress drives pathological remodeling across human epithelial barriers, the prevailing focus has heavily favored the canonical Nrf2/KEAP1 antioxidant axis. Translating highly heterogeneous transcriptomic data into a conserved survival model requires large-scale network biology.

This meta-analysis framework integrates:
* 594 transcriptomic samples spanning gut, lung, and skin epithelia.
* Rigorous inter-study batch correction via ComBat-seq.
* Scale-free topology network construction (WGCNA).
* Intramodular connectivity (kME) hub gene ranking.
* **Dual Clinical Validation:** Hypergeometric overlap model against human Age-Related Macular Degeneration (AMD) and severe Chronic Obstructive Pulmonary Disease (COPD) transcriptomes.

The goal is to bridge isolated *in vitro* stress responses into a unified, mathematically robust *in vivo* disease defense model.

## Repository Structure

* `data/` - Contains the ComBat-seq adjusted count matrices and sample metadata.
* `results/` - Target directory for generated enrichment tables, hypergeometric statistics (Table S3), and clinical validation metrics.
* `figures/` - High-resolution network visualizations, PCA plots, and clinical validation charts.
* `scripts/` - Contains the executable R scripts for network construction and validation.
* `archive/` - Legacy drafts and superseded pipeline iterations.

## The "Halt and Fortify" Framework

This pipeline isolates a dual-module transcriptomic architecture that reframes epithelial survival as a form of "Metabolic Triage":

1. **The Structural Defense Program (Yellow Module - ME4)**
   * **Dynamics:** Highly upregulated under stress (r = 0.48, P = 2.87e-36).
   * **Key Drivers:** Classical cadherins (CDH12, CDH7), extensive protocadherin clusters, stress keratins, and the metabolic detoxifier AKR1B10.
   * **Function:** Immediate physical barrier fortification and lipid detoxification.

2. **Genomic Suppression (Turquoise Module - ME3)**
   * **Dynamics:** Actively suppressed under stress (r = -0.49, P = 1.71e-37).
   * **Function:** Halting active cellular proliferation, chromatin remodeling, and DNA repair to funnel resources into structural fortification.

## Reproducibility

All analyses were performed using R (v4.3.3). The pipeline is designed to be run sequentially from the root directory:
1. `scripts/01_WGCNA_Network.R` (Builds the structural network and ranks hubs)
2. `scripts/02_Clinical_Validation.R` (Calculates AMD enrichment significance)
3. `scripts/04_Validate_COPD.R` (Calculates COPD enrichment significance and generates Table S3)

## Data Sources

All raw datasets are publicly accessible via the NCBI Gene Expression Omnibus (GEO):
* **Discovery Cohorts:** GSE125342, GSE293179, GSE134533, GSE285905, GSE292944, GSE301606
* **Clinical Validation Cohorts:** GSE115828 (Human AMD) and GSE76925 (Severe COPD)

## Author

**Mohd Mehboob Uddin**
Department of Life Sciences, 
A.V. College of Arts, Science and Commerce
(Osmania University), Hyderabad, India

## Citation

If you utilize this WGCNA pipeline or the identified structural gene signatures, please cite the associated manuscript.
