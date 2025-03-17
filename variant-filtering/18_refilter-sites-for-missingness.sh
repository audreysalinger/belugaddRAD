#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=refilter-sites-for-missingness-20
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --time=00:25:00

###########################################################
#     use BCFtools to again exclude sites on the basis    #
#  of the proportion of missing data, this time removing  #
#            sites with >20% missing genotypes            #
###########################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load StdEnv/2023
module load gcc/12.3
module load bcftools/1.19

#--- alpha 0.01 ---#
#--- output type z = compressed VCF ---#
bcftools view --exclude 'F_MISSING>0.2' \
	--output-type z \
	--output ${PROJECTS}/variant-filtering/0.01_missingness-refilter-20.vcf.gz \
	${PROJECTS}/variant-filtering/0.01_ExcludeMissing-60.recode.vcf.gz

#--- alpha 0.001 ---#
bcftools view --exclude 'F_MISSING>0.2' \
	--output-type z \
	--output ${PROJECTS}/variant-filtering/0.001_missingness-refilter-20.vcf.gz \
	${PROJECTS}/variant-filtering/0.001_ExcludeMissing-60.recode.vcf.gz
