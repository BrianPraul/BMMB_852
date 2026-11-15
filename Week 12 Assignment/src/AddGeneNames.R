#!/usr/bin/env Rscript
#
# Collapse a transcript-level count matrix into a gene-level count matrix
# by summing the counts of all transcripts that belong to each gene, and
# add a "name" column with the common gene symbol.
#
# The transcript -> gene mapping and gene names come from a GTF file.
# Genes with no gene_name in the GTF fall back to org.Hs.eg.db (if installed).
#
# Usage (from the directory containing results/ and gtf/):
#   Rscript make_gene_matrix.R
#   Rscript make_gene_matrix.R results/transcript_counts.csv gtf/chr22.gtf results/gene_counts.csv
#
# Arguments (all optional):
#   1. transcript count matrix (default: results/transcript_counts.csv)
#   2. GTF file                (default: gtf/chr22.gtf)
#   3. output file             (default: results/gene_counts.csv)

args       <- commandArgs(trailingOnly = TRUE)
tx_file    <- if (length(args) >= 1) args[1] else "results/transcript_counts.csv"
gtf_file   <- if (length(args) >= 2) args[2] else "gtf/chr22.gtf"
out_file   <- if (length(args) >= 3) args[3] else "results/gene_counts.csv"

# ---- Read the transcript-level matrix ------------------------------------
tx <- read.csv(tx_file, check.names = FALSE, stringsAsFactors = FALSE)
tx_ids <- tx[[1]]
counts <- as.matrix(tx[, -1, drop = FALSE])
rownames(counts) <- tx_ids

# ---- Parse the GTF --------------------------------------------------------
gtf <- read.delim(gtf_file, header = FALSE, sep = "\t", quote = "",
                  comment.char = "#", colClasses = "character")
attrs <- gtf[[9]]

get_attr <- function(x, key) {
  pat <- paste0(key, ' "[^"]+"')
  out <- rep(NA_character_, length(x))
  hit <- grepl(pat, x)
  out[hit] <- sub(paste0('.*', key, ' "([^"]+)".*'), "\\1", x[hit])
  out
}

annot <- unique(data.frame(
  transcript_id = get_attr(attrs, "transcript_id"),
  gene_id       = get_attr(attrs, "gene_id"),
  gene_name     = get_attr(attrs, "gene_name"),
  stringsAsFactors = FALSE
))

tx2gene <- unique(annot[!is.na(annot$transcript_id) & !is.na(annot$gene_id),
                        c("transcript_id", "gene_id")])

# gene_id -> gene_name (first non-missing name per gene)
named <- annot[!is.na(annot$gene_id) & !is.na(annot$gene_name), ]
gene2name <- named$gene_name[match(unique(named$gene_id), named$gene_id)]
names(gene2name) <- unique(named$gene_id)

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
gene_ids <- rownames(gene_counts)

# ---- Look up common gene names -------------------------------------------
gene_name <- unname(gene2name[gene_ids])

# Fill gaps from org.Hs.eg.db when available
missing_name <- is.na(gene_name)
if (any(missing_name) && requireNamespace("org.Hs.eg.db", quietly = TRUE)) {
  message(sum(missing_name), " genes lack a gene_name in the GTF; ",
          "looking them up in org.Hs.eg.db.")
  ens <- sub("\\.[0-9]+$", "", gene_ids[missing_name])
  fill <- suppressMessages(
    AnnotationDbi::mapIds(org.Hs.eg.db::org.Hs.eg.db, keys = ens,
                          keytype = "ENSEMBL", column = "SYMBOL",
                          multiVals = "first")
  )
  gene_name[missing_name] <- unname(fill)
}
message(sum(is.na(gene_name)), " genes have no common name and are left blank.")

# ---- Write the matrix -----------------------------------------------------
dir.create(dirname(out_file), showWarnings = FALSE, recursive = TRUE)
out <- data.frame(gene = gene_ids, name = gene_name, gene_counts,
                  check.names = FALSE, row.names = NULL)
write.csv(out, out_file, row.names = FALSE, quote = FALSE, na = "")
message("Wrote ", out_file, "  (", nrow(gene_counts), " genes x ",
        ncol(gene_counts), " samples, from ", nrow(counts), " transcripts)")
