#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=subset-map-bwa-mem
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --array=2-20%10
#SBATCH --cpus-per-task=20
#SBATCH --mem-per-cpu=15G
#SBATCH --time=02:30:00


#-----------------------------------------------------#
#  mapping a subset of 20 samples to the reference    #
#  genome with lanes 1 and 2 separate, in order to    #
#  assess any differences in mapping success between  #
#  lanes                                              #
#-----------------------------------------------------#

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

echo "Starting task $SLURM_ARRAY_TASK_ID"

#--- set the sample directory to line #task_id of the directories list ---#
#--- print line number N of a particular file with sed -n "Np" <file> ---#
SAMPLE_DIR=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${PROJECTS}/raw/Q031409_beluga_ddRAD/directory.list)
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${PROJECTS}/raw/Q031409_beluga_ddRAD/samples.list)

#--- load the bwa module ---#
module load StdEnv/2023
module load bwa/0.7.18

#--- load samtools ---#
module load gcc/12.3
module load samtools/1.20

#--- start with lane 1 ---#
bwa mem -t 20 \
	~/scratch/ref-genome/bwa/beluga_db \
	${PROJECTS}/raw/Q031409_beluga_ddRAD/Lane1/${SAMPLE_DIR}/$SAMPLE*'_L002_R1_001'.fastq.gz \
	${PROJECTS}/raw/Q031409_beluga_ddRAD/Lane1/${SAMPLE_DIR}/$SAMPLE*'_L002_R2_001'.fastq.gz | \
	samtools view -b -h | \
	samtools sort \
	-o ~/scratch/alignments/$SAMPLE-L002.bam

#--- lane 2 ---#
bwa mem -t 20 \
	~/scratch/ref-genome/bwa/beluga_db \
	${PROJECTS}/raw/Q031409_beluga_ddRAD/Lane2/${SAMPLE_DIR}/$SAMPLE*'_L003_R1_001'.fastq.gz \
	${PROJECTS}/raw/Q031409_beluga_ddRAD/Lane2/${SAMPLE_DIR}/$SAMPLE*'_L003_R2_001'.fastq.gz | \
	samtools view -b -h | \
	samtools sort \
	-o ~/scratch/alignments/$SAMPLE-L003.bam
