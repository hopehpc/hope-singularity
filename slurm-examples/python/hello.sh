#!/bin/bash

#SBATCH --job-name=hello

$SIF_FILE=${SIF_FILES}/python.sif
$SCRIPT=scripts/hello.py

singularity exec $SIF_FILE python3 $SCRIPT
