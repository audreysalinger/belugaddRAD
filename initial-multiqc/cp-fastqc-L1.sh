#!/bin/bash

#------------------------------------------#
#  copy FastQC directories of interest to  #
#     a new QC directory for each lane     #
#------------------------------------------#

#--- in a new QC directory, I want to make a copy of each fastqc.R* sub-directory that is within each sample directory ---#

#--- run script from beluga-ddRAD directory ---#
#--- start within Lane1 directory ---#
cd ./raw/Q031409_beluga_ddRAD/Lane1

#--- for each sample do ---#
for sample in 'Sample_'*;
do
	#--- make a copy of the R1 sub-directory that contains the fastqc_data.txt file to the QC/Lane1 directory ---# 
	cp -r $sample/fastqc.R1/*'_fastqc'/ ~/projects/def-frasiert/beluga-ddRAD/QC/Lane1/$sample'.R1'
		
	#--- make a copy of the R2 sub-directory that contains the fastqc_data.txt file to the QC/Lane1 directory ---# 
	cp -r $sample/fastqc.R2/*'_fastqc'/ ~/projects/def-frasiert/beluga-ddRAD/QC/Lane1/$sample'.R2'
done
