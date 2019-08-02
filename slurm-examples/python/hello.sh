#!/bin/bash

#SBATCH --job-name=hello

SIF_FILE=${SIF_FILES}/python.sif
SCRIPT=scripts/hello.py

singularity run $SIF_FILE $SCRIPT
