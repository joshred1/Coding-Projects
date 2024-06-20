# -*- coding: utf-8 -*-
"""
Lab 1: Arrays and Plotting

@author: Joshua
"""

import numpy as np
import math as m
import cmath as c
import matplotlib.pyplot as plt

#Lab Book: Given a complex number in Python how do we extract its real and imaginary parts? 

#Given a complex number z = a + bj, we can extract its real and imaginary 
#parts by the z.real and z.imag functions in the cmath module. For example:
    
z = complex(1,-1)
print()
print ("The real part of complex number is : ", z.real)
print ("The real part of complex number is : ", z.imag)

#Lab Book: Use Python’s complex numbers functionality to check Euler’s identity e^iπ = −1.

tol = 1e-8 #tolerance
c.exp(m.pi*1j) #complex exponential of pi* j 

#We can see that the output is approximately -1, this is due to the round off 
#error python incurs as the numbers are stored as floats. If we test Euler's 
#identity using a tolerance level of 1e-8, we see that it passes the test:
    
abs(c.exp(m.pi*1j) + 1) < tol

#ab Book: Given a vector x, write code which sets all elements of x to zero except the first and last elements, which should stay unchanged.

x = np.arange(1,11) #take x to be the sample array 
print("our original vector x = ", x)
x[1:-1] = 0
print("our modified x = ", x) 

#Lab Book: Write code which, given NumPy vectors x and y, calculates v1 and v2. By running your code on test vectors x = np.array([2.0, -3.0]) and y = np.array([1.0, 1.0]), show that your function produces the correct answer.

#The algorithm in question is known as the Gram- Schmidt Process, as such I'll name my function appropriately after this name.

def gram_schmidt(x,y):
    """
    Orthonormalises a set of vectors x and y in an inner product space, via 
    the Gram-Schmidt Process.    

    Parameters
    ----------
    x : Given NumPy vector of length n.
    y : Given NumPy vector of length n. Cannot be the zero vector

    Returns v1 and v2 as calculated by the Gram-Schmidt Process (array)
    -------

    """
    assert type(x) == np.ndarray, "x must be an array"
    assert type(y) == np.ndarray, "y must be an array"
    assert len(x) == len(y), "vectors of unequal length"
    assert np.all(y==0) == False, "y cannot be the zero vector"
   
    v1 = y*(x.T@y)/(y.T@y); v2 = x - v1
    return v1, v2 

x =  np.array([2.0, -3.0]); y = np.array([1.0, 1.0])
[v1,v2] = gram_schmidt(x, y)
print([v1,v2])

#We check our result as follows:   
x == v1 + v2 #output returns true for x1 and x2 
np.all(v2.T@y==0)  #dot product returns the zero vector and so is perpendicular to y
v1 == -0.5*y #v1 is a scalar multiple of y and hence is parallel to y.

#Hence our returned output is correct as confirmed by all TRUE statements.

#Lab Book: How would you calculate the determinant of the top-left 2 × 2 block of a 10 × 10 matrix? 

#Lets consider the 10x10 matrix A generated as follows:
    
A = np.diag([1,2,3,4,5,6,7,8,9,10])
A.shape #confirm matrix is 10x10
print(A)

B = A[:2,:2] #extract 2x2 block.
print(B)
np.linalg.det(B) #which we can confirm is correct.

#Lab Book: Write code which generates the 15 × 15 Hilbert matrix A, and creates the vector b which is the first column of A. Mathematically, what is the true solution to Ax = b? Solve the linear system Ax = b using np.linalg.solve and by calculating A^(−1)*b. What do you observe?

def hilbert(n):
    A = np.zeros((n,n)) # create an empty n*n matrix
    for i in range(n):
        for j in range(n):
            A[i,j] = 1/(i + j + 1) # fill entry (i,j)
    return A

A = hilbert(15) 
b = A[:,0]

x1 = np.linalg.solve(A, b) 
invA = np.linalg.inv(A)
x2 = invA @ b
print(x1); print(x2)

#We see that the solve function in python outputs a 15x1 vector containing 
#a 1 in the first row, and zeroes in all remaining rows. Solving via inverting the matrix A and multiplying with b returns a vector which severely
#different values. These include extreme numbers such as 351.281 and -276.75. This is because the Hilbert matrix is ill-conditioned and so is prone to numerical error. Thus inverting such a matrix is very unstable.

#Lab Book: Plot the above data with the points shown as green squares and with a dashed line, and show the figure in your lab book.

x =  np.array([0.5, 0.7, 0.9, 1.3, 1.7, 1.8])
y = y = np.array([0.1, 0.2, 0.75, 1.5, 2.1, 2.4])

plt.figure() 
plt.clf() 
plt.plot(x, y, color='g', linestyle='--', linewidth=1.5, marker='s', markersize=10) 
plt.show() 

#Lab Book: Add reasonable plot titles, gridlines and set some axis limits to the trendline plot above, and show the resulting figure in your lab book.

xtrend = np.array([0.5, 2.0])
ytrend = np.array([0.0, 2.7])

plt.figure()
plt.clf()
plt.plot(x, y, 'r.', markersize=10, label='Data')
plt.plot(xtrend, ytrend, 'b--', label='Trend line')
plt.legend(loc='best') 
plt.xlabel('x')
plt.ylabel('y')
plt.title('Plot of y w.r.t x')
plt.xlim(0, 2)
plt.ylim(0, 2.5) 
plt.grid()
plt.show()

#Lab Book: Plot the graphs of f(x) = 1/(1 + e^(ax)) for x ∈ [−4, 4], where a = 0.5, 1, 2, all in one figure (with appropriate legends and axis ranges).

x = np.linspace(-4, 4, 400); a = [0.5, 1, 2]
plt.figure()
plt.clf()
for i in a:
    fx = 1/(1 + np.exp(i*x))
    plt.plot(x, fx)
plt.grid()
plt.legend(['a=0.5','a=1','a=2'], loc='best') 
plt.xlabel('x')
plt.ylabel('f(x)')
plt.title('f(x) = 1/(1 + exp(a*x))')
plt.show()