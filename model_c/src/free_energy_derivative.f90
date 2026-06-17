!------------------------------------------------------------------
! Method 3:  free_energy_derivative
! dfdcon and dfdphi for coupled CH-AC system
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
        real(8) :: phi3, phi4, phi5, phi6
        real(8) :: h_phi, dh_dphi
        
        ! Store parameters
        this%A = A
        this%B = B
        this%D = D
        
        do i = 1, this%Nx
            do j = 1, this%Ny
                ! Interpolation function: h(phi) = phi^3*(10 - 15*phi + 6*phi^2)
                phi3 = this%phi(i,j)**3
                phi4 = this%phi(i,j)**4
                phi5 = this%phi(i,j)**5
                phi6 = this%phi(i,j)**6
                
                h_phi = 10.0*phi3 - 15.0*phi4 + 6.0*phi5
                dh_dphi = 30.0*phi3 - 60.0*phi4 + 30.0*phi5
                
                ! Derivative with respect to concentration
                ! df/dc = 2*A*c*(1 - h(phi)) - 2*B*(1 - c)*h(phi)
                this%dfdcon(i, j) = 2.0*A*this%con(i,j)*(1.0 - h_phi) - &
                    2.0*B*(1.0 - this%con(i,j))*h_phi
                
                ! Derivative with respect to phase field
                ! df/dphi = -A*c^2*dh/dphi + 2*B*(1-c)^2*dh/dphi + 
                !           2*D*phi*(1-phi)*(1-2*phi)
                this%dfdphi(i, j) = -A*this%con(i,j)*this%con(i,j)*dh_dphi + &
                    2.0*B*(1.0 - this%con(i,j))*(1.0 - this%con(i,j))*dh_dphi + &
                    2.0*D*this%phi(i,j)*(1.0 - this%phi(i,j))* &
                    (1.0 - 2.0*this%phi(i,j))
            end do
        end do
        
    end procedure
end submodule