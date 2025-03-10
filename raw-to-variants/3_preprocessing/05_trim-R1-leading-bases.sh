#!/bin/bash
#SBATCH --account=def-frasiert
#SBATCH --job-name=trim-R1-array
#SBATCH --mail-user=audrey.salinger@smu.ca
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=%x-%A_%a.out
#SBATCH --array=1-178%10
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=10G
#SBATCH --time=01:00:00

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

echo "Starting task $SLURM_ARRAY_TASK_ID"

#--- set the sample directory to line #task_id of the directories list ---#
#--- print line number N of a particular file with sed -n "Np" <file> ---#
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${PROJECTS}/raw/Q031409_beluga_ddRAD/samples.list)


###################################
#  trimming leading bases on R1s  #
###################################

###############################################
#  remove leading C bases left on some reads  #
#   from sequencing centre adapter trimming   #
#               using cutadapt                #
###############################################

#--- activate virtual environment with cutadapt installed ---#
source ~/ddrad_venv/bin/activate

#--- run cutadapt on R1s ---#
cutadapt -g ^C \
	-o ~/scratch/trimC/${SAMPLE}'.fastq.gz' \
	${PROJECTS}/raw/Q031409_beluga_ddRAD/both-lanes/${SAMPLE}'_L001_R1_001.fastq.gz' \
	&> ~/scratch/trimC/${SAMPLE}.trimC.oe

#--- deactivate virtual environment ---#
deactivate


####################################################
#   use Trimmomatic to remove leading N uncalled   #
#  bases on some reads due to Illumina sequencing  #
#                    artifact                      #
####################################################

#--- load java ---#
module load java/21.0.1

#--- run trimmomatic to trim leading N ---#
java -Xmx8G -jar ~/projects/def-frasiert/beluga-ddRAD/java/trimmomatic-0.39.jar SE \
-threads 12 \
-trimlog ${PROJECTS}/trimN_logs/${SAMPLE}.trimN.log \
~/scratch/trimC/${SAMPLE}'.fastq.gz' \
~/scratch/trimmed-R1/${SAMPLE}'_S'${SLURM_ARRAY_TASK_ID}'_L001_R1_001.fastq.gz' \
LEADING:3 &> ${PROJECTS}/trimN_logs/${SAMPLE}.trimN.oe


#--- move trimmed reads into a directory from which to run Stacks ---#
mkdir ~/scratch/stacks-input
cp ~/scratch/trimmed-R1/Bel0* ~/scratch/stacks-input/
