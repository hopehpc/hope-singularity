#!/bin/bash

# Try/catch functions used from Mathias Henze's answer to SO question #22009364
function try()
{
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

function catch()
{
    export ex_code=$?
    (( $SAVED_OPT_E )) && set +e
    return $ex_code
}

# Packages to install
packages=(matplotlib pandas numpy scipy tensorflow scikit-learn)

printf "Installing packages\n"A

for package in ${packages[*]}
do
	try
	{
    	pip install $package
	}

	catch || {
    	echo "Could not install pip package: $package" >> notfound.txt	
	}

	try
	{
    	pip3 install $package
	}

	catch || {
    	echo "Could not install pip3 package: $package" >> notfound.txt	
	}

done

# Install CUDA Toolkit
wget https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-ubuntu1604-10-1-local-10.1.168-418.67_1.0-1_amd64.deb

sudo dpkg -i cuda-repo-ubuntu1604-10-1-local-10.1.168-418.67_1.0-1_amd64.deb
sudo apt-key add /var/cuda-repo-<version>/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda
