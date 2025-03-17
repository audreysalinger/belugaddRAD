#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=remove-repetitive-regions
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=25G
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00


PROJECTS=~/projects/def-frasiert/beluga-ddRAD


###############################
#  sort the VCFs by position  #
###############################

module load StdEnv/2023
module load gcc/12.3
module load bcftools/1.19

#--- alpha 0.01 ---#
#--- output type z = compressed VCF ---#
bcftools sort \
	--output-type z \
	--output ${PROJECTS}/variant-filtering/0.01_filtered-sorted.vcf.gz \
	${PROJECTS}/variant-filtering/0.01_missingness-refilter-20.vcf.gz

#--- alpha 0.001 ---#
bcftools sort \
	--output-type z \
	--output ${PROJECTS}/variant-filtering/0.001_filtered-sorted.vcf.gz \
	${PROJECTS}/variant-filtering/0.001_missingness-refilter-20.vcf.gz


###################################################################
#  remove repetitive regions identified by the RepeatMasker file  #
###################################################################

#--- RepeatMasker file was downloaded on 29 October 2024 from the DNAZoo reference genome repository ---#
#--- https://dnazoo.s3.wasabisys.com/index.html?prefix=Delphinapterus_leucas/ ---#

module load bedtools/2.31.0

#--- -v = only report those entries in A that are not in (have no overlaps with) B ---#
#--- -wa = write the original entry in A for each overlap, keeping only entries from A ---#
#--- -header = retain the header from the A file in the output ---#

#--- 0.01 ---#
bedtools intersect -v \
	-a ${PROJECTS}/variant-filtering/0.01_filtered-sorted.vcf.gz \
	-b ${PROJECTS}/ref-genome/ASM228892v2_HiC.repeatmasker.trf.windowmasker.gff.gz \
	-wa \
	-header \
	> ${PROJECTS}/variant-filtering/0.01_filtered-sorted-norepeat.vcf.gz

#--- 0.001 ---#
bedtools intersect -v \
	-a ${PROJECTS}/variant-filtering/0.001_filtered-sorted.vcf.gz \
	-b ${PROJECTS}/ref-genome/ASM228892v2_HiC.repeatmasker.trf.windowmasker.gff.gz \
	-wa \
	-header \
	> ${PROJECTS}/variant-filtering/0.001_filtered-sorted-norepeat.vcf.gz
