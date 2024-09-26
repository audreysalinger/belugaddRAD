#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=multiQC-mapping-stats
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=5
#SBATCH --time=00:30:00

#######################################
#     mapping quality assessment:     #
#  running MultiQC on Qualimap files  #
#######################################

#-----------------------------------------------------#
#  use MultiQC v1.21 to compile all Qualimap results  #
#                 into one html report                #
#-----------------------------------------------------#

#----------------------------------------#
#  activate virtual environment to load  #
#   python and have MultiQC available    #
#----------------------------------------#
source ~/ddrad_venv/bin/activate

multiqc ~/scratch/qualimap-samples-separate \
	--outdir ~/projects/def-frasiert/beluga-ddRAD/QC/mapping/multiqc \
	&> ~/scratch/logs/mapping/multiqc/multiqc-qualimap.oe
