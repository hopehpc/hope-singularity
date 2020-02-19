export AMBER_PREFIX="/usr/local/amber18"
export AMBERHOME=/usr/local/amber18
# Assume that /usr/local/cuda is a link that points to correct version
export CUDA_HOME=/usr/local/cuda
export PATH="${AMBER_PREFIX}/bin:${CUDA_HOME}/bin:${PATH}"
# Add location of Amber Python modules to default Python search path
if [ -z "$PYTHONPATH" ]; then
    export PYTHONPATH="${AMBER_PREFIX}/lib/python2.7/site-packages"
else
    export PYTHONPATH="${AMBER_PREFIX}/lib/python2.7/site-packages:${PYTHONPATH}"
fi
if [ -z "${LD_LIBRARY_PATH}" ]; then
   export LD_LIBRARY_PATH="${AMBER_PREFIX}/lib:${CUDA_HOME}/lib64"
else
   export LD_LIBRARY_PATH="${AMBER_PREFIX}/lib:${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"
fi
