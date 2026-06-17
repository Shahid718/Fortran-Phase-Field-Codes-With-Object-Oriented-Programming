!------------------------------------------------------------------
! Method 7: Output results for Model C
! Saves phi and optionally concentration to files
!
! Programmer  : Shahid Maqbool
!
! Date modified : 6 Oct 2023 , 16 June 2026
!------------------------------------------------------------------

submodule (phase_field_mod) output_results_sub
    implicit none
contains
    module procedure output_results
        integer :: i, j, fileunit
        
        ! Output phase field
        open(newunit=fileunit, file=phi_filename, status='replace')
        do i = 1, this%Nx
            write(fileunit, *) (this%phi(i, j), j = 1, this%Ny)
        end do
        close(fileunit)
        
        print *, "Phase field written to: ", trim(phi_filename)
        
        ! Output concentration if requested
        if (present(con_filename)) then
            open(newunit=fileunit, file=con_filename, status='replace')
            do i = 1, this%Nx
                write(fileunit, *) (this%con(i, j), j = 1, this%Ny)
            end do
            close(fileunit)
            print *, "Concentration written to: ", trim(con_filename)
        end if
        
    end procedure
end submodule