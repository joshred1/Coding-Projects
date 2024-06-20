# -*- coding: utf-8 -*-
"""
Lab 2: Rootfinding and Interpolation 

@author: Joshua
"""

import numpy as np
import math as m
import matplotlib.pyplot as plt
import scipy.optimize as optimize
import scipy.interpolate as interpolate

def newton(f, df, x0, niters):
    """
    Newton's method for 1D rootfinding.
    - The function f(x) is the one we want the root of
    - The function df(x) is the derivative f'(x)
    - x0 is the starting point
    - niters is the number of iterations to run
    """
    x = x0 # initial guess
    print("{0:^3}{1:^25}{2:^25}".format("k", "xk", "f(xk)"))
    for i in range(niters):
        print("{0:^3}{1:^25.15e}{2:^25.15e}".format(i, x, f(x)))
        x = x - f(x)/df(x)
    return x

def secant(f, x1, x2, niters):
    """
    Secant method for 1D rootfinding.
    - The function f(x) is the one we want the root of
    - x1 and x2 are the two starting points
    - niters is the number of iterations to run
    """
    f1 = f(x1); f2 = f(x2)
    print("{0:^3}{1:^25}{2:^25}".format("k", "xk", "f(xk)"))
    for i in range(niters):
        print("{0:^3}{1:^25.15e}{2:^25.15e}".format(i, x2, f2))
        if f1 == f2:
            print('Secant method error: division by zero')
            return x2
        x3 = x2 - f2*(x2 - x1)/(f2 - f1)
        x1 = x2; f1 = f2
        x2 = x3; f2 = f(x3)
    return x2

#Lab Book: Make a plot of the function f(x) = e^(−x) − x, and use this to decide on a sensible choice of starting points. Run Newton’s method and the secant method for 10 iterations to find a root of f(x). Comment on the results.

def f(x):
    return m.exp(-x)-x

def df(x):
    return -m.exp(-x)-1 

x = np.linspace(-20, 20, 200)
plt.figure()
plt.clf()
plt.plot(x, np.exp(-x)-x)
plt.grid()
plt.xlabel('x')
plt.ylabel('f(x)')
plt.show()

x0 = 0 #reasonable choice as there are no critical points between x0 and the root of f.
newton(f, df, x0, 10)

#Check if newton solves f by plugging root back into f(x):
m.exp(-newton(f, df, x0, 10))-newton(f, df, x0, 10)
#output is 0.0 which suggests our solution is accurate. We also find that the method converges to the root very quickly

x1= 0; x2 = 1 #again, these two choices would be appropriate as theyre both relatively close to the root, and approximate a tangent at x0. 

secant(f, x1, x2, 10)

#check if second solves f by plugging root back into f(x):
m.exp(-secant(f, x1, x2, 10))-secant(f, x1, x2, 10)
#Output is 0.0 which suggests our solution is accurate. Infact the two algorithms yeild identical results to 16 dps.

#Lab Book: Run Newton’s method to find a root of f(x) = x^4 starting from x = 1. Comment on the results.

def g(x):
    return x**4

def dg(x):
    return 4*x**3

newton(g, dg, 1, 50)
#the method converges rather slowly to the root X=0.

#Lab Book: Brent’s method does not require the derivative f'(x). For f(x) = e^(−x) − x, how does it compare to the secant method?

#Brents method involves a combination of the secand method and the bisection method. This allows it to take advantage of the secant method for faster convergence, and can fall back to the bisection method when a more robust method is needed. As f(x) is this case doesn't involve turning points or discontinuities on its domain, the secant method is the desired form and so for both methods which suggests they should take equal time to converge on the root.
    
soln1 = optimize.root_scalar(f, bracket=(-1, 1), method = 'brentq') 
soln1 #method took 7 iterations 

soln2 = secant(f, -1, 1, 10) #division by zero error
soln2

#Multidimensional Rootfinding

def equations(p):
    x, y = p
    return(x + y - x*y + 2, x*m.exp(-y) - 1)

x, y =  optimize.fsolve(equations, (6, 6))
x1, y1 =  optimize.fsolve(equations, (10, 0))

