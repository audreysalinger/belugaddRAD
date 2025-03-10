#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=process_radtags-for-lane-effects
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --array=1-178
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00

#---------------------------------------------------#
#  using Stacks process_radtags to clean the data,  #
#    removing reads with uncalled or low-quality    #
#   bases and assessing differences between lanes   #
#---------------------------------------------------#

module load StdEnv/2020
module load stacks/2.64

PROJECTS=~/projects/def-frasiert/beluga-ddRAD


#--- set the sample directory to the first sample in directory.list ---#
#--- print line number N of a particular file with sed -n "Np" <file> ---#
SAMPLE_DIR=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${PROJECTS}/raw/Q031409_beluga_ddRAD/directory.list)

#--- start with Lane 1 ---#
process_radtags \
	--in-path ${PROJECTS}/raw/Q031409_beluga_ddRAD/Lane1/${SAMPLE_DIR} \
	--out-path ${PROJECTS}/lane-effects/cleaned/Lane1 \
	--paired \
	--clean \
	--quality \
	--discards \
	--disable-rad-check \
	&> ${PROJECTS}/lane-effects/cleaned/Lane1/process_radtags.${SAMPLE_DIR}.oe

#--- then do the same for Lane 2 ---#
process_radtags \
	--in-path ${PROJECTS}/raw/Q031409_beluga_ddRAD/Lane2/${SAMPLE_DIR} \
	--out-path ${PROJECTS}/lane-effects/cleaned/Lane2 \
	--paired \
	--clean \
	--quality \
	--discards \
	--disable-rad-check \
	&> ${PROJECTS}/lane-effects/cleaned/Lane2/process_radtags.${SAMPLE_DIR}.oe
