#!/bin/bash
rm pcast_compare.dat
make TARGET=cpu
#export PGI_COMPARE=disable
export PGI_COMPARE=create
srun -n 1 -p debug -A g110 -C gpu code 2>&1  | tee cpu.log
