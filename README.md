## Files

- **pi_seq_accuracy.f90** – Sequential Fortran source code.
- **pi_mpi_accuracy.f90** – MPI parallel Fortran source code.
- **run_pi_seq.sh** – SGE job script for the sequential version.
- **run_pi_mpi.sh** – SGE job script for the MPI version.

---

## Compilation

### Sequential Version
Compile with gfortran:
```bash
gfortran -O2 -o pi_seq pi_seq_accuracy.f90
```

Compile with MPI:
```bash
mpif90 -O2 -o pi_mpi pi_mpi_accuracy.f90
```

## Run
Run the programs with either 
```bash
qsub run_pi_mpi.sh
``` 
or
```bash
qsub run_pi_seq.sh
```