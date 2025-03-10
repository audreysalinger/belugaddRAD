#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=bwa-index-10M
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=5G
#SBATCH --cpus-per-task=2
#SBATCH --time=1:00:00

PROJECTS=~/projects/def-frasiert/beluga-ddRAD
genome_fa=${PROJECTS}/ref-genome/ASM228892v2_HiC_10M-bp.fasta.gz

module load bwa/0.7.18

bwa index $genome_fa \
	-p ~/scratch/bwa/beluga_db \
	&> ~/scratch/bwa/logs/bwa_index.oe

#--- copy the bwa directory to projects ---#
cp -r ~/scratch/bwa/ ${PROJECTS}/
