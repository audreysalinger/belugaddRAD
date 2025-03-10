#!/bin/bash

##################################
#  creating input data file for  #
#     qualimap multi-bamqc       #
##################################

#################################################
#  format needs to be 3 tab-delimited columns:  #
#  * column 1 = sample name                     #
#  * column 2 = path to the bam file            #
#  * column 3 = lane number                     #
#################################################

#--- start with sample names list ---#
cp ~projects/def-frasiert/beluga_ddRAD/raw/Q031409_beluga_ddRAD/samples.list ~scratch/qualimap-subset/qualimap_input_file

#--- copy column 1 to a second column ---#
awk -F, '{$1=$1"\t"$1}1' qualimap_input_file > qualimap_input_file2
 
#--- add the alignments directory path in front of sample name in column 2 ---#
sed 's/\t/\talignments\//' qualimap_input_file2 > qualimap_input_file

#--- remove intermediary file ---#
rm qualimap_input_file2

#--- add lane information to column 2 pathways and add a third column with lane number ---#
sed -i 's/$/\-L002\.bam\tlane_1/' qualimap_input_file

#--- copy all sample names again to have info for lane 2 ---#
cp ~/projects/def-frasiert/beluga-ddRAD/raw/Q031409_beluga_ddRAD/samples.list lane2

#--- copy column 1 to a second column ---#
awk -F, '{$1=$1"\t"$1}1' lane2 > lane2-2

#--- add the alignments directory path in front of sample name in column 2 ---#
sed 's/\t/\talignments\//' lane2-2 > lane2

#--- remove intermediary file ---#
rm lane2-2

#--- add lane information to column 2 pathways and add a third column with lane number ---#
sed -i 's/$/\-L003\.bam\tlane_2/' lane2

#--- concatenate lane 2 file onto the original qualimap-input-file ---#
cat qualimap_input_file lane2 > qualimap_input-ALL

#--- make an input file for the subset, take line 1-20 and 179-198, concatenate ---#
sed -n '1,20p' qualimap_input-ALL > subset1
sed -n '179,198p' qualimap_input-ALL > subset2
cat subset1 subset2 > qualimap_input-subset
rm subset1
rm subset2
