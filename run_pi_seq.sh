#!/bin/bash
#$ -N pi_seq_job
#$ -cwd
#$ -pe smp 1
#$ -q AMCS
#$ -l h_rt=00:05:00
#$ -o pi_seq_output.txt
#$ -e pi_seq_error.txt

./pi_seq