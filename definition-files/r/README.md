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

`packages/base.txt` is a list of all the R packages installed on curie. To obtain a list of packages installed on a machine, complete the following steps:

Start R:
```bash
$ R
```

List installed packages:
```R
> installed.packages()
```

There should be a lot of output with repeated package names. Copy all of the text that has the format shown below:
```R
MASS           "recommended"
Matrix         "recommended"
matrixStats    NA           
maxLik         NA           
mclust         NA           
memoise        NA           
mgcv           "recommended"
mime           NA           
miniUI         NA           
minqa          NA           
miscTools      NA  
```

Save the text as a text file and use [this](https://github.com/hopehpc/cluster-scripts/blob/master/read-packages.sh) script to remove the second column of text:
```bash
$ ./read-packages.sh mypackages.txt
```

`read-packages.sh` will create a text file named `packages.txt` that can be used in the definition file.
<br><br>

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

### %post
```bash
%post
	WORKDIR=/singularity-build	# Directory created in %setup
	PACKAGES=base.txt		# Base packages to install

	cd $WORKDIR
	
	# Install dependencies
	apt-get update
	apt-get install -y --no-install-recommends locales
```
This section of `%post` sets a variable for the directory created during `%setup` and the file copied over in `%files`. It then updates and installs locales.

```bash
	# Set locale to avoid R warning messages
	# Note: code from nikjer/singularity-r:3.5.1 on Singularity Hub
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	locale-gen en_US.utf8
	/usr/sbin/update-locale LANG=en_US.UTF-8
	export LC_ALL=en_US.UTF-8
	export LANG=en_US.UTF-8
```
This code sets the locale correctly in the container, which prevents R giving an error message about the wrong locale being set. (This might only be a problem with Ubuntu 18.04.)

```bash
	# Install R
	apt-get install -y ca-certificates gnupg
	gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
	gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | apt-key add -
	apt-get update
	echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" | tee /etc/apt/sources.list.d/r.list
	apt-get update
	apt-get install -y r-base r-base-dev
```
This section installs R; the code can be found in R's documentation.

```bash
	# Read each line of $PACKAGES and install
	while read -r line; do
		echo install.packages\(\"$line\"\, repos\=\'https://cloud.r-project.org\'\) | R --slave	
	done < $PACKAGES
```
This code reads each line of `base.txt` and installs each package.
