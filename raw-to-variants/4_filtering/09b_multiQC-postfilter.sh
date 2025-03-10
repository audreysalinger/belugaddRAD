#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=multiQC-postfilter
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=5
#SBATCH --time=00:30:00

########################################
#  quality assessment post-filtering:  #
#   running MultiQC on FastQC files    #
########################################

#---------------------------------------------------#
#  use MultiQC v1.21 to compile all FastQC results  #
#                into one html report               #
#---------------------------------------------------#

#----------------------------------------#
#  activate virtual environment to load  #
#   python and have MultiQC available    #
#----------------------------------------#
source ~/ddrad_venv/bin/activate

multiqc ~/projects/def-frasiert/beluga-ddRAD/QC/post-filtering/fastqc-postfilter \
	--outdir ~/projects/def-frasiert/beluga-ddRAD/QC/post-filtering/multiqc/removing-adapter \
	&> ~/scratch/logs/multiqc/multiqc-adapter-removed.oe

deactivate
