#!/bin/bash

if [ "$#" -ne 1 ]; then
	printf "Usage: ./build.sh <subdirectory>/<source.def>\n\n"
	exit 1
fi

source ../globals.sh

DIR=${1///*}
DEF=${1#*/}								# remove path prefix of def file 
SIF=${DEF%.def}.sif						# remove .def and add .sif extension

cd $DIR									# cd in case there are files needed by the def file in the subdirectory
sudo singularity build $SIFDIR/$SIF $DEF	# run the build command
