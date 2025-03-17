#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=stats-norepeats
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00

####################################################
#  use BCFtools to generate a report of stats for  #
#    the VCFs after removing repetitive regions    #
####################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load StdEnv/2023
module load gcc/12.3
module load bcftools/1.19

#--- make output directory ---#
mkdir ${PROJECTS}/variant-filtering/stats-for-norepeats
STATS_OUTPUT=${PROJECTS}/variant-filtering/stats-for-norepeats

#--- for the datset generated using 0.01 alphas ---#
bcftools stats --verbose \
	${PROJECTS}/variant-filtering/0.01_filtered-sorted-norepeat.vcf.gz \
	> ${STATS_OUTPUT}/0.01_norepeats.bcfstats

#--- for the datset generated using 0.001 alphas ---#
bcftools stats --verbose \
	${PROJECTS}/variant-filtering/0.001_filtered-sorted-norepeat.vcf.gz \
	> ${STATS_OUTPUT}/0.001_norepeats.bcfstats
