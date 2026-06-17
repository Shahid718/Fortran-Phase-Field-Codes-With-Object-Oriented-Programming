!------------------------------------------------------------------------
! Module with type definition and procedure interfaces for Cahn-Hilliard
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
        real(4) :: A, dt, mobility, grad_coef, c0
        real(4), dimension(:,:), allocatable :: con
        real(4), dimension(:,:), allocatable :: r
        real(4), dimension(:,:), allocatable :: dfdcon
        real(4), dimension(:,:), allocatable :: lap_con
        real(4), dimension(:,:), allocatable :: dummy_con
        real(4), dimension(:,:), allocatable :: lap_dummy
    contains
        procedure :: create_grid              ! Procedure 1
        procedure :: init_microstructure      ! Procedure 2
        procedure :: free_energy_derivative   ! Procedure 3
        procedure :: laplace_evaluation       ! Procedure 4
        procedure :: time_integration         ! Procedure 5
        procedure :: output_results           ! Procedure 6
    end type PhaseFieldGrid

    ! Interface blocks to declare the procedures
    interface
        module subroutine create_grid(this, Nx, Ny, dx, dy)
            class(PhaseFieldGrid), intent(inout) :: this
            integer, intent(in) :: Nx, Ny, dx, dy
        end subroutine
        
        module subroutine init_microstructure(this, c0, noise)
            class(PhaseFieldGrid), intent(inout) :: this
            real(4), intent(in) :: c0, noise
        end subroutine
        
        module subroutine output_results(this, filename)
            class(PhaseFieldGrid), intent(in) :: this
            character(len=*), intent(in) :: filename
        end subroutine
        
        module subroutine free_energy_derivative(this, A)
            class(PhaseFieldGrid), intent(inout) :: this
            real(4), intent(in) :: A
        end subroutine
        
        module subroutine laplace_evaluation(this)
            class(PhaseFieldGrid), intent(inout) :: this
        end subroutine

        module subroutine time_integration(this, dt, mobility, grad_coef)
            class(PhaseFieldGrid), intent(inout) :: this
            real(4), intent(in) :: dt, mobility, grad_coef
        end subroutine
    end interface

end module phase_field_mod