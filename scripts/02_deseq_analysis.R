#script to perform differential expression analysis

library(DESeq2)
library(SummarizedExperiment) # loads DESeq2 and SummarizedExperiment packages

#DESeq2 is the core package for differential expression analysis of RNA-seq data. 

data <- readRDS("/Volumes/Extreme SSD/RNAseq_TCGA_BRCA_Pipeline/data/BRCA_rnaseq_data.rds") #reads .rds file creted in the last script

counts <- assay(data) #extracts the matrix of raw read counts per gene
coldata <- colData(data) #extracts the metadata (e.g., tumor vs normal labels for each sample).

dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = coldata,
  design = ~ sample_type
) #Creates a DESeqDataSet, the input format required for DESeq2.

#desgin(tells DDSeq2 that we want to compare gene expression based on sample type (tumor vs normal))

dds <- dds[rowSums(counts(dds)) > 10, ] #Filters out genes that have very low read counts
dds <- DESeq(dds) #runs the full DDSeq2 pipeline
res <- results(dds, contrast = c("sample_type", "Primary Tumor", "Solid Tissue Normal")) #extracts the results

#DDSeq pipeline - Normalization, Dispersion estimation, Negative binomial GLM fitting, Hypothesis testing (tumor vs normal)
#Results - log2 fold changes, p-values, and adjusted p-values for each gene.

resOrdered <- res[order(res$padj), ] #orders the results 
saveRDS(resOrdered, file = "/Volumes/Extreme SSD/RNAseq_TCGA_BRCA_Pipeline/results/deseq_results.rds") #saves results as an .rds file
write.csv(as.data.frame(resOrdered), file = "/Volumes/Extreme SSD/RNAseq_TCGA_BRCA_Pipeline/results/deseq_results.csv") #saves results as a .csv file

#padj is the adjusted p-value (FDR corrected) — used to identify significantly differentially expressed genes 