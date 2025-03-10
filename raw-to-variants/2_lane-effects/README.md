## Looking for any differences between sequencing lanes

Each one of my samples was divided and sequenced across two sequencing lanes.
Before moving on with my analysis, I will first look at the data from both lanes
to assess whether there are any notable differences in the quality of reads or
the mapping statistics between the lanes.

I have already reviewed the MultiQC reports for lanes 1 and 2 and detected no
significant differences.

Next, in this next step, I have done two things:
1. I ran Stacks `process_radtags` (disabling the check for the RAD cut site) to
   assess whether the lanes differed in the number of reads retained after
   quality filtering or in the proportion of retained reads. I exported the
   read count data from the process_radtags logs into R to visually assess
   the two lanes.
2. I mapped the raw, uncleaned reads for a subset of 20 samples (10%) using BWA-mem
   and used Qualimap to assess whether there were differences in the proportion
   of reads mapped between lanes 1 and 2.

The scripts used to do these two checks are contained within this directory.
