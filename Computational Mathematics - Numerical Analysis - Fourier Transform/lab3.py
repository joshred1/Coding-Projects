# -*- coding: utf-8 -*-
"""
Lab 3: Rounding Errors, Differentiation, Quadrature

@author: Joshua
"""

import math as m
import numpy as np
import matplotlib.pyplot as plt


#Lab Book: Using float_info for the float data type (double precision), what is: (a) the largest positive finite machine number; (b) the largest (in absolute value) negative finite machine number; (c) the smallest positive #machine number? You may need to read the documentation of np.finfo

float_info = np.finfo(float)

#The largest positive finite number is:

float_info.max

#The Largest negative finite number is:
    
float_info.min

#Smallest possible machine number is:
    
float_info.eps 


#Lab Book: Find an example where math.sin or math.cos produces the wrong answer. How close is Python’s calculation to the true value?

#It is well known in mathematics that (sin x)^2 + (cos x)^2 = 1. Lets test this result for x = 100.

m.sin(100)**2 + m.cos(100)**2 == 1

#The statement returns false, due to rounding error.

error = abs(m.sin(100)**2 + m.cos(100)**2 - 1)
error

#error is approx 1.11e-16 which is extremely small (negligible even in many cases).

#Lab Book: Evaluate f(x)for x = 10−2, 10−3, . . . and compare your answer to the Taylor series. Commenton what you observe. Then find a better way to evaluate f(x) which avoids catastrophic cancellation. Check your new code by comparing it to the Taylor series.


def f(x):
    return (m.cos(2*x) - 1)/(x**2)

def T(x):
    return -2 + (2*x**2)/3

for i in range(2,21):
    x = 10**(-i)
    print('f:', f(x),'T:', T(x),'error:', abs(f(x)-T(x)))

#We see that as x approaches 0, the absolute error increases drastically. This is the opposite of what we expect; which is that the taylor series should converge to f(x). This is due to a phenomenon is known as "catastrophic cancellation" which is caused by the -1/x^2 term in f. A better way to evaluate f(x) is to avoid subtraction where possible we can using trig identities define g(x) as an alternative (equivalent) expression for f(x). 

def g(x):
    return -2*(m.sin(x))**2/(x**2)

for i in range(2,21):
    x = 10**(-i)
    print('g:', g(x),'T:', T(x),'error:', abs(g(x)-T(x)))
    
#We see that the error quickly converges to 0 after a few iterations and thus g is not subjected to the catastrophic cancellation as we've removed the subtracted term.

#Lab Book: By editing the code template below, use both approximations to estimate f'(1) for the function f(x) = e^x − cos(x), for decreasing values of h. Estimate the order of convergence of both methods by plotting the approximation error (compared to the analytic derivative) against h. Comment on what you observe.
 
def fn(x):
    return m.exp(x) - m.cos(x)

def df(x):
    return m.exp(x) + m.sin(x)

# Decreasing sequence of h values
hs = 2**(-np.linspace(0,30,128))
# Make an empty vector of errors
forward_error = np.zeros((len(hs),))
central_error = np.zeros((len(hs),))
for i in range(len(hs)):
    h = hs[i] # current value of h
    x = 1
    forward_error[i] = abs((fn(x+h)-fn(x))/h - df(x))
    central_error[i] = abs((fn(x+h)-fn(x-h))/(2*h) - df(x))
    
# The below vectors show the error decrease for particular orders of convergence
linear_rate = hs # plot hs vs linear_rate to see linear convergence

plt.figure()
plt.clf()
plt.plot(hs, linear_rate)
plt.grid()
plt.xlabel('h')
plt.ylabel('linear rate')
plt.show()

quadratic_rate = hs**2 # plot hs vs quadratic_rate to see quadratic convergence rate

plt.figure()
plt.clf()
plt.plot(hs, quadratic_rate)
plt.grid()
plt.xlabel('h')
plt.ylabel('quadratic rate')
plt.show()

# TODO Plot hs vs forward_error and central_error (on a log-log plot)

plt.figure()
plt.clf()
plt.loglog(hs, forward_error)
plt.loglog(hs, central_error)
plt.loglog(hs, linear_rate, linestyle = '--')
plt.loglog(hs, quadratic_rate, linestyle = '--')
plt.grid()
plt.xlabel('log h')
plt.ylabel('log error')
plt.title('First derivative approximation error')
plt.legend(['forward difference','central difference', 'O(h)', 'O(h^2)'], loc='best')
plt.show()

#From the plots we identify that the forward difference scheme error is of order O(\h) and the central difference scheme is of order O(h^2). For extremely low values, it is evident that some rounding errors are incurred due to floating point error. This is a larger issue for the central difference method however as this method converges faster, we can accept a larger h value and still have a much more accurate approximation than the forward difference method.

#Lab Book: Implement the second derivative estimation method from lectures to estimate f''(1). Estimate the order of convergence (versus some reasonable measure of accuracy) by producing a plot similar to the above.    

def d2f(x):
    return m.exp(x) + m.cos(x)

