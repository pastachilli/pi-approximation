#!/bin/bash
#$ -N pi_mpi_job
#$ -cwd
#$ -pe mpi 4          # Adjust the number of processes as needed
#$ =q AMCS
#$ -l h_rt=00:10:00
#$ -o pi_mpi_output.txt
#$ -e pi_mpi_error.txt

module load openmpi
mpirun ./pi_mpi