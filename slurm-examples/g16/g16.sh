#!/bin/bash
#SBATCH --ntasks=2

JOBNAME="g16"
IMAGE="$SIF_PATH/g16.sif"

singularity run $IMAGE g16 <$JOBNAME.inp >$JOBNAME.out 2>$JOBNAME.err
