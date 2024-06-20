# -*- coding: utf-8 -*-
"""
Linear Solvers, Sparse Matrices

@author: Joshua
"""

import numpy as np
import scipy.linalg as linalg
import scipy.sparse as sparse
import scipy.sparse.linalg as sp
import matplotlib.pyplot as plt
import time


#Lab Book: By reading the documentation for np.linalg.norm, calculate the infinity norm of x and the Frobenius norm of A (for x and A as given in the above code). What is the ‘default’ choice for ord (i.e. what do you get if you just calculate np.linalg.norm(x) or np.linalg.norm(A))?

# Create an example vector
x = np.sin(np.arange(10))

# Create an example matrix
A = np.arange(36).reshape((6,6))

#infinity norm of x:
print("||x||_inf =", np.linalg.norm(x, ord=np.inf))

#frobenius norm of A:
print("||A||_F =", np.linalg.norm(A, ord="fro"))

#According to the documentation; for vectors the default (ie when ord=None) is the 2-norm, and for matrices it is the Frobenius norm. We see that both of these are true:
    
np.linalg.norm(x) == np.linalg.norm(x, ord=2)
np.linalg.norm(A) == np.linalg.norm(A, ord="fro")



#Lab Book: Run the above code. What is the solution x? Check this by measuring the size of the residual ||Ax − b||_2. By reading the documentation and the lecture notes, explain how lu and piv store the information in P, L and U.

# Create an example 6*6 linear system (related to elastic membranes)
n = 6
A = np.diag(np.ones(n-1), -1) - 2*np.diag(np.ones(n)) + np.diag(np.ones(n-1), 1)
b = np.ones(n)
# Calculate LU factorisation
lu, piv = linalg.lu_factor(A)
# Solve a linear system using a previously computed LU factorisation
x = linalg.lu_solve((lu, piv), b)

#residual:
np.linalg.norm(A@x-b, ord=2)

#clearly the residual is extremely small, and so the calculated solution is very accurate. 

#scipy stores the condensed form of the LU matrix factors; that is, the zeros and ones along the diagonal of the lower triangular matrix L are replaced by the corresponding values in the upper triangle of U. piv represents the permutation matrix P (the inverse of P in the standard PA=LU factorisation). This storage method is more efficients as we can save storage by not having to have 3 separate matrices containing some redundant information.



#Lab Book: Explain why the np.linalg.solve applied to the Hilbert matrix (as per the above code) produces such a bad answer.

n = 15
#######
def hilbert(n):
    A = np.zeros((n,n)) 
    for i in range(n):
        for j in range(n):
            A[i,j] = 1/(i + j + 1) 
    return A

A = hilbert(n) 
#######
xtrue = np.ones((n,))
b = A @ xtrue # RHS of Ax=b with known solution xtrue
x = np.linalg.solve(A, b) # Gaussian Elimination with partial pivoting
print("Relative error of np.linalg.solve =", np.linalg.norm(x - xtrue) / np.linalg.norm(xtrue))

print("kappa(A) =", np.linalg.cond(A))

#The conditional number of the Hilbert matrix is astronomically large, which suggests that problem of solving Ax=b is very sensitive to perturbations (which is unavoidable due to rounding error). 



#Lab Book: Based on the LU factorisation code given in lectures, write your own function which implements Gaussian Elimination with partial pivoting (i.e. produces the factorisation PA = LU). Your function should produce P, L and U as dense n × n matrices. For an example linear system of your own, show that your function gives the same answer as scipy.linalg.lu.

def lu_factorisation(A):
    n= A.shape[0] 
    L = np.eye(n) 
    U = A.copy() 
    P = np.eye(n) 
    for k in range(n-1): 
        for i in range(k+1,n):
            if np.fabs(U[i,k]) > np.fabs(U[k,k]):
                U[[k,i]]= U[[i,k]] 
                P[[k,i]]= P[[i.k]] 
                break
        for i in range(k+1, n):
            L[i, k] = U[i,k] / U[k,k]
            for j in range (k, n):
                U[i,j]= U[i,j] - L[i,k]*U[k,j]
    return P.T, L, U

n = 6
A = np.diag(np.ones(n-1), -1) - 2*np.diag(np.ones(n)) + np.diag(np.ones(n-1), 1)
p,l,u = lu_factorisation(A)

#we can verify that this function yields the pivot matrix, a lower triangular matrix for L, and an upper triangular matrix cor U. We compare this result to scipy's equivalent implementation as follows:
    
p1,l1,u1 = linalg.lu(A)

p == p1; l == l1; u == u1

#Comparing the outputs we find that the corresponding matrices are identical.



#Lab Book: Write your own function which, given a pre-computed factorisation P A = LU, solves a linear system Ax = b. For the same example linear system as the previous question, show that your function gives the same answer as a built-in NumPy/SciPy routine.

def factor_solve(P, L, U, b):
    y = np.linalg.solve(L, P@b)
    x = np.linalg.solve(U, y)
    return x 

#Using p,l,u from the previous question we have:

b = np.ones(n)
x = factor_solve(p, l, u, b)

