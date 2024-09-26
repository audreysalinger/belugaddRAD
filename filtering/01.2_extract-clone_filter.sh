#!/bin/bash

#######################################################
#  grep to extract clone_filter data for each sample  #
#######################################################

touch ../clone_filter-extract.txt

for file in Bel*;
do
	echo "$file" > temp.txt
	
	grep --only-matching -e "[0-9]\+ pairs of reads output" -e "[0-9][0-9].[0-9][0-9]% clone reads" $file >> temp.txt
	
	paste -s temp.txt >> ../clone_filter-extract.txt
	
done

rm temp.txt
