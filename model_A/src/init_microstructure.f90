!------------------------------------------------------------------
! Method 2: Initial microstructure
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
        real(4) :: random_val
        
        ! Initialize random seed
        call random_seed()
        
        ! Generate random microstructure
        do i = 1, this%Nx
            do j = 1, this%Ny
                call random_number(random_val)
                this%r(i, j) = random_val
                this%phi(i, j) = phi_0 + noise * (0.5 - random_val)
            end do
        end do
        
        print *, "Initial microstructure created with phi_0=", phi_0, ", noise=", noise
        
    end procedure
end submodule