#Using the original matrix A (which we factorised in the previous question):
A = np.diag(np.ones(n-1), -1) - 2*np.diag(np.ones(n)) + np.diag(np.ones(n-1), 1)
x1 = np.linalg.solve(A,b)

x == x1
#Statement returns true, thereby confirming that the function returns the same solution as the Numpy routine.



#Lab Book: Using the above code, check that A = QR and QTQ = I, at least up to rounding error. Do not just print both sides of the equality, use matrix norms to print out summary information (this approach is necessary for large matrices). 

# Create an example 6*6 linear system (related to elastic membranes)
n = 6
A = np.diag(np.ones(n-1), -1) - 2*np.diag(np.ones(n)) + np.diag(np.ones(n-1), 1)
b = np.ones(n)
# Calculate QR factorisation
Q, R = np.linalg.qr(A)
# Solve a linear system using a QR factorisation
x = linalg.solve_triangular(R, Q.T @ b, lower=False)

#we can check that A=QR and QTQ=I(accounting for rounding error via a certain tolerance level) by checking the residuals. 
np.linalg.norm(A-Q@R, ord="fro")
np.linalg.norm(Q.T@Q-np.eye(Q.shape[1]), ord="fro")

#Both these values are extremely small and so we can conclude that the matrices equations are equal. 



#Lab Book: Complete the above code to get an implementation of CG (based on ‘classic’ version in Algorithm 2 of the lecture slides). Make sure you only interact with A via performing exactly one matrixvector product in each iteration. The below code can be use to test your conjugate_gradient function by plotting the norms of the residuals krkk for a test symmetric positive definite system. Using the below test code for at least two choices of n, verify that CG converges in at most n iterations for an n × n matrix

def conjugate_gradient(A, b, x0, tol):
    # Initialise variables
    x = x0.copy()
    r = b - A@x
    d = r
    # Run the main CG loop
    k = 0
    residual_norm_history = []
    residual_norm_history.append(np.linalg.norm(r))
    while k < len(b) and np.linalg.norm(r) >= tol: # stop when k=n or small         residual
        # Complete CG iteration here
        alpha = (r.T@r)/(d.T@(A@d))
        x += x + alpha*d
        r1 = r - alpha*(A@d)
        # Store the norm of the current residual
        residual_norm_history.append(np.linalg.norm(r1))
        k += 1
        if np.linalg.norm(r1) < tol:
            return x, np.array(residual_norm_history)
        beta = (r1.T@r1)/(r.T@r)
        d = r1 + beta*d
        r = r1
    return x, np.array(residual_norm_history)

# Create example symmetric positive definite linear system

n = 10
A = -np.diag(np.ones(n-1), -1) + 2*np.diag(np.ones(n)) - np.diag(np.ones(n-1), 1)
b = np.arange(n)
x0 = np.zeros((n,))
# Solve with CG
x, resids = conjugate_gradient(A, b, x0, tol=1e-5)
print("Final residual ||Ax-b|| =", np.linalg.norm(A@x - b))
# Plot decrease in residuals
plt.figure(1)
plt.clf()
plt.semilogy(resids, 'o-')
plt.grid()
plt.xlabel('k')
plt.ylabel('||rk||')
plt.show()

n = 25
A = -np.diag(np.ones(n-1), -1) + 2*np.diag(np.ones(n)) - np.diag(np.ones(n-1), 1)
b = np.arange(n)
x0 = np.zeros((n,))
# Solve with CG
x, resids = conjugate_gradient(A, b, x0, tol=1e-5)
print("Final residual ||Ax-b|| =", np.linalg.norm(A@x - b))
# Plot decrease in residuals
plt.figure(1)
plt.clf()
plt.semilogy(resids, 'o-')
plt.grid()
plt.xlabel('k')
plt.ylabel('||rk||')
plt.show()

n = 50
A = -np.diag(np.ones(n-1), -1) + 2*np.diag(np.ones(n)) - np.diag(np.ones(n-1), 1)
b = np.arange(n)
x0 = np.zeros((n,))
# Solve with CG
x, resids = conjugate_gradient(A, b, x0, tol=1e-5)
print("Final residual ||Ax-b|| =", np.linalg.norm(A@x - b))
# Plot decrease in residuals
plt.figure(1)
plt.clf()
plt.semilogy(resids, 'o-')
plt.grid()
plt.xlabel('k')
plt.ylabel('||rk||')
plt.show()

#Testing the CG algorithm we see that the error converges to zero in n interations for each of the matrices. 



#Lab Book: Construct two 20×20 symmetric positive definite matrices with condition number κ(A) = 105: one with all eigenvalues distinct, and one with exactly 5 distinct eigenvalues (each with multiplicity 4).  You will need to explain how you know you have satisfied these requirements. Compare the performance of CG on both matrices.

np.random.seed(0)
n = 20
Q = np.linalg.qr(np.random.rand(n, n))[0]
v = np.arange(1, n) 
evals = np.append(v, 10e5) #n distinct eigenvalues
A = Q.T @ np.diag(evals) @ Q
b = np.arange(n)
x0 = np.zeros((n,))
tol = 1e-5
x, resids = conjugate_gradient(A, b, x0, tol)
plt.figure(1)
plt.clf()
plt.semilogy(resids, 'o-')
plt.grid()
plt.xlabel('k')
plt.ylabel('||rk||')
plt.show()

