#!/bin/bash

##################################
#  creating input data file for  #
#     qualimap multi-bamqc       #
##################################

###############################################
#  format needs to be tab-delimited columns:  #
#  * column 1 = sample name                   #
#  * column 2 = path to the bam file          #
###############################################

#--- start with sample names list ---#
cp ~/projects/def-frasiert/beluga-ddRAD/raw/Q031409_beluga_ddRAD/samples.list ~/projects/def-frasiert/beluga-ddRAD/alignments/qualimap_input

#--- copy column 1 to a second column ---#
awk -F, '{$1=$1"\t"$1}1' qualimap_input > temp.file

#--- add .bam to the end of each line ---#
sed 's/$/\.bam/' temp.file > qualimap_input

#--- remove temp file ---#
rm temp.file

#--- add a third column to indicate the whole library ---#
sed 's/$/\tWhole\-Library/' qualimap_input > temp.file
rm qualimap_input
mv temp.file qualimap_input
