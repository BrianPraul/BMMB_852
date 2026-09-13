# Week 2 Assignment

#

1) **Makefile Usage**

The generic command to run the makefile is as follows:

```
make -f /absolute/path/to/GenomeDownloadMakefile \
  download ACCESSION=GCA/GCF_XXXXXXXXX.X
```
This downloads a given GCA or GCF accession in both FASTA and GFF format. GCA prefixes indicate a Genbank genome assembly, while GCF indicates a Refseq assembly. By default, the files will be downloaded into your current working directory.

The specific command I ran for this assignment is:
```
make -f /Users/brianpraul/GenomeDownloadMakefile \
  download ACCESSION=GCF_060595115.1
```
This downloads a _Salmonella enterica_ assembly.
#

#
2) **How large is the genome? How many chromosomes does it have?**

The command to find this is `seqkit stats GCF_060595115.1.fasta`.</br>
The genome is approximately 5 Mb long, with one chromosome 4.857 Mb long and one 93 Kb plasmid.
#

#
3) **How many annotations are in the annotation file?**

Using the command below returns the total number of annotation entries in the GFF file:

```
grep -v '^#' GCF_060595115.1.gff | wc -l
```
>9852

Meanwhile, this command breaks down the GFF annotations by labeled type:
```
awk -F'\t' '!/^#/ { count[$3]++ }
END {
  for (x in count) print x, count[x]
}' GCF_060595115.1.gff | sort
```

It returns:
``CDS 4731  
RNase_P_RNA 1  
SRP_RNA 1  
antisense_RNA 1  
direct_repeat 3  
exon 125  
gene 4725  
ncRNA 13  
pseudogene 128  
rRNA 22  
region 2  
riboswitch 6  
sequence_feature 7  
tRNA 86  
tmRNA 1``
#

#
4) **How complete is this genomic build in your opinion?**

Based on the returned annotation counts and comparison with other _Salmonella enterica_ genomes, I believe it is a reasonably complete genomic build. _S. enterica_ is expected to have between 4,000 and 5,000 genes. Since the annotations show 4,725 annotations labeled as "gene", I believe it has been well annotated.

#

#
5) **How tightly packed are the genes in this genome? Estimate the gene-to-gene distance via the browser.**

   Since it's bacterial (meaning one circular chromosome without introns) the genes are packed very tightly, often with ~100 bp distance between genes
#

#
7) **Pick a coordinate on the chromosome and visually inspect the sequence regions around it. Describe all six reading frames (codons) that the coordinate could be part of.**

On the main chromosome, I picked the coordinate 674,675. It is a thymine on the forward strand and adenine on the reverse strand. Depending on reading frame, the coordinate could be part of a:

``Methionine (ATG)``
``Cysteine (TGC)``
``Aspartic Acid (GAT)``  

On the reverse strand it could be part of a:
``Histidine (CAT)``
``Isoleucine (ATC)``
``Alanine (GCA)``

<a href="https://ibb.co/Dg7ZQLmf"><img src="https://i.ibb.co/LhC31vBd/Screenshot-2026-09-03-at-2-22-40-PM.png" alt="Screenshot-2026-09-03-at-2-22-40-PM" border="0"></a>

<a href="https://ibb.co/v4Vv02RG"><img src="https://i.ibb.co/XxjkcmMg/Screenshot-2026-09-03-at-2-56-29-PM.png" alt="Screenshot-2026-09-03-at-2-56-29-PM" border="0"></a>
#

#
8) **Identify the type of feature displayed as a data track.**

The type of feature displayed here is a gene encoding molybdopterin-dependent oxidoreductase.

<a href="https://ibb.co/HfdXb2xh"><img src="https://i.ibb.co/TxLr7TbW/Screenshot-2026-09-03-at-2-30-32-PM.png" alt="Screenshot-2026-09-03-at-2-30-32-PM" border="0"></a>
#

#
9) **Color features by their strand orientation.**

Blue is the positive strand, while red is the negative strand.


<a href="https://ibb.co/8DCTv8r0"><img src="https://i.ibb.co/pv7GVXfx/Screenshot-2026-09-03-at-2-53-06-PM.png" alt="Screenshot-2026-09-03-at-2-53-06-PM" border="0"></a>
