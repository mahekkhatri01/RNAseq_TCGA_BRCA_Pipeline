#helper scipt to automatically install all packages needed for the pipeline

packages <- c(
  "TCGAbiolinks", "SummarizedExperiment", "DESeq2", "biomaRt", 
  "clusterProfiler", "org.Hs.eg.db", "ggplot2", "EnhancedVolcano",
  "pheatmap", "dplyr", "tidyr"
) #lists the names of the packages to be installed in a vector

#TCGAbiolinks(data querying), SummarizedExperiment (data structure), DESeq2(differential expression), 
#biomaRt(gene ID mapping), clusterProfiler & org.Hs.eg.db(enrichment analysis), 
#ggplot2, EnhancedVolcano & pheatmap (visualisation), 
#dplyr & tidyr (data manupulation)"


install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    BiocManager::install(pkg)
  }
} #defines a custom function

#requireNamespace(pkg, quietly = TRUE) (checks if package is already installed)
#BiocManager::install(pkg) (if not, installs package using BiocManager)


if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
} #installs BiocManager if it is not already installed

sapply(packages, install_if_missing) #loops function over each item in packages vector
