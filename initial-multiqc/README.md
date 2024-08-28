## Initial quality assessment

Before beginning my ddRAD analysis with the Stacks workflow, I want to do an initial read quality check.

I have already looked at a few lines of some R1 and R2 fastq files, to visually assess that the read structure is as expected.
I can see that R1 reads appear to begin with the restriction enzyme cut site sequence TGCAT.
R2 reads appear to start with the degenerate base sequences (10b) that we included to be able to ID PCR duplicates, followed by the CATG cut site remnant. 

Now I will look at the fastqc reports, which are provided for each read by the sequencing centre. I will use MultiQC to aggregate the fastqc reports for each lane into one singular html report.

There are two steps to this process:
	1. There are two fastqc directories of interest for each sample (one for R1 and one for R2), and they are nested within the sample directories. I want to pull them out and copy them into a new QC directory. For this, I will keep the two lanes separate.
	2. One the fastqc files of interest are moved, I can then run multiqc for each lane using a slurm batch script.

Code used for these two steps can be found here in the initial-multiqc directory.
