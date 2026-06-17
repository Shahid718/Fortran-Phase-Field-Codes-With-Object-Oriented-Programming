# The Cahn-Hilliard Simulation Workflow

## 1. Initialize

```fortran
    call grid%create_grid(Nx=100, Ny=100, dx=1, dy=1)
    call grid%init_microstructure(c0=0.4, noise=0.02)
```

## 2. Time Evolution Loop

```fortran
    do tsteps = 1, 2000
        call grid%free_energy_derivative(A=1.0)
        call grid%laplace_evaluation
        call grid%time_integration(dt=0.01, mobility=1.0, grad_coef=0.5)
        
        ! Print progress every 1000 steps
        if (mod(tsteps, 1000) == 0) then
            print *, 'Done steps = ', tsteps
        end if
    end do
```

## 3. Output Results

```fortran
    call grid%output_results(filename="ch.dat")
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

## Output

```text
$ fpm run
Project is up to date
 Grid created:          100 x 100  with dx = 1 , dy = 1
 Initial microstructure created with c0= 0.400000006, noise= 1.99999996E-02

 === Starting Cahn-Hilliard Microstructure Evolution ===
 Done steps =         1000
 Done steps =         2000

 === Concentration Values (first 5x5) ===
  0.242215  0.094440  0.069763  0.131575  0.419407
  0.104601  0.067370  0.071002  0.119421  0.317621
  0.074307  0.092499  0.117752  0.139677  0.198643
  0.138068  0.255460  0.338779  0.314071  0.210396
  0.394589  0.702585  0.805664  0.716420  0.373453

 Results written to: ch.dat

 === Simulation Complete ===
  Time       =      1.156 seconds.

```