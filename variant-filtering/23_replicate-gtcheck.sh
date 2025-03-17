#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=replicate-check
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=1G
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00

###################################################################
#   use BCFtools to compare genotypes of replicate sample pairs   #
#  (the sample set included replicate samples for 5 individuals)  #
###################################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load StdEnv/2023
module load gcc/12.3
module load bcftools/1.19

#--- make output directory ---#
mkdir ${PROJECTS}/variant-filtering/gtcheck

#--- 0.01 ---#
#--- output t = compressed text tab-delimited output ---#
bcftools gtcheck \
	--pairs Bel00470_FRA2297A15-6,Bel00470R_FRA2297A19-2,Bel00595_FRA2297A18-8,Bel00595R_FRA2297A22-6,Bel00711_FRA2297A10-3,Bel00711R_FRA2297A22-7,Bel00743_FRA2297A5-7,Bel00743R_FRA2297A17-8,Bel01211_FRA2297A1-2,Bel01211R_FRA2297A4-3 \
	--output-type t \
	--output ${PROJECTS}/variant-filtering/gtcheck/0.01_replicate-gtcheck.tsv \
	${PROJECTS}/variant-filtering/0.01_biallelic-snps.vcf.gz

#--- 0.001 ---#
bcftools gtcheck \
	--pairs Bel00470_FRA2297A15-6,Bel00470R_FRA2297A19-2,Bel00595_FRA2297A18-8,Bel00595R_FRA2297A22-6,Bel00711_FRA2297A10-3,Bel00711R_FRA2297A22-7,Bel00743_FRA2297A5-7,Bel00743R_FRA2297A17-8,Bel01211_FRA2297A1-2,Bel01211R_FRA2297A4-3 \
	--output-type t \
	--output ${PROJECTS}/variant-filtering/gtcheck/0.001_replicate-gtcheck.tsv \
	${PROJECTS}/variant-filtering/0.001_biallelic-snps.vcf.gz
