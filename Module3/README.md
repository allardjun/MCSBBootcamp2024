# Module 3: Numerical calculus

Four notebooks, in order:

1. `numericalCalculus_1Functions` --- functions, samples, and the difference between them
2. `numericalCalculus_2Derivatives` --- finite differences, higher derivatives, Taylor series
3. `numericalCalculus_3DifferentialEquations` --- ODEs, Euler stepping, library solvers, steady states
4. `numericalCalculus_4SystemsOfODEs` --- coupled ODEs, phase planes, direction fields

Each one exists twice: as a Matlab Live Script (`.mlx`) and as a Python notebook (`.ipynb`).
They cover the same material in the same order, so you can work through either, or open both side by side and compare.

## The Matlab version

Open the `.mlx` in Matlab.
`uBlackBox.m` is a function two of the notebooks call; leave it where it is.

## The Python version

Open the `.ipynb` in VSCode or JupyterLab.
`u_black_box.py` is the counterpart of `uBlackBox.m` and, likewise, has to stay in this directory for the notebooks that import it to find it.

You need the packages the notebooks import.
From the top of the repository:

```sh
uv sync
```

That builds `.venv/` from `pyproject.toml` and `uv.lock`, which pin the exact versions these notebooks were written against.
Then point your editor's kernel at `.venv`.
If you would rather use conda, pip, or a Python you already have, that will work too --- the notebooks need only numpy, scipy and matplotlib --- but the pinned versions are the ones known to run every cell.

## Editing the Python notebooks

**The `.qmd` is the source; the `.ipynb` is generated from it.**
Edit the `.qmd` and re-render:

```sh
sh Module3/render.sh
```

That writes the `.ipynb` a student opens, plus an `.html` for previewing, and it runs every code cell on the way through --- so a broken cell is a failed render rather than something a student finds later.
Edits made directly in the `.ipynb` are overwritten by the next render.

Cells marked `#| eval: false` are the ones left for you to run or to write.
They arrive in the `.ipynb` as ordinary runnable cells with the directive stripped out.
