export AMBER_PREFIX="/usr/local/amber18"
export AMBERHOME=/usr/local/amber18
export PATH="${AMBER_PREFIX}/bin:/usr/local/mpich-3.1.4/bin:${PATH}"
# Add location of Amber Python modules to default Python search path
if [ -z "$PYTHONPATH" ]; then
    export PYTHONPATH="${AMBER_PREFIX}/lib/python2.7/site-packages"
else
    export PYTHONPATH="${AMBER_PREFIX}/lib/python2.7/site-packages:${PYTHONPATH}"
fi
if [ -z "${LD_LIBRARY_PATH}" ]; then
   export LD_LIBRARY_PATH="${AMBER_PREFIX}/lib:/usr/local/mpich-3.1.4/lib"
else
   export LD_LIBRARY_PATH="${AMBER_PREFIX}/lib:/usr/local/mpich-3.1.4/lib:${LD_LIBRARY_PATH}"
fi
