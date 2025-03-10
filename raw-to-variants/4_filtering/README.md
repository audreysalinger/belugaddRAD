## Cleaning and filtering data

First, I used Stacks `clone_filter` to remove PCR duplicates based on the 10bp degenerate base region (DBR), which was
included on the ddRAD adapters during library prep. These random oligos were found at the start of the R2 sequences.
The `clone_filter` program identifies PCR duplicates, or clones, by comparing the signle and paired-end reads to find
identical sequences. More than one set of identically matching single and paired-end reads will be considered a clone
and only one representative of that set will be output. After identifying PCR duplicates, `clone_filter` trims the 10bp
DBR off the 5'-end of the R2 sequences.

A second script was then used to extract data on the percent of clone reads for each sample.

Next, I used Stacks `process_radtags` to clean and quality filter the data. This program was used to:
(1) discard any reads that containing an uncalled base 'N',
(2) discard any reads where the mean quality within a sliding window 15% of the read length dropped below 20,
(3) discard any reads without a proper cut site remnant seuqence after rescuing any cut site remnant sequences
    that contained 1 mismatch,
(4) discard any reads with poly-G runs, and
(5) discard any reads containing Nextera Transposase adapter read-through at the 3'-end.

Two scripts were then used to extract data on per-sample performance, including number and percent of reads retained,
reasons reads were discarded, and the number of retained reads that were successfully paired.

Post-filtering QC was then conducted using FastQC and MultiQC.

Code used for all of these steps can be found here in the filtering directory.
