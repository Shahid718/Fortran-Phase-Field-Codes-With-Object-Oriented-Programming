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
                
                this%lap_phi(i, j) = (this%phi(ip, j) + this%phi(im, j) + &
                    this%phi(i, jm) + this%phi(i, jp) - 4.0 * this%phi(i, j)) / &
                    (this%dx * this%dy)
            end do
        end do
		
    end procedure
end submodule