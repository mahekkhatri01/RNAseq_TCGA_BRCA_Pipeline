#script to download RNA-Seq data from TCGA

library(TCGAbiolinks) #loads TCGAbiolinks package

#TCGAbiolinks (to query, download, and prepare TCGA/GTEx/GDC data directly in R)

set.seed(123) # for reproducibility

sample_info <- getResults(query, cols = c("cases", "sample_type", "file_id")) #creates a data frame of all available tumor and normal files

tumor_samples_all <- sample_info$cases[sample_info$sample_type == "Primary Tumor"]
normal_samples_all <- sample_info$cases[sample_info$sample_type == "Solid Tissue Normal"] #filters all tumor and normal tissues into separate vectors based on sample type

tumor_barcodes <- sample(tumor_samples_all, 100)
normal_barcodes <- sample(normal_samples_all, 100) # randomly samples 100 tumor and normal tissues from the dataset 

# we are sampling data to stay within the RAM limit while still making meaningful visualizations

query <- GDCquery(
  project = "TCGA-BRCA",
  data.category = "Transcriptome Profiling",
  data.type = "Gene Expression Quantification",
  workflow.type = "STAR - Counts",
  barcode = c(tumor_barcodes, normal_barcodes)
) #queries data

#project(specifies TCGA cancer type — here, BRCA), data.category(Transcriptome Profiling for RNA-Seq data)
#data.type(Gene Expression Quantification gives gene-level counts), wokflow.type(STAR - Counts - gene counts generated from STAR aligner pipeline (HTSEQ - counts is aoutdated for the current verion of TCGA data))
#barcode(we request information for the 100 barcoded tumor and normal tissue only)

GDCdownload(query, files.per.chunk = 10) #downloads queried data
data <- GDCprepare(query) #converts raw data to standard Bioconductor format



saveRDS(data, file = "/Volumes/Extreme SSD/RNAseq_TCGA_BRCA_Pipeline/data/BRCA_rnaseq_data.rds") #saves data as an .rds file

