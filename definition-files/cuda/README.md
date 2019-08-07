# Creating a CUDA Definition File
This document describes how a CUDA definition file is created.<br><br>

## Contents
1. [Sections](#sections)
2. [Compiling CUDA Samples](#compiling-cuda-samples)
<br>

## Sections

### Header
```bash
Bootstrap: docker
From: nvidia/cuda:10.0-devel-ubuntu16.04
```

The header should use `docker` for the `Bootstrap` keyword. The name of a NVIDIA CUDA image should be used for the `From` keyword. A full list of CUDA Docker images can he found [here](https://gitlab.com/nvidia/cuda/blob/master/doc/supported-tags.md). Various versions of CUDA and different operating systems are available. Note that Ubuntu 14.04, 16.04, and 18.04, and Centos 6 and Centos 7 are the only operating systems available for CUDA images.

This example uses a CUDA 10.0 and Ubuntu 16.04 Docker image.

### %environment
```bash
%environment
	# Path to CUDA programs
	export PATH=$PATH:/usr/local/cuda/bin
```

`/usr/local/cuda/bin` should be added to `$PATH` so that CUDA programs can be accessed (e.g., nvcc). 

### %post
```bash
%post
	# Install required dependencies
	apt-get update -y
	apt-get upgrade -y
	apt-get install -y build-essential software-properties-common \
                curl git unzip vim wget gcc
```
Since this definition file is using the instructions from a CUDA image, it isn't necessary to put much here, since the original image already does some of the work (e.g., updating). Some common packages are being installed here for user convenience.
<br><br>

## Compiling CUDA Samples
`cuda-8-0.def` contains instructions to install and compile CUDA samples. It installs the `cuda-samples-8.0` package and then compiles some samples within `$SAMPLE_DIR`; the `$SAMPLE_DIR` directory contains many subdirectories for individual samples. The samples that are compiled within that directory are listed in `$SAMPLES`. The compiled samples are moved to the directory created in `%setup`, and the variable `$CUDA_SAMPLES` is set to the directory where the compiled samples are moved to.

Note that the `cuda-samples-8.0` package is specific to CUDA 8.0, which is why this installation is only included in `cuda-8.0.def`. It is possible that the samples may compile with newer versions of CUDA.
<br><br>

## Running a CUDA Sample
To run a CUDA sample in `$CUDA_SAMPLES`, use the following commands:
```bash
$ singularity shell --nv $SIF_PATH/cuda-8-0.sif
Singularity $ cd $CUDA_SAMPLES
Singularity $./<sample-name>
```
