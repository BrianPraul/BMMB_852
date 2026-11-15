#!/usr/bin/env Rscript
#
# Build a transcript-level count matrix (rows = transcripts,
# columns = samples) from salmon quant.sf files using tximport.
#
# Usage (from the directory containing design.csv and counts/):
#   Rscript make_expression_matrix.R
#   Rscript make_expression_matrix.R design.csv counts results
#
# Arguments (all optional):
#   1. design file   (default: design.csv)   needs a "sample" column
#   2. counts dir    (default: counts)       expects counts/<sample>/quant.sf
#   3. output dir    (default: results)
rm(list = ls())
setwd("~/edu/bioinfo")
suppressPackageStartupMessages(library(tximport))

args        <- commandArgs(trailingOnly = TRUE)
design_file <- if (length(args) >= 1) args[1] else "design.csv"
counts_dir  <- if (length(args) >= 2) args[2] else "counts"
out_dir     <- if (length(args) >= 3) args[3] else "results"

# ---- Read the design file -------------------------------------------------
design <- read.csv(design_file, stringsAsFactors = FALSE)
if (!"sample" %in% colnames(design)) {
  stop("The design file must contain a 'sample' column.")
}
samples <- design$sample

# ---- Locate the salmon quant.sf files ------------------------------------
files <- file.path(counts_dir, samples, "quant.sf")
names(files) <- samples

missing <- !file.exists(files)
if (any(missing)) {
  stop("Missing quant.sf file(s):\n  ", paste(files[missing], collapse = "\n  "))
}

# ---- Import with tximport (transcript level, no gene summarization) ------
txi <- tximport(files, type = "salmon", txOut = TRUE)

# Estimated counts (NumReads); columns follow the design file order
counts <- txi$counts
colnames(counts) <- samples

# ---- Write the matrix -----------------------------------------------------
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

out_path <- file.path(out_dir, "transcript_counts.csv")
out <- data.frame(transcript = rownames(counts), counts, check.names = FALSE)
write.csv(out, out_path, row.names = FALSE, quote = FALSE)
message("Wrote ", out_path, "  (", nrow(counts), " transcripts x ", ncol(counts), " samples)")
