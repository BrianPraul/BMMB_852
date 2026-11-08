# Week 11 Assignment

The task:

Visualize the coverage for all samples and the GTF file in IGV.

1. Look at a wide region (millions of bases wide). How are the two sample types different?

<img width="1134" height="472" alt="Screenshot 2026-11-07 at 4 56 20 PM" src="https://github.com/user-attachments/assets/6e1b7642-a79e-4d29-aaa4-3f46dd3d80d1" />

  There are varying levels of coverage at different genes, showing the differences in expression. Sometimes the coverage is the same between replicates and groups, sometimes it isn't.
   
2. Navigate across the genome. How consistent are the replicates?
   
  The replicates are fairly consistent in coverage across the genome.
   
3. Find a gene that is not expressed in any of the samples.

<img width="834" height="556" alt="Screenshot 2026-11-07 at 4 57 37 PM" src="https://github.com/user-attachments/assets/4c5945cf-ddc3-48db-834d-300ddd8499ef" />

  This gene does not code for a protein, but a long non-coding RNA (lncRNA) that has an unclear role with transcriptional regulation, so it makes sense that it's not highly expressed.
   
4. Find a gene that is very strongly expressed in all samples. What is its coverage?

<img width="1232" height="554" alt="Screenshot 2026-11-07 at 4 59 16 PM" src="https://github.com/user-attachments/assets/75905ebe-9418-4d38-a6e8-4c44d2457028" />
   
In the HBR samples the coverage is ~20x, while in the UBR samples it is closer to ~30x
   
5. Can you identify the transcripts that are expressed? Sometimes you can only exclude some candidates.

<img width="1035" height="715" alt="Screenshot 2026-11-07 at 10 18 20 PM" src="https://github.com/user-attachments/assets/2e3d1044-fc28-43e8-9a99-a8d4a7da02e4" />

I believe the top line of amino acids is the one expressed in the exon, because of the stop codon corresponding perfectly to the sudden drop in coverage.
    
6. Can you find a gene/transcript where the expression is clearly different between the two sample types? What is the fold change?


<img width="1067" height="690" alt="Screenshot 2026-11-07 at 5 10 26 PM" src="https://github.com/user-attachments/assets/de9a24e6-7ca8-4a21-9288-7c782afa0eb6" />

Based on the coverage, it is about a 10x-fold change in transcription.

7. Is the transcript upregulated or downregulated?

   It is downregulated in the cancer lines (UBR) relative to the non-cancer samples.
  
8. How certain are you that it is not a random fluctuation? Why?

   I'm not certain, but I am confident because the gap in coverage is both large (average of 10x vs 0) and consistent across replicates.
