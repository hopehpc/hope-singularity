# ubuntu-18-04.sh
# A script to install basic packages inside of the base Ubuntu 18.04 container

#!/bin/bash

# Update and upgrade OS
apt-get -y update
apt-get -y upgrade

# Install packages
#   First add software-properties-common so that we can add universe repository
apt-get install -y --no-install-recommends \
        software-properties-common

add-apt-repository universe

apt-get -y update
apt-get -y upgrade

#   Now add lot of useful packages
apt-get install -y --no-install-recommends \
        htop curl wget man unzip gcc \
        nano vim less build-essential \
        gfortran csh tcsh dialog \


