# Module 6: Gene regulatory networks

Two lecture notebooks and two projects:

1. `GuidoCollins_simplified01` --- transcription factor binding, mRNA and protein, promoter states, parameter sweeps, positive feedback
2. `GRN_Lecture` --- five network motifs: direct negative feedback, indirect negative feedback, double negative feedback, incoherent feed-forward, the Repressilator
3. `GRN_Project1` --- HW1: EC50 of an activator and IC50 of an inhibitor
4. `GRN_Project2` --- HW2: find a motif with a switch-like response

Each one exists twice: as a Matlab Live Script (`.mlx`) and as a Python notebook (`.ipynb`).
They cover the same material in the same order, so you can work through either, or open both side by side and compare.

`Networks.pdf` is the lecture slides, and `Networks.key` the Keynote they came from.

## The Matlab version

Open the `.mlx` in Matlab.

`guido_simplified01.m` is an older, slightly different copy of `GuidoCollins_simplified01.mlx` --- same model, but different parameter values and numbered figures.
The `.mlx` is the current one, and it is the one the Python translation follows.

`GRN_Project2.mlx` says the five motifs are in a file called `GRNs_for_HW2.m`.
There is no such file in this directory; the motifs are in `GRN_Lecture.mlx`, which is what the Python version points at.

Three small things the Python version corrects rather than copies, so a figure or a label may not match the Matlab exactly:

- `GuidoCollins_simplified01` section 1.1 steps both equations from the state at the start of the step. The Matlab's second line uses the value its first line has just overwritten, which lets the conserved total drift from 100 to 100.33 over the run.
- `GRN_Lecture` section 4 plots protein B in the bottom panel, in the protein colour. The Matlab plots gene B's mRNA there under a "Protein B" label; the two are within half a percent of each other, so only the colour really changes.
- The spelling is "promoter" throughout the Python, where the Matlab writes "promotor" --- including in axis labels.

## The Python version

Open the `.ipynb` in VSCode or JupyterLab.

You need the packages the notebooks import.
From the top of the repository:

```sh
uv sync
```

That builds `.venv/` from `pyproject.toml` and `uv.lock`, which pin the exact versions these notebooks were written against.
Then point your editor's kernel at `.venv`.
If you would rather use conda, pip, or a Python you already have, that will work too --- the notebooks need only numpy, scipy and matplotlib --- but the pinned versions are the ones known to run every cell.

`GRN_Lecture.ipynb` takes about half a minute to run end to end, almost all of it in the Repressilator at the bottom.

## Editing the Python notebooks

**The `.qmd` is the source; the `.ipynb` is generated from it.**
Edit the `.qmd` and re-render:

```sh
sh Module6/render.sh
```

That writes the `.ipynb` a student opens, plus an `.html` for previewing, and it runs every code cell on the way through --- so a broken cell is a failed render rather than something a student finds later.
Edits made directly in the `.ipynb` are overwritten by the next render.

Cells marked `#| eval: false` are the ones left for you to run or to write.
They arrive in the `.ipynb` as ordinary runnable cells with the directive stripped out.
