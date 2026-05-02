
library(Seurat)
library(ggplot2)

pbmc <- readRDS("results/pbmc_multiome_wnn.rds")

DefaultAssay(pbmc) <- "RNA"

pbmc$celltype <- "Unknown"

# TEMPORARY labels - refine after checking dot plot
pbmc$celltype[pbmc$seurat_clusters %in% c(0, 1, 2, 3, 4, 6, 7, 10, 11, 12)] <- "T cells"
pbmc$celltype[pbmc$seurat_clusters %in% c(5)] <- "B cells"
pbmc$celltype[pbmc$seurat_clusters %in% c(8)] <- "NK cells"
pbmc$celltype[pbmc$seurat_clusters %in% c(9, 13, 14)] <- "Monocytes"

p <- DimPlot(pbmc, group.by = "celltype", label = TRUE) +
  theme_bw()

ggsave("figures/07_celltype_annotation.png", p, width = 8, height = 6, bg = "white")

saveRDS(pbmc, "results/pbmc_multiome_annotated.rds")

print(pbmc)

