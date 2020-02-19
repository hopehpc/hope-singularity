#!/bin/bash

# Move to install location
#   Assume that $WD variable has been defined
cd $WD

# Install cuda toolkit (and path) from RPMs.
#   Note that these RPMs were downloaded from NVidia at the following locations:
#     For CUDA verison 9.2 (and one patch)
#        https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda-repo-rhel7-9-2-local-9.2.148-1.x86_64
#        https://developer.nvidia.com/compute/cuda/9.2/Prod2/patches/1/cuda-repo-rhel7-9-2-148-local-patch-1-1.0-1.x86_64
#     For CUDA verison 9.1 (and three patches)
#        https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda-repo-rhel7-9-1-local-9.1.85-1.x86_64
#        https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/1/cuda-repo-rhel7-9-1-local-cublas-performance-update-1-1.0-1.x86_64
#        https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/2/cuda-repo-rhel7-9-1-local-compiler-update-1-1.0-1.x86_64
#        https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/3/cuda-repo-rhel7-9-1-local-cublas-performance-update-3-1.0-1.x86_64

# Based on this discussion: https://github.com/sylabs/singularity/issues/2421
#   I believe that we need to install just libraries within the container
#   and that the drivers need to be installed on the host O/S. Those drivers
#   then get connected into the container with the -nv option when calling
#   singularity. Note that driver versions and toolkit verions don't need
#   to be matched exactly. The driver can be upgraded to a nerwer version
#   without breaking existing code. But code compiled with a new toolkit 
#   will not run on an old driver. Here is a compatibility chart:
#      Toolkit        Driver must be this or newer
#      CUDA 10.1:     418.39
#      CUDA 10.0:     410.48
#      CUDA  9.2.148: 396.37
#      CUDA  9.2.88:  396.26
#      CUDA  9.1:     390.46
#      CUDA  9.0:     384.81
#      CUDA  8.0.61(GA2): 375.26
#      CUDA  8.0.44:  367.48
#      Chart is from: https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html


echo Doing rpm -i for main cuda rpm
rpm -i cuda-repo-rhel7-9-1-local-9.1.85-1.x86_64.rpm
echo Doing yum clean all
yum clean all

echo Doing yum install cuda-toolkit
# To install cuda libraries plus drivers and have it auto-update to new versions do
# yum install cuda
# To install cuda libraries plus drivers and have it stay at this version do
# yum install cuda-9-2
# To install drivers only do
# yum install cuda-drivers
# To install just the libraries do 
yum --assumeyes install cuda-toolkit-9-1

# I'm assuming that I need to 'install' the rpm for each patch so that yum knows about it
echo Doing rpm -i for all cuda patches
rpm -i cuda-repo-rhel7-9-1-local-cublas-performance-update-1-1.0-1.x86_64.rpm
rpm -i cuda-repo-rhel7-9-1-local-compiler-update-1-1.0-1.x86_64.rpm
rpm -i cuda-repo-rhel7-9-1-local-cublas-performance-update-3-1.0-1.x86_64.rpm

# I'm hoping that yum update will know that it needs to install the patch stuff.
echo Doing yum update
yum --assumeyes update

