# -*- coding: utf-8 -*-
"""
Gaussian Elimination

@author: Joshua
"""

import numpy as np

def lu_factorisation(A):
    n = A.shape[0] # dimension of A
    L = np.eye(n) # L starts as the identity matrix
    U = A.copy() # U starts as A (we will put in zeros  as we go)
    for k in range(n-1): # column of U where we are adding zeros
        for i in range(k+1, n): # row of U to add zero
            L[i, k] = U[i,k] / U[k,k] # entry of L to zero out U[i,k]
            for j in range(k, n): # apply row operation to nonzero part of row i
                U[i, j] = U[i, j] - L[i, k]*U[k, j]
    return L, U