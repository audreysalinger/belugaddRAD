#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=qualimap-10M
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --cpus-per-task=20
#SBATCH --mem-per-cpu=20G
#SBATCH --time=02:00:00

#################################################
#  using Qualimap to assess mapping statistics  #
#  for reads now aligned to scaffolds >10M bp   #
#################################################

cd ~/projects/def-frasiert/beluga-ddRAD/alignments

#--- load java ---#
module load java/21.0.1

#--- run qualimap ---#
~/projects/def-frasiert/beluga-ddRAD/java/qualimap_v2.3/qualimap \
	multi-bamqc \
	--data ./qualimap_input \
	-outdir ../QC/mapping-10M-scaffolds/qualimap_10M \
	-nr 10000 \
	--run-bamqc \
	--java-mem-size=8G \
	&> ~/scratch/logs/mapping-10M/qualimap/qualimap-10M.oe
