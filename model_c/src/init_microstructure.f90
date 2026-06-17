!------------------------------------------------------------------
! Method 2: Initial microstructure 
! Circular nucleus with concentration and phase field
!
! Programmer  : Shahid Maqbool
!
! Date modified : 6 Oct 2023 , 16 June 2026
!------------------------------------------------------------------

submodule (phase_field_mod) init_microstructure_sub
    implicit none
contains
    module procedure init_microstructure
        integer :: i, j
        real(8) :: dx_center, dy_center
        
        ! Store radius
        this%radius = radius
        
        ! Create circular nucleus at center
        do i = 1, this%Nx
            do j = 1, this%Ny
                dx_center = real(i - this%Nx/2, kind=8)
                dy_center = real(j - this%Ny/2, kind=8)
                
                if (dx_center*dx_center + dy_center*dy_center < radius*radius) then
                    this%con(i, j) = 1.0
                    this%phi(i, j) = 1.0
                else
                    this%con(i, j) = 0.02
                    this%phi(i, j) = 0.0
                end if
            end do
        end do
        
        print *, "Initial microstructure created with nucleus radius=", radius
        
    end procedure
end submodule