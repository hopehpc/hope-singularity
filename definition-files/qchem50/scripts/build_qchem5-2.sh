# build_qchem5-2.sh
# A script to build the serial and multicore versions of Q-Chem

#!/bin/bash

# Move to /usr/local and run the installation script
#   Expect that the .def file copied qcinstall.sh to /usr/local during prep
cd /usr/local

# First, create a file with text to serve as input for the installer script
#   Using webmo.net as a guide:
#     n -> new installation (present for 5.0, this line is NOT present for 5.2)
#     /usr/local/qchem52 -> path for installation
#     1 -> option 1, install shared memory parallel version (not MPI)
#          for version 50 option 4 is the serial/multicore parallel version (not MPI)
#          note that option 5 includes GPU support (not sure if we have license for that or not)
#     /scratch  -> the full path for the scratch directory
#     8000    -> upper memory limit (in MB)
#     n -> no, I do not want to view the license agreement
#     1628 -> order number
#     polik@webmo.net -> email associated with order number
#     y -> confirm that the above information is correct
#     1 -> to specify node-locked licensing (not present for 5.0)
SCRIPT=tempconfigscript.txt
cat <<"@EOF" >$SCRIPT
/usr/local/qchem52
1
/scratch
8000
n
1628
polik@webmo.net
y
1

@EOF

# Now actually run the installer
cat $SCRIPT | ./qcinstall.sh

# Move the license files to the correct place
#   Not sure why there are two, but that is what Polik
#   had done with the old mu3c, so just duplicating it.
mv /usr/local/qchem.license.dat /usr/local/qchem50/qcaux/license/
mv /usr/local/qchem.license.dat.serial /usr/local/qchem50/qcaux/license/

# Move the more up to date manual into a good place
mv /usr/local/qchem_manual_5.0.pdf /usr/local/qchem50/doc/

# Remove the installer and temp script
rm /usr/local/qcinstall.sh
rm /usr/local/$SCRIPT

