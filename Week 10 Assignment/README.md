# Week 10 Assignment

For week 10, we are supposed to modify our workflow makefile from week 9 to be used for ChIP-seq data.

# 1. Background information.
             
Like before, this week used _Salmonella enterica_ genomes. Specifically, it used the BioProject ```PRJNA1223327```, which is associated with the paper "Bacterial chromatin remodeling associated with transcription-induced domains at pathogenicity Islands.", where it is used to examine _Salmonella_'s Type-III secretion system.

There are a few different conditions in this BioProject. There are cells grown to either Early Exponential Phase or Early Stationary Phase, and some that are Green Fluorescent Protein positive or negative. I chose to run 2 samples that were GFP - and 2 that were GFP +

# 2. The Design File.

The Makefile requires a design file named design.csv in the current directory. The Design file needs 4 columns and reads as follows: 


| sample | srr | reads | control|
| --- | --- | --- | --- |
| S01 | SRRXXXX | 1000000 |     |
| S02 | SRRXXXX | 1000000 | S01 |

In this example, S01 is the control, while S02 is the test.

# 3. The Makefile.

There's a few different commands to run the makefile:

To run the first sample in the design file:
```make -f PeakMakefile_batch all REF=fasta/genome.fa```

To run one sample:
```make -f PeakMakefile_batch all REF=fasta/genome.fa SAMPLE=```

To run only the background samples:
```make -f PeakMakefile_batch background REF=fasta/genome.fa```

To run all samples:
```make -f PeakMakefile_batch batch REF=fasta/genome.fa```

# 4. IGV

Interestingly, even though they are replicates of each other, there are no peaks where they agree when run with 350,000 reads. When the sample is upped to 1 million reads, more peaks were called, and there were several overlaps. However, there were still significant differences.

<img width="1493" height="254" alt="Screenshot 2026-11-01 at 3 44 03 PM" src="https://github.com/user-attachments/assets/0356fb2e-9d00-441a-ae62-90e5b59fd7cf" />

When run with 1 million reads per sample:
<img width="1137" height="255" alt="Screenshot 2026-11-01 at 4 01 00 PM" src="https://github.com/user-attachments/assets/380cb251-1fd6-4f4c-b9a6-211051fadeb7" />

An example of peaks that match:
<img width="427" height="217" alt="Screenshot 2026-11-01 at 4 01 58 PM" src="https://github.com/user-attachments/assets/fb95f123-4c36-45c5-944e-ca7b7f34f248" />


