# build 

## Description
This directory contains definition files for Singularity images (SIF files). Each subdirectory contains a `.def` file with its build instructions. Each subdirectory may contain additional files for the image.

## How to Build Images
Images can be built manually, or by using the `build.sh` script. `build.sh` will place images in the directory defined by `SIFDIR` in `globals.sh`.

### build.sh usage
`./build.sh <directory>/<definition file> 
