#!/usr/bin/env Rscript
#
# Collapse a transcript-level count matrix into a gene-level count matrix
# by summing the counts of all transcripts that belong to each gene.
# The transcript -> gene mapping is taken from a GTF annotation file.
#
# Usage (from the directory containing results/ and gtf/):
#   Rscript make_gene_matrix.R
#   Rscript make_gene_matrix.R results/transcript_counts.csv gtf/chr22.gtf results/gene_counts.csv
#
# Arguments (all optional):
#   1. transcript count matrix (default: results/transcript_counts.csv)
#   2. GTF file                (default: gtf/chr22.gtf)
#   3. output file             (default: results/gene_counts.csv)

rm(list = ls())
setwd("~/edu/bioinfo")
args       <- commandArgs(trailingOnly = TRUE)
tx_file    <- if (length(args) >= 1) args[1] else "results/transcript_counts.csv"
gtf_file   <- if (length(args) >= 2) args[2] else "gtf/chr22.gtf"
out_file   <- if (length(args) >= 3) args[3] else "results/gene_counts.csv"

# ---- Read the transcript-level matrix ------------------------------------
tx <- read.csv(tx_file, check.names = FALSE, stringsAsFactors = FALSE)
tx_ids <- tx[[1]]
counts <- as.matrix(tx[, -1, drop = FALSE])
rownames(counts) <- tx_ids

# ---- Build the transcript -> gene map from the GTF -----------------------
gtf <- read.delim(gtf_file, header = FALSE, sep = "\t", quote = "",
                  comment.char = "#", colClasses = "character")
attrs <- gtf[[9]]

get_attr <- function(x, key) {
  m <- regmatches(x, regexpr(paste0(key, ' "[^"]+"'), x))
  out <- rep(NA_character_, length(x))
  hit <- grepl(paste0(key, ' "'), x)
  out[hit] <- sub(paste0('^', key, ' "([^"]+)"$'), "\\1", m)
  out
}

tx2gene <- unique(data.frame(
  transcript_id = get_attr(attrs, "transcript_id"),
  gene_id       = get_attr(attrs, "gene_id"),
  stringsAsFactors = FALSE
))
tx2gene <- tx2gene[!is.na(tx2gene$transcript_id) & !is.na(tx2gene$gene_id), ]

# ---- Match transcripts to genes ------------------------------------------
gene_of <- tx2gene$gene_id[match(rownames(counts), tx2gene$transcript_id)]

# If nothing matches, try again ignoring version suffixes (e.g. ENST...1)
if (all(is.na(gene_of))) {
  message("No exact ID matches; retrying without version suffixes.")
  strip <- function(x) sub("\\.[0-9]+$", "", x)
  gene_of <- tx2gene$gene_id[match(strip(rownames(counts)), strip(tx2gene$transcript_id))]
}
if (all(is.na(gene_of))) {
  stop("None of the transcript IDs in the count matrix were found in the GTF.")
}

unmapped <- is.na(gene_of)
if (any(unmapped)) {
  warning(sum(unmapped), " of ", length(unmapped),
          " transcripts were not found in the GTF and are dropped.")
  counts  <- counts[!unmapped, , drop = FALSE]
  gene_of <- gene_of[!unmapped]
}

# ---- Sum transcript counts per gene --------------------------------------
gene_counts <- rowsum(counts, group = gene_of, reorder = TRUE)

# ---- Write the matrix -----------------------------------------------------
dir.create(dirname(out_file), showWarnings = FALSE, recursive = TRUE)
out <- data.frame(gene = rownames(gene_counts), gene_counts, check.names = FALSE)
write.csv(out, out_file, row.names = FALSE, quote = FALSE)
message("Wrote ", out_file, "  (", nrow(gene_counts), " genes x ",
        ncol(gene_counts), " samples, from ", nrow(counts), " transcripts)")
