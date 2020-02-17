#!/bin/bash

if [ "$#" -ne 1 ]; then
	printf "Usage: ./build.sh <subdirectory>/<source.def>\n\n"
	exit 1
fi

source /etc/profile.d/singularity.sh
export SINGULARITY_TMPDIR=/scratch

DIR=${1///*}					# subdirectory where def file is located
DEF=${1#*/}					# remove path prefix of def file 
SIF=${DEF%.def}.sif				# remove .def and add .sif extension

cd $DIR						# cd in case there are files needed by the def file in the subdirectory
sudo --preserve-env=SINGULARITY_TMPDIR singularity build $SIF_FILES/$SIF $DEF	# run the build command
sudo chown root:containeradmin $SIF_FILES/$SIF  # change sif file to be owned by root with group containeradmin (rather than whatever user ran the build command)

