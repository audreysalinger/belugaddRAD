#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=initial_multiqc
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=5
#SBATCH --time=4:00:00

#------------------------------------------#
#  initial quality assessment with FastQC  #
#               and MultiQC                #
#------------------------------------------#

#--- FastQC is a Java app which provides a QC report that can be used to ensure the raw data looks good ---#
#--- FastQC html files provided for each read by the sequencing centre have been copied to the QC directory ---#
#--- MultiQC aggregates results from bioinformatics analyses across many samples into a single report ---#

#---------------------------------------------------#
#  use MultiQC v1.21 to compile all FastQC results  #
#         into one html report for each lane        #
#---------------------------------------------------#

#--- from the beluga-ddRAD projects directory ---#
#--- move into the directory for Lane1 and run MultiQC ---#
cd QC/Lane1

#----------------------------------------#
#  activate virtual environment to load  #
#   python and have MultiQC available    #
#----------------------------------------#
source ~/ddrad_venv/bin/activate
multiqc .

#--- then move into the QC/Lane2 directory and run MultiQC ---#
cd ../Lane2
multiqc .
