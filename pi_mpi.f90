program pi_mpi
    use mpi
    implicit none
    integer :: ierr, rank, size, i, count, global_count, n_local, n_total
    integer, parameter :: block_iter = 10000
    real(8) :: x, y, pi, tol, error
    real(8) :: start_time, end_time, total_time
    integer, allocatable :: seed_vals(:)
    integer :: seed_size, j, done
  
    call MPI_Init(ierr)
    call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr)
    call MPI_Comm_size(MPI_COMM_WORLD, size, ierr)
  
    tol = 1.0d-8
    count = 0
    n_local = 0
  
    ! Initialize a different random seed per process
    call random_seed(size=seed_size)
    allocate(seed_vals(seed_size))
    do j = 1, seed_size
       seed_vals(j) = rank + j * 37
    end do
    call random_seed(put=seed_vals)
  
    if (rank == 0) then
       call cpu_time(start_time)
    end if
  
    done = 0
    do
       do i = 1, block_iter
          call random_number(x)
          call random_number(y)
          n_local = n_local + 1
          if (x*x + y*y <= 1.0d0) then
             count = count + 1
          end if
       end do
  
       ! Reduce to sum counts and iterations from all processes
       call MPI_Reduce(count, global_count, 1, MPI_INTEGER, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
       call MPI_Reduce(n_local, n_total, 1, MPI_INTEGER, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
  
       if (rank == 0) then
          pi = 4.0d0 * global_count / dble(n_total)
          error = abs(pi - 3.141592653589793d0)
          if (error < tol) then
             done = 1
          else
             done = 0
          end if
       end if
  
       ! Broadcast termination flag to all processes
       call MPI_Bcast(done, 1, MPI_INTEGER, 0, MPI_COMM_WORLD, ierr)
       if (done == 1) exit
    end do
  
    if (rank == 0) then
       call cpu_time(end_time)
       total_time = end_time - start_time
       print *, "Approximated pi = ", pi
       print *, "Total iterations = ", n_total
       print *, "Error = ", error
       print *, "Time taken (s) = ", total_time
    end if
  
    call MPI_Finalize(ierr)
  end program pi_mpi
  