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
        
        ! Store A parameter
        this%A = A
        
        ! Compute derivative of free energy: df/dc = A*(2*c*(1-c)^2 - 2*c^2*(1-c))
        do i = 1, this%Nx
            do j = 1, this%Ny
                this%dfdcon(i, j) = A * (2.0 * this%con(i, j) * &
                    (1.0 - this%con(i, j))**2 - 2.0 * this%con(i, j)**2 * &
                    (1.0 - this%con(i, j)))
            end do
        end do

    end procedure
end submodule	