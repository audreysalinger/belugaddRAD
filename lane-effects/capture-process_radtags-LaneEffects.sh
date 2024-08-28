################################################
#    capture the Stacks process_radtags log    #
#  output for "per_file_raw_read_counts" into  #
#     a .tsv file that can be plotted in R     #
################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD/

module load StdEnv/2020
module load stacks/2.64

#--- for lane 1 ---#
cd ${PROJECTS}/lane-effects/cleaned/Lane1

#--- concatenate per sample read counts to the running .tsv ---#
for log_file in *.log;
do
	stacks-dist-extract $log_file per_file_raw_read_counts | tail -1 >> ../data-capture/raw_read_counts-LANE1.tsv
done


#--- for lane 2 ---#
cd ${PROJECTS}/lane-effects/cleaned/Lane2

#--- concatenate per sample read counts to the running .tsv ---#
for log_file in *.log;
do
	stacks-dist-extract $log_file per_file_raw_read_counts | tail -1 >> ../data-capture/raw_read_counts-LANE2.tsv
done
