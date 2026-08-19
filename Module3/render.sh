#!/bin/sh
# Render the Module 3 notebooks: .qmd in, .ipynb out, with an .html beside it to read.
#
# The .qmd is the source of truth and the only file to edit. The .ipynb is generated from it, and is what a student opens and runs; the .html is for previewing while authoring and is not committed.
#
# Run it from anywhere:  sh Module3/render.sh

set -eu

MODULE_DIR=$(cd "$(dirname "$0")" && pwd)
REPO_DIR=$(dirname "$MODULE_DIR")
VENV_PYTHON="$REPO_DIR/.venv/bin/python"

# Point quarto at this repo's venv rather than letting it take whichever python is first on PATH.
# Quarto's own version of this failure arrives as a render error inside a document and says nothing about environments, so it is worth catching here.
if [ ! -x "$VENV_PYTHON" ]; then
  echo "No .venv in $REPO_DIR. Build it first with:  uv sync" >&2
  exit 1
fi
QUARTO_PYTHON="$VENV_PYTHON"
export QUARTO_PYTHON

# Matplotlib otherwise stamps the current time into every SVG it writes, so an unchanged notebook would produce a different figure on every render.
# A fixed constant rather than the commit date, so the figures do not all change on every commit. The other half of this is svg.hashsalt in Module3/matplotlibrc.
SOURCE_DATE_EPOCH=0
export SOURCE_DATE_EPOCH

cd "$MODULE_DIR"

for qmd in numericalCalculus_*.qmd; do
  stem=${qmd%.qmd}
  echo "--- $stem"
  # html first: the python executes once and jupyter-cache serves the second render, which is also what forces the two outputs to have come from the same run.
  quarto render "$qmd" --to html --quiet
  quarto render "$qmd" --to ipynb --quiet
  "$VENV_PYTHON" - "$stem.ipynb" <<'PY'
# Make the rendered .ipynb fit to commit. Two fixes, both to things quarto emits that are correct but not reproducible or not ours to ship.
#
# 1. The absolute kernel path. A jupyter-engine kernelspec comes out as {name, display_name, language, path}, and that path is this machine's --- /Users/<someone>/.../.venv/share/jupyter/kernels/python3 --- baked into a file students download.
#    It is not part of the nbformat spec and no client needs it; `name` is what VSCode and JupyterLab resolve a kernel from.
#
# 2. Random cell ids. nbformat 4.5 gives every cell an `id`, and quarto generates a fresh uuid for each one on every render, so every re-render would show up as a diff rewriting every cell with pure noise.
#    Numbering them by position is stable across renders, still unique within the notebook, and when one does change the diff means something: a cell was added, removed or moved.
import json, sys

path = sys.argv[1]
with open(path) as fh:
    nb = json.load(fh)

nb.get("metadata", {}).get("kernelspec", {}).pop("path", None)

for i, cell in enumerate(nb.get("cells", [])):
    if "id" in cell:
        cell["id"] = f"cell-{i}"

with open(path, "w") as fh:
    json.dump(nb, fh, indent=1, ensure_ascii=False)
    fh.write("\n")
PY
done

echo "done"
