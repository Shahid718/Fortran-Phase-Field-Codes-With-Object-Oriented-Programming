# The Allen-Cahn Simulation Workflow

## 1. Initialize

```fortran
call grid%create_grid(Nx=128, Ny=128, dx=2, dy=2)
call grid%init_microstructure(phi_0=0.5, noise=0.02)
```

## 2. Time Evolution Loop

```fortran
do tsteps = 1, 1500
    call grid%free_energy_derivative(A=1.0)
    call grid%laplace_evaluation()
    call grid%time_integration(dt=0.01, mobility=1.0, grad_coef=1.0)
end do
```

## 3. Output Results

```fortran
call grid%output_results(filename="ac.dat")
```

## Repository Structure

```text
model_A/
│
├── app/
│   └── main.f90                  # Main program
│
├── src/
│   ├── phase_field_mod.f90       # Main module with type definition
│   │
│   ├── create_grid.f90           # Submodule: Grid creation
│   ├── init_microstructure.f90   # Submodule: Initial microstructure
│   ├── free_energy_derivative.f90# Submodule: Free energy derivative
│   ├── laplace_evaluation.f90    # Submodule: Laplace operator
│   ├── time_integration.f90      # Submodule: Time integration
│   └── output_results.f90        # Submodule: Results output
│
├── fpm.toml                      # Fortran Package Manager file
│
├── README.md                     # This file
│
├── LICENSE                       # License file
│
├── .gitignore                    # Git ignore file
│
└── data/
    └── (simulation output files)
```
