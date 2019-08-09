#!/bin/bash

#SBATCH --job-name=gpu-matmul
#SBATCH --nodelist=node03

# Run a TF matrix multiplication on a GPU node

SIF_FILE=${SIF_FILES}/ml-python.sif	# python image with TF GPU package
SCRIPT=tensorflow/gpu-matmul.py

singularity run $SIF_FILE $SCRIPT
