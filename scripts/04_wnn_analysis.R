
library(Seurat)
library(Signac)
library(ggplot2)
library(patchwork)

pbmc <- readRDS("results/pbmc_multiome_qc.rds")

DefaultAssay(pbmc) <- "RNA"
pbmc <- NormalizeData(pbmc)
pbmc <- FindVariableFeatures(pbmc)
pbmc <- ScaleData(pbmc)
pbmc <- RunPCA(pbmc)

DefaultAssay(pbmc) <- "ATAC"
pbmc <- RunTFIDF(pbmc)
pbmc <- FindTopFeatures(pbmc, min.cutoff = "q0")
pbmc <- RunSVD(pbmc)

pbmc <- FindMultiModalNeighbors(
  pbmc,
  reduction.list = list("pca", "lsi"),
  dims.list = list(1:30, 2:30)
)

pbmc <- RunUMAP(
  pbmc,
  nn.name = "weighted.nn",
  assay = "RNA"
)

pbmc <- FindClusters(
  pbmc,
  graph.name = "wsnn",
  algorithm = 3,
  resolution = 0.5
)

p1 <- DimPlot(pbmc, reduction = "umap", label = TRUE) +
  ggtitle("WNN UMAP: RNA + ATAC")

ggsave("figures/03_wnn_umap_clusters.png", p1, width = 8, height = 6)

p2 <- FeaturePlot(
  pbmc,
  features = c("RNA.weight", "ATAC.weight"),
  reduction = "umap",
  ncol = 2
)

ggsave("figures/04_modality_weights.png", p2, width = 10, height = 5)

saveRDS(pbmc, "results/pbmc_multiome_wnn.rds")

print(pbmc)