#Interpolation 

p = np.poly1d([1,-3,4])
p(12)

def polyfit_vandermonde(xdata, ydata):
    """
    Given data (x0,y0), ..., (xn,yn),
    construct the unique interpolating polynomial by solving
    the Vandermonde linear system.
    """
    n = len(xdata) - 1
    if len(ydata) != n+1:
        print("xdata and ydata do not have the same length")
        return None # return a blank 'nothing' object
    # Build the Vandermonde matrix
    A = np.zeros((n+1,n+1))
    for i in range(n+1): # i=0,1,...,n (inclusive)
        A[:,n-i] = xdata**i
    # Solve the linear system
    a = np.linalg.solve(A, ydata)
    p = np.poly1d(a)
    return p

#Lab Book: Using 11 equally spaced nodes in [−1, 1], find the polynomial interpolant for Runge’s function. Make a graph of the true f(x) and the interpolant p(x) and comment on what you see.

x = np.linspace(-1, 1, 200)
plt.figure()
plt.clf()
plt.plot(x, 1/(1+25*x**2))
plt.grid()
plt.xlabel('x')
plt.ylabel('f(x)')
plt.show()

# Select interpolation nodes
x = np.linspace(-1, 1, 11) # equally spaced nodes
fx = 1/(1+25*x**2) 
p = interpolate.BarycentricInterpolator(x, fx) 
p(x) #interpolating polynomial

x = np.linspace(-1, 1, 200)
plt.figure()
plt.clf()
plt.plot(x, p(x))
plt.grid()
plt.xlabel('x')
plt.ylabel('p(x)')
plt.show()

#f(x) is a "bell-shaped" curve with just one turning point at the centre. The interpolant is not a good proxy for f as the 11 nodes correspond to 11 critical points and as such result in a very different curve. f and p are similar only in that they are symmetric, and there is a "general" bell-shape, however the error is considerably high, especially towards the endpoints (Runge phenomenon).

#Lab Book: Repeat the above experiment using Chebyshev points (i.e. interpolate Runge’s function at n + 1 Chebyshev points for n = 10). Plot the true f(x) and your new interpolant p(x) and compare to your previous result.

def chebyshev_points(n):
    '''
    Returns a vector of the Chebyshev points for interpolation to polynomials  
    of degree n. The vector has length n+1.
    '''
    x = []
    for i in range(n+1):
        x.append(m.cos((2*i+1)*m.pi/(2*n+2)))
    return np.array(x) 

x = chebyshev_points(10)
fx = 1/(1+25*x**2) 
p = interpolate.BarycentricInterpolator(x, fx) 
p(x)

x = np.linspace(-1, 1, 200)
plt.figure()
plt.clf()
plt.plot(x, p(x))
plt.grid()
plt.xlabel('x')
plt.ylabel('p(x)')
plt.show()

#Plotting p(x) we instantly see a vast improvement. The bell-shape is far more prominent, and the error does not grow considerably towards the endpoints. The oscillatory behaviour of the polynomial is less significant than for the equally-spaced nodes interpolant, and overall closely resembles f(x). 

#Lab Book: Repeat the above experiment using 11 equally spaced points in [−1, 1] and a cubic spline with “not-a-knot” extra conditions. Plot f(x) and your new interpolant and compare to your result for polynomial interpolation with equally spaced points.

x = np.linspace(-1, 1, 11) # equally spaced nodes
fx = 1/(1+25*x**2) 
p = interpolate.CubicSpline(x,fx,bc_type='not-a-knot',extrapolate=None)
p(x)

x = np.linspace(-1, 1, 200)
plt.figure()
plt.clf()
plt.plot(x, p(x))
plt.grid()
plt.xlabel('x')
plt.ylabel('p(x)')
plt.show()

#Plotting p(x) we immediately see that the interpolant is almost identical to f(x) (the bell-shape is just slightly wider). Unlike the previous two interpolants, this polynomial does not have any oscillatory characteristics and no Runge phenomena like we have in the original equally-spaced points interpolant.