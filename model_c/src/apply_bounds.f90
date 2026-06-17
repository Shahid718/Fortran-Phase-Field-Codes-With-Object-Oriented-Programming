!-------------------------------------------------------------------------------
! Method 6: Apply bounds to phase field
! Ensures phi stays within physical limits [0, 1]
!
! Programmer  : Shahid Maqbool
!
! Date modified : 6 Oct 2023 , 16 June 2026
!------------------------------------------------------------------

submodule (phase_field_mod) apply_bounds_sub
    implicit none
contains
    module procedure apply_bounds
        integer :: i, j
        
        do i = 1, this%Nx
            do j = 1, this%Ny
                if (this%phi(i, j) >= 0.99999)  this%phi(i, j) = 0.99999
                if (this%phi(i, j) < 0.00001)   this%phi(i, j) = 0.00001
            end do
        end do
        
    end procedure
end submodule