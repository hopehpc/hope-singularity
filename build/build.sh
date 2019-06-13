#!/bin/bash

source ../globals.sh

DEF=${1#*/}		# remove path prefix of def file 
SIF=${DEF%.def}.sif	# remove .def and add .sif extension

sudo singularity build $SIFDIR/$SIF $1
