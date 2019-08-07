# Creating a Mothur Definition File
This document describes how a Mothur definition file is created.<br>

## Contents
1. [Sections](#sections)

## Sections

### Header
```bash
Bootstrap: library
From: ubuntu:16.04
```

This definition file has only been tested with Ubuntu 16.04.
<br><br>

### %post

```bash
%post
	# Mothur executable
	MOTHUR=https://github.com/mothur/mothur/releases/download/v.1.42.3/Mothur.linux_64.zip

	# Download dependencies
	apt-get update
	apt-get install -y wget unzip build-essential
	
	# Download mothur
	mkdir /mothur
	cd /mothur
	wget $MOTHUR
	unzip Mothur.linux_64.zip
	cd mothur

	# Copy executables to /usr/bin
	DEST=/usr/bin
	cp mothur $DEST
	cp uchime $DEST
	cp vsearch $DEST
	cd blast/bin 
	cp blastall $DEST
	cp formatdb $DEST
	cp megablast $DEST
```

The `%post` section downloads the Mothur executable from GitHub and then unzips it. The file contains multiple different applications; they are moved to `/usr/bin`. 
