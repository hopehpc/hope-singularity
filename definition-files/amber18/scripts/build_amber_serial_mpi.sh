# build_amber_serial_mpi.sh
# A script to build the serial and mpi versions of amber and amberTools

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
make install 2>&1 | tee amber18_gcc_install_2019-09-09-2300.stdouterr 


#~~~~~~~~~~~~~~
# Configure and build mpi/parallel components
 
# First cleanup the previous build
cd $AMBERHOME
make clean

# If using gcc, add MPI to path and library path ENV variables
export LD_LIBRARY_PATH=/usr/local/mpich-3.1.4/lib:$LD_LIBRARY_PATH
export PATH=/usr/local/mpich-3.1.4/bin:$PATH

# Run configure
# for gcc
./configure -mpi gnu
. $AMBERHOME/amber.sh

cd $AMBERHOME
make install 2>&1 | tee amber18_gccmpi_install_2019-09-09-2300.stdouterr 

