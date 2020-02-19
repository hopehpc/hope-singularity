setenv AMBERHOME "/usr/local/amber18"
setenv PATH "${AMBERHOME}/bin:/usr/local/mpich-3.1.4/bin:${PATH}"
# Add location of Amber Python modules to default Python search path
if( ! ($?PYTHONPATH) ) then
    setenv PYTHONPATH "${AMBERHOME}/lib/python2.7/site-packages"
else
    setenv PYTHONPATH "${AMBERHOME}/lib/python2.7/site-packages:${PYTHONPATH}"
endif
if( ! ($?LD_LIBRARY_PATH) ) then
   setenv LD_LIBRARY_PATH "${AMBERHOME}/lib:/usr/local/mpich-3.1.4/lib"
else
   setenv LD_LIBRARY_PATH "${AMBERHOME}/lib:/usr/local/mpich-3.1.4/lib:${LD_LIBRARY_PATH}"
endif
