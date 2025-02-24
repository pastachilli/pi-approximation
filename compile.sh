#!/bin/bash
# compile.sh - Compile the sequential and MPI versions of the pi approximation program

# Compile the Sequential Version
echo "Compiling sequential version (pi_seq_accuracy.f90)..."
gfortran -O2 -o pi_seq pi_seq_accuracy.f90
if [ $? -ne 0 ]; then
    echo "Error compiling pi_seq_accuracy.f90"
    exit 1
fi
echo "Sequential executable 'pi_seq' compiled successfully."

# Load the OpenMPI module for MPI compilation
echo "Loading OpenMPI module..."
module load openmpi

# Compile the MPI Parallel Version
echo "Compiling MPI version (pi_mpi_accuracy.f90)..."
mpif90 -O2 -o pi_mpi pi_mpi_accuracy.f90
if [ $? -ne 0 ]; then
    echo "Error compiling pi_mpi_accuracy.f90"
    exit 1
fi
echo "MPI executable 'pi_mpi' compiled successfully."

echo "Compilation complete!"
