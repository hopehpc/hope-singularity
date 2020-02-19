# ubuntu-18-04.sh
# A script to install basic packages inside of the base Ubuntu 16.04 container

#!/bin/bash

# Update and upgrade OS
apt-get -y update
apt-get -y upgrade

# Install packages
apt-get install -y --no-install-recommends \
	software-properties-common

add-apt-repository universe

apt-get -y update
apt-get -y upgrade

apt-get install -y --no-install-recommends \
	htop curl wget man zip unzip \
        bzip2 libbz2-1.0 libbz2-dev \
        zlib1g zlib1g-dev \
	nano vim less build-essential \
	gcc gfortran csh tcsh flex dialog \
        libboost-all-dev \
        python python-dev python3-dev python3-pip 

apt-get install -y --no-install-recommends \
        xorg-dev xserver-xorg 

        #x11-common x11-utils \

# Still need:
#  X11

apt-get -y update
apt-get -y upgrade

