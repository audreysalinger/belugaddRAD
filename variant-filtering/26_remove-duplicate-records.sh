#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=remove-duplicate-records
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=5G
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00


PROJECTS=~/projects/def-frasiert/beluga-ddRAD


######################################################
#  retain only the first instance where a record is  #
#     present multiple times using BCFtools norm     #
######################################################

module load StdEnv/2023
module load gcc/12.3
module load bcftools/1.19

#--- 0.01 ---#
bcftools norm --rm-dup all \
	${PROJECTS}/variant-filtering/0.01_lowfreq-filtered.recode.vcf.gz \
	--output-type z \
	--output ${PROJECTS}/variant-filtering/0.01_fully_filtered.vcf.gz

#--- 0.001 ---#
bcftools norm --rm-dup all \
	${PROJECTS}/variant-filtering/0.001_lowfreq-filtered.recode.vcf.gz \
	--output-type z \
	--output ${PROJECTS}/variant-filtering/0.001_fully_filtered.vcf.gz


####################################################
#  use BCFtools to generate a report of stats for  #
#     the VCFs after removing duplicate sites      #
####################################################

#--- 0.01 ---#
bcftools stats \
	${PROJECTS}/variant-filtering/0.01_fully_filtered.vcf.gz \
	> ${PROJECTS}/variant-filtering/0.01_fully-filtered.stats

#--- 0.001 ---#
bcftools stats \
	${PROJECTS}/variant-filtering/0.001_fully_filtered.vcf.gz \
	> ${PROJECTS}/variant-filtering/0.001_fully-filtered.stats

#--- copy final stats reports to log extracts directory ---#
cp ${PROJECTS}/variant-filtering/0.01_fully-filtered.stats ${PROJECTS}/log-extracts/variant-filtering/
cp ${PROJECTS}/variant-filtering/0.001_fully-filtered.stats ${PROJECTS}/log-extracts/variant-filtering/
