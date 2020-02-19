# centos-7-6.sh
# A script to install basic packages inside of the base Centos 7.6 container
#   All of the packages below are customized for installation of AMBER18 (CPU version)

#!/bin/bash

yum --assumeyes update

yum --assumeyes group install "Development Tools"

yum --assumeyes install \
      hostname tcsh which vim nano man sudo wget \
      zlib-devel bzip2-devel boost boost-devel \
      libXt-devel libXext-devel libX11-devel \
      libICE-devel libSM-devel

# Installation of python3 requires the EPEL repository
#   (The EL in EPEL is Enterprise Linux. It is maintained
#    by Fedora for RedHat Enterprise and CentOS, so it
#    should be trustworthy.)
# Note that python is not necessary for amber, but is 
#    probably useful to users for analysis/processing
#    of results.
yum --assumeyes install epel-release
yum --assumeyes install \
      python2-pip python3 python3-devel python3-pip

pip install --upgrade pip
pip install numpy
pip3 install numpy
pip install scipy
pip3 install scipy


