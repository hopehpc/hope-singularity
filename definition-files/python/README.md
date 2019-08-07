# Creating a Python Definition File
This document describes how a Python definition file is created.<br><br>

## Contents
1. [Required Files](#required-files)
2. [Sections](#sections)
<br>

## Required Files
Three files are required for this definition file: `install-python.sh`, `install-packages.sh`, and a list of packages to install inside of the container.

### install-python.sh
This file can be found at `scripts`. It downloads and installs Python 2, Python 3, pip, and pip3; specific versions of Python are given as command-line arguments. Note that pip3 relies on Python 2, so both versions must be installed.

Usage:
```bash
$ ./install-python.sh <Python 2 version> <Python 3 version> <current working directory>
```

### install-packages.sh
This file can be found in `scripts`. It reads a list of packages and installs each one with pip and pip3. 

Usage:
```bash
$ ./install-packages.sh <list of packages>
```

### List of packages
A list of packages can be any text file that contains one Python package name per line.

Example:
```
numpy
pandas
matplotlib
requests
```
</br>

## Sections
This section will describe the contents of each definition file section.

### %setup
```bash
%setup
        # Working directory where installation scripts and other files will be stored
        mkdir ${SINGULARITY_ROOTFS}/singularity-build
```
The `%setup` section is used to create a working directory inside of the container at `/singularity-build`. It will contain the files copied over during the `%files` section and anything installed during the `%post` section.

### %files
```bash
%files
        /home/hope-singularity/definition-files/scripts/install-python.sh /singularity-build/install-python.sh
        /home/hope-singularity/definition-files/scripts/install-packages.sh /singularity-build/install-packages.sh
        /home/hope-singularity/definition-files/packages/base.txt /singularity-build/base.txt
```
These commands copy all of the required files to the container filesystem.

### %post
``` bash
%post
        WORKDIR=/singularity-build  # Working directory in container created during %setup
        PY2VER=2.7.16               # Python 2 version
        PY3VER=3.7.3                # Python 3 version
        PACKAGES=base.txt           # Package list to install
        
        # Install basic packages
        apt-get update && apt-get -y upgrade
        apt-get install -y build-essential software-properties-common \
        curl htop man unzip wget gcc \
        python3-setuptools
	
        cd $WORKDIR

        # Run Python installation script
        ./install-python.sh $PY2VER $PY3VER $WORKDIR

        # Run Python package installation script
        ./install-packages.sh $PACKAGES
```
The `$PY2VER` and `$PY3VER` environment variables set the versions of Python to install and are passed to `install-python`. `$PACKAGES` should be set to the file copied to the container during the `%files` section.  

### %runscript
```bash
%runscript
        python3	$@	# Default to Python 3 and accept command-line arguments
```
The runscript will default this container to Python 3, and including `$@` will allow it to process command-line arguments that are passwd to `singularity run`.</br></br>
