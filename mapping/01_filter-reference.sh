#!/bin/bash

#############################################################
#  filter the reference genome for scaffolds > 10M bp long  #
#############################################################

PROJECTS=~/projects/def-frasiert/beluga-ddRAD

module load bioawk/1.0

bioawk -c fastx 'length($seq) > 10000000{ print ">"$name; print $seq }' ${PROJECTS}/ref-genome/ASM228892v2_HiC.fasta.gz \
	> ${PROJECTS}/ref-genome/ASM228892v2_HiC_10M-bp.fasta

#--- zip output file ---#
gzip ${PROJECTS}/ref-genome/ASM228892v2_HiC_10M-bp.fasta
