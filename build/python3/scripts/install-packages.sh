#!/bin/bash

ERR=notinstalled.txt    # Error file for names of packages not installed

# Note: The definition file runs commands at build time with /bin/sh, so it is not possible to pass a bash array; convert a comma-separated list of packages into a bash array instead
IFS=', ' read -r -a packages <<< "$1"
#packages=("$@")			# Array of packages passed as argument

# Source try/catch functions
source ../../scripts/trycatch.sh

printf "Installing Python packages\n\n"

for package in ${packages[*]}
do
	try 
	{
		pip install $package
	}

	catch || 
	{
		echo "Could not install pip package: $package" >> $ERR  
	}

	try 
	{
		pip3 install $package
    }

	catch || 
	{
		echo "Could not install pip3 package: $package" >> $ERR
	}
done
