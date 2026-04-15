# Conserved Epithelial Responses to Oxidative Stress

**Author:** Mohd Mehboob Uddin  
**Institution:** Osmania University  
**Project Type:** Independent Bioinformatics Research & Skill Development Portfolio

## Project Overview
This repository contains the complete bioinformatics pipeline for an independent meta-analysis of 594 transcriptomic samples across 6 studies. I designed and executed this project independently to develop advanced skills in systems biology, cross-study data harmonization, and clinical transcriptomics.

## Pipeline Architecture
The analysis was conducted using a custom 23-script bilingual (R/Python) pipeline:
1. **Harmonization:** `ComBat-seq` was utilized to correct severe cross-study batch effects.
2. **Network Inference:** `WGCNA` was applied to identify co-expressed gene modules.
3. **Functional Annotation:** `topGO` was used for pathway enrichment.
4. **Clinical Validation:** Hypergeometric testing against clinical Age-Related Macular Degeneration (AMD) datasets.

## Key Findings
* **The Structural Shield:** WGCNA identified a highly significant module of 297 genes conserved across all epithelial tissues under oxidative stress.
* **Mechanism:** Rather than metabolic detoxification, the universally conserved response is structural, heavily enriched for Cell-Cell Adhesion and Keratin Filament Organization.
* **Clinical Translation:** Hypergeometric testing confirmed that this in vitro "structural shield" architecture is significantly enriched in in vivo human clinical pathology (AMD) with a fold enrichment of 4.65x.
