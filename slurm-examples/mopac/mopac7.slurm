#!/bin/sh
#SBATCH --job-name=mopac7_test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=compute

sif_file=${SIF_FILES}/mopac7_centos-7-6.sif
scratch_base=/scratch
mopacroot=/usr/local/mopac7

#~~~~~~~~~~~~~~~~~~
export BASEFILE=$SLURM_JOB_NAME.$SLURM_JOBID   #Base filename for all in/out files
scratch_path=$scratch_base/$USER.$SLURM_JOBID  #Where the job will be run
storage_path=$SLURM_SUBMIT_DIR                 #Where output will be written back to

echo "Running mopac7 test calculation"
echo "  using $SLURM_NPROCS processors"
echo "  using container file $sif_file"
echo "  working in directory $scratch_path on node $HOSTNAME"
echo "  and saving output to $storage_path"
echo

# Create temp directory within scratch
mkdir -p $scratch_path
# cd to temp directory and do everything else there
cd $scratch_path

#~~~~~~~~~~~~~~~~~
echo Creating env variables for mopac files in host OS

export FOR005=$BASEFILE.dat
export FOR006=$BASEFILE.out
export FOR009=$BASEFILE.res
export FOR010=$BASEFILE.den
export FOR011=$BASEFILE.log
export FOR012=$BASEFILE.arc
export FOR013=$BASEFILE.gpt
export FOR016=$BASEFILE.syb
export FOR020=$BASEFILE.ump
export SETUP=SETUP.DAT
export SHUTDOWN=$BASEFILE.end

#===================
echo Creating input file $BASEFILE.dat
cat <<@ > $BASEFILE.dat
PRECISE ef p1994 am1 SYMMETRY GRADIENTS
Phosphine HERR= -1.08 DERR= 0.60 CERR=-1.31

H
P 1.323947 1 0.000000 0 0.000000 0 1 0 0 0.4897
H 1.323947 0 97.134488 1 0.000000 0 2 1 0 -0.1633
H 1.323947 0 97.134488 0 98.050307 1 2 1 3 -0.1633
0 0.000000 0 0.000000 0 0.000000 0 0 0 0
2, 1, 3,
2, 1, 4,
3, 2, 4,
@
#====================

# Now actually run the calculation
echo Calling singularity exec
singularity exec $sif_file $mopacroot/mopac.exe $BASEFILE <$BASEFILE.dat 2>$BASEFILE.err 

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

