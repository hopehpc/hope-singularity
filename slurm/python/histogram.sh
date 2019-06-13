#!/bin/bash

#SBATCH --job-name=histogram

source config.sh

singularity exec $PYSIF python3 $PYSRC/histogram.py
