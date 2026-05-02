
library(Seurat)
library(ggplot2)
library(patchwork)

pbmc <- readRDS("results/pbmc_multiome_wnn.rds")

DefaultAssay(pbmc) <- "RNA"

markers <- c(
  "CD3D", "CD3E",   # T cells
  "CD4", "CD8A",    # T subsets
  "MS4A1",          # B cells
  "NKG7",           # NK cells
  "LYZ", "S100A8",  # monocytes
  "FCGR3A",         # macrophages
  "FCER1A",         # dendritic
  "PPBP"            # platelets
)

p1 <- DotPlot(pbmc, features = markers) + RotatedAxis()
ggsave("figures/05_marker_dotplot.png", p1, width = 12, height = 6)

p2 <- FeaturePlot(
  pbmc,
  features = c("CD3D", "MS4A1", "NKG7", "LYZ"),
  reduction = "umap",
  ncol = 2
)

ggsave("figures/06_marker_featureplots.png", p2, width = 10, height = 8)

