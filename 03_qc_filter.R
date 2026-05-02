
library(Seurat)
library(Signac)
library(ggplot2)
library(patchwork)

dir.create("figures", showWarnings = FALSE)

pbmc <- readRDS("results/pbmc_multiome_raw.rds")

DefaultAssay(pbmc) <- "RNA"
pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern = "^MT-")

DefaultAssay(pbmc) <- "ATAC"
pbmc <- NucleosomeSignal(pbmc)
pbmc <- TSSEnrichment(pbmc)

p1 <- VlnPlot(pbmc, features = c("nCount_RNA", "nFeature_RNA", "percent.mt"),
              ncol = 3, pt.size = 0)

p2 <- VlnPlot(pbmc, features = c("nCount_ATAC", "TSS.enrichment", "nucleosome_signal"),
              ncol = 3, pt.size = 0)

ggsave("figures/01_rna_qc.png", p1, width = 12, height = 4)
ggsave("figures/02_atac_qc.png", p2, width = 12, height = 4)

pbmc <- subset(
  pbmc,
  subset =
    nCount_RNA > 1000 &
    nCount_RNA < 25000 &
    nFeature_RNA > 500 &
    percent.mt < 20 &
    nCount_ATAC > 1000 &
    nCount_ATAC < 100000 &
    TSS.enrichment > 2 &
    nucleosome_signal < 4
)

saveRDS(pbmc, "results/pbmc_multiome_qc.rds")

print(pbmc)

