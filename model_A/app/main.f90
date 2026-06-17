!-------------------------------------------------------------------------------
! Main Program
! Compile and Run : fpm Run
!
! Programmer  : Shahid Maqbool
!
! Date modified : 6 Oct 2023 , 16 June 2026
!------------------------------------------------------------------

program fd_ac
    use phase_field_mod
    implicit none
    
    ! Create grid object
    type(PhaseFieldGrid) :: grid
    integer :: tsteps

    ! Generate grid
    call grid%create_grid(Nx=128, Ny=128, dx=2, dy=2)
    
    ! Create initial microstructure
    call grid%init_microstructure(phi_0=0.5, noise=0.02)
    
	! Time evolution
    print *, ''
    print *, '=== Starting Microstructure Evolution ==='
    
    do tsteps = 1, 1500
        call grid%free_energy_derivative(A=1.0)
		call grid%laplace_evaluation
        call grid%time_integration(dt=0.01, mobility=1.0, grad_coef=1.0)	
	end do
		
    ! calling method 
    call grid%output_results(filename="ac.dat")
    print *, '=== Simulation Complete ==='
    
end program fd_ac