# Week 3 Assignment: Collaboration

NOT DONE YET

For this week's assignment, I used the repository of Emily Snyder, which can be found at:

```
[Link to repository](https://github.com/EXS5825/appbio-2026)
```
After forking the repository, I checked the makefile in Visual Studio Code's agent (I used Claude) to make sure it wasn't risky (it of course wasn't). The only issue I encountered was when I tried to run the makefile. The provided command to run it was:

```
pixi run makefile
```

This command doesn't work, but it's a simple fix. Simply either do:

```
pixi run make
```

or just

```
make
```
in an environment with pixi and it runs, with this output:

``datasets download genome accession GCA_000441915.1 --include genome,gff3 --filename GCA_000441915.1.zip
New version of client (18.37.0) available at https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/mac/datasets.
Collecting 1 genome record [================================================] 100% 1/1
Downloading: GCA_000441915.1.zip    21.7MB valid data package
Validating package files [================================================] 100% 6/6
unzip -p GCA_000441915.1.zip "ncbi_dataset/data/GCA_000441915.1/*.fna" > GCA_000441915.1_genomic.fna
unzip -p GCA_000441915.1.zip ncbi_dataset/data/GCA_000441915.1/genomic.gff > GCA_000441915.1_genomic.gff``

This is the output in the readme as well, showing it does what the readme says it does.
#
After feeding both makefiles into the VS Code AI, it listed strengths and weaknesses for each without taking a side. When pressed to pick one, the AI said that Emily's was better for this application because the single accession to be pulled was coded into the makefile itself, while mine requires specifying the accession in the command to run it.







Placeholder text here to make the folder for Week 3's assignment.
