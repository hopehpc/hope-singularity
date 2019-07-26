#!/bin/bash

printf "Installing Python packages\n\n"

while read package
do
	pip install $package
	pip3 install $package
done < $1
