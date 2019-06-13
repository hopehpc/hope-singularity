# build 

## Description
This directory contains definition files for Singularity images (SIF files). Each subdirectory contains a `.def` file with its build instructions. Each subdirectory may contain additional files needed to build the image.

## How to Build Images
Images can be built manually with the `singularity build` command, or by using the `build.sh` script. 

### singularity build usage
For more details, see the [Singularity documentation](https://singularity.lbl.gov/docs-build-container).

`[build/subdirectory] $ singularity build <destination> <source.def> `

### build.sh usage
`build.sh` takes one argument: the path to a definition file. Note that the command will place images in the directory defined by `SIFDIR` in `globals.sh`.

`[build] $  ./build.sh <subdirectory>/<source.def>`
