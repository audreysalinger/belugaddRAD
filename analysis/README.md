## Data files and scripts for R analyses

I made an R project for this analysis, which helps package the scripts and data into a self-contained working directory. The **analysis.Rproj** file is a shortcut for opening this project space.

### R Markdown files

There are two R markdown scripts within this directory:
- **beluga_ddRADseq.Rmd** (the main code script used for analysis, figures, primary Bayesian models)
- **live-reference-models.rmd** (a secondary script file used to run models with 'live biopsy' samples as the reference category)

### Bash script

There is one bash script file, **vcf-gt-check.sh** which is used within the main code script to check for data integrity after converting VCFs to the matrix format required by InbreedR.

### Data files

The remaining files are data files; some are housed within sub-directories.

The mortality data from necropsies are found in **mortality_data.csv**.

**final-vcfs/** contains the two fully-filtered vcf files resulting from the two alpha stringecies used for variant discovery and genotype calling (0.01, 0.001):
- **0.01_fully_filtered.vcf.gz**
- **0.001_fully_filtered.vcf.gz** 

**inbreeding-coefficients/** contains four files:
- **0.01_vcftools.het** (F values calculated in VCFtools for the 0.01 dataset)
- **0.001_vcftools.het** (F values calculated in VCFtools for the 0.001 dataset)
- **GENHET_0.01_results.tsv** (GENHET results for calculating IR and HL using the 0.01 dataset)
- **GENHET_0.001_results.tsv** (GENHET results for calculating IR and HL using the 0.001 dataset)

Finally, **read-depth-stats/** contains two Stacks output files with per-sample read depth statistics, one for each alpha stringency dataset:
- **0.01_read-depth**
- **0.001_read-depth**
