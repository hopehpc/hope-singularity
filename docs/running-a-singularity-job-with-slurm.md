# Running a Singularity Job with Slurm
This document provides an overview of creating a Slurm job script that uses Singularity.</br></br>

## Table of Contents
1. [Creating a script](#creating-a-script)
2. [Adding job options](#adding-job-options)
3. [Using `singularity run`](#using-singularity-run)
4. [Submitting the job](#submitting-the-job)</br></br>

### Creating a script
First, create a file named `<jobname>.sh` in your home directory.</br></br>

### Adding job options
Job options can be added to the beginning of your script. Each line should start with `#SBATCH` and be followed by a job option. Below is a basic list of options with their #PBS analogues. 

| `#PBS` | `#SBATCH` | Definition |
| --- | --- | --- |
| `-l nodes=X:ppn=Y` | `--ntasks<multiplyX*Y>`| # of processes to run |
| `-l walltime=<HH:MM:SS>` | `--time=<HH:MM:SS>` | how long the job will run |
| `-q <queue-name>` | `--partition=<partition-name>` | which set of nodes to run on |
| `-l mem=<number>` | `--mem=<number>` | total memory (single node) |
| `-l pmem<number>` | `--mem-per-cpu=<number>` | memory per CPU |

A complete list of options can be found [here](https://slurm.schedmd.com/sbatch.html).</br></br>

### Using `singularity run`
Pick a Singularity image file to use. The subdirectories within `/home/hope-singularity/image-files` each contain a `.sif` file that can be used. For this example, we will use `/home/hope-singularity/image-files/ubuntu/ubuntu.sif`.

For convienence, the environment variable `$SIF_PATH` can be used instead of `/home/hope-singularity/image-files`.

Look at the subdirectories within hope-singularity/slurm-examples for instructions regarding specific software.

#### Creating a separate script to be called in your job
pass</br></br>

#### Creating a script within your job
pass</br></br>

### Submitting the job
First, ensure that your user has executable permissions on the `<jobname>.sh`. The `sbatch` command can then be used to submit your job to Slurm.

Example: `$ sbatch <jobname>.sh`
