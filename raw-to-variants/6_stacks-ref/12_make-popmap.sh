#!/bin/bash

#############################
#  creating population map  #
#############################

cp ~/projects/def-frasiert/beluga-ddRAD/raw/Q031409_beluga_ddRAD/samples.list ~/projects/def-frasiert/beluga-ddRAD/popmap.tsv

#--- add a new column to indicate SLE population ---#
sed -i 's/$/\tSLE/' popmap.tsv
