# Week 5 Assignment

##
For this week's assignment, we are supposed to create a BAM alignment file using reads obtained in Week 4 and the alignment in Week 3.

##
1. Download an N number of reads that would equate to >10x coverage, and explain how you calculated N.

   I am going to download 350,000 reads. My reasoning is as follows: the _Salmonella enterica_ genome is approximately 5 million bases. The average short read length for the DRR accession I used last week is 150 per the fastqc report. Dividing 5 million by 150 = 33,333 reads to cover the whole genome. Then multiply that by 10 to get 10x, and a little extra buffer, gets me to 350,000.
##

2. Running the Makefiles.

  To download the reads, navigate to Week 4 Assignment's makefile and download it. Then, run the makefile with the following command:

  ```
make -f SRRDownloadMakefile ACCESSION=DRR1060913 N=350000
```
  This will download the first 350,000 reads from this accession. In this case since reads are paired it will result in ~700,000 reads

  To align the reads, download the makefile under this week's assignment, then run the following command:
```
make -f AlignMakefile REFERENCE=Referencegenome.fasta  SAMPLES=SRR_Accession
```

Specifically, I ran:

```make -f AlignMakefile REFERENCE=GCA_060595115.1_genomic.fna  SAMPLES=DRR1060913```

After running the following command to generate a statistics report:
```
samtools flagstat path/to/BAMfile/DRR1060913.bam
```
I got these results:
```
705946 + 0 in total (QC-passed reads + QC-failed reads)
700000 + 0 primary
0 + 0 secondary
5946 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
626106 + 0 mapped (88.69% : N/A)
620160 + 0 primary mapped (88.59% : N/A)
700000 + 0 paired in sequencing
350000 + 0 read1
350000 + 0 read2
583670 + 0 properly paired (83.38% : N/A)
610148 + 0 with itself and mate mapped
10012 + 0 singletons (1.43% : N/A)
656 + 0 with mate mapped to a different chr
644 + 0 with mate mapped to a different chr (mapQ>=5)
```
  
  ##
3. What percent of the reads align?

    88.69%

5. What do the alignments and coverage look like?

   The coverage is not uniform, and the alignment has several notable gaps. Examples of both are shown below:

   <a href="https://ibb.co/XxGnfhz0"><img src="https://i.ibb.co/8gQynWjv/Screenshot-2026-09-27-at-12-05-07-PM.png" alt="Screenshot-2026-09-27-at-12-05-07-PM" border="0"></a>

<a href="https://ibb.co/RGkN3DKR"><img src="https://i.ibb.co/hxJcBmN3/Screenshot-2026-09-27-at-12-01-40-PM.png" alt="Screenshot-2026-09-27-at-12-01-40-PM" border="0"></a>
