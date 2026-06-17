!------------------------------------------------------------------
! Method 1 : Grid generation
!
! Programmer  : Shahid Maqbool
!
! Date modified : 6 Oct 2023 , 16 June 2026
!------------------------------------------------------------------

submodule (phase_field_mod) create_grid_sub
    implicit none
contains
    module procedure create_grid
        ! Store grid parameters
        this%Nx = Nx
        this%Ny = Ny
        this%dx = dx
        this%dy = dy
        
        ! Allocate arrays
        allocate(this%phi(Nx, Ny))
        allocate(this%r(Nx, Ny))
        allocate(this%dfdphi(Nx, Ny))
        allocate(this%lap_phi(Nx, Ny))
        allocate(this%dummy_phi(Nx, Ny))		
			
        print *, "Grid created: ", Nx, "x", Ny, " with dx=", dx, ", dy=", dy
        
    end procedure
end submodule