#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=remove-low-freq-variants
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=5G
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

##################################################
#  remove low frequency variants using VCFtools  #
##################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load vcftools/0.1.16

#--- mac = min. minor allele count, # of times that allele appears over all indv. at that site ---#
#--- maf = min. minor allele frequency, # of times an allele appears over all indv. at a site/total # non-missing alleles at the site ---#

# --- 0.01 ---#
vcftools --gzvcf ${PROJECTS}/variant-filtering/0.01_biallelic-snps_uniqueindv_alltags.vcf.gz \
	--mac 3 \
	--maf 0.01 \
	--recode --recode-INFO-all \
	--out ${PROJECTS}/variant-filtering/0.01_lowfreq-filtered

#--- 0.001 ---#
vcftools --gzvcf ${PROJECTS}/variant-filtering/0.001_biallelic-snps_uniqueindv_alltags.vcf.gz \
	--mac 3 \
	--maf 0.01 \
	--recode --recode-INFO-all \
	--out ${PROJECTS}/variant-filtering/0.001_lowfreq-filtered

#--- bgzip files; faster lookup/access time ---#
bgzip ${PROJECTS}/variant-filtering/0.01_lowfreq-filtered.recode.vcf
bgzip ${PROJECTS}/variant-filtering/0.001_lowfreq-filtered.recode.vcf
