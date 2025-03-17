#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=vcf-stats
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --time=2:00:00

######################################################
#   use BCFtools to generate a report of stats for   #
#            the VCFs after filtering                #
# use VCFtools to assess mean depth per sample/site  #
#   and generate a report on missing data per site   #
######################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load StdEnv/2023
module load gcc/12.3
module load bcftools/1.19
module load vcftools/0.1.16

#--- make output directory ---#
mkdir ${PROJECTS}/variant-filtering/stats-post-missingness-filter
STATS_OUTPUT=${PROJECTS}/variant-filtering/stats-post-missingness-filter

#--- for the data set generated using 0.01 alphas ---#
bcftools stats --verbose \
	--samples - \
	${PROJECTS}/variant-filtering/0.01_missingness-refilter-20.vcf.gz \
	> ${STATS_OUTPUT}/0.01_postfilter.bcfstats

vcftools --gzvcf ${PROJECTS}/variant-filtering/0.01_missingness-refilter-20.vcf.gz \
	--depth \
	--out ${STATS_OUTPUT}/0.01-postfilter

vcftools --gzvcf ${PROJECTS}/variant-filtering/0.01_missingness-refilter-20.vcf.gz \
	--site-mean-depth \
	--out ${STATS_OUTPUT}/0.01-postfilter

vcftools --gzvcf ${PROJECTS}/variant-filtering/0.01_missingness-refilter-20.vcf.gz \
	--missing-site \
	--out ${STATS_OUTPUT}/0.01-postfilter


#--- for the data set generated using 0.001 alphas ---#
bcftools stats --verbose \
	--samples - \
	${PROJECTS}/variant-filtering/0.001_missingness-refilter-20.vcf.gz \
	> ${STATS_OUTPUT}/0.001_postfilter.bcfstats

vcftools --gzvcf ${PROJECTS}/variant-filtering/0.001_missingness-refilter-20.vcf.gz \
	--depth \
	--out ${STATS_OUTPUT}/0.001-postfilter

vcftools --gzvcf ${PROJECTS}/variant-filtering/0.001_missingness-refilter-20.vcf.gz \
	--site-mean-depth \
	--out ${STATS_OUTPUT}/0.001-postfilter

vcftools --gzvcf ${PROJECTS}/variant-filtering/0.001_missingness-refilter-20.vcf.gz \
	--missing-site \
	--out ${STATS_OUTPUT}/0.001-postfilter
