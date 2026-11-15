# Transcript-based RNA-Seq quantification with Salmon
#
# Usage (run from the project root):
#   make index
#   make SAMPLE=HBR_1 counts
#   make batch
#
# Alternate transcripts file (use a separate OUTDIR so results don't mix):
#   make batch FASTA=fasta/other.fa OUTDIR=counts_other

# --- Inputs ---

# Transcript sequences (cDNA) to quantify against
FASTA = fasta/chr22.transcripts.fa

# Salmon index directory, derived from the fasta name so each fasta gets its own index
FASTA_IDX_DIR = $(patsubst %.fa,%.salmon,${FASTA})

# Sentinel file marking a finished index (touched after salmon index succeeds)
FASTA_IDX = ${FASTA_IDX_DIR}/index.done

# Annotation file (not used by salmon itself, kept for the downstream gene summary)
GTF = gtf/chr22.gtf

# Optional download location for the example data
DATA_URL = http://data.biostarhandbook.com/data/rnaseq-tutorial-2026.tar.gz

# Design file with a "sample" column
DESIGN = design.csv

# --- Per-sample settings ---

# The sample name
SAMPLE = HBR_1

# Single-end reads for the sample
R1 = fastq/${SAMPLE}_R1.fq

# Root output directory (use a different one per fasta) and the sample's directory
OUTDIR = counts
COUNT_DIR = ${OUTDIR}/${SAMPLE}
COUNTS = ${COUNT_DIR}/quant.sf

# --- Resources ---

# Threads per salmon run
THREADS = 4

# Samples run in parallel in batch mode (2 jobs x 4 threads = 8 cores)
JOBS = 2
PARALLEL = parallel --eta --colsep , --header : --jobs ${JOBS} --lb

# This makefile, so batch mode can call it again from any directory layout
MAKEFILE := $(lastword $(MAKEFILE_LIST))

# --- All definitions above this line. All code below this line ---

# First target is the help.
help:
	@echo "#"
	@echo "# SAMPLE=${SAMPLE}"
	@echo "# FASTA=${FASTA}"
	@echo "# R1=${R1}"
	@echo "# COUNTS=${COUNTS}"
	@echo "#"
	@echo "# make data     (download and unpack the example data)"
	@echo "# make index    (build the salmon index from the transcripts)"
	@echo "# make counts   (quantify one sample: SAMPLE=${SAMPLE})"
	@echo "# make batch    (quantify every sample in ${DESIGN})"
	@echo "#"

# Download and unpack the data
${FASTA} ${GTF} ${R1} &:
	curl ${DATA_URL} | tar xzvf -

data: ${FASTA} ${GTF} ${R1}
	ls -lh ${FASTA} ${GTF} ${R1}

# Build the salmon index from the transcript fasta
${FASTA_IDX}: ${FASTA}
	salmon index --transcripts ${FASTA} --index ${FASTA_IDX_DIR} --threads ${THREADS}
	touch ${FASTA_IDX}

index: ${FASTA_IDX}
	ls -lh ${FASTA_IDX_DIR}

# Quantify one sample against the transcripts
${COUNTS}: ${FASTA_IDX} ${R1}
	mkdir -p ${COUNT_DIR}
	salmon quant --index ${FASTA_IDX_DIR} --libType A -r ${R1} --threads ${THREADS} --output ${COUNT_DIR}

counts: ${COUNTS}
	ls -lh ${COUNTS}

all: counts

# Quantify every sample listed in the design file
batch: ${FASTA_IDX}
	cat ${DESIGN} | ${PARALLEL} ${MAKE} -f ${MAKEFILE} SAMPLE={sample} counts

.PHONY: all help data index counts batch

# Additional Makefile settings
SHELL := bash
.DELETE_ON_ERROR:
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --warn-undefined-variables --no-print-directory
