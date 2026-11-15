# Week 12 Assignment

WIP

This week's assignment:

1. Visualize the coverage for all samples and the GTF file in IGV.

2. Perform the transcript-based quantification.

First, make sure you have the chr22.transcripts.fa within the fasta folder. ```make counts``` will run for one sample, while ```make batch``` will run all samples.

3. Write R scripts that:
    Combine the individual transcript counts into a single transcript-level count matrix.
    Combine the resulting transcript-level counts into another gene-level count matrix.
    Ensure that both count matrices also have gene names associated with each row.

   TranscriptCountMatrix.R takes the transcript-based counts (in the quant.sf files within the project root) and design file and make the count matrix in a csv. MakeGeneCountMatrix.R takes the transcript-level matrix and condenses it to a gene-level count matrix. Finally, AddGeneNames.R adds common gene names to the gene-level count matrix, as long as you have the GTF file in the same directory.

5. Refer to your previous assignment that visually identified highly expressed genes. Does your count matrix support the visually identified behavior?
