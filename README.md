
# 🧬 RNA-Seq Analysis Pipeline for TCGA-BRCA Data

This project performs a complete RNA-Seq differential gene expression
analysis using publicly available breast cancer data from The Cancer
Genome Atlas (TCGA). It uses the `TCGAbiolinks` package in R to download
and process raw count data, performs differential expression analysis
with `DESeq2`, and optionally conducts functional enrichment using
`clusterProfiler`.

------------------------------------------------------------------------

## 📁 Project Structure

RNAseq_TCGA_BRCA_Pipeline/

│

├── data/ \# Processed or downloaded data (not tracked by Git)

├── results/ \# Output files (e.g. DESeq2 results)

├── plots/ \# Figures generated for visualization

├── scripts/ \# R scripts used for analysis

├── README.md \# Project overview and usage instructions

├── .gitignore \# Ignore large data files, logs, etc.

└── RNAseq_report.Rmd if using notebook)

------------------------------------------------------------------------

## 🔧 Tools & Packages Used

-   [**TCGAbiolinks**](https://bioconductor.org/packages/release/bioc/html/TCGAbiolinks.html)
    — to query and download RNA-Seq data
-   **DESeq2** — for differential gene expression analysis
-   **biomaRt** — for mapping Ensembl IDs to gene symbols
-   **clusterProfiler** — for functional enrichment (GO terms)
-   **EnhancedVolcano** — for volcano plot visualization
-   **pheatmap** — for heatmaps
-   **ggplot2, dplyr, tidyr** — for general data wrangling and plotting

## 🚀 How to Run the Pipeline

1.  **Install Required Packages** (first-time setup) \`\`\`r
    source("scripts/install_packages.R") \# or run package list manually

2.  **Download and Prepare TCGA-BRCA Data**
    source("scripts/01_download_data.R")

3.  **Subset Samples to Fit RAM Constraints** The dataset is large. We
    selected 20 tumor and 20 normal samples to reduce memory usage.

4.  **Run Differential Expression Analysis**
    source("scripts/02_deseq_analysis.R")

5.  **Visualise Data** source("scripts/03_visualisation.R")

6.  **Optional: Functional Enrichment**
    source("scripts/04_enrichment_analysis.R")

## 📊 Outputs

-   results/deseq_results.rds: DESeq2 results table

-   results/deseq_results.csv: DESeq2 results table

-   plots/volcano_plot.png: Volcano plot for DE genes

-   plots/heatmap.png: Heatmap of top significant genes

-   plots/go_dotplot.png: GO enrichment dotplot (if applicable)

## ⚠️Notes

-   Due to memory limits (\~16 GB), we sampled 20 tumor and 20 normal
    tissues.

-   Ensure `BiocManager`, `TCGAbiolinks`, and `DESeq2` are installed
    correctly.

-   The `data/` folder is excluded via `.gitignore` to avoid uploading
    large files.

## 📚 References

-   The Cancer Genome Atlas (TCGA): <https://portal.gdc.cancer.gov/>

-   TCGAbiolinks: Colaprico et al. (2016) *Nucleic Acids Res.*

-   DESeq2: Love et al. (2014) *Genome Biology*

## 🧑‍💻 Author

**Mahek K**\
University of Toronto
