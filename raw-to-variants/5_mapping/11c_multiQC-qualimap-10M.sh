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

#-------------------------------------- -------#
#  use MultiQC v1.21 to compile whole library  #
#   Qualimap results into one html report      #
#----------------------------------------------#

#--- first move the _stats files from alignments to a scratch directory ---#

mkdir ~/scratch/qualimap-10M-whole-library

PROJECTS=~/projects/def-frasiert/beluga-ddRAD
cp -r ${PROJECTS}/alignments/*_stats ~/scratch/qualimap-10M-whole-library

#----------------------------------------#
#  activate virtual environment to load  #
#   python and have MultiQC available    #
#----------------------------------------#
source ~/ddrad_venv/bin/activate

mkdir ${PROJECTS}/QC/mapping-10M-scaffolds/multiqc
mkdir ${PROJECTS}/QC/mapping-10M-scaffolds/multiqc/whole-library

multiqc ~/scratch/qualimap-10M-whole-library \
	--outdir ${PROJECTS}/QC/mapping-10M-scaffolds/multiqc/whole-library \
	&> ~/scratch/logs/mapping-10M/multiqc-qualimap.oe
