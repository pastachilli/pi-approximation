program pi_seq
    implicit none
    integer :: count, i, n
    integer, parameter :: block_iter = 10000
    real(8) :: x, y, pi, tol, error
    real(8) :: start_time, end_time, total_time
  
    ! Desired tolerance (accuracy) for the π approximation
    tol = 1.0d-3
  
    count = 0
    n = 0
  
    ! Start timing
    call cpu_time(start_time)
  
    do
       do i = 1, block_iter
          call random_number(x)
          call random_number(y)
          n = n + 1
          if (x*x + y*y <= 1.0d0) then
             count = count + 1
          end if
       end do
  
       pi = 4.0d0 * count / n
       error = abs(pi - 3.141592653589793d0)
       if (error < tol) exit
    end do
  
    call cpu_time(end_time)
    total_time = end_time - start_time
  
    print *, "Approximated pi = ", pi
    print *, "Total iterations = ", n
    print *, "Error = ", error
    print *, "Time taken (s) = ", total_time
  end program pi_seq
  