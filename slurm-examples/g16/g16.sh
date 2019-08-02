#!/bin/bash
#SBATCH --ntasks=2

JOB_NAME=g16
SIF_FILE=${SIF_PATH}/g16.sif

singularity run $SIF_FILE g16 <$JOB_NAME.inp >$JOB_NAME.out 2>$JOB_NAME.err
