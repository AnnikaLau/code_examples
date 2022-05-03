#!/bin/bash
make TARGET=gpu

export CRAY_CUDA_MPS=1
export MPICH_RDMA_ENABLED_CUDA=1
export PGI_ACC_SYNCHRONOUS=1
export PGI_COMPARE=summary,compare,rel=12,abs=5,patchall

srun -N 1 --ntasks-per-node=1 -p debug -A g110 -C gpu code 2>&1 | tee gpu.log 
