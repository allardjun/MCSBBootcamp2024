"""A function defined in a file of its own, rather than in the notebook that uses it.

The Python counterpart of uBlackBox.m, and it is here for the same reason: to be a
function whose insides you cannot see from the place you call it. Notebook 1 calls it
to make the point that a function is a black box; notebook 2 differentiates it without
ever being told what it is.

Import it with:

    from u_black_box import u_black_box
"""

import numpy as np


def u_black_box(t):
    """Fluorescence signal at time t, in seconds. Works on a scalar or on an array."""
    a_hidden = 1.1  # fluorescence intensity units
    omega_hidden = 2.6  # rad/s
    a0_hidden = 0.01
    b_hidden = 0.5

    return a_hidden * np.sin(omega_hidden * t) + a0_hidden + b_hidden * np.cos(omega_hidden * t)
