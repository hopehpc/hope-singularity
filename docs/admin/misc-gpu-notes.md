# Miscellaneous GPU Notes

## Contents
1. [Testing a CUDA Container](#testing-a-cuda-container)
<br>

## Testing a CUDA Container
A CUDA 8.0 container can be tested by running the compiled samples on a GPU node. `cuda-8-0.def` can be found [here](https://github.com/hopehpc/hope-singularity/tree/master/definition-files/cuda); the samples are not compiled in any other container because they are CUDA 8.0 samples. 

On a GPU node, run the following commands:
```bash
$ singularity shell $SIF_FILES/cuda-8-0.sif
Singularity $ cd $CUDA_SAMPLES
Singularity $ ./<cuda-sample>
```
