# belugaddRAD

This is repository for the code associated with assessing inbreeding depression in St. Lawrence Estuary beluga whales using ddRADseq.

The **raw-to-variants/** directory contains the scripts used to get from raw sequence files to Stacks genotype calls (vcf files).
It is organized into sub-directories for the larger steps.
Scripts are numbered continuously.

The **variant-filtering/** directory contains the scripts used to filter variants; numbering continues from the raw-to-variants steps.

The **analysis/** directory contains the data files and R markdown code used to calculate inbreeding coefficients and conduct subsequent analyses.
