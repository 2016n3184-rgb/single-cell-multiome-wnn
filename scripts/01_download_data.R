
dir.create("data/pbmc_multiome", recursive = TRUE, showWarnings = FALSE)

urls <- c(
  matrix_h5 = "https://cf.10xgenomics.com/samples/cell-arc/2.0.0/10k_PBMC_Multiome_nextgem_Chromium_X/10k_PBMC_Multiome_nextgem_Chromium_X_filtered_feature_bc_matrix.h5",
  fragments = "https://cf.10xgenomics.com/samples/cell-arc/2.0.0/10k_PBMC_Multiome_nextgem_Chromium_X/10k_PBMC_Multiome_nextgem_Chromium_X_atac_fragments.tsv.gz",
  fragments_index = "https://cf.10xgenomics.com/samples/cell-arc/2.0.0/10k_PBMC_Multiome_nextgem_Chromium_X/10k_PBMC_Multiome_nextgem_Chromium_X_atac_fragments.tsv.gz.tbi"
)

dest <- c(
  "data/pbmc_multiome/filtered_feature_bc_matrix.h5",
  "data/pbmc_multiome/atac_fragments.tsv.gz",
  "data/pbmc_multiome/atac_fragments.tsv.gz.tbi"
)

for (i in seq_along(urls)) {
  if (!file.exists(dest[i])) {
    download.file(urls[i], destfile = dest[i], mode = "wb")
  }
}

