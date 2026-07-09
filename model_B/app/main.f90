!------------------------------------------------------------------
! Main Program for Cahn-Hilliard Equation
!
! Compile and Run : fpm Run
!
! Programmer  : Shahid Maqbool
!
! Date modified : 6 Oct 2023 , 16 June 2026
!------------------------------------------------------------------

program fd_ch
    use phase_field_mod
    implicit none
    
    ! Create grid object
    type(PhaseFieldGrid) :: grid
    integer :: tsteps
    real(4) :: start_time, finish_time
    
    call cpu_time(start_time)
    
    ! Generate grid
    call grid%create_grid(Nx=100, Ny=100, dx=1, dy=1)
    
    ! Create initial microstructure
    call grid%init_microstructure(c0=0.4, noise=0.02)
    
    ! Time evolution
    print *, ''
    print *, '=== Starting Cahn-Hilliard Microstructure Evolution ==='
    
    do tsteps = 1, 2000
        call grid%free_energy_derivative(A=1.0)
        call grid%laplace_evaluation(grad_coef=0.5)
        call grid%time_integration(dt=0.01, mobility=1.0)
        
        ! Print progress every 1000 steps
        if (mod(tsteps, 1000) == 0) then
            print *, 'Done steps = ', tsteps
        end if
    end do
    
    ! Output results
    call grid%output_results(filename="ch.dat")
    
    call cpu_time(finish_time)
    
    print *, ''
    print *, '=== Simulation Complete ==='
    print '("  Time       = ", f10.3, " seconds.")', finish_time - start_time
    
end program fd_ch
