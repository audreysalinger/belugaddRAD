#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=fastQC-postfilter
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%A_%a.out
#SBATCH --array=1-178%10
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

################################################
#  use FastQC to re-assess read quality after  #
#            cleaning and filtering            #
################################################

module load StdEnv/2023
module load fastqc/0.12.1

PROJECTS=~/projects/def-frasiert/beluga-ddRAD
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${PROJECTS}/raw/Q031409_beluga_ddRAD/samples.list)

fastqc ${PROJECTS}/cleaned/${SAMPLE}.1.fq.gz ${PROJECTS}/cleaned/${SAMPLE}.2.fq.gz \
	--outdir ${PROJECTS}/QC/post-filtering/fastqc-postfilter \
	--noextract \
	&> ~/scratch/logs/fastqc/${SAMPLE}.fastqc.oe
