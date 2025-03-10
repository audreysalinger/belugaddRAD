#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=qualimap-subset
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --cpus-per-task=20
#SBATCH --mem-per-cpu=10G
#SBATCH --time=04:00:00


#-----------------------------------------------#
#  using Qualimap to assess mapping statistics  #
#  of the 20-sample subset to see if there are  #
#                lane differences               #
#-----------------------------------------------#

cd ~/scratch

#--- load java ---#
module load java/21.0.1

#--- run qualimap ---#
~/projects/def-frasiert/beluga-ddRAD/java/qualimap_v2.3/qualimap \
	multi-bamqc \
	--data 	./qualimap-subset/qualimap_input-subset \
	-outdir ./qualimap-subset \
	-nr 10000 \
	--run-bamqc \
	--java-mem-size=8G
