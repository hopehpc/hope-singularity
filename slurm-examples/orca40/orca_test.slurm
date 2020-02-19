#!/bin/sh
#SBATCH --job-name=orca_test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=compute

# This job is set up as a 1 core job by default.
# To test ORCA with a shared memory parallel calculation,
#   change the ntasks-per-node setting above to the number of 
#   cores that are desired.  

maxram=18000                                     #Max RAM available for calculation, in MB (24000 = 24GB). 
                                                 #  For orca should be 75% of total memory in machine or less
scratch_base=/scratch                            #Local scratch on compute node
sif_file=${SIF_FILES}/orca4012_centos-7-6.sif    #Name of container image to use

#~~~~~~~~~~~~~~~~~~~~~~
export BASEFILE=$SLURM_JOB_NAME.$SLURM_JOBID     #Base filename for all files
scratch_path=$scratch_base/$USER.$SLURM_JOBID    #Where the job will be run
storage_path=$SLURM_SUBMIT_DIR                   #Where output will be written back to
export OMP_NUM_THREADS=$SLURM_NPROCS             #Number of processors for orca parallel using OpenMPI
maxcorevalue=$(($maxram/$OMP_NUM_THREADS))       #Use nprocs to calculate RAM available per core

echo "Running orca test calculation"
echo "  using $OMP_NUM_THREADS processors"
echo "  using container file $sif_file"
echo "  working in directory $scratch_path on node $HOSTNAME"
echo "  and saving output to $storage_path"

# Create temp directory within scratch
mkdir -p $scratch_path

# Create file with a list of nodes for each processing core
#   If there are N cores, there must be N lines to this file
#   even if all cores are on the same node.
# Assume that we are only using 1 node.
# First put name of node into a new file
echo $SLURM_NODELIST > $scratch_path/$BASEFILE.nodes
# Now append N-1 more copies of that node into the same file
for ((i=1;i<$OMP_NUM_THREADS;i++))
do
  echo $SLURM_NODELIST >> $scratch_path/$BASEFILE.nodes
done

# cd to temp directory and do everything else here
cd $scratch_path

#~~~~~~~~~~~~~~~~~
cat <<"@EOF" >$BASEFILE.sh
echo The following is running inside the container
df -h
echo Working dir is `pwd`
echo Hostname is `hostname`
echo Source the orca setup script
source $ORCADIR/orca_setup.sh

echo Run job
$ORCADIR/orca $BASEFILE.in >$BASEFILE.out 2>$BASEFILE.err

@EOF

chmod +x $BASEFILE.sh
#~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~
# Create the input file

# First put in the 'route' line
echo "! B3LYP def2-svp opt" >$BASEFILE.in

# Next if using more then one core, tell program how many cores to use
if [ $OMP_NUM_THREADS -gt 1 ]
then
   echo "%pal" >>$BASEFILE.in
   echo " nprocs $OMP_NUM_THREADS" >>$BASEFILE.in
   echo end >>$BASEFILE.in
fi

# Then max RAM per core
echo "%maxcore $maxcorevalue" >>$BASEFILE.in

# Now put in the structure of the molecule
cat <<"@EOF" >>$BASEFILE.in

* xyz 0 1
C  0.0  0.0  -0.6
O  0.0  0.0  0.6
*

@EOF
#~~~~~~~~~~~~~~~~~~~~

/usr/bin/time -f "Walltime: %e seconds\tMax memory use: %M kbytes" -o $BASEFILE.runinfo singularity run $sif_file ./$BASEFILE.sh
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
  echo ERROR! Files were not copied back from $scratch_path
  echo   Therefore, nothing was deleted. You can manually
  echo   go to the scratch directory on $SLURM_NODELIST and
  echo   retrieve output.
  echo
fi


