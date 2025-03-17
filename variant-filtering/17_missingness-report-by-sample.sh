#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=missingness-report-per-sample
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

######################################################
#  use VCFtools to generate a report of missingness  #
#              per individual/sample                 #
######################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load vcftools/0.1.16

#--- for data set with alphas 0.01 ---#
vcftools --gzvcf ${PROJECTS}/variant-filtering/0.01_ExcludeMissing-60.recode.vcf.gz \
	--missing-indv \
	--out ${PROJECTS}/variant-filtering/0.01

#--- for data set wth alphas 0.001 ---#
vcftools --gzvcf ${PROJECTS}/variant-filtering/0.001_ExcludeMissing-60.recode.vcf.gz \
	--missing-indv \
	--out ${PROJECTS}/variant-filtering/0.001
