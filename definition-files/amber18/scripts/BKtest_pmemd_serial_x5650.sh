#!/bin/bash
# This job will run one set of amber tests (serial AmberTools)
# User needs to be root to run this because it needs to write to /usr/local/amber18

date_string=`date +%Y-%m-%d_%H-%M-%S`
logdir="${AMBERHOME}/logs/test_pmemd_serial"
#logdir="/home/krieg/testing/logs/test_pmemd_serial"
logprefix="${logdir}/${date_string}"
logfile="${logprefix}.log"
difffile="${logprefix}.diff"

mkdir -p ${logdir}

#Run the test programs
cd $AMBERHOME/test
(make -k -f Makefile test.serial.pmemd 2>&1) | tee ${logfile}
(make -k -f Makefile test.serial.pmemd.gem 2>&1) | tee -a ${logfile}
(make -k -f Makefile finished.serial 2>&1) | tee -a ${logfile}

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

