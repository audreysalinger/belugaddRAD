#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=concatenate-lanes
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%j.out
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=10G
#SBATCH --time=02:00:00

cd ~/projects/def-frasiert/beluga-ddRAD/raw/Q031409_beluga_ddRAD

#-----------------------------#
#  loop through samples list  #
#-----------------------------#
for sample in $(<samples.list);
do
	
	echo "$sample"
	
	#--- concatenate R1 files from Lanes 1 and 2, retaining Illumina naming scheme ---#
	cat Lane1/Sample_$sample/$sample*'_L002_R1_001'.fastq.gz Lane2/Sample_$sample/$sample*'_L003_R1_001'.fastq.gz \
	> both-lanes/$sample'_L001_R1_001'.fastq.gz
	
	#--- print number of lines for original R1 files and new combined R1 files ---#
	wc -l Lane1/Sample_$sample/$sample*'_L002_R1_001'.fastq.gz
	wc -l Lane2/Sample_$sample/$sample*'_L003_R1_001'.fastq.gz
	wc -l both-lanes/$sample'_L001_R1_001'.fastq.gz
	
	#--- concatenate R2 files from Lanes 1 and 2, retaining Illumina naming scheme ---#
	cat Lane1/Sample_$sample/$sample*'_L002_R2_001'.fastq.gz Lane2/Sample_$sample/$sample*'_L003_R2_001'.fastq.gz \
	> both-lanes/$sample'_L001_R2_001'.fastq.gz
	
	#--- print number of lines for originals R2 files and new combined R2 files ---#
	wc -l Lane1/Sample_$sample/$sample*'_L002_R2_001'.fastq.gz
	wc -l Lane2/Sample_$sample/$sample*'_L003_R2_001'.fastq.gz
	wc -l both-lanes/$sample'_L001_R2_001'.fastq.gz
	
done
