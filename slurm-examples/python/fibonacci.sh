#!/bin/bash

#SBATCH --job-name=fib

SIF_FILE=${SIF_FILES}/python.sif
SCRIPT=scripts/fibonacci.py

singularity run $SIF_FILE $SCRIPT
