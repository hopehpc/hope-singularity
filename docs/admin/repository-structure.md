# Repository Structure
This document describes the purpose and structure of the `hope-singularity` repository.<br><br>

## Contents
1. [Purpose](#purpose)
2. [Directories](#directories)
    + [definition-files](#definition-files)
    + [image-files](#image-files)
    + [slurm-examples](#slurm-examples)
3. [Other Important Files](#other-important-files)
    + [.gitignore](#gitignore)
<br>

## Purpose
The purpose of `hope-singularity` is to contain Singularity definition files and example submission scripts for Hope's cluster. It is located at `/home/hope-singularity` on the cluster and is NFS-shared to all of the compute nodes.
<br><br>

## Directories

### definition-files
This directory contains Singularity definition files (def files). Each type of def file has its own subdirectory and there may be more than one def file in each. For example, the subdirectory for CUDA may have separate def files for the past three releases of the software. 

Each subdirectory also contains the necessary files for that particular image. For instance, the `python` subdirectory contains a directory for installation scripts used during the build process of the image.

One important script in this directory is `build.sh`, which is designed to make building images from definition files easy. Explaining the build process is out of the scope of this document, but is explained [here]().

### image-files
This directory contains all of the Singularity Image Files (sif files) that are used on the cluster. Its contents are included in the `.gitignore` file and are not published to GitHub; it's included as a bare repository for convenience. 

### slurm-examples
This directory contains example Slurm job submission scripts for various programs. Each program has its own subdirectory; each subdirectory contains `.sbatch` scripts and other files or scripts that are used.<br><br>

## Other Important Files

### .gitignore
This file contains a list of files or directories within the repository to be ignored by Git. It should contain at least one entry for all of the sif files: `image-files/*.sif`. Any tarballs or licensed software should be included here.
