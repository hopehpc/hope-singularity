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
7. [Other Basic Slurm commands](#other-basic-slurm-commands)</br></br>

### Creating a job script
First, create a file named `<jobname>.sh` in your home directory. For this document, we will call the job script `jobscript.sh`

Add a shebang to the beginning of `jobscript.sh`:

```bash
$ cat jobscript.sh
#!/bin/bash
```
</br>

### Adding job options
Job options can be added to the beginning of your script. Each line should start with `#SBATCH` and be followed by a job option. Below is a basic list of options with their `#PBS` analogues. 

| `#PBS` | `#SBATCH` | Definition |
| --- | --- | --- |
| `-l nodes=X:ppn=Y` | `--ntasks<multiplyX*Y>`| # of processes to run |
| `-l walltime=<HH:MM:SS>` | `--time=<HH:MM:SS>` | how long the job will run |
| `-q <queue-name>` | `--partition=<partition-name>` | which set of nodes to run on |
| `-l mem=<number>` | `--mem=<number>` | total memory (single node) |
| `-l pmem<number>` | `--mem-per-cpu=<number>` | memory per CPU |

A complete list of options can be found [here](https://slurm.schedmd.com/sbatch.html).

Add a `--job-name` option to the beginning of `jobscript.sh`:

```bash
$ cat jobscript.sh
#!/bin/bash

#SBATCH --job-name=cows
```
</br>

### Using `singularity run` to run a script
The `singularity run` command is used to launch a Singularity container and run commands inside of it. Its syntax is `singularity run [run options...] <container>`. Most of our containers are designed to accept arguments passed after `<container>` to mimic regular software usage.

Pick a Singularity image file (`.sif`) to use. `.sif` files that can be used can be found in `/home/hope-singularity/image-files`. For this example, we will use `/home/hope-singularity/image-files/ubuntu.sif`.

Please note:
+ For convienence, the environment variable `$SIF_PATH` can be used instead of `/home/hope-singularity/image-files`.
+ User permissions of each `.sif` file within `$SIF_PATH` will vary. In other words, you may not have access to all of the software on the cluster.
+ `singularity run` usage will vary by container. Look at the subdirectories within `/home/hope-singularity/slurm-examples` for instructions regarding specific software.

Below are two examples of running a script in a Singularity container through `jobscript.sh`.

#### Calling a separate script from your job
If you have created a separate script to be called from your job script, ensure that your user has executable permissions on it. Below is an example of a script named `moo.sh` being run inside of an `ubuntu.sif` container from the command line.

```bash
$ cat moo.sh
echo "Cows go moo!"

$ singularity run $SIF_PATH/ubuntu.sif bash cow.sh
Cows go moo!
```

The last command can easily be added to `jobscript.sh` as it is run on the command line:

```bash
$ cat jobscript.sh
$!/bin/bash

#SBATCH --job-name=cows

singularity run $SIF_PATH/ubuntu.sif bash cow.sh
```
</br>

#### Creating a script within your job
It is also possible to create a script to run inside of a container in your job script:

```bash
$ cat jobscript.sh
#!/bin/bash

#SBATCH --job-name=cows

cat << "EOF" > moo.sh

echo "Cows go moo!"

EOF

singularity run $SIF_PATH/ubuntu.sif bash moo.sh
```
</br>

### Submitting the job
First, ensure that your user has executable permissions on `jobscript.sh`. The `sbatch` command can then be used to submit your job to Slurm:

```bash
$ sbatch jobscript.sh
Submitted batch job 42
```

`sbatch` will output the job ID after it is submitted; in this case, the job ID is 42.</br></br>

### Checking job status
To check the status of your job, use the `scontrol command`:
```bash
$ scontrol show job 42
```

You can use the `squeue` command to view all of your running jobs:
```bash
$ squeue -u <username>
```
</br>

### Viewing job output
By default, Slurm will combine the output and error files of a job into one file named `slurm-<job-ID>.out`. The output and error files can be separated by using the `--error` and `--output` job options.

The output of `slurm-42.out` would show the contents of `moo.sh`:
```bash
$ cat slurm-42.out
Cows go moo!
```
</br>

### Other Basic Slurm commands
| Command | Definition |
| --- | --- |
| `sbatch <jobscript>` | submit a job script to the queue |
| `squeue -u <username>` | check the jobs of a particular user in the queue |
| `salloc <options>` | request an interactive job |
| `squeue --start` | show estimated start time |
| `squeue -p <partition>` | display queue/partition entries |
| `scontrol show job <job-ID>` | show job details |
| `qdel <job-ID>` | delete a job |</br></br>
