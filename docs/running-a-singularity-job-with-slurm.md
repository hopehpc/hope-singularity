# Running a Singularity Job with Slurm
This document provides an overview of creating a Slurm job script that uses Singularity.</br></br>

## Table of Contents
1. [Creating a job script](#creating-a-job-script)
2. [Adding job options](#adding-job-options)
3. [Using `singularity run` to run a script](#using-singularity-run-to-run-a-script)
    + [Calling a separate script from your job](#calling-a-separate-script-from-your-job)
    + [Creating a script within your job](#creating-a-script-within-your-job)
4. [Submitting the job](#submitting-the-job)
5. [Checking job status](#checking-job-status)
6. [Viewing job output](#viewing-job-output)
7. [Other Slurm commands](#other-slurm-commands)
8. [Examples]()
    + [Example that calls a separate script]()
    + [Example that calls a script within the job]()</br></br>

### Creating a job script
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

### Using `singularity run` to run a script
The `singularity run` command is used to launch a Singularity container and run commands inside of it. Its syntax is `singularity run [run options...] <container>`. Most of our containers are designed to accept arguments passed after `<container>` to mimic regular software usage.

Pick a Singularity image file (`.sif`) to use. The subdirectories within `/home/hope-singularity/image-files` each contain a `.sif`  that can be used. For this example, we will use `/home/hope-singularity/image-files/ubuntu/ubuntu.sif`.

Note that for convienence, the environment variable `$SIF_PATH` can be used instead of `/home/hope-singularity/image-files`.

Below are two examples of running a script in a Singularity container.

#### Calling a separate script from your job
If you have created a separate script to be called from your job script, ensure that your user has executable permissions on it. Below is an example of a script named `cow.sh` being run inside of an `ubuntu.sif` container.

```
$ cat cow.sh
echo "Cows go moo!"
```

Example: `singularity run $SIF_PATH/ubuntu.sif cow.sh`</br></br>

#### Creating a script within your job
pass

Note that `singularity run` usage will vary by container. Look at the subdirectories within hope-singularity/slurm-examples for instructions regarding specific software.</br></br>

### Submitting the job
First, ensure that your user has executable permissions on the `<jobname>.sh`. The `sbatch` command can then be used to submit your job to Slurm.

Example: `$ sbatch <jobname>.sh`</br></br>

### Checking job status
pass</br></br>

### Viewing job output
pass</br></br>

### Other Slurm commands
pass</br></br>
