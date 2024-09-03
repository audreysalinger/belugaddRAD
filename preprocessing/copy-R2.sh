#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=copy-R2s
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%A_%a.out
#SBATCH --array=2-178%10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=5G
#SBATCH --time=00:05:00

#################################################
#  copy and rename the R2 fastq file for each  #
#   sample to a scratch directory that will    #
#   be used as Stacks input for clone_filter   #
#################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${PROJECTS}/raw/Q031409_beluga_ddRAD/samples.list)

cp ${PROJECTS}/raw/Q031409_beluga_ddRAD/both-lanes/${SAMPLE}"_L001_R2_001.fastq.gz" \
	~/scratch/stacks-input/${SAMPLE}"_S"${SLURM_ARRAY_TASK_ID}"_L001_R2_001.fastq.gz"
