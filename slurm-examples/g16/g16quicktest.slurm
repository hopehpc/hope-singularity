#!/bin/sh
#SBATCH --job-name=g16test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=compute

# This job is set up as a 1 core job by default.
# To test Gaussian with a shared memory parallel calculation,
#   change the ntasks-per-node setting above to the number of 
#   cores that are desired.  

sif_file=${SIF_FILES}/g16_centos-7-6.sif
scratch_base=/scratch

#~~~~~~~~~~~~~~~~~~
export BASEFILE=$SLURM_JOB_NAME.$SLURM_JOBID   #Base filename for all in/out files
scratch_path=$scratch_base/$USER.$SLURM_JOBID  #Where the job will be run
storage_path=$SLURM_SUBMIT_DIR                 #Where output will be written back to

echo "Running g16 test calculation"
echo "  using $SLURM_NPROCS processors"
echo "  using container file $sif_file"
echo "  working in directory $scratch_path on node $HOSTNAME"
echo "  and saving output to $storage_path"

# Create temp directory within scratch
mkdir -p $scratch_path
# cd to temp directory and do everything else there
cd $scratch_path

#~~~~~~~~~~~~~~~~~
# Create script to run calculation within container
cat <<"@EOF" >$BASEFILE.sh
echo The following is running inside the container
echo
echo Some information about the node we are running on
df -h
echo Working dir is `pwd`
echo Hostname is `hostname`
echo
echo Source g16 environment setup
. $g16root/g16/bsd/g16.profile
echo Run job
g16 <$BASEFILE.in >$BASEFILE.out 2>$BASEFILE.err

@EOF

chmod +x $BASEFILE.sh

#~~~~~~~~~~~~~~~~~~~~
# Create input file for calculation
#   First write NProcShared if needed
#   and the route line.
if [ $SLURM_NPROCS -eq 1 ]
then
   echo "#N HF/6-31G(d,p) Force" >$BASEFILE.in
else
   echo "%NProcShared=$SLURM_NPROCS" >$BASEFILE.in
   echo "#N HF/6-31G(d,p) Force" >>$BASEFILE.in
fi

#   Then append the comment and the molecular structure.
cat <<"@EOF" >>$BASEFILE.in

H2CO Geometry Optimization force calc

0 1
C
O 1 B1
H 1 B2 2 A1
H 1 B3 2 A2 3 D1

A1 120.00000
A2 120.00000
D1 180.00000
B1 1.2750000
B2 1.0900000
B3 1.0900000

@EOF

#~~~~~~~~~~~~~~
# Now actually run the calculation
echo
singularity run $sif_file ./$BASEFILE.sh
echo

# Copy output files back to home directory
cp -p $BASEFILE* $storage_path/
if [ $? -eq 0 ]
then
  echo "files before clean up"
  ls -l
  echo
  cd $storage_path
  echo "Files were copied to the location:"
  pwd
  echo
  echo "cleaning up ..."
  rm -rf $scratch_path
  echo "files removed from scratch"
  echo "... job over"
  echo
else
  echo ERROR! Files were not copied back successfully from 
  echo   $scratch_path to $storage_path
  echo   Therefore, nothing was deleted. You can manually
  echo   go to the scratch directory on $SLURM_NODELIST and
  echo   retrieve output.
  echo
fi

