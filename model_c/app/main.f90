!------------------------------------------------------------------
! Main Program for Model C (Coupled Cahn-Hilliard / Allen-Cahn)
! Simulates phase separation with concentration and order parameter
!
! Compile and Run : fpm Run
!
! Programmer  : Shahid Maqbool
!
! Date modified : 6 Oct 2023 , 16 June 2026
!------------------------------------------------------------------

program fd_ch_ac
    use phase_field_mod
    implicit none
    
    ! Create grid object
    type(PhaseFieldGrid) :: grid
    integer :: istep
    integer, parameter :: nsteps = 10000
    integer, parameter :: nprint = 1000
    real(8) :: start_time, finish_time
    
    call cpu_time(start_time)
    
    ! Generate grid
    call grid%create_grid(Nx=128, Ny=128, dx=1, dy=1)
    
    ! Create initial microstructure (circular nucleus)
    call grid%init_microstructure(radius=10.0_8)
    
    ! Time evolution
    print *, ''
    print *, '=== Starting Model C Microstructure Evolution ==='
    print *, 'Total steps:', nsteps
    print *, ''
    
    do istep = 1, nsteps
        ! Compute free energy derivatives
        call grid%free_energy_derivative(A=1.0_8, B=1.0_8, D=1.0_8)
        
        ! Compute Laplacians
        call grid%laplace_evaluation
        
        ! Time integration
        call grid%time_integration(dt=0.03_8, mobility_con=0.5_8, mobility_phi=0.5_8, &
            grad_coef_con=1.5_8, grad_coef_phi=1.5_8)
        
        ! Apply bounds to phase field
        call grid%apply_bounds
        
        ! Print progress
        if (mod(istep, nprint) == 0) print *, 'Done steps = ', istep
        
        ! Output intermediate results
        if (istep == 1) then
            call grid%output_results(phi_filename="phi_1.dat")
        end if
        
        if (istep == 10000) then
            call grid%output_results(phi_filename="phi_10000.dat", &
                con_filename="con_10000.dat")
        end if
    end do
    
    call cpu_time(finish_time)
    
    print *, ''
    print *, '=== Simulation Complete ==='
    print '("  Time       = ", f10.3, " seconds.")', finish_time - start_time
    
end program fd_ch_ac