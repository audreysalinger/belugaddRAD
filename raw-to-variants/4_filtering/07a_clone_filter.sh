#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=clone_filter-array
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%A_%a.out
#SBATCH --array=40,41,42,43,33
#SBATCH --mem-per-cpu=20G
#SBATCH --cpus-per-task=10
#SBATCH --time=03:00:00

######################################################
#  using Stacks clone_filter to identify and remove  #
#  PCR duplicates based on degenerate base sequence  #
#                  at the start of R2                #
######################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${PROJECTS}/raw/Q031409_beluga_ddRAD/samples.list)

module load StdEnv/2023
module load stacks/2.66

clone_filter \
	-1 ~/scratch/stacks-input/${SAMPLE}*'R1'* \
	-2 ~/scratch/stacks-input/${SAMPLE}*'R2'* \
	-i gzfastq \
	-o ~/scratch/clone_filtered \
	-D \
	--null-inline \
	--oligo_len_2 10 \
	&> ~/scratch/logs/clone_filter/${SAMPLE}.clone_filter.oe
