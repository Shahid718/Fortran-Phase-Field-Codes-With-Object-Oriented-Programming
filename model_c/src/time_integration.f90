!------------------------------------------------------------------
! Method 5: Time integration for Model C
! Cahn-Hilliard for concentration and Allen-Cahn for phase field
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
        
        ! Store parameters
        this%dt = dt
        this%mobility_con = mobility_con
        this%mobility_phi = mobility_phi
        this%grad_coef_con = grad_coef_con
        this%grad_coef_phi = grad_coef_phi
        
        ! Update concentration (Cahn-Hilliard)
        do i = 1, this%Nx
            do j = 1, this%Ny
                this%con(i, j) = this%con(i, j) + dt * mobility_con * &
                    this%lap_dummy(i, j)
            end do
        end do
        
        ! Update phase field (Allen-Cahn)
        do i = 1, this%Nx
            do j = 1, this%Ny
                this%phi(i, j) = this%phi(i, j) - dt * mobility_phi * &
                    this%phi_dummy(i, j)
            end do
        end do
        
    end procedure
end submodule