#script for functional enrichment (optional but powerful)

library(clusterProfiler)
library(org.Hs.eg.db)
library(DOSE) #loads packages for enrichment analysis
library(biomaRt) #loads biomaRt for ensembl dataset

#clusterProfiler used for gene ontology analysis

res <- readRDS("/Volumes/Extreme SSD/RNAseq_TCGA_BRCA_Pipeline/results/deseq_results.rds") #reads in generated results file

sig_genes <- rownames(res)[which(res$padj < 0.05)] #filters significant genes (adjusted p-value < 0.05).
sig_genes_clean <- gsub("\\..*", "", sig_genes) #to remove the version from ensembl IDs

mart <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
id_map <- getBM(
  filters = "ensembl_gene_id",
  attributes = c("ensembl_gene_id", "entrezgene_id", "hgnc_symbol"),
  values = sig_genes_clean,
  mart = mart
) #maps ensembl IDs to entrez IDs

entrez_ids <- id_map$entrezgene_id #mapped entrez IDa

ego <- enrichGO(gene = entrez_ids,
                OrgDb = org.Hs.eg.db,
                keyType = "ENTREZID",
                ont = "BP",
                pAdjustMethod = "BH",
                qvalueCutoff = 0.05) #performs gene ontology enrichment


#Adjusts for multiple testing using Benjamini-Hochberg (BH) correction.

dotplot(ego) #Plots enriched gene ontology terms using a dotplot:

#X-axis: gene ratio
#Y-axis: GO term
#Dot size: number of genes
#Dot color: significance