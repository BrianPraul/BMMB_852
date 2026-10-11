
# Week 7 Assignment: VCF File Generation  + Variant Calling


1. Makefile usage:

```
make -f VCFMakefile vcf REF=GCA_060595115.1_ASM6059511v1_genomic.fna  BAM=DRR1060913.bam
```

Substitute the REF and BAM for your own reference and BAM files as needed. Then, use bcftools to uncompress the resulting .vcf.gz file (while still keeping the compressed file) with:

```
bcftools view vcf/DRR1060913-GCA_060595115.1_ASM6059511v1_genomic.vcf.gz -Ov -o vcf/DRR1060913-GCA_060595115.1_ASM6059511v1_genomic.vcf
```

2. VCF Statistics:

Below are the VCF statistics: 
 
<img width="626" height="400" alt="Screenshot 2026-10-11 at 11 57 34 AM" src="https://github.com/user-attachments/assets/3eaf7004-cefe-461d-bf83-5959a7d16888" />


3. Variants called:

The vast majority of variants called were SNPs, with the remainder being small indels Below is the IGV screenshot when looking at the entire chromosome:

<img width="1499" height="275" alt="Screenshot 2026-10-10 at 11 46 21 PM" src="https://github.com/user-attachments/assets/87f6fd95-3503-47d9-ab2e-5bbbabf5f678" />

And here is a smaller view, compared with the BAM file to show coverage:
<img width="1130" height="559" alt="Screenshot 2026-10-11 at 2 31 12 PM" src="https://github.com/user-attachments/assets/c6ea8a98-500a-4cba-8c83-b5d6fa2503c6" />


A Claude-generated table splitting the SNPs and indels, then sorting by confidence in true variance is below:

<img width="720" height="348" alt="Screenshot 2026-10-11 at 1 25 36 PM" src="https://github.com/user-attachments/assets/6633547e-9cc9-483a-bafa-f19ed36b848c" />


