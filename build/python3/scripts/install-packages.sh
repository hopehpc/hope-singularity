#!/bin/bash

packages=("$@")
ERR=notfound.txt

# Source try/catch functions

printf "Installing Python packages\n\n"

for package in ${packages[*]}
do
	try {
		pip install $package
	}

	catch || {
		echo "Could not install pip package: $package" >> $ERR  
	}

	try {
		pip3 install $package
    }

	catch || {
		echo "Could not install pip3 package: $package" >> $ERR
	}
done
