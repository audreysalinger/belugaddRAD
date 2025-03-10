#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=ref_map-0.01
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=50G
#SBATCH --cpus-per-task=10
#SBATCH --time=5:00:00

################################################################
#  running Stacks reference-based pipeline with alphas = 0.01  #
################################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load StdEnv/2023
module load stacks/2.67

#--- make output directory ---#
mkdir ~/scratch/stacks_ref/gt0.01

#--- run stacks ---#
ref_map.pl \
	--samples ${PROJECTS}/alignments \
	--popmap ${PROJECTS}/popmap.tsv \
	--out-path ~/scratch/stacks_ref/gt0.01 \
	-T 8 \
	-X "populations: -r 0.8 --vcf-all" \
	-X "gstacks: --gt-alpha 0.01 --var-alpha 0.01 --details"

#--- rename vcf file ---#
cd ~/scratch/stacks_ref/gt0.01
mv populations.all.vcf gt0.01_initial.vcf

#--- zip vcf file ---#
gzip gt0.01_initial.vcf
