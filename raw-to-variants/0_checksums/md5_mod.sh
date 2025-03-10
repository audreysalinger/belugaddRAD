#!/bin/bash

#----------------------------#
# Create a directory to hold #
# the original md5 files.    #
#----------------------------#
#mkdir original-md5

#-------------------------------#
#  Loop through each directory  #
#-------------------------------#
for dir in Sample_*/;
do
  
  echo $dir

  #-- Go into that directory ---#
  cd $dir

  #------------------------------#
  #  Loop through each md5 file  #
  #------------------------------#
  for file in *.md5;
  do

    #--- Copy file to "original" directory ---#
    echo $file
    #cp $file ../original-md5/

    #--- modify md5 file to just contain checksums value and sample name ---#
    sed -i -r 's/(\w+).*\/(Bel.*)/\1 \2/' $file

    #--- Run Checksums ---#
    md5sum -c $file

  done

  #---------------------------------#
  #  Go back to original directory  #
  #---------------------------------#
  cd ..
done
