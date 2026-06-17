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
        
        ! Cahn-Hilliard time integration: dc/dt = M * laplacian(mu)
        ! where mu = df/dc - kappa*laplacian(c)
        do i = 1, this%Nx
            do j = 1, this%Ny
                this%con(i, j) = this%con(i, j) + dt * mobility * &
                    this%lap_dummy(i, j)
                
                ! Enforce bounds (for numerical stability)
                if (this%con(i, j) >= 0.99999)  this%con(i, j) = 0.99999
                if (this%con(i, j) < 0.00001)   this%con(i, j) = 0.00001
            end do
        end do
        
    end procedure
end submodule