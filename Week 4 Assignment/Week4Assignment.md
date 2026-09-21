# Week 4 Assignment

NOT DONE YET For this week's assignment, I had to pick a different accession for *Salmonella enterica* because the one I had initially picked did not have any SRA data. My new accession is also a *S. enterica* genome.
##

1. How "popular" is this genome? How many datasets are available?

   There are 289 SRA datasets available.
##

2. What is the breakdown by sequencing strategy and platform (or some other attribute)?

   212 SRA datasets were sequenced using the Illumina Novaseq, while the remaining 77 were sequenced with the Oxford Nanopore MinION.
##

4. What do you find interesting or surprising?

   I thought the variation in sequencing methods surprising; I would have expected them to use only one strategy for all SRA experiments.
##

5. The Makefile

   Makefile usage, with the specific DRR accession and read count I used (replace with your own N and accession as needed):

   ```
   make -f SRRDownloadMakefile ACCESSION=DRR1060913 N=1000
   ```
##

6. The QC Step
