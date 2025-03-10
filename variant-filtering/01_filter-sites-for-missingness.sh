#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=filter-sites-for-missing-data
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

################################################
#  use VCFtools to exclude sites on the basis  #
#      of the proportion of missing data       #
################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load vcftools/0.1.16

#--- make output directory ---#
mkdir ${PROJECTS}/variant-filtering

#--- using vcf generated with 0.01 alpha values ---#
vcftools --gzvcf ${PROJECTS}/stacks-output/with-RD-filter/gt0.01/gt0.01_RDfilter_initial.vcf.gz \
         --max-missing 0.6 \
         --out ${PROJECTS}/variant-filtering/0.01_ExcludeMissing-60 \
         --recode \
         --recode-INFO-all

#--- using vcf generated with 0.001 alpha values ---#
vcftools --gzvcf ${PROJECTS}/stacks-output/with-RD-filter/gt0.001/gt0.001_RDfilter_initial.vcf.gz \
         --max-missing 0.6 \
         --out ${PROJECTS}/variant-filtering/0.001_ExcludeMissing-60 \
         --recode \
         --recode-INFO-all

#--- zip output files ---#
gzip ${PROJECTS}/variant-filtering/0.01_ExcludeMissing-60.recode.vcf
gzip ${PROJECTS}/variant-filtering/0.001_ExcludeMissing-60.recode.vcf
