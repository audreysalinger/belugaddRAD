## Mapping to reference genome

This mapping directory contains all code scripts used to:

1. filter the reference genome to contain only scaffolds >10Mbp
2. create a BWA genome database for the filtered reference
3. map reads to the reference genome using BWA in mem mode, then convert to BAM and sort alignments
4. create an input file for Qualimap
5. run Qualimap to summarize mapping statistics
6. run MultiQC to create a report of per-sample mapping statistics
