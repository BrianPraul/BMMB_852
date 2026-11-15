# Week 12 Assignment

This week's assignment:

1.  Perform the transcript-based quantification.

    First, make sure you have the chr22.transcripts.fa within the fasta folder. ```make counts``` will run for one sample, while ```make batch``` will run all samples.

3. Write R scripts that:
    Combine the individual transcript counts into a single transcript-level count matrix.
    Combine the resulting transcript-level counts into another gene-level count matrix.
    Ensure that both count matrices also have gene names associated with each row.

   TranscriptCountMatrix.R takes the transcript-based counts (in the quant.sf files within the project root) and design file and make the count matrix in a csv. MakeGeneCountMatrix.R takes the transcript-level matrix and condenses it to a gene-level count matrix. Finally, AddGeneNames.R adds common gene names to the gene-level count matrix, as long as you have the GTF file in the same directory.

   I was surprised at how easily the prompting process worked. I did find I needed to be very specific telling the AI which packages I didn't have installed, and making sure it all worked in the correct directory. It also tried to do transcripts per million (TPM) initially, which I had to dissuade it from doing.

5. Refer to your previous assignment that visually identified highly expressed genes. Does your count matrix support the visually identified behavior?

Yes, the count matrix generally supports the behavior observed the previous week. Two examples from last week included this gene, which was highly expressed in all samples:
<img width="2464" height="1108" alt="image" src="https://github.com/user-attachments/assets/51e86d90-12b1-4459-ad15-5cce7ac4009a" />

The count data supports this:

<img width="544" height="117" alt="Screenshot 2026-11-15 at 2 01 47 PM" src="https://github.com/user-attachments/assets/b902e6c0-f84b-4830-8b45-d8fec625519a" />

Likewise, here's an image with a very different expression between the two sets of samples:

<img width="2134" height="1380" alt="image" src="https://github.com/user-attachments/assets/36c4ea40-ee8f-4264-adc6-2596b33ef7e2" />


And this is again supported in the count data:


<img width="550" height="265" alt="Screenshot 2026-11-15 at 2 14 55 PM" src="https://github.com/user-attachments/assets/dee79a8a-f12c-4fc8-b7a0-566ebe715065" />

