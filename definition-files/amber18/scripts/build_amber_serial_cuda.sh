# build_amber_serial_cuda.sh
# A script to build the serial and cuda versions of amber and amberTools

#!/bin/bash

# Move to amberhome (expect that $AMBERHOME is defined in container definition file)
cd $AMBERHOME
echo Verify that we are in amberhome
pwd

# Normally, we'd clean up any old installation first, but 
#   this is not needed here because we are starting from a 
#   completely clean install.
#make uninstall

# There is some issue with AmberTools patch 10 and it fails.
#   Try to circumvent this by doing an upgrade to AmberTools19
#echo y | ./update_amber --upgrade
# This also fails, so just skip updating for now.

#~~~~~~~~~~~~~~
# Now configure (full options available using ./configure --full-help)
#   First, create tiny script to serve as input to the configure script
#   The first line is to say no, don't update (because update #10 is broken)
#   The second line is to say yes, install miniconda
SCRIPT=tempconfigscript.txt
cat <<"@EOF" >$SCRIPT
n
y

@EOF

#   Now actually run configure
echo Run configure for serial gnu installation
#./configure gnu
# The line below is for ubuntu
#./configure -noX11 --with-python /usr/bin/python3 gnu
# The line below is for centos 
#./configure --with-python /bin/python3 gnu
cat $SCRIPT | ./configure gnu

. $AMBERHOME/amber.sh

#~~~~~~~~~~~~~~
# Build all of the serial components

# make install
echo Make install
make install 2>&1 | tee amber18_gcc_install_2019-12-23-1700.stdouterr 


#~~~~~~~~~~~~~~
# Configure and build cuda components
 
# First cleanup the previous build
cd $AMBERHOME
make clean

# Set CUDA_HOME, add CUDA to path and library path ENV variables
#   Assume that /usr/local/cuda is a link that points to current cuda version
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda/bin:$PATH

# Run configure
cd $AMBERHOME
echo run configure for CUDA gnu installation
./configure -cuda gnu
. $AMBERHOME/amber.sh

cd $AMBERHOME
echo make install
make install 2>&1 | tee amber18_gcccuda_install_2019-12-23-1700.stdouterr 

