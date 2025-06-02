#!/bin/bash

#################################################################################
#  extract first 5 and last 5 genotypes for the first 5 and last 5 individuals  #
#                  to check against transformed genotype files                  #
#################################################################################

cd ../final-vcfs

###################
#  0.01 data set  #
###################

#--- get first 5 sample names and save to a temp file---#
zgrep -v "^##" 0.01_fully_filtered.vcf.gz | head -n 1 | cut -f 10-14 | awk '{for(i=1;i<=NF;i++) $i=substr($i,1,8)}1' > 0.01_first5ind

#--- add first 5 genotypes for the first 5 samples to temp file---#
zgrep -v "^##" 0.01_fully_filtered.vcf.gz | head -n 6 | tail -n 5 | cut -f 10-14 | awk '{for(i=1;i<=NF;i++) $i=substr($i,1,3)}1' >> 0.01_first5ind

#--- add last 5 genotypes for the first 5 samples to temp file ---#
zgrep -v "^##" 0.01_fully_filtered.vcf.gz | tail -n 5 | cut -f 10-14 | awk '{for(i=1;i<=NF;i++) $i=substr($i,1,3)}1' >> 0.01_first5ind


#--- get last 5 sample names and save to another temp file ---#
zgrep -v "^##" 0.01_fully_filtered.vcf.gz | head -n 1 | cut -f 159-163 | awk '{for(i=1;i<=NF;i++) $i=substr($i,1,8)}1' > 0.01_last5ind

#--- add first 5 genotypes for the last 5 samples to temp file ---#
zgrep -v "^##" 0.01_fully_filtered.vcf.gz | head -n 6 | tail -n 5 | cut -f 159-163 | awk '{for(i=1;i<=NF;i++) $i=substr($i,1,3)}1' >> 0.01_last5ind

#--- add last 5 genotypes for the last 5 samples to temp file ---#
zgrep -v "^##" 0.01_fully_filtered.vcf.gz | tail -n 5 | cut -f 159-163 | awk '{for(i=1;i<=NF;i++) $i=substr($i,1,3)}1' >> 0.01_last5ind


#--- paste temp files together ---#
paste -d ' ' 0.01_first5ind 0.01_last5ind > ../gt-conversion-check/0.01_vcf_gt_subset

#--- remove temp files ---#
rm 0.01_first5ind
rm 0.01_last5ind


####################
#  0.001 data set  #
####################

#--- get first 5 sample names and save to a temp file---#
zgrep -v "^##" 0.001_fully_filtered.vcf.gz | head -n 1 | cut -f 10-14 | awk '{for(i=1;i<=NF;i++) $i=substr($i,1,8)}1' > 0.001_first5ind

#--- add first 5 genotypes for the first 5 samples to temp file---#
zgrep -v "^##" 0.001_fully_filtered.vcf.gz | head -n 6 | tail -n 5 | cut -f 10-14 | awk '{for(i=1;i<=NF;i++) $i=substr($i,1,3)}1' >> 0.001_first5ind

#--- add last 5 genotypes for the first 5 samples to temp file ---#
zgrep -v "^##" 0.001_fully_filtered.vcf.gz | tail -n 5 | cut -f 10-14 | awk '{for(i=1;i<=NF;i++) $i=substr($i,1,3)}1' >> 0.001_first5ind


#--- get last 5 sample names and save to another temp file ---#
zgrep -v "^##" 0.001_fully_filtered.vcf.gz | head -n 1 | cut -f 159-163 | awk '{for(i=1;i<=NF;i++) $i=substr($i,1,8)}1' > 0.001_last5ind

#--- add first 5 genotypes for the last 5 samples to temp file ---#
zgrep -v "^##" 0.001_fully_filtered.vcf.gz | head -n 6 | tail -n 5 | cut -f 159-163 | awk '{for(i=1;i<=NF;i++) $i=substr($i,1,3)}1' >> 0.001_last5ind

#--- add last 5 genotypes for the last 5 samples to temp file ---#
zgrep -v "^##" 0.001_fully_filtered.vcf.gz | tail -n 5 | cut -f 159-163 | awk '{for(i=1;i<=NF;i++) $i=substr($i,1,3)}1' >> 0.001_last5ind


#--- paste temp files together ---#
paste -d ' ' 0.001_first5ind 0.001_last5ind > ../gt-conversion-check/0.001_vcf_gt_subset

#--- remove temp files ---#
rm 0.001_first5ind
rm 0.001_last5ind
