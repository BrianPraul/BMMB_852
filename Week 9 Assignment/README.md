# Week 9 Assignment

For week 9's assignment, we were supposed to automate the analysis of variant calling for 10 samples.

##

# 1. Samples, reference, and Bioproject.

For this submission I used the same Bioproject I have been using: ```PRJDB42458```, also known as ```DRP019527```. This Bioproject was a study on the diversity of _Salmonella enterica_, serovar _Dublin_ in Japanese cattle herds. It includes 289 SRA experiments, 212 sequenced using Illumina methods and 77 with Oxford Nanopore. All SRR accessions used are in the current ```design.csv``` file in the directory for this week's assignment. 

# 2. Running the Workflow.

To run the workflow, use the following command:

```
 make -f VCFMakefile_batch batch REF=REF.fna
```

The reference genome I used is accession ```GCA_060595115.1```, which I'd renamed to ```Sentericaref.fna```


Some important tips for running:
* The Makefile assumes that your design file is named design.csv, and is in the current directory.
* Make sure your design.csv is saved as a plain CSV (I encountered an issue where saving it as an alternately encoded CSV like UTF-8 or Macintosh from Excel resulted in it not reading columns correctly; doing a plain CSV file fixed it).
* Make sure your design file has a reasonable read count per sample. I did 350,000 reads per sample here, but if running for a different organism needs may be different.

##

# 3. Visualization.

<img width="1133" height="308" alt="Screenshot 2026-10-25 at 3 59 57 PM" src="https://github.com/user-attachments/assets/fe841586-a73e-4494-9fff-70782653fd38" />
<img width="1141" height="382" alt="Screenshot 2026-10-25 at 3 59 46 PM" src="https://github.com/user-attachments/assets/1373217f-6e49-4c86-a242-1973ee078acc" />



The 30 bp insertion found in Week 8's assignment was found once again, showing in all 10 BAM alignment's generated.

<img width="950" height="871" alt="Screenshot 2026-10-25 at 3 54 38 PM" src="https://github.com/user-attachments/assets/c13591b8-dbd5-465c-bd69-94b4cebee56a" />
