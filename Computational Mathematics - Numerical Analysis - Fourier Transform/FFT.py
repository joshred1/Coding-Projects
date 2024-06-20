# -*- coding: utf-8 -*-
"""
Fast Fourier Transform 

@author: Joshua
"""

import numpy as np 
import cmath 

def fft(x):
    n = len(x) # n must be a power of 2
    # Base case
    if n == 1:
        F1 = np.array([1.0])
        return np.array([F1 @ x]) # force to be vector of length 1
    
    # Recursive case
    omega_n = cmath.exp(-2 * cmath.pi * 1j / n)
    y = x[::2] # even entries [x0,x2,...] using clever NumPy indexing
    z = x[1::2] # odd entries [x1,x3,...]
    yhat = fft(y)
    zhat = fft(z)
    xhat = np.zeros((n,), dtype=complex)
    for j in range(n // 2): # using integer division
        xhat[j] = yhat[j] + omega_n**j * zhat[j]
        xhat[j+n//2] = yhat[j] - omega_n**j * zhat[j]
    return xhat