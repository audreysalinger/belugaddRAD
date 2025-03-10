#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=bwa-index-subset
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mem-per-cpu=5G
#SBATCH --cpus-per-task=2
#SBATCH --time=1:00:00

genome_fa=~/scratch/ref-genome/ASM228892v2_HiC.fasta.gz

cd ~/scratch/ref-genome/bwa

module load bwa/0.7.18

bwa index $genome_fa \
	-p ~/scratch/ref-genome/bwa/beluga_db \
	&> ~/scratch/ref-genome/bwa/bwa_index.oe
