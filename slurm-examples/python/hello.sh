#!/bin/bash

#SBATCH --job-name=hello

source config.sh

singularity exec $PYSIF python3 $PYSRC/hello.py
