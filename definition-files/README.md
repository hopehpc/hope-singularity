# definition-files 

## Description
This directory contains definition files for Singularity images (SIF files). Each subdirectory contains a `.def` file with its build instructions. Each subdirectory may contain additional files needed to build the image.</br></br>

## How to Build Images
Images can be built manually with the `singularity build` command, or by using the `build.sh` script. Using `build.sh` is recommend; it automatically chooses the correct path and filename for the image.</br></br>

### build.sh usage
`build.sh` takes one argument: the path to a definition file. The command will place images in the directory defined by `SIFDIR` in `globals.sh`, and it will name the image file with the same name as the definition file with a `.sif` extension.

`[definition-files] $  ./build.sh <subdirectory>/<source.def>`

### singularity build usage
Further details on the `singularity build` command can be found [here](https://singularity.lbl.gov/docs-build-container).

`[definition-files/subdirectory] $ singularity build <destination> <source.def> `
