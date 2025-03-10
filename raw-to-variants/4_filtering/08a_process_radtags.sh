#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=process_radtags
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%A_%a.out
#SBATCH --array=1-178%10
#SBATCH --mem-per-cpu=20G
#SBATCH --cpus-per-task=5
#SBATCH --time=00:30:00

#####################################################
#  using Stacks process_radtags to clean the data:  #
#    removing reads with uncalled or low-quality    #
#      bases or poly g runs and filtering reads     #
#    without a RE remnant cut site sequence after   #
#                        rescue                     #
#              ALSO FILTERING OUT NEXTERA           #
#   TRANSPOSASE SEQUENCE FROM ADAPTER READ-THROUGH  #
#####################################################

module load StdEnv/2023
module load stacks/2.67

PROJECTS=~/projects/def-frasiert/beluga-ddRAD
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${PROJECTS}/raw/Q031409_beluga_ddRAD/samples.list)

process_radtags \
	-1 ~/scratch/clone_filtered/${SAMPLE}*R1_001.1.fq.gz \
	-2 ~/scratch/clone_filtered/${SAMPLE}*R2_001.2.fq.gz \
	--out-path ${PROJECTS}/cleaned \
	--basename ${SAMPLE} \
	--clean \
	--quality \
	--score-limit 20 \
	--force-poly-g-check \
	--discards \
	--rescue \
	--renz-1 nsiI \
	--renz-2 nlaIII \
	--adapter-1 CTGTCTCTTATACACATCTCCGAGCCCACGAGAC \
	--adapter-2 CTGTCTCTTATACACATCTGACGCTGCCGACGA \
	--adapter-mm 2 \
	&> ~/scratch/logs/process_radtags/${SAMPLE}.process_radtags.oe
