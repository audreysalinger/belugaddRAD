## Preprocessing reads

Before cleaning and quality filtering, I will take a few steps to prepare my reads.

First, since I have now determined (by analyzing 10% of samples) that there are no significant differences in quality or mapping
performance for sequence data between the two sequencing lanes, I will combine (concatenate) the forward read fastq files from both
lanes and the reverse read fastq files from both lanes so that there will be only one R1 and one R2 file for each sample going forward.

Next I wanted to remove leading bases from the R1 reads. I had my reads demultiplexed by the sequencing centre, and some R1 sequences
still have a leading C base before the RE cut site remnant, which I believe to be an artifact of trimming as it is the last base in 
the adapter sequence that would have been trimmed. Additionally, some R1 sequences have a leading uncalled N base, a common occurrence
with Illumina data. I have used Cutadapt and Trimmomatic to remove these C/N bases if they are present at the start of R1 sequences, so
that I will subsequently be able to use Stacks `process_radtags` to check for the RAD cut site (which must be at the read start).

Lastly, I copied the concatenated and/or trimmed reads to a working scratch directory from which I will run the Stacks programs.
