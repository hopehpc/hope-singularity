# ubuntu-16-04.sh
# A script to install basic packages inside of the base Ubuntu 16.04 container

#!/bin/bash

# Update and upgrade OS
apt-get -y update
apt-get -y upgrade

# Install packages
apt-get install -y --no-install-recommends \
	htop curl wget man unzip gcc \
	nano vim less build-essential \
	software-properties-common

