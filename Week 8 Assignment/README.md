# Week 8 Assignment

WIP
#
For Week 8's Assignment, I had to generate a multisample VCF file, then annotate some of the variants to see how they might have changed the protein.

1. Selecting Reference and Runs

I opted to use method 2 from the multisample VCF file creation lecture, where variants are called simultaneously on all BAM files. For my reference I will be using the same _Salmonella enterica_ reference I have been using: ``GCA_060595115.1_ASM6059511v1_genomic.fna``, named Sentericaref.fna

For the runs, I used the same Bioproject I have used in previous weeks: ``DRP019527``
The specific runs were: ``DRR1060913`` (from last week), ``DRR1060918``, and ``DRR1060917``.

I downloaded them using the earlier SRRDownloadMakefile with the following command, substituting the different runs:

````
make -f SRRDownloadMakefile ACCESSION=DRR1060913 N=350000
````

Then, I aligned them using the AlignMakefile from earlier in the semester, using this command:

````
make -f AlignMakefile REFERENCE=Referencegenome.fasta  SAMPLES=SRR_Accession
````
#

2. Variant Calling:

The command to run the multisample VCF file is as follows:

````
make -f VCFMakefile_multi vcf REF=Sentericaref.fna BAMS="bam/DRR1060913.bam bam/DRR1060918.bam bam/DRR1060917.bam" PLOIDY=1
````

Then, decompress it with:

```
bcftools view vcf/merged-Sentericaref.vcf.gz -Ov -o vcf/merged-Sentericaref.vcf
```


When loading the merged VCF into IGV, we see the following:

<img width="1137" height="267" alt="Screenshot 2026-10-17 at 6 53 55 PM" src="https://github.com/user-attachments/assets/cc875522-9f47-4c1d-b7b8-6f1b9bfa8397" />

#

3. Feature Annotation

   If we look at approximately 2,658,000 we can see a 31 bp insertion

<img width="1326" height="327" alt="Screenshot 2026-10-17 at 8 38 53 PM" src="https://github.com/user-attachments/assets/bc6c913e-72af-4348-a387-d8403a675838" />

On the minus strand, this insertion sits on a 973 base coding sequence. After searching the reference assembly annotations on genbank, I found the following gene at the same coordinates:

<img width="678" height="635" alt="Screenshot 2026-10-17 at 8 50 31 PM" src="https://github.com/user-attachments/assets/00b22525-782d-4f49-828f-135c0351e65d" />

As a result, we can conclude that these isolates (of a different serovar than the reference), have almost a 10 AA difference in this gene. This insertion disrupts the asparagine located in this region, and replaces it with a run of: TPAPTAAATQK instead. This is not predicted to have a large effect on the protein's function, which is interesting considering how many amino acids were added.
