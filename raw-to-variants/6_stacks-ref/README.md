## Variant calling with Stacks referenced-based pipeline

This directory contains the scripts that I used to call SNPs and genotypes with the Stacks reference-based pipeline.

I am trialing two different strigency thresholds, one using alphas of 0.01 and the other using alphas of 0.001:
--gt-alpha sets the threshold for calling genotypes
--var alpha sets the threshold for discovering SNPs

Script 12 creates a population map. 
I first ran the pipeline for each alpha threshold using all samples (scripts 13 and 14).
I then made the decision to filter to remove samples with read depth <5X, and I re-ran the pipeline for both alphas (script 15).

