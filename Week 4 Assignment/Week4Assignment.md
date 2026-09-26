# Week 4 Assignment

EDIT: In an earlier version, I said there were 289 SRA datasets available. I mistakenly thought the question and subsequent ones were referring to the datasets under a specific BioProject Number. It has since been fixed.

I picked the *Salmonella enterica* genome.
##

1. How "popular" is this genome? How many datasets are available?

   There are 929,885 SRA datasets available.
##

2. What is the breakdown by sequencing strategy and platform (or some other attribute)?

   ```
   ABI SOLiD(100)
   BGISEQ(924)
   Capillary(128)
   Complete Genomics(66)
   Helicos(2)
   Illumina(926,009)
   Ion Torrent(1,318)
   LS454(683)
   Oxford Nanopore(6,068)
   PacBio SMRT(1,615)
   ```
##

4. What do you find interesting or surprising?

   I thought it was interesting that the vast, vast majority of sequencing is still done with Illumina, despite the variety in the total number of methods used.
##

5. The Makefile

   Makefile usage, with the specific DRR accession and read count I used (replace with your own N and accession as needed):

   ```
   make -f SRRDownloadMakefile ACCESSION=DRR1060913 N=100000
   ```
##

6. The QC Visualization

   After running fastQC, it generated two sets of reports for the paired data. An overview screenshot of one is below. The overrepresented sequences are a string of guanines.
   
[![Screenshot-2026-09-20-at-11-17-22-PM.png](https://i.postimg.cc/90V171Zy/Screenshot-2026-09-20-at-11-17-22-PM.png)](https://postimg.cc/CBPjyGvK)

##

8. Fastp

   I next ran fastp on the data. It did trim about 0.5Mbp and ~100 sequences. However, it did not have a huge impact on the overall quality of the data, both because the reads were already of really high quality, and I suspect the adapter sequence in the fastp wasn't correct (I can't find the adapter sequence in the SRA metadata).

[![Screenshot-2026-09-20-at-11-17-31-PM.png](https://i.postimg.cc/7hxM6hrS/Screenshot-2026-09-20-at-11-17-31-PM.png)](https://postimg.cc/0MBJX8QN)



   
