# Creating an R Definition File
This document explains how an R definition file is created.<br><br>

## Contents
1. [Required Files](#required-files)
2. [Sections](#sections)
<br>

## Required Files
The only required file is a text file that contains packages to be installed inside of the container. The file should have one package name on each line. It should be placed inside of `packages` within this subdirectory.

For example:
```
blob
crayon
glue
magic
praise
sandwich
```
<br>

## Sections

### %setup
```bash
%setup
	mkdir ${SINGULARITY_ROOTFS}/singularity-build
```

This section creates a directory to put container-related files in.

### %files
```bash
%files
	/home/hope-singularity/definition-files/r/packages/base.txt /singularity-build/base.txt	
```

This section copies a list of packages `base.txt` to the directory that was created in `%setup`.

