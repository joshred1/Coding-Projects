# -*- coding: utf-8 -*-
"""
Created on Fri Mar  5 03:16:45 2021
This module includes the Richardson Extrapolation algorithms used in math3511
@author: Joshua
"""

import numpy as np
def richardson_central_differences(f, x, h, k):
    # Store all the values in a matrix R, where R[i,j] = phi_j(2**i * h)
    R = np.zeros((k+1,k+1))
    for i in range(k+1):
        # Create the first column of R
        # R[i,0] = central difference with step 2**i * h
        R[i,0] = (f(x + 2**i * h) - f(x - 2**i * h)) / (2 * 2**i * h)
    # Fill down each column recursively
    for j in range(1, k+1):
        for i in range(k-j+1):
            R[i,j] = (4**j * R[i,j-1] - R[i+1,j-1])/(4**j-1)
    return R[0,k] # return value phi_k(h)