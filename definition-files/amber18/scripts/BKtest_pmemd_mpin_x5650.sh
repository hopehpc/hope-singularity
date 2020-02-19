#!/bin/bash
# This job will run one set of amber (pmemd) mpi tests 
# The number of cores should be specified on the command line
# e.g.    ./BKtest_pmemd_mpin_x5650.sh 4    for a 4 core job.
# For pmemd testing it is typical to run tests using 2, 4, 8, and 11 cores.
# User needs to be root to run this because it needs to write to /usr/local/amber18

NPROCS=$1
echo Running Amber pmemd mpi tests using $NPROCS cores.

date_string=`date +%Y-%m-%d_%H-%M-%S`
logdir="${AMBERHOME}/logs/test_pmemd_parallel"
#logdir="/home/krieg/testing/logs/test_pmemd_parallel"
logprefix="${logdir}/${date_string}"
logfile="${logprefix}.log"
difffile="${logprefix}.diff"

mkdir -p ${logdir}

cd $AMBERHOME/test

# set up parallel command for use with amber:
export DO_PARALLEL='mpirun -n '$NPROCS
echo The DO_PARALLEL variable contains: $DO_PARALLEL

#Run the test programs
(make -k -f Makefile test.parallel.pmemd 2>&1) | tee ${logfile}
(make -k -f Makefile test.parallel.pmemd.gem 2>&1) | tee -a ${logfile}
(make -k -f Makefile finished.parallel 2>&1) | tee -a ${logfile}

#Parse the output
passed_count=`grep PASS ${logfile} | wc -l`
questionable_count=`grep -e "FAILURE:" -e "FAILED:" ${logfile} | wc -l`
error_count=`grep "Program error" ${logfile} | wc -l`

echo "${passed_count} file comparisons passed" | tee -a ${logfile}
echo "${questionable_count} file comparisons failed" | tee -a ${logfile}
echo "${error_count} tests experienced errors" | tee -a ${logfile}

echo "Test log file saved as ${logfile}" | tee -a ${logfile}

if [ -f TEST_FAILURES.diff ]; then
   mv TEST_FAILURES.diff ${difffile}
   echo "Test diffs file saved as ${difffile}" | tee -a ${logfile}
else
   echo "No test diffs to save!" | tee -a ${logfile}
fi

