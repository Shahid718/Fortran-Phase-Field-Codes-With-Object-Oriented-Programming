!------------------------------------------------------------------
! Method 5: time_integration
!
! Programmer  : Shahid Maqbool
!
! Date modified : 6 Oct 2023 , 16 June 2026
!------------------------------------------------------------------

submodule (phase_field_mod) time_integration_sub
    implicit none
contains
    module procedure time_integration
        integer :: i, j
        
        this%dt = dt
        this%mobility = mobility
        this%grad_coef = grad_coef
		
        do i = 1, this%Nx
            do j = 1, this%Ny
                this%dummy_phi(i, j) = this%dfdphi(i, j) - this%grad_coef * this%lap_phi(i, j)
                this%phi(i, j) = this%phi(i, j) - this%dt * this%mobility * this%dummy_phi(i, j)
            end do
        end do
		
    end procedure
end submodule	