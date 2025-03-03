#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=mapping-BWA-MEM
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%A_%a.out
#SBATCH --array=1-178%10
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=15G
#SBATCH --time=0:45:00

############################################################
#  aligning/mapping cleaned reads to the reference genome  #
#                     using BWA-MEM                        #
############################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${PROJECTS}/raw/Q031409_beluga_ddRAD/samples.list)

#--- load the bwa module ---#
module load StdEnv/2023
module load bwa/0.7.18

#--- load samtools ---#
module load gcc/12.3
module load samtools/1.20

#--- align with bwa, then use samtools to convert to BAM and sort the alignments ---#
bwa mem -t 20 \
	${PROJECTS}/bwa/beluga_db \
	${PROJECTS}/cleaned/${SAMPLE}.1.fq.gz \
	${PROJECTS}/cleaned/${SAMPLE}.2.fq.gz | \
	samtools view --bam --with-header | \
	samtools sort \
	-o ${PROJECTS}/alignments/$SAMPLE.bam
