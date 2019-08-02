# Building Image Files
This document explains how images can be built from definition files within this repository. It is not an explaination on how images are built or how definition files are written.<br><br>

## Contents
1. [Building from build.sh (recommended)](#building-from-buildsh)
2. [Building Manually](#building-manually)
<br>

## Building from build.sh
`definition-files` contains a script `build.sh` that should be used to build sif files from the def files in the directory. The script runs the `singularity build` command and builds images in the location specified by `$SIF_FILES` in `/etc/profile.d/singularity.sh` (created during the cluster build process; located [here](https://github.com/hopehpc/cluster-scripts/tree/master/profile.d). 
  
Additionally, the script creates the sif file with an appropriate name: it only changes the extension from `.def` to `.sif`.

### build.sh usage
`build.sh` accepts one argument: the path to a definition file. It should be called from within `definition-files`.

```bash
$ sudo ./build.sh <path-to-def-file>
```

### Example
```bash
[/home/hope-singularity/definition-files] $ sudo ./build.sh python/python.sif
```
<br>

## Building Manually
Images can be build manually using the `singularity build` command. Further documentation can be found [here](https://sylabs.io/guides/3.3/user-guide/cli/singularity_build.html?highlight=singularity%20build)

### singularity build usage
`singularity build`'s general usage takes two arguments: the destination sif file and the source def file.

```bash
$ sudo singularity build <destination sif file> <source def file>
```

### Example
```bash
[/home/hope-singularity/definition-files/python] $ sudo singularity build /home/hope-singularity/image-files python.sif
```
