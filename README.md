# Transcriptomic Meta-Analysis Reveals a Conserved Structural Gene Signature Associated with Oxidative Stress Across Human Epithelia

## Overview

This repository contains the complete computational workflow, source code, processed outputs, and supporting resources associated with the study:

**"Transcriptomic Meta-Analysis Reveals a Conserved Structural Gene Signature Associated with Oxidative Stress Across Human Epithelia."**

The project integrates multiple publicly available transcriptomic datasets to investigate whether a conserved oxidative stress-associated transcriptional signature can be identified across diverse human epithelial tissues.

Using batch-corrected RNA-sequencing data, weighted gene co-expression network analysis (WGCNA), functional enrichment analysis, and independent clinical validation cohorts, this study identifies a reproducible co-expression module enriched for genes associated with cell-cell adhesion, epithelial structural maintenance, and oxidative stress adaptation.

---

## Study Design

### Discovery Cohorts

| GEO Accession | Tissue Type | Experimental Context |
|--------------|------------|---------------------|
| GSE125342 | Gut Epithelium | DSS Exposure |
| GSE293179 | Lung Epithelium | Cigarette Smoke Extract |
| GSE134533 | Skin Epidermis | UV-B Exposure |
| GSE285905 | Gut Epithelium | Hydrogen Peroxide |
| GSE292944 | Airway Epithelium | Ozone Exposure |
| GSE301606 | Skin Epidermis | Hydrogen Peroxide |

**Total discovery samples:** 594

### Clinical Validation Cohorts

| GEO Accession | Disease |
|--------------|----------|
| GSE115828 | Age-Related Macular Degeneration (AMD) |
| GSE76925 | Severe Chronic Obstructive Pulmonary Disease (COPD) |

**Total validation samples:** 674

---

## Computational Workflow

```text
Raw GEO Datasets
        │
        ▼
Quality Control Filtering
        │
        ▼
ComBat-seq Batch Correction
        │
        ▼
Principal Component Analysis
        │
        ▼
WGCNA Network Construction
        │
        ▼
Module Identification
        │
        ▼
Gene Ontology Enrichment
        │
        ▼
Hub Gene Analysis
        │
        ▼
Clinical Validation
(AMD and COPD)
        │
        ▼
Pathway Specificity Assessment
```

---

## Key Findings

A 297-gene co-expression module was identified that showed a strong positive association with oxidative stress across integrated epithelial datasets.

Functional enrichment analysis indicated overrepresentation of:

- Cell-cell adhesion pathways
- Cadherin-mediated interactions
- Intermediate filament organization
- Epithelial structural maintenance

Highly connected hub genes included:

- CDH12
- CDH7
- AKR1B10
- PCDH17
- PCDHA3
- KRT16
- KRT13
- KRT15

Independent validation demonstrated significant enrichment of this gene signature within human AMD and COPD transcriptomic datasets.

These findings support the existence of a conserved oxidative stress-associated transcriptional program that may contribute to epithelial adaptation across multiple tissue types.

---

## Repository Structure

```text
Epithelial_OxStress_Meta_Analysis/

├── scripts/
│   ├── 01_WGCNA_Network.R
│   ├── 02_Clinical_Validation.R
│   └── 04_Validate_COPD.R
│
├── figures/
│   ├── PCA plots
│   ├── WGCNA visualizations
│   ├── GO enrichment figures
│   └── Clinical validation figures
│
├── results/
│   ├── Module assignments
│   ├── Hub gene rankings
│   ├── Enrichment outputs
│   └── Validation statistics
│
├── archive/
│   └── Legacy analyses and draft materials
│
└── README.md
```

---

## Software Environment

### R Version

R 4.3.3

### Major Packages

- WGCNA
- sva
- DESeq2
- limma
- topGO
- msigdbr

Additional package information and computational details are provided in the manuscript supplementary materials.

---

## Reproducibility

The analysis pipeline is designed to be executed sequentially:

```r
scripts/01_WGCNA_Network.R
scripts/02_Clinical_Validation.R
scripts/04_Validate_COPD.R
```

All datasets used in this study are publicly accessible through the NCBI Gene Expression Omnibus (GEO).

---

## Data Availability

Raw transcriptomic datasets were obtained from publicly available GEO repositories.

### Discovery Cohorts

- GSE125342
- GSE293179
- GSE134533
- GSE285905
- GSE292944
- GSE301606

### Validation Cohorts

- GSE115828
- GSE76925

Processed outputs generated during this study are available within this repository.

---

## Important Note

This repository presents computational analyses derived from publicly available transcriptomic datasets. The identified co-expression modules represent statistical associations and coordinated transcriptional patterns. These findings should not be interpreted as evidence of direct regulatory, causal, or mechanistic relationships. Experimental validation will be required to establish the functional roles of candidate genes identified in this study.

---

## Author

**Mohd Mehboob Uddin**  
Department of Life Sciences  
A.V. College of Arts, Science and Commerce  
Osmania University  
Hyderabad, Telangana, India

---

## Citation

If you use this repository, code, or derived results, please cite the associated manuscript.

---

## License

MIT License