second_order_error = np.zeros((len(hs),))
for i in range(len(hs)):
    h = hs[i] # current value of h
    x = 1
    second_order_error[i] = abs((fn(x+h)-2*fn(x) + fn(x-h))/(h**2) - d2f(x))
    
plt.figure()
plt.clf()
plt.loglog(hs,  second_order_error)
plt.loglog(hs, quadratic_rate, linestyle = '--')
plt.grid()
plt.xlabel('log h')
plt.ylabel('log error')
plt.title('Second derivative approximation error')
plt.legend([' second order error', 'O(h^2)'], loc='best')
plt.show()

#From the plot we identify that the second order difference scheme error is of order O(x^2), and so the error converges to zero quite rapidly wrt h. It is evident that some rounding errors are incurred due to floating point error, however due to the rapid convergence of the error to 0, this isn't much of an issue as we can accept a larger h value and still have a relatively accurate approximation.

#Lab Book: Rewrite riemann_sum using NumPy array operations, so that it does not have any loops, but still works for non-equally spaced nodes (you will need to use slicing from Lab 1). Use your new code to approximate int(-1,1) e^−x dx, and (with reference to theory from lectures) compare your approximation to the true value of the integral for increasing values of n and comment on your results.

def riemann_sum(xdata, ydata):
    """
    Approximate an integral using Riemann sums, based on evaluated
    function values (x0,y0), ..., (xn, yn).
    Inputs xdata and ydata are (xi,yi), both vectors of length n+1
    """
    n = len(xdata) - 1
    assert len(ydata) == n+1, "Lengths of xdata and ydata do not match"
    
    # Calculate Riemann sum
    approx_integral = sum((xdata[1:len(xdata)] - xdata[0:len(xdata)-1]) * np.exp(-xdata[0:len(xdata)-1]))
    return approx_integral
# Basic code to run riemann_sum(...)
# Assume we have a function f(x) using numpy element-wise functions,
# limits of integration [a,b], and number of points n
ns = np.arange(1,200)
riemann_error = np.zeros((len(ns),))
for k in range(len(ns)):
    xs = np.linspace(-1, 1, ns[k]+1) # equally spaced points xi (we can change to non-equally spaced)
    ys = np.exp(-xs)
    print("Left Riemann sum =", riemann_sum(xs, ys))
    riemann_error[k] = abs(m.exp(1)-m.exp(-1) - riemann_sum(xs, ys)) #analytic solution is e-1/e

ns = ns.astype(float)    
plt.figure()
plt.clf()
plt.plot(ns,  riemann_error)
plt.grid()
plt.xlabel('n')
plt.ylabel('error')
plt.title('Reimann sums approximation error')
plt.show()

#From the plot we see the error is O(1/n), which decreases very rapidly for low n, but converges overall very slowly to the true value. Unlike in differentiation, we don't incur much issues with the floating point error, mostly because the rectangle widths are much larger in comparison to the infitessimal interval h used in finite difference methods.

#Lab Book: Using riemann_sum as a starting point, write a function which implements the composite trapezoidal rule which works for non-equally spaced nodes (without using ‘for’ loops). Compare the accuracy of the trapezoidal rule to left Riemann sums and comment on what you observe.

def trapezoidal(xdata, ydata):
    """
    Approximate an integral using the trapezoidal rule, based on evaluated
    function values (x0,y0), ..., (xn, yn).
    Inputs xdata and ydata are (xi,yi), both vectors of length n+1
    """
    n = len(xdata) - 1
    if len(ydata) != n+1:
        assert len(ydata) == n+1, "Lengths of xdata and ydata do not match"
        
    h = (xdata[1:len(xdata)] - xdata[0:len(xdata)-1])
    return sum(h*(np.exp(-xdata[0:len(xdata)-1]) + np.exp(-xdata[1:len(xdata)]))/2)

ns = np.arange(1,200)
trapezoidal_error = np.zeros((len(ns),))
for k in range(len(ns)):
    xs = np.linspace(-1, 1, ns[k]+1) #we can freely change this to a non-equally spaced grid
    ys = np.exp(-xs)
    print("trapezoidal sum =", trapezoidal(xs, ys))
    trapezoidal_error[k] = abs(m.exp(1)-m.exp(-1) - trapezoidal(xs, ys))

ns = ns.astype(float)    
plt.figure()
plt.clf()
plt.loglog(ns,  riemann_error)
plt.loglog(ns, trapezoidal_error)
plt.loglog(ns, 1/ns, linestyle = '--')
plt.loglog(ns, 1/ns**2, linestyle = '--')
plt.grid()
plt.xlabel('log n')
plt.ylabel('log error')
plt.title('Quadrature approximation error')
plt.legend(['Riemann sums','Trapezoidal rule', 'O(1/n)', 'O(1/n^2)'], loc='best')
plt.show()

#From the plot we see that the trapezoidal error is O(1/n^2), which decreases very rapidly for low n, but converges overall very slowly to the true value as n increases, however this convergence is a lot faster than that of Riemann sums. If we were to compare the errors to h instead, the Trapezoidal error converves in O(h^2), compared with Riemann sums in O(h), which emphaseses that the Trapezoidal method converges much faster.   