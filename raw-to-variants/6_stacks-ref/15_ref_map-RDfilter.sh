#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=ref_map-RDfilter
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=50G
#SBATCH --cpus-per-task=10
#SBATCH --time=12:00:00

###############################################################
#  re-running Stacks reference-based pipeline after removing  #
#                samples with read depth < 5X:                #
#         using two alpha stringencies, 0.01 and 0.001        #
###############################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load StdEnv/2023
module load stacks/2.67

#--- make output directories ---#
mkdir ~/scratch/stacks_ref/postRDfilter
mkdir ~/scratch/stacks_ref/postRDfilter/gt0.01
mkdir ~/scratch/stacks_ref/postRDfilter/gt0.001

#-----------------------------------------------------------------#
#  use the mean coverage values in the gstacks.log.distribs file  #
#             from the initial stacks ref_map.pl run              #
#       to create a new popmap filtered for read depth > 5X       #
#-----------------------------------------------------------------#

tail -n 383 ~/scratch/stacks_ref/gt0.01/gstacks.log.distribs | head -n 179 | awk '($4 > 5){print $1}' \
	> ~/scratch/stacks_ref/postRDfilter/popmap-RDfilter.tsv

#--- add a new column to indicate SLE population ---#
sed -i 's/$/\tSLE/' ~/scratch/stacks_ref/postRDfilter/popmap-RDfilter.tsv

#--- run stacks with alphas 0.01---#
ref_map.pl \
	--samples ${PROJECTS}/alignments \
	--popmap ~/scratch/stacks_ref/postRDfilter/popmap-RDfilter.tsv \
	--out-path ~/scratch/stacks_ref/postRDfilter/gt0.01 \
	-T 8 \
	-X "populations: -r 0.8 --vcf-all" \
	-X "gstacks: --gt-alpha 0.01 --var-alpha 0.01 --details"

#--- run stacks with alphas 0.001---#
ref_map.pl \
	--samples ${PROJECTS}/alignments \
	--popmap ~/scratch/stacks_ref/postRDfilter/popmap-RDfilter.tsv \
	--out-path ~/scratch/stacks_ref/postRDfilter/gt0.001 \
	-T 8 \
	-X "populations: -r 0.8 --vcf-all" \
	-X "gstacks: --gt-alpha 0.001 --var-alpha 0.001 --details"

#--- rename & zip vcf files ---#
cd ~/scratch/stacks_ref/postRDfilter/gt0.01
mv populations.all.vcf gt0.01_RDfilter_initial.vcf
gzip gt0.01_RDfilter_initial.vcf

cd ~/scratch/stacks_ref/postRDfilter/gt0.001
mv populations.all.vcf gt0.001_RDfilter_initial.vcf
gzip gt0.001_RDfilter_initial.vcf

#--- copy outputs to projects directory ---#
mkdir ${PROJECTS}/stacks-output
mkdir ${PROJECTS}/stacks-output/with-RD-filter

cp -r ~/scratch/stacks_ref/postRDfilter/gt0.01 ${PROJECTS}/stacks-output/with-RD-filter
cp -r ~/scratch/stacks_ref/postRDfilter/gt0.001 ${PROJECTS}/stacks-output/with-RD-filter
