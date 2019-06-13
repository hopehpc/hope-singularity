#!/bin/bash

#SBATCH --job-name=fib

source config.sh

singularity exec $PYSIF python3 $PYSRC/fibonacci.py
