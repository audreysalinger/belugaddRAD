#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=biallelic-snps
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

################################################
#  use BCFtools to retain only biallelic SNPs  #
#   and remove invariant sites from the VCFs   #
################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load StdEnv/2023
module load gcc/12.3
module load bcftools/1.19

#--- 0.01 ---#
bcftools view \
	--min-alleles 2 \
	--max-alleles 2 \
	--types snps \
	--output-type z \
	--output ${PROJECTS}/variant-filtering/0.01_biallelic-snps.vcf.gz \
	${PROJECTS}/variant-filtering/0.01_filtered-sorted-norepeat.vcf.gz

#--- 0.001 ---#
bcftools view \
	--min-alleles 2 \
	--max-alleles 2 \
	--types snps \
	--output-type z \
	--output ${PROJECTS}/variant-filtering/0.001_biallelic-snps.vcf.gz \
	${PROJECTS}/variant-filtering/0.001_filtered-sorted-norepeat.vcf.gz
