#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=ref_map-0.001
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=50G
#SBATCH --cpus-per-task=10
#SBATCH --time=05:30:00

#############################################
#  running Stacks reference-based pipeline  #
#############################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load StdEnv/2023
module load stacks/2.67

#--- make output directory ---#
mkdir ~/scratch/stacks_ref/gt0.001

ref_map.pl \
	--samples ${PROJECTS}/alignments \
	--popmap ${PROJECTS}/popmap.tsv \
	--out-path ~/scratch/stacks_ref/gt0.001 \
	-T 8 \
	-X "populations: -r 0.8 --vcf-all" \
	-X "gstacks: --gt-alpha 0.001 --var-alpha 0.001 --details"

#--- rename vcf file ---#
cd ~/scratch/stacks_ref/gt0.001
mv populations.all.vcf gt0.001_initial.vcf

#--- zip vcf file ---#
gzip gt0.001_initial.vcf
