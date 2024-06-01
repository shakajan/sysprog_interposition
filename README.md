# sysprog_interposition
- system programming study: calling `malloc`, `free` function with interpositioning at compile-time, link-time, and run-time.

# notice
- `printf` uses `malloc` function itself, so function for printing is replaced by `write` at run-time.

# how-to-use
- `make` commands: `make compile`, `make link`, `make run`, and also `make clean` to clean the created files.
