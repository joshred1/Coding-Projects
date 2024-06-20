# -*- coding: utf-8 -*-
"""
Created on Thu Apr  1 19:11:34 2021
This module includes the Romberg Integration algorithms used in math3511
@author: Joshua
"""

import numpy as np
def romberg(f, a, b, m):
    h = b - a
    # Store all the values in a matrix R, where R[i,j] = T_{i+1}(f, h / 2**(-j))
    R = np.zeros((m+1,m+1))
    R[0,0] = (f(a) + f(b)) * h/2
    for i in range(1, m+1):
        # Create the first column of R recursively (top to bottom)
        R[i,0] = 0.5 * R[i-1,0]
        for k in range(2**(i-1)):
            R[i,0] = R[i,0] + h/2**i * f(a + (1+2*k)*h/2**i)
    # Fill each column recursively
    for j in range(1, m+1):
        for i in range(j, m+1):
            R[i,j] = (4**j * R[i,j-1] - R[i-1,j-1])/(4**j-1)
    return R[m,m] # return value T_{m+1}(f, h/2**m)