np.random.seed(1)
n = 20
Q = np.linalg.qr(np.random.rand(n, n))[0]
#n eigenvalues: 5 disinct of multiplicity 4. 
evals = np.array([1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,10e5,10e5,10e5,10e5])
B = Q.T @ np.diag(evals) @ Q
b = np.arange(n)
x0 = np.zeros((n,))
tol = 1e-5
x, resids = conjugate_gradient(B, b, x0, tol)
plt.figure(1)
plt.clf()
plt.semilogy(resids, 'o-')
plt.grid()
plt.xlabel('k')
plt.ylabel('||rk||')
plt.show()

#As can be seen in the above code, the desired eigenvalues can be specified, noting that for diagonal matrices, the diagonal entries are the eigenvalues. Since we want 20x20 (specified by n) symmetric (satisfied as these matrices are square and diagonal) positive definite matrices, we require all eigenvalues to be positive. To ensure the conditional number of these matrices is 10^5, we need (max |lambda|) / (min |lambda|) = k (derived from k = ||A||||A^-1||). For simplicity we set the smallest eigenvalue to be 1 and the largest to be 10^5 in both matrices. To show that k is indeed 10^5:
    
print("kappa(A) =", np.linalg.cond(A))
print("kappa(B) =", np.linalg.cond(B))

#k = 1000000 = 10^5 (accounting for rounding error). From the residuals plots, its clear that both of these methods converge faster than for the matrices in the previous question, which had only converged on the nth iteration. In the matrix with n distinct eigenvalues, convergence is faster than what we had previously, but we still have to wait till n iterations have passed for complete convergence. In the matric with 5 eigenvalues with multiplicity 4, the error converges to 0 rapidly (in just 4 iterations).



#Lab Book: Write code which generates the below n × n symmetric positive definite matrix A (where n can be changed to any value) as a sparse matrix in CSR format. For n = 5 check your code by converting A to a dense matrix and printing it out

n = 5 #dimension of square matrix
diagonals = [[1/12],[-4/3],[7/2],[-4/3],[1/12]] 
A_sparse = sparse.diags(diagonals, offsets=[-2,-1,0,1,2], format="csr", shape=(n,n))

#We can check that this is indeed the matrix we're after by looking at the standard form:
    
print(A_sparse.toarray())



#Lab Book: With b=np.arange(n), compare the time taken to solve Ax = b with spsolve and np.linalg.solve for n = 10, 100, 1000 and comment on your results. For np.linalg.solve, you will have to first convert A to a dense matrix (do not count this towards the time taken).

n = 10 
diagonals = [[1/12],[-4/3],[7/2],[-4/3],[1/12]] 
A_sparse = sparse.diags(diagonals, offsets=[-2,-1,0,1,2], format="csr", shape=(n,n))
A_dense = A_sparse.toarray()
b = np.arange(n)

t_start = time.time()
x_sparse = sp.spsolve(A_sparse, b)
t_end = time.time()
time_taken = t_end - t_start
print("Total time taken (seconds) =", time_taken)

t_start = time.time()
x_dense = np.linalg.solve(A_dense, b) 
t_end = time.time()
time_taken = t_end - t_start
print("Total time taken (seconds) =", time_taken)

#Time taken to solve Ax=b is the "same" whether we choose to use the sparce matrix or the dense matrix. This is because the matrix is small enough that differences in time are negligible.

n = 100
A_sparse = sparse.diags(diagonals, offsets=[-2,-1,0,1,2], format="csr", shape=(n,n))
A_dense = A_sparse.toarray()
b = np.arange(n)

t_start = time.time()
x_sparse = sp.spsolve(A_sparse, b)
t_end = time.time()
time_taken = t_end - t_start
print("Total time taken (seconds) =", time_taken)

t_start = time.time()
x_dense = np.linalg.solve(A_dense, b) 
t_end = time.time()
time_taken = t_end - t_start
print("Total time taken (seconds) =", time_taken)

#We see that the equation is solved about 10x faster for the sparse matrix than for when A is dense. The matrix A is now large enough that differences in computing time are detectable.


n = 1000
A_sparse = sparse.diags(diagonals, offsets=[-2,-1,0,1,2], format="csr", shape=(n,n))
A_dense = A_sparse.toarray()
b = np.arange(n)

t_start = time.time()
x_sparse = sp.spsolve(A_sparse, b)
t_end = time.time()
time_taken = t_end - t_start
print("Total time taken (seconds) =", time_taken)

t_start = time.time()
x_dense = np.linalg.solve(A_dense, b) 
t_end = time.time()
time_taken = t_end - t_start
print("Total time taken (seconds) =", time_taken)

#We see that the equation is solved about 40x faster for the sparse matrix than for when A is dense. What we also find is that the computation time for the sparse matrix is virtually the same as for the 100X100 dimension case, whereas the equation containing the dense matrix took 4x as long to solve.