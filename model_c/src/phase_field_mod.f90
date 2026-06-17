!-------------------------------------------------------------------------------
! Module with type definition and procedure interfaces for Model C
! (Coupled Cahn-Hilliard and Allen-Cahn)
!
! Programmer  : Shahid Maqbool
!
! Date modified : 6 Oct 2023 , 16 June 2026
!------------------------------------------------------------------------

module phase_field_mod
    implicit none
    
    ! Type definition
    type, public :: PhaseFieldGrid
        integer :: Nx, Ny, dx, dy
        real(8) :: A, B, D, dt
        real(8) :: mobility_con, mobility_phi
        real(8) :: grad_coef_con, grad_coef_phi
        real(8) :: radius
        real(8), dimension(:,:), allocatable :: con
        real(8), dimension(:,:), allocatable :: phi
        real(8), dimension(:,:), allocatable :: dfdcon
        real(8), dimension(:,:), allocatable :: dfdphi
        real(8), dimension(:,:), allocatable :: lap_con
        real(8), dimension(:,:), allocatable :: lap_phi
        real(8), dimension(:,:), allocatable :: dummy_con
        real(8), dimension(:,:), allocatable :: lap_dummy
        real(8), dimension(:,:), allocatable :: phi_dummy
    contains
        procedure :: create_grid              ! Procedure 1
        procedure :: init_microstructure      ! Procedure 2
        procedure :: free_energy_derivative   ! Procedure 3
        procedure :: laplace_evaluation       ! Procedure 4
        procedure :: time_integration         ! Procedure 5
        procedure :: apply_bounds             ! Procedure 6
        procedure :: output_results           ! Procedure 7
    end type PhaseFieldGrid

    ! Interface blocks to declare the procedures
    interface
        module subroutine create_grid(this, Nx, Ny, dx, dy)
            class(PhaseFieldGrid), intent(inout) :: this
            integer, intent(in) :: Nx, Ny, dx, dy
        end subroutine
        
        module subroutine init_microstructure(this, radius)
            class(PhaseFieldGrid), intent(inout) :: this
            real(8), intent(in) :: radius
        end subroutine
        
        module subroutine free_energy_derivative(this, A, B, D)
            class(PhaseFieldGrid), intent(inout) :: this
            real(8), intent(in) :: A, B, D
        end subroutine
        
        module subroutine laplace_evaluation(this)
            class(PhaseFieldGrid), intent(inout) :: this
        end subroutine

        module subroutine time_integration(this, dt, mobility_con, mobility_phi, &
                grad_coef_con, grad_coef_phi)
            class(PhaseFieldGrid), intent(inout) :: this
            real(8), intent(in) :: dt, mobility_con, mobility_phi
            real(8), intent(in) :: grad_coef_con, grad_coef_phi
        end subroutine
        
        module subroutine apply_bounds(this)
            class(PhaseFieldGrid), intent(inout) :: this
        end subroutine
        
        module subroutine output_results(this, phi_filename, con_filename)
            class(PhaseFieldGrid), intent(in) :: this
            character(len=*), intent(in) :: phi_filename
            character(len=*), optional, intent(in) :: con_filename
        end subroutine
    end interface

end module phase_field_mod