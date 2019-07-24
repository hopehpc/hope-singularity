# Building a Container
This document describes the basic process of building a container. It is adapted from the [Singularity documentation](https://sylabs.io/guides/3.3/user-guide/index.html).

Singularity's documentation is thorough and provides clear examples. Therefore, this document will only cover essential parts of the build process; it will refer you to the Singularity documentation for more detail when necessary.

## Table of Contents
1. [How a Container is Built](#how-a-container-is-built)
2. [Writing the Definition File](#writing-the-definition-file)
    + [Header](#header)
    + [Sections](#sections)
3. [Creating the Singularity Image File](#creating-the-singularity-image-file)
4. [Running the Container](#running-the-container)</br></br>

## How a Container is Built
In general, two steps are required before a container can be run:
1. A definition file needs to be written that defines the contents of the image file/container
2. The definition file needs to be converted to a Singularity Image file (`.sif`)

After these two steps are complete, we can say that a container has been "built," and that containers can now be "run" using the created `.sif`.

The steps above assume that the container is built from a definition file. However, Singularity can also convert Docker images on Docker Hub to `.sif` files without first creating a definition file.
</br></br>

## Writing the Definition File
A Singularity Definition File (def file) has two parts:
1. **Header**: The core operating system to build within the container. You can specify the Linux distribution, the specific version, and the packages that must be a part of the core install.
2. **Sections**: The rest of the def file contains sections defined by a `%` character. All sections are optional, and a def file can contain more than one instance of a section. Sections that are executed at build time or that produce scripts to be executed at runtime can accept `/bin/sh` options.

A def file can be created in any text editor, and we recommend using a `.def` extension.

### Header
The header should be written at the top of the def file. It tells Singularity about the base operating system that should be used to build in the container, and it is composed of many keywords.

#### Bootstrap
The `bootstrap` keyword is required for every build and must be the first entry of the header. It determines the bootstrap agent that will be used to create the base operating system.

For example, the `library` bootstrap agent will pull a container from the [Container Library](https://cloud.sylabs.io/library) as a base. The `docker` bootstrap agent will pull layers from [Docker Hub](https://hub.docker.com) as a base operating system.

Each bootstrap agent enables its own options and keywords. For example, when using the `library` bootstrap agent, the `from` keyword becomes available.

#### Examples
The following header uses Ubuntu 16.04 from the Container Library as a base operating system:
```
Bootstrap: library
From: ubuntu:16.04
```

This header uses CentOS 7 from Docker Hub as a base operating system:
```
Bootstrap: docker
From: centos:7
```

Further documentation on bootstrap agents can be found [here](https://sylabs.io/guides/3.3/user-guide/appendix.html#buildmodules).

### Sections
Most of the def file is split into sections. Sections add content or execute commands at different times during the build process. No sections are required; multiple sections with the same name are valid and will be appended to each other during the build process.

#### `%files`
The `%files` section copies files from the host system to the container. Each line is a `<source> <destination>` pair, where `<source>` is a path on the host machine and `<destination>` is a path in the container. This section is executed before the `%post` section.

#### `%post`
The `%post` section allows you to install software and libraries, create new directories and files, download content from the internet, etc.

#### `%environment`
The `%environment` section defines environment variables that will be set at runtime. They are not available during the build process; if you need the same environment variables during the build, they should be defined in the `%post` section.

#### `%runscript`
The `%runscript` is executed when the container is run with `singularity run`. When the container is invoked, arguments following the container name are passed to the runscript. This means that you can and should process arguments within your runscript.

#### Examples
The following example uses the Ubuntu header from above to create a def file named `ubuntu.def`:
```
Bootstrap: library
From: ubuntu:16.04

%files
    /home/user/file /file
    
%environment
    export N=42
    
%post
    apt-get update -y
    apt-get install -y git
    git clone https://github.com/hopehpc/hope-singularity.git
    cd hope-singularity
    
%runscript
    echo "Arguments received: $*"
    exec echo "$@"
```

This example uses the CentOS header from above to create `centos.def`:
```
Bootstrap: docker
From: centos:7

%post
    yum update -y
    yum install -y python
    
%runscript
    python $@
```

Further documentation on sections can be found [here](https://sylabs.io/guides/3.3/user-guide/definition_files.html#sections)</br></br>

## Creating the Singularity Image File
Once the def file is written, the `singularity build` command can be used to build a `.sif` file.

### Examples
The following example would create `ubuntu.sif` from `ubuntu.def` above:
```bash
$ singularity build ubuntu.sif ubuntu.def
```

This example would create `centos.sif` from `centos.def` above:
```bash
$ singularity build centos.sif centos.def
```

Further documentation on the `singularity build` command can be found [here](https://sylabs.io/guides/3.3/user-guide/cli/singularity_build.html).</br></br>

## Running the Container 
Containers can be run using the `singularity run` command.

### Examples
This command would run the `ubuntu.sif` created above:
```bash
$ singularity run ubuntu.sif
```

This command would run the `centos.sif` created above and run a Python script named `hello.py`:
```bash
$ singularity run centos.sif hello.py
```

To submit your container to the cluster, see [Submitting a Container to the Cluster](submitting-a-container-to-the-cluster.md).

Further documentation on the `singularity run` command can be found [here](https://sylabs.io/guides/3.3/user-guide/cli/singularity_run.html?highlight=run).
