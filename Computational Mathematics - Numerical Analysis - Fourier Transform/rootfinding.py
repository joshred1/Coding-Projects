# -*- coding: utf-8 -*-
"""
Created on Tue Mar  2 18:23:49 2021
This module includes the root-finding algorithms used in MATH3511
@author: Joshua
"""

#Bisection Method 

def bisect(f, inita, initb, tol):
    fval = tol+1.0 # initialise the function evaluation
    a = inita # set the starting value of a
    b = initb # set the starting value of b
    # while |f(m)| > tol continue to iterate
    while abs(fval)> tol:
        m = (a+b)/2.0 # find the midpoint
        fval = f(m) # evaluate the function at the midpoint
        if f(a)*fval < 0.0: # find the new range [a, b]
            b = m
        else:
            a = m
        print([a, b, m, fval]) # display the intermediate results
    return m, abs(b-a)/2.0


#Newton's Method

def newton(f, df, x0, delta):
    x = x0 # initial guess
    err = delta+1.0 # set an upper bound on the error
    print('The inital guess is', x, 'and f(x) =', f(x))
    # while the error estimate is large
    while err > delta :
        y = f(x) # evaluate the function
        dydx = df(x) # evaluate the derivative
        dx = - y/dydx # find the step size
        err = abs(dx) # estimate the error
        x = x + dx # take a step
        print('The new approximate root is', x)
        print('f(x) =',y)
        print('The error estimate is', err)
    return x


#Secant Method

def secant(f, x1, x2, delta, epsilon, N):
    f1 = f(x1); f2 = f(x2) # initial guess
    for step in range(N): # upper bound on interations
        if f1 == f2: # avoid devision by zero
            print('error: division by zero')
            return x1
        dx = -f2*(x2-x1)/(f2-f1) # find step szie
        x3 = x2+dx # take a step
        err = abs(dx) # approximate the error
        f3 = f(x3) # evaluate function at point
        if err < delta or abs(f3) < epsilon:
            return x3 # return if error is small or x3 close to root
        x1 = x2; f1 = f2; x2 = x3; f2 = f3 # next iteration
    # if maximum number of iterations reached print message
    print('error: iteration limit was reached without convergence')
    return x2
