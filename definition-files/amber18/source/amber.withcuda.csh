setenv AMBERHOME "/usr/local/amber18"
# Assume that /usr/local/cuda is a link that points to correct version
setenv CUDA_HOME "/usr/local/cuda"
setenv PATH "${AMBERHOME}/bin:${CUDA_HOME}/bin:${PATH}"
# Add location of Amber Python modules to default Python search path
if( ! ($?PYTHONPATH) ) then
    setenv PYTHONPATH "${AMBERHOME}/lib/python2.7/site-packages"
else
    setenv PYTHONPATH "${AMBERHOME}/lib/python2.7/site-packages:${PYTHONPATH}"
endif
if( ! ($?LD_LIBRARY_PATH) ) then
   setenv LD_LIBRARY_PATH "${AMBERHOME}/lib:${CUDA_HOME}/lib64"
else
   setenv LD_LIBRARY_PATH "${AMBERHOME}/lib:${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"
endif
