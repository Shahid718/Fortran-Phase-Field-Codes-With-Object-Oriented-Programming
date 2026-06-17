!------------------------------------------------------------------
! Method 6: Output results
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
        
        ! Print to screen (first 5x5 sample)
        print *, ""
        print *, "=== Concentration Values (first 5x5) ==="
        do i = 1, min(5, this%Nx)
            write(*, '(5F10.6)') (this%con(i, j), j = 1, min(5, this%Ny))
        end do
        print *, ""
        
        ! Write to file (full grid)
        open(newunit=fileunit, file=filename, status='replace')
        do i = 1, this%Nx
            write(fileunit, *) (this%con(i, j), j = 1, this%Ny)
        end do
        close(fileunit)
        
        print *, "Results written to: ", trim(filename)
        
    end procedure
end submodule