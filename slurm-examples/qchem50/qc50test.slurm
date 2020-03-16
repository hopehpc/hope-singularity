#!/bin/sh
#SBATCH --job-name=qc_test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=compute

# This job is set up as a 1 core job by default.
# To test Q-Chem with a shared memory parallel calculation,
#   change the ntasks-per-node setting above to the number of 
#   cores that are desired.  

sif_file=${SIF_FILES}/qchem5-0_centos-7-6.sif
scratch_base=/scratch

#~~~~~~~~~~~~~~~~~~
export BASEFILE=$SLURM_JOB_NAME.$SLURM_JOBID   #Base filename for all in/out files
scratch_path=$scratch_base/$USER.$SLURM_JOBID  #Where the job will be run
storage_path=$SLURM_SUBMIT_DIR                 #Where output will be written back to

echo "Running qchem test calculation"
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
df -h
echo Working dir is `pwd`
echo Hostname is `hostname`
echo Environment is
env
echo ""
echo Run job
if [ $SLURM_NPROCS -eq 1 ]
then
  qchem $BASEFILE.in > $BASEFILE.out
else
  qchem -nt $SLURM_NPROCS $BASEFILE.in > $BASEFILE.out
fi

@EOF

chmod +x $BASEFILE.sh

#~~~~~~~~~~~~~~~~~~~~
# Create input file for calculation
cat <<"@EOF" >$BASEFILE.in
$comment
water      HF/6-31G*   Vibrational frequencies
$end

$molecule
0  1
O
H1 O OH
H2 O OH H1 HOH

OH  = 0.947
HOH = 105.5
$end

$rem
JOBTYPE            FREQ     Vibrational frequencies
METHOD             HF       HF exchange
BASIS              6-31G*   Basis Set
$end

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

