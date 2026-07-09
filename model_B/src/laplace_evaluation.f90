!------------------------------------------------------------------
! Method 4: Laplace evaluation
!
! Programmer  : Shahid Maqbool
!
! Date modified : 6 Oct 2023 , 16 June 2026
!------------------------------------------------------------------


submodule (phase_field_mod) laplace_evaluation_sub
    implicit none
contains
    module procedure laplace_evaluation
        integer :: i, j, ip, im, jp, jm
        this%grad_coef = grad_coef
        
        ! Compute Laplacian of concentration
        do i = 1, this%Nx
            do j = 1, this%Ny
                ip = i + 1
                im = i - 1
                jp = j + 1
                jm = j - 1
                
                if (im == 0)            im = this%Nx
                if (ip == this%Nx + 1)  ip = 1
                if (jm == 0)            jm = this%Ny
                if (jp == this%Ny + 1)  jp = 1
                
                ! Laplacian of concentration
                this%lap_con(i, j) = (this%con(ip, j) + this%con(im, j) + &
                    this%con(i, jm) + this%con(i, jp) - 4.0 * this%con(i, j)) / &
                    (this%dx * this%dy)
                
                ! Chemical potential: mu = df/dc - kappa*laplacian(c)
                this%dummy_con(i, j) = this%dfdcon(i, j) - &
                    this%grad_coef * this%lap_con(i, j)
            end do
        end do
        
        ! Compute Laplacian of chemical potential
        do i = 1, this%Nx
            do j = 1, this%Ny
                ip = i + 1
                im = i - 1
                jp = j + 1
                jm = j - 1
                
                if (im == 0)            im = this%Nx
                if (ip == this%Nx + 1)  ip = 1
                if (jm == 0)            jm = this%Ny
                if (jp == this%Ny + 1)  jp = 1
                
                ! Laplacian of chemical potential
                this%lap_dummy(i, j) = (this%dummy_con(ip, j) + &
                    this%dummy_con(im, j) + this%dummy_con(i, jm) + &
                    this%dummy_con(i, jp) - 4.0 * this%dummy_con(i, j)) / &
                    (this%dx * this%dy)
            end do
        end do
        
    end procedure
end submodule
