# The Cahn-Hilliard Simulation Workflow

## 1. Initialize

```fortran
    call grid%create_grid(Nx=128, Ny=128, dx=1, dy=1)
    call grid%init_microstructure(radius=10.0_8)
```

## 2. Time Evolution Loop

```fortran
    do istep = 1, nsteps
        call grid%free_energy_derivative(A=1.0_8, B=1.0_8, D=1.0_8)
        call grid%laplace_evaluation
        call grid%time_integration(dt=0.03_8, mobility_con=0.5_8, mobility_phi=0.5_8, &
            grad_coef_con=1.5_8, grad_coef_phi=1.5_8)
        call grid%apply_bounds
        if (mod(istep, nprint) == 0) print *, 'Done steps = ', istep
    end do
```

## 3. Output Results

```fortran
    call grid%output_results(phi_filename="phi_1.dat")
    call grid%output_results(phi_filename="phi_10000.dat", &
                con_filename="con_10000.dat")
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
│   ├── apply_bounds.f90          # Submodule: Apply bounds
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

## Output

```text
$ fpm run
Project is up to date
 Grid created:          128 x 128  with dx= 1 , dy= 1
 Initial microstructure created with nucleus radius=   10.000000000000000

 === Starting Model C Microstructure Evolution ===
 Total steps:       10000

 Phase field written to: phi_1.dat
 Done steps =         1000
 Done steps =         2000
 Done steps =         3000
 Done steps =         4000
 Done steps =         5000
 Done steps =         6000
 Done steps =         7000
 Done steps =         8000
 Done steps =         9000
 Done steps =        10000
 Phase field written to: phi_10000.dat
 Concentration written to: con_10000.dat

 === Simulation Complete ===
  Time       =     25.641 seconds.
```