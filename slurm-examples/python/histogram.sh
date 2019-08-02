#!/bin/bash

#SBATCH --job-name=histogram

$SIF_FILE=${SIF_FILES}/python.sif
$SCRIPT=scripts/histogram.py

singularity run $SIF_FILE python3 $SCRIPT
