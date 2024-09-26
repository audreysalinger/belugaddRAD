#!/bin/bash

######################################################
#  extract process_radtags log data for each sample  #
######################################################

module load stacks/2.67

stacks-dist-extract Bel00001_FRA2297A22-1.log per_file_raw_read_counts | head -n 1 > ~/scratch/logs/process_radtags-NoAdapter-stats.tsv

for log_file in *.log;
do
	 stacks-dist-extract $log_file per_file_raw_read_counts | tail -n 1 >> ~/scratch/logs/process_radtags-NoAdapter-stats.tsv
done
