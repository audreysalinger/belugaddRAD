#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=remove-replicate-samples-and-fill-tags
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem=100M
#SBATCH --time=00:01:00


PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load StdEnv/2023
module load gcc/12.3
module load bcftools/1.19


###################################################################
#  use BCFtools to remove the 5 replicate samples from the VCFs:  #
#   comma-separated list of samples to exclude prefixed with ^    #
###################################################################

#--- 0.01 ---#
bcftools view \
	--samples ^Bel00470R_FRA2297A19-2,Bel00595R_FRA2297A22-6,Bel00711R_FRA2297A22-7,Bel00743R_FRA2297A17-8,Bel01211R_FRA2297A4-3 \
	--output-type z \
	--output ${PROJECTS}/variant-filtering/0.01_biallelic-snps_uniqueindv.vcf.gz \
	${PROJECTS}/variant-filtering/0.01_biallelic-snps.vcf.gz

#--- 0.001 ---#
bcftools view \
	--samples ^Bel00470R_FRA2297A19-2,Bel00595R_FRA2297A22-6,Bel00711R_FRA2297A22-7,Bel00743R_FRA2297A17-8,Bel01211R_FRA2297A4-3 \
	--output-type z \
	--output ${PROJECTS}/variant-filtering/0.001_biallelic-snps_uniqueindv.vcf.gz \
	${PROJECTS}/variant-filtering/0.001_biallelic-snps.vcf.gz


##########################################################################
#  use BCFtools +fill-tags plugin to compute and fill various INFO tags  #
#                option -- -t all fills all available tags               #
##########################################################################

#--- 0.01 ---#
bcftools +fill-tags \
	${PROJECTS}/variant-filtering/0.01_biallelic-snps_uniqueindv.vcf.gz \
	--output-type z \
	--output ${PROJECTS}/variant-filtering/0.01_biallelic-snps_uniqueindv_alltags.vcf.gz \
	-- -t all

#--- 0.001 ---#
bcftools +fill-tags \
	${PROJECTS}/variant-filtering/0.001_biallelic-snps_uniqueindv.vcf.gz \
	--output-type z \
	--output ${PROJECTS}/variant-filtering/0.001_biallelic-snps_uniqueindv_alltags.vcf.gz \
	-- -t all


###################################################################
#  use BCFtools to generate a report of stats for resulting VCFs  #
###################################################################

#--- make output directory ---#
mkdir ${PROJECTS}/variant-filtering/stats-uniqueindv
STATS_OUTPUT=${PROJECTS}/variant-filtering/stats-uniqueindv

#--- 0.01 ---#
bcftools stats --verbose \
	${PROJECTS}/variant-filtering/0.01_biallelic-snps_uniqueindv.vcf.gz \
	> ${STATS_OUTPUT}/0.01_uniqueindv.bcfstats

bcftools stats --verbose \
	${PROJECTS}/variant-filtering/0.01_biallelic-snps_uniqueindv_alltags.vcf.gz\
	> ${STATS_OUTPUT}/0.01_uniqueindv-withtags.bcfstats

#--- 0.001 ---#
bcftools stats --verbose \
	${PROJECTS}/variant-filtering/0.001_biallelic-snps_uniqueindv.vcf.gz \
	> ${STATS_OUTPUT}/0.001_uniqueindv.bcfstats

bcftools stats --verbose \
	${PROJECTS}/variant-filtering/0.001_biallelic-snps_uniqueindv_alltags.vcf.gz\
	> ${STATS_OUTPUT}/0.001_uniqueindv-withtags.bcfstats
