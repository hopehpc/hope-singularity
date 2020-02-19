# install_mpich.sh
# A script to install MPICH

#!/bin/bash

# Setup environment variables for mpich build
export FC=gfortran
export CC=gcc
export CXX=g++

# Move to install location
cd /usr/local

# Download and untar MPICH 3.1.4 (recommended by Ross Walker)
#   Could also consider http://www.mpich.org/static/downloads/3.3.1/mpich-3.3.1.tar.gz
#   or http://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz
#wget http://www.mpich.org/static/downloads/3.1.4/mpich-3.1.4.tar.gz
tar xzf mpich-3.1.4.tar.gz
mv mpich-3.1.4 mpich-3.1.4_source
chown -R root:root mpich-3.1.4_source
rm mpich-3.1.4.tar.gz

# Create directory for mpich executables.
mkdir mpich-3.1.4

# Move to mpich source directory
cd mpich-3.1.4_source

# Remove tarball
rm mpich-3.1.4.tar.gz

# Configure and build
./configure --prefix=/usr/local/mpich-3.1.4
make -j2  #the j2 just amkes it faster by letting is use 2 cores
make install

