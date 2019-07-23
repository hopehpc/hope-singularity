#!/bin/bash

DATE=$(date +%Y-%m-%d)
ERR=$DATE-notinstalled.txt    # Error file for names of packages not installed

# Source try/catch functions
source ../../scripts/trycatch.sh

printf "Installing Python packages\n\n"

while read package
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
done < $1
	
