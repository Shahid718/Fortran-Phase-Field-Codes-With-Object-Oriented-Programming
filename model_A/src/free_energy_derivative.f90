!------------------------------------------------------------------
! Method 3:  free_energy_derivative
!
! Programmer  : Shahid Maqbool
!
! Date modified : 6 Oct 2023 , 16 June 2026
!------------------------------------------------------------------

submodule (phase_field_mod) free_energy_derivative_sub
    implicit none
contains
    module procedure free_energy_derivative
        integer :: i, j
		
        ! Store A 
        this%A = A
		
        do i = 1, this%Nx
            do j = 1, this%Ny
                this%dfdphi(i, j) = this%A * (2.0 * this%phi(i, j) * &
                    (1.0 - this%phi(i, j))**2 * (1.0 - 2.0 * this%phi(i, j)))
            end do
        end do

    end procedure
end submodule	