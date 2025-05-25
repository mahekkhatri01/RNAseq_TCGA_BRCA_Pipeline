#script for visualisation by volcano plot and heatmap

library(EnhancedVolcano)
library(pheatmap) #loads packages

res <- readRDS("/Volumes/Extreme SSD/RNAseq_TCGA_BRCA_Pipeline/results/deseq_results.rds") #loads the .rds file from DDSeq2 for visualization

EnhancedVolcano(res,
                lab = rownames(res),
                x = 'log2FoldChange',
                y = 'padj',
                pCutoff = 0.05,
                FCcutoff = 1.5) #creates volcano plot

#X-axis: log2 fold change (effect size)
#Y-axis: -log10(adjusted p-value)
#Genes that are both highly differentially expressed and statistically significant are easy to spot.

topGenes <- head(order(res$padj), 20) #selects the top 20 most significant genes.
vsd <- vst(dds, blind = FALSE) #applies vst (varience stablising transformation) to normalize the counts for better visualization.
pheatmap(assay(vsd)[topGenes, ], scale = "row") #plots a heatmap of expression patterns across samples
