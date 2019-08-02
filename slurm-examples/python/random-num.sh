#!/bin/bash

#SBATCH --job-name=random-num

SIF_FILE=${SIF_FILES}/python.sif
SCRIPT=random-num.py

cat << "EOF" > $SCRIPT

import random

print("Your random number is: {}".format(random.randint(0, 42)))

EOF

singularity run $SIF_FILE $SCRIPT

rm $SCRIPT
