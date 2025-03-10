#!/bin/bash

#############################################
#  grep to extract process_radtags data on  #
#   properly paired reads for each sample   #
#############################################

touch ~/projects/def-frasiert/beluga-ddRAD/log-extracts/paired-stats.tsv

for log_file in *.log;
do
	echo "$log_file" > temp.txt

	grep "Properly Paired" $log_file >> temp.txt

	paste -s temp.txt >> ~/projects/def-frasiert/beluga-ddRAD/log-extracts/paired-stats.tsv
done

rm temp.txt
