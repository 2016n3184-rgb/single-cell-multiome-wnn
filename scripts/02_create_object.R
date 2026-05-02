
library(Seurat)
library(Signac)
library(EnsDb.Hsapiens.v86)
library(GenomeInfoDb)

dir.create("results", showWarnings = FALSE)

counts <- Read10X_h5("data/pbmc_multiome/filtered_feature_bc_matrix.h5")

pbmc <- CreateSeuratObject(
  counts = counts$`Gene Expression`,
  assay = "RNA"
)

pbmc[["ATAC"]] <- CreateChromatinAssay(
  counts = counts$Peaks,
  sep = c(":", "-"),
  genome = "hg38",
  fragments = "data/pbmc_multiome/atac_fragments.tsv.gz"
)

annotations <- GetGRangesFromEnsDb(EnsDb.Hsapiens.v86)
seqlevelsStyle(annotations) <- "UCSC"
genome(annotations) <- "hg38"

Annotation(pbmc[["ATAC"]]) <- annotations

saveRDS(pbmc, "results/pbmc_multiome_raw.rds")

print(pbmc